<#
	HTTP BASE functions
	
		Estas são as funcoes HTTP base que usaremos no PowershAI.  
		Estas funcoes implementam todas as funcionalidades necessárias para que ateners aos diversos providers.  
		Recursos como upload de arquivos, Server Side Events (sse), etc. ficma disponíveis.  
		
		As funcoes HTTP são disponibilizadas em 3 cmdlets:
			- Start-HttpRequest 
				Inciaum novo request e devolve o request
				
			- Receive-HttpRequest   
				Recebe o request criado por Start-HttpRequest 
				
			- Invoke-Http 
				É um atalaho para Start-HttpRequest + Receive-HttpRequest.  
				Os outros cmdlets dão mairo controle ao usuario.  
				Esse ultimo faz uma requisicao unica e devolve a resposta.
#>

if(-not(Get-Command verbose -EA SilentlyContinue)){
	function verbose {
		write-verbose ($Args -Join " ")
	}
}

Function Start-HttpRequest {
	[CmdLetBinding()]
	param(
		# A  URL para deve ser enviado a requisicao 
			$url 			= $null
		,#Os dados a serem enviados. 
		 #Se for um texto, envia no body diretamente. 
		 #Se for uma hashtable, convete ela para o formato mais aporproiado, baseado no -ContentType.
			[object]$data 	= $null
		
		,#Método  HTTP
			$method 		= "GET"
		
		
		,#O Mime Type (que será enviado no Header ContentType). 
		 #Quando é application/json (ou apenas json), se -data for uma hashtable, ou objeto, converte ele para um JSON.
		 #Caso queria ter mais controle sobre o json gerado, passe -data como uma string direto no formato json desejado!
		 #Quando multipart/form-data (ou apenas form)
			$contentType 	= "application/json"
			
			
		,#A codificação dos dados a ser enviadas 
			$Encoding = "UTF-8"
			
		,$headers 		= @{}
		
		,$MaxConnections = 50
		
		,#Max auto http redirect
			$MaxRedirects = $null
			
                ,#Json depth quando convertendo data em json
                         $JsonDepth = 5

                ,#Permite especificar o content-type de campos individuais
                        $FieldContentTypes = @{}
        )
	$ErrorActionPreference = "Stop";

	
	#Troca caracteres não-unicode por um \u + codigo!
	#Solucao adapatada da resposta do Douglas em: http://stackoverflow.com/a/25349901/4100116
	Function EscapeNonUnicodeJson {
		param([string]$Json)
		
		$Replacer = {
			param($m)
			
			return [string]::format('\u{0:x4}', [int]$m.Value[0] )
		}
		
		$RegEx = [regex]'[^\x00-\x7F]';
		verbose "  Original Json: $Json";
		$ReplacedJSon = $RegEx.replace( $Json, $Replacer)
		verbose "  NonUnicode Json: $ReplacedJson";
		return $ReplacedJSon;
	}
		
	#Converts objets to JSON and vice versa,
	Function ConvertTojson2($o) {
		
		if(Get-Command ConvertTo-Json -EA "SilentlyContinue"){
			verbose " Using ConvertTo-Json"
			return EscapeNonUnicodeJson(ConvertTo-Json $o -Depth 10);
		} else {
			verbose " Using javascriptSerializer"
			Movidesk_LoadJsonEngine
			$jo=new-object system.web.script.serialization.javascriptSerializer
			$jo.maxJsonLength=[int32]::maxvalue;
			return EscapeNonUnicodeJson ($jo.Serialize($o))
		}
	}
	
	
	Function UrlEncode {
		param($Value)
		
		try {
			$Encoded =  [Uri]::EscapeDataString($Value);
			return $Encoded;
		} catch {
			write-verbose "Failure on urlencode. Data:$Value. Error:$_";
			return $Value;
		}
	}
		
	Function Hash2Qs {
		param($Data)
		
		
		$FinalString = @();
		$Data.GetEnumerator() | %{
			write-verbose "$($MyInvocation.InvocationName): Converting $($_.Key)..."
			$ParamName = UrlEncode $_.Key; 
			$ParamValue = UrlEncode $_.Value; 
		
			$FinalString += "$ParamName=$ParamValue";
		}

		$FinalString = $FinalString -Join "&";
		return $FinalString;
	}



	$DebugVar = @{};
	
	$HttpRequest = [PsCustomObject]@{
		WebRequest 	= $null
		WebResponse = $null
		DebugData 	= $DebugVar
		ReqBytes 	= $null
		ReqStream 	= $null
		
		RespStream 			= $null
		RespStreamReader 	= $null
		ReadAsyncTask		= $null
		
		Completed 	= $false
	}
	

	
	$ContentTypeAlias = @{
		"json" = "application/json"
		"form" = "multipart/form-data"
	}
	
	$ContentTypeAliasValue = $ContentTypeAlias[$ContentType]
	
	if($ContentTypeAliasValue){
		verbose "ContentType is alias: $ContentType -> $ContentTypeAliasValue"
		$ContentType = $ContentTypeAliasValue
	}

	#building the request parameters
	if($method -eq 'GET' -and $data){
		if($data -is [hashtable]){
				$QueryString = Hash2Qs $data;
		} else {
				$QueryString = $data;
		}
		
		if($url -match '\?'){
			$url += '&' + $QueryString
		} else {
			$url += '?' + $QueryString;
		}
	}

	verbose "  Creating WebRequest method... Url: $url. Method: $Method ContentType: $ContentType";
	$Web = [System.Net.WebRequest]::Create($url);
	$Web.Method = $method;
	$Web.ContentType = $contentType
	
	if($MaxRedirects -eq 0){
		$Web.AllowAutoRedirect  = $false;
	}
	
	if($MaxRedirects){
		$Web.MaximumAutomaticRedirections  = $MaxRedirects
	}
	
	$HttpRequest.WebRequest = $Web;
	
	#Faz o close do connection group!
	try {
		$AllSp = [Net.ServicePointManager]::FindServicePoint($url)
		$AllSp.ConnectionLimit = $MaxConnections
	} catch {
		verbose "Setting MaxConnections failed: $_"
	}
	
	
	@($headers.keys) | %{
		$HeaderName = $_;
		$HeaderVal = $headers[$_];
		verbose "Adding header $HeaderName $HeaderVal";
		$Web.Headers.add($_, $HeaderVal);
	}
	
	$Utf8Enc = [Text.Encoding]::UTF8;
	$IsoEnc = [System.Text.Encoding]::GetEncoding("iso-8859-1");
	
	#Obtém o encoding!
	$SendEncoding = [System.Text.Encoding]::GetEncoding($Encoding);
	
	#building the body..
	if($data -and 'POST','PATCH','PUT' -Contains $method){

		[Byte[]]$ReqBytes = @()
		
		<#
			Aqui é onde montamos o body da requisição.
			Tem toda uam regra em volta disso aqui, o que está implementado aqui é exclusivo para que este módulo funcione corretamente!
			
			Basicamente, podemos enviar dados via HTTP de duas formas: Um body com texto simples ou via multipart/form-data.  
			O primeiro é mais amplamente usado em diversas APIs e é o que mais iremos usar qui nesse módulo.  
			
			Vamos começar pelo mais fácil: Quando enviamos os dados como texto simples.  
			Esse texto pode ser qualquer coisa: várias linhas, um JSON, um XMl, etc.   
			Por facilidade, se o usuario passa uma hashtable no parametro -data, assumimos que é um JSON, e por isso convertemos pra JSON.  
			
			Basicamente, o que precisamos fazer pra emontar a requisicao pro server é: Pegar o conteudo em texto e escrever no stream da requisicao.
			Essa escrita no stream é feita em bytes. Nao posso escrever diretamente uma string.  
			Por isso, precisamos obter os "bytes" que forma a string que queremos enviar.  
			No Powershell, para fazer isso, precisamos usar as classees "Text.Encoding".  
			Internamente, o Powershell/.NET aramazena tods os textos como Unicode.  
			Mas, eu posso usar essas clases Text.Enconding para obter essas strings em outras codificacoes.  
			No nosso caso, assumimos por padrão que o encoding seja UTF-8, isto é , iremos enviar todo o conteúdo codificado como UTF-8. O parametro -Encoding altera isso.
			Por isso, usamos a classe Text.Encoding.NomEncoding. Com ela, posso obter a representacao da minha string na memoria, no formato que o usuário deste cmdlet deseja!
			
			Uma vez que tenho os bytes, ja no formato do encoding desejado, entao, basta escreve-los no stream do request. E esses bytes serão transmitidos exatamente assim para o server.  
			No Header, como eu especifico em qual encoding os dados estão sendo enviados, o server entende e deve processar corretamente!
			Ou seja, independnete de como esse dado chegou aqui, eu sempre vou enviar no formato que o usuário quer, e o padrão é enviar como UTF-8.
			
			Agora vamos para o mais complexo: O multipart/form-data. 
			Esse é um formato suportado pelos protocolos HTTP, onde podemos enviar dados mais complexos que textos, como o binarios (conteudo de um arquivo, por exemplo).
			E nao posso enviar apenas arquivos, posso enviar varios "Campos", cada campo pode conter um binario ou um texto.  
			é o formato utilizado geralmente para fazer upload de arquivos. (imagina um form HTML com vários campos, e alguns destes campos pode ser escolher arquivos)
			
			Ele tem um formato complexo: Preciso criar um delimitador (que chama de boundary). É uma string aleatoria e ela nao pode conter nos dados que vou enviar.  
			Por isso no codigo abaixo gero com GUIDs, etc. Esse boundary vai no header da requisicao, assim, o server sabe onde cada campo começa e termina.  
			
			Entao, montamos cada field que queremos enviar (em um formato especifico), e separando ele pelo boundary.  
			Basicamente, o body da requisicao, é uma string, com esse formatato:
			
				--BOUNDARY 
				Content-Disposition: field="NomeCampo"; filename="NomeArrquivo"
				Content-Type: audio/mpeg
				
				DADOS
				--BOUNDARY 
				Content-Disposition: field="NomeCampo"; filename="NomeArrquivo"
				Content-Type: application/octet-stream
				
				DADOS
				--BOUNDARY 
				Content-Disposition:
				
				
				DADOS
				--BOUNDARY--
				
			Este é o formato para o envio sem chunking (o HTTP ainda suporta enviar esses dados em partes... mas nao implementamos este aqui ainda).
			Cada vez que o --BOUNDARY aparece, temos um novo field... O server deve ser capaz de entender isso e separar.  
			Para campos que são texto, DADOS é o conteudo direto do campo. E nao tem um "Content-Type". Assume sempre que seja texto codificado pelo encoding especificado em -Encoding (o encoding padrão da requisicao).
			Para campos que são arquivos, DADOS é o binário com o conteudo do arquivo.  
			
			E é aqui que começa um grande ponto de atencao: Quando lidamos com arquivos, DADOS é um binário, não e um base64, ou alguma outra forma de codificar o binario. É exatamente os bytes do arquivo...
			Isso significa que temos que concatenar o binario diretamente no corpo da requisicao. Se voce intercepar essas requisicoes, verá que nesse trecho tem caracters "estranhos".  
			simplesmente pq alguns bytes nao tem representacao ou sao um caracter completamente aleatorio.... E ao exibi-lo como texto, fica estranho.  
			
			Bom, para consegurimos implementar isso aqui, precisamos fazer um jogo de cintura com o Powershell... 
			Conforme documentado, quando o usuario passar multipart/form-data, assumimos que -data hashtable, e cada key é um field a ser enviado.
			É como se cada key fosse um campo HTML em que o usuário pode colocar informacoes. O nome do campo é o nome da key e o seu valor é o proprio valor dela.
			Se o valor de uma key é um array, então enviamos várias vezes com o mesmo field. Isso é suprotado no protocolo. O server deve ter condicoes de juntar isso em um array.
			Obviamente, que vai depender do server, o usuário deve especifciar conforme aceitável pelo server, mas o fato é: se puder enviar vários, é só usar arrays!
			
			Para cada field vamos gerar o que é comum: colocamos o boundary e em seguida o header padrão.
			Tudo isso vai como uma string direto. A codificação desses "metadados" não importa, pois nenhum caracter além de 127 é usado. Em qualquer encoding, os primeiros 127 são os mesmos.
			Na verdade, o único field que atrapalhar seria o "filename", pois o usuário pode nomear o arquivo como quiser, e o SO aceita caracteres unicode. 
			Por isso que ele tem um tratamento diferente, que você vai entender logo abaixo.
			
			Agora, vem o ponto mais complexo: Como concatenar o binario do arquivo, ou o conteudo do campo, na string que estamos construindo, e manter a corretamente a codificação solicitada pelo usuário?
			Por exemplo, suponha que o usuário tenha um arquivo de áudio, e um dos bytes desse arquivo seja o 225 (inpdenente do que ele signifique para este arquivo). Imagine que ele queria enviar os dados em UTF-8.
			Quando eu concatenar esse byte 225 na string original, e depois transformar em bytes UTF-8, Esse 225 vai virar 2 novos bytes, pois, para o UTF-8, 225 é um caracter codificado em 2 bytes.  
			Isso alteraria o conteúdo do arquivo.
			
			Por isso, precisamos tratar corretamente essa concatenção e conversão.  
			
			Para resolver isso, fazemos o seguinte:
				
				Semelhante ao que fazemos anteriormente, no caso de um texto simples, precisamos primeiro obter os bytes do arquivo (ou do campo de texto).
				Esses são os bytes crus que formam o conteúdo do usuário.  
				A menira como eu pego os bytes é diferente para arquivo e para o valor direto do campo.
				
				NO caso do arquivo, é exatamente os bytes e não me interesse o conteúdo do arquivo.  
				O método ReadAllBytes faz esse trabalho facilmente, lendo tudo e jogando na variável um array de bytes.  
				Obviamente que há formas melhores de fazer (usando chunk) para não carregar um arquivo gigante na memória do Powershell.  
				Mas, por enquanto, assumo que isso não será um problema, pois o usuário irá lidar apenas arquivos pequenos. Futuros ajustes podem melhorar isso.
				
				No caso de campos, os bytes do conteúdo é os bytes coforme o encoding solicitado. Isso é, se o usuário tem campo chamado "nome", vou enviar os bytes do valor usando o encoding que ele solicitou.
				Aqui fazemos igual no método simples: Precisamos obter os bytes conforme o encoding de origem, usando a classe respectiva, que vai converter a string UTF16 para o encoding que o usuário quer.
				Com isso, eu tenho a sequencia de bytes que representa aquela string, naquele encoding.
			
			Neste ponto, seja arquivo, seja campo, eu tenho os bytes que preciso enviar ao server. 
			Agora preciso concatenar esse binário, sem alteracoes, no corpo da requisicao que estou montando.  
			No PowerShell, nao consigo concatenar um array e bytes em uma string. Eu preciso converter para string. 
			Eu poderia fazer um loop, transformar cada byte em char e concatenar, mas isso deixar o codigo lento.. 
			Quero delegar essa tarefa para as funcoes builint do .net, que sao muito mais rapidas que o powershell!
			
			E, usando as proprias classes de Encoding, conseguimos gerar uma string a partir de uma sequencia de bytes.  
			Essas clases possuem um metodo chamado GetString, que a partir de uma sequencia de bytes, ele devolve uma string (basicamente é: converte esses bytes para os chars respectivos).	
			O segredo aqui é: Preciso de uma string que mantenha os bytes originais, sem alterar.  
			Nao é qualquer encoding que pode fazer isso, pois alguns deles fazem uma tradução dos bytes. Por exemplo, se o UTF8 encontrar os bytes 195 e 161 em sequencia, ele transforma em um byte com valor 225.
			Isso alteraria o dado do usuário.
			E um encoding que faz isso da forma que eu preciso é o iso-8859-1.
			Utilizando o GetString desse encoding, ele me retorna uma string com exatamente os mesmos bytes, na mesma ordem. Ele funcona pois ele tem um caractere em todo os bytes (0 a 255, 00 a ff).
			Obviamente, se você tentar exibir essa string, não vai conseguir ver alguns caracteres (especialmente os que estao acima do byte 127).
			Mas aqui o importante não é a exibição deles, e sim o conteúdo binário, que será enviado ao servidor e processado corretamente para que,quando recuperado, seja tratado corretamente.
			Qualquer encoding que tenha essa característica, poderia ser usado aqui.
			
			Uma vez que tenho a string, com os bytes originais, basta concatenar no body. Essa concatenção vai continuar preservando os bytes.  
			Isso é, se o meu arquivo tinha o binário (195,161) isso vai continuar depois de ser concatenado.
			
			Note que tudo isso explicado até aqui foi aprar gerar o body da requisicao, contendo os valores com seus respectivos binários peservados corretamente.
			A última etapa, depois que tenho todo o body gerado, eu preciso transformar iso de volta para bytes para escrever no stream.  
			E, de novo, preciso ler os bytes preservando a ordem. Novamente, uso a propria tecnica com o encoding iso, só que usando a funcao GetBytes, para obter os bytes que formam a string.
			
			Essa mesma técnica também usamos para gerar o nome filename. Uma vez que ele pode ser unicode, geramos a sua representação no encoding do usuario, e concatenamos esses bytes diretamente.
			
			Em suma, o segredo para não se perder aqui, em relação ao enconding é que o iso é apenas usado para fazer u jogo bytes entre tipos byte e string.  
			Isso é devido as pecularidades de como o PowerShell funciona!
		#>
		
		if($contentType -eq "multipart/form-data"){
			# É um form data!
			# Assume que os arquivos estarão nos fields de data que são do tiop FIle!
			# Demais fields enviados normalmente!
			
			#Itera...
			$BodyLines = @()
			#Vamos usar um boundary com esse formato: PowershAI_GUID.
			$boundary = "PowershaAI_" + [System.Guid]::NewGuid().ToString();
			
			foreach( $FieldName in @($data.keys) ){
				verbose "Adding field $FieldName"
				$FieldValues = $data[$FieldName];
				
				#Se for um array, esse trecho vai expandir autoamticamente os elementos do array!
				#Para cada item vamos processar e reusar o nome do field!
				foreach($FieldValue in @($FieldValues)){
					$ContentDisposition = @(
						"Content-Disposition: form-data"
						'name="'+$FieldName+'"'
					)
					
                                $BodyLines += "--$boundary"
                                $FieldContentType = $FieldContentTypes[$FieldName]
					
					# É u file?
                                        if($FieldValue -is [IO.FileInfo]){
                                                $file = $FieldValue;
                                                $FileNamedEnc = $IsoEnc.GetString($SendEncoding.GetBytes($File.name));
                                                $ContentDisposition += 'filename="'+$FileNamedEnc+'"'
                                                if(!$FieldContentType){
                                                        $FieldContentType = "application/octet-stream"
                                                }

						#Isso aqui tambem funcionaria!
						verbose "	Reading file raw binary content"
						$FieldBytes =  [System.IO.File]::ReadAllBytes($file.FullName)
						verbose "	Bytes=$($Bytes.length). Converting to string..."
					} else {
						#Aqui vamos converter o valor em utf-8 e obter os bytes!
						#Entao, precisamos concatenar essa string "utf-8" diretamente na string finalq ue será transmitida.
						#Para conseguir fazer isso, sem alterar o conteudo, vamos usar o encoding iso para obter uma string com os bytes originais.  
						#SE você tentar ver essa string, vai ver no formato incorreto, pois os bytes acima de 127 estao quebrados como 2 chars. E isso é o que queremos, pois lá no server, ele vai interpretar como utf-8 e juntar as peças.
						$FieldBytes = $SendEncoding.GetBytes($FieldValue);
					}
					
					$FieldContent = $IsoEnc.GetString($FieldBytes);
					
					$BodyLines += $ContentDisposition -Join "; "
					
					if($FieldContentType){
						$BodyLines += "Content-Type: $FieldContentType"
					}
					
					$BodyLines += @(
						""
						$FieldContent
					)
				}
				
			}
			
			$BodyLines += @(
					"--$boundary--"
					""
			)

					
			#verbose "FormData Fields:`n$($BodyLines|out-string)";
			
			$data = $BodyLines -join "`r`n";
			$DebugVar.BodyLines = $BodyLines
			$contentType += "; boundary=`"$boundary`""
			$ReqBytes = $IsoEnc.GetBytes($data)
		} else {
			
			$Primitives = [string],[int],[decimal]
			
			if($data -and $data.getType() -notin $Primitives){
				verbose "Converting input object to json string..."
				$data = $data | ConvertTo-Json -Depth $JsonDepth;
			}

			verbose "Data to be send:`n$data"

			# Transforma a string json em bytes...
			$ReqBytes = $SendEncoding.GetBytes($data);
		}
		
		$DebugVar.ReqBody 		= $Data
		$HttpRequest.ReqBytes  	= $ReqBytes;
		$Web.ContentType 		= "$contentType; charset=" + $SendEncoding.HeaderName;
	}
	
	
	$UrlUri = [uri]$Url;
	$Unescaped  = $UrlUri.Query.split("&") | %{ [uri]::UnescapeDataString($_) }
	verbose "Query String:`r`n$($Unescaped | out-string)"
	
	return $HttpRequest;


}


function Get-HttpResponse {
	[CmdLetBinding()]
	param(
		[Parameter(ValueFromPipeline=$true)]
		$HttpRequest
		
		,#Unidade de leitura. Indica o que será lido. Por exemplo, line, lê linhas. all, lê tudo!
		 #Numero 	- numero de linhas para ser lido 
		 #line 		- lê uma linha inteira!
		 #all 		- lê tudo 
		 #auto 		- determinada automaticamente cmo base no COntent Type da resposta.
			$ReadMode = "auto"
		
		,#Quantidade de itens a serem lidos de uma só vez (depende de read mode).
		 #Nao tem efeito quando ReadMode = all.
			$ReadCount = 1
			
		,#Timeout de leitura!
			$Timeout = $null
			
		,#Tempo de sleep, em ms, quando aguardando dados da conexao 
			$WaitSleep = 1000
		
		,#força o encerramento da requisicao 
			[switch]$ForceEnd
		
		,[switch]$StreamsOnly
	)
	
	function WaitAsync {
		param($handle)
		
		$Start = (Get-Date)
		
		
		
		
		while(!$handle.IsCompleted){
			
			if($Timeout){
				$Elapsed = (Get-Date) - $Start;
				
				if($Elapsed.totalMilliseconds -ge $Timeout){
					verbose "Wait timedout: Timeout:$($Timeout), elapsed = $Elapsed"
					throw "WaitTimeout";
				}
			}
			
			if($handle.AsyncWaitHandle.WaitOne){
				$null = $handle.AsyncWaitHandle.WaitOne($WaitSleep)
			} else {
				Start-Sleep -m $WaitSleep;
			}
		}	
		
		if($handle.IsFaulted){
			throw $handle.Exception;
		}
		
	}
	
	$Result  = [PsCustomObject]@{
		text 		= ""
		object		= $null
		completed	= $HttpRequest.Completed
		error 		= $null
	};
	
	try {
		if($HttpRequest.Completed){
			write-warning "Request completed";
			return $Result;
		}
		
		$Web = $HttpRequest.WebRequest;
		
		if(!$HttpRequest.ReqStream -and $HttpRequest.ReqBytes){
			verbose "Building request stream"
			$ReqBytes = $HttpRequest.ReqBytes;
			
			#Escrevendo os dados
			$Web.ContentLength = $ReqBytes.Length;
			verbose "  Bytes lengths: $($Web.ContentLength)"

			# a partir desse momento pode haver conexão!
			verbose "  Getting request stream...."
			$WaitHandle = $Web.BeginGetRequestStream($null,$null);
			
			verbose "waiting RequestStream"
			WaitAsync $WaitHandle 
			
			verbose " returning req stream...";
			$RequestStream = $Web.EndGetRequestStream($WaitHandle);
			
			verbose "  Writing bytes to the request stream...";
			$RequestStream.Write($ReqBytes, 0, $ReqBytes.length);

			$HttpRequest.ReqStream = $RequestStream;
		}

		if(!$HttpRequest.WebResponse){
			verbose "  Making http request... Waiting for the response..."
			try {
				$AsyncResp = $HttpRequest.WebRequest.BeginGetResponse($null,$null);
				
				verbose "Waiting initial http response...";
				WaitAsync $AsyncResp;
				verbose "Getting response";
				
				$HttpResp = $HttpRequest.WebRequest.EndGetResponse($AsyncResp);
				$HttpRequest.WebResponse = $HttpResp
			} catch [System.Net.WebException] {
				verbose "ResponseError: $_... Processing..."
				$ErrorResp = $_.Exception.Response;
				$HttpRequest.WebResponse = $ErrorResp;
				
				$ErrorDetails = @{}
				$PassError = $_.exception;
				$PassError | Add-Member -Force Noteproperty PowershaiDetails $ErrorDetails
				
				if($ErrorResp.ContentLength){
					verbose "Response Error contains length... Trying read...";
					
					try {
						verbose "Getting response stream..."
						$ErrorResponseStream = $ErrorResp.GetResponseStream();
						
						verbose "Creating error response reader..."
						$ErrorIO = New-Object System.IO.StreamReader($ErrorResponseStream);
						
						verbose "Reading the error response!"
						$ErrorText = $ErrorIO.ReadToEnd();
						$ErrorDetails.ResponseError = @{
							text 		= $ErrorText 
							response 	= $ErrorResp
						}
					} catch {
						write-warning "failed process response error!";
						$ErrorDetails.ResponseErrorException = @{
								exception 		= $_
								stream 			= $ErrorResponseStream
								reader 			= $ErrorIO
							}
					}
				}
				
				$HttpRequest.Completed 	= $true;
				throw;
			}
			
			verbose "  Response: charset: $($HttpResp.CharacterSet) encoding: $($HttpResp.ContentEncoding) ContentType: $($HttpResp.ContentType)"
			verbose "  Getting response stream..."
			$ResponseStream  = $HttpResp.GetResponseStream();
			
			verbose "building stream reader...";
			$IO = New-Object System.IO.StreamReader($ResponseStream);
			
			

			$HttpRequest.RespStream 		= $ResponseStream
			$HttpRequest.RespStreamReader 	= $IO
			
			verbose "Response stream size: $($ResponseStream.Length) bytes"
		}
		verbose "Request done..."
		
		if($StreamsOnly){
			return;
		}
		
		
		$HttpResp = $HttpRequest.WebResponse;

		
		$IO = $HttpRequest.RespStreamReader
		
		verbose "Setting stream timeout..."
		#$HttpRequest.RespStream.ReadTimeout = $Timeout;
		
		verbose "Check if completed..."
		
		
		
		$RespContentTypeHeader 	= $HttpRequest.WebResponse.Headers["Content-Type"] -Split ";";
		$RespContentType 		= $RespContentTypeHeader[0];
					
		if($ReadMode -eq "auto"){
			verbose "ReadCount Auto Mode. Content Type = $RespContentType"
			$ReadMode = "all";
			
			
			if($RespContentType -eq "text/event-stream"){
				$ReadMode = "line"
			}
		}
		
		$GenerateObject = $false;
		if($RespContentType -eq "application/json"){
			$GenerateObject = $true;
		}
		
		if($ReadMode -eq "all"){
			$ReadCount = 1;
		}
		
		verbose "ReadMode: $ReadMode, Count: $ReadCount";
		
		function ReadData {
			if($HttpRequest.ReadAsyncTask -eq $null){
				if($ReadMode -eq "line"){
					$HttpRequest.ReadAsyncTask =  $IO.ReadLineAsync();	
				} else {
					$HttpRequest.ReadAsyncTask =  $IO.ReadToEndAsync();	
				}
			}
			
			$Task = $HttpRequest.ReadAsyncTask;
			
			verbose "Waiting request answer...";
			WaitAsync $Task;
			verbose "	Task completed!"
			
			$HttpRequest.DebugData.LastAsyncTask += $Task;
			$HttpRequest.ReadAsyncTask 	= $null;

			return $Task.Result;
		}
		
		$ReadNum = $ReadCount;
		
		
		$HttpRequest.DebugData.LastAsyncTask = @()
		
		$Result.text = @()
		
		while($ReadNum--){
			$ReadText = ReadData;
			
			if($ReadText -eq $null){
				$HttpRequest.completed = $true;
				break;
			}
			
			$Result.text += $ReadText
		}
		
		if($GenerateObject){
			try {
				$Result.object = ConvertFrom-json $($Result.text -Join "`n")
			} catch {
				verbose "Failed Generated object: $_";
			}
		}
		
		if($ReadMode -eq "all"){
			$HttpRequest.completed = $true;
		}
		
		verbose " HttpResult:`n$($Result.text|out-string)"
		
		$Result.completed = $HttpRequest.Completed;
	} catch {
	
		if($_.Exception.Message -eq "WaitTimeout"){
			$Result.error = "timeout";
		} else {
			throw;
		}
	}
	finally {
		Close-HttpRequest $HttpRequest -Force:$ForceEnd
	}
	
	return $Result
}


function Close-HttpRequest {
	<#
		.SYNOPSIS 
			Close Http opended with Start-HttpRequest
	#>
	[CmdLetBinding()]
	param(
		[Parameter(ValueFromPipeline=$true)]
		$HttpRequest
		
		,[switch]$Force
	)

	$ErrorActionPreference = "Continue";
	
	if($Force){
		$HttpRequest.Completed = $true;
	}
		
	if($HttpRequest.Completed){
		if($HttpRequest.RespStreamReader){
			$HttpRequest.RespStreamReader.close()
		}

		if($HttpRequest.ReqStream){
			write-verbose "Ending request stream..."
			$HttpRequest.ReqStream.Close()
		}
		
		if($HttpRequest.HttpResponse){
			verbose "Ending http stream..."
			$HttpRequest.HttpResponse.Close();
		}
		
		
		if($HttpRequest.RespStream){
			verbose "Ending response stream..."
			$HttpRequest.RespStream.Close()
		}
	}
}


function Invoke-Http {
	[CmdLetBinding()]
	param(
		# A  URL para deve ser enviado a requisicao 
			$url 			= $null
			
		,#Os dados a serem enviados. 
		 #Se for um texto, envia no body diretamente. 
		 #Se for uma hashtable, convete ela para o formato mais aporproiado, baseado no -ContentType.
			[object]$data 	= $null
		
		,#Método  HTTP
			$method 		= "GET"

		,#O Mime Type (que será enviado no Header ContentType). 
		 #Quando é application/json (ou apenas json), se -data for uma hashtable, ou objeto, converte ele para um JSON.
		 #Caso queria ter mais controle sobre o json gerado, passe -data como uma string direto no formato json desejado!
		 #Quando multipart/form-data (ou apenas form)
			$contentType 	= "application/json"
			
			
		,#A codificação dos dados a ser enviadas 
			$Encoding = "UTF-8"
			
		,$headers 		= @{}
		
		,#Script que será invocado para ser executado em cada resposta do servudor.
		 #Use com Server Side Events!
			$SseCallBack 	= $null
		
		,#Nome da variavle que receberá a hashtable com informacoes de debug! 
		 #PAra fins de debug. Use com $PSDefaultParameterValues para especificar um valor!
		 $DebugVarName = $null
		 
		,#Timeout 
		 #Max ms aguardando por uma resposta conexão antes de encerrar
			$Timeout = $null
			
		,#MaxRedirects 
			$MaxRedirects = 0
		
                ,#Json depth quando convertendo -data em json
                        $JsonDepth = 5

                ,$FieldContentTypes = @{}
        )
	
	$ErrorActionPreference = "Stop";
	
	if($DebugVarName){
		verbose "checking debugvar $DebugVarName"
		$DebugVar = Get-Variable -Scope Global -Name $DebugVarName;	
	}
	
	
	
	$HttpReqParams = @{
		url 			= $url
		data 			= $data 
		method 			= $method
		contentType 	= $contentType
		encoding		= $encoding 
		headers 		= $headers 
		MaxRedirects = $MaxRedirects
		JsonDepth = $JsonDepth
                FieldContentTypes = $FieldContentTypes
	}
	
	$HttpRequest = Start-HttpRequest @HttpReqParams
	
	$ResultData = [PsCustomObject]@{
		stream 	= $false
		text 	= ""
		status 	= $null
		headers = $null
	}
	
	$DebugData = @{
		results = @()
		request = $HttpRequest
	}
		
	if($DebugVar){
		write-warning "DebugVar $DebugVarName enabled";
		$DebugVar.Value = $DebugData
	}
	
	try {
		verbose "Starting main loop";
		while($true){
			
			
			$ResponseParams = @{
				HttpRequest = $HttpRequest
				Timeout 	= $Timeout
			}
			
			if($SseCallBack){
				$ResponseParams.ReadMode 	= "line";
				$ResponseParams.ReadCount 	= 1
			}
			
			$HttpResult = Get-HttpResponse @ResponseParams
			
			
			if($DebugVar){
				$DebugData.results += $HttpResult;
			}
			
			if($HttpResult.error){
				throw $HttpResult.error
			}
			
			if($HttpRequest.WebResponse.StatusCode -in (308,302) -and $MaxRedirects -ne $null){
				
				$e = New-PowershaiError "HTTP_REDIRECT" "Maximum redirects reached $MaxRedirects" -Prop @{
					req = $HttpRequest
					status = $HttpRequest.WebResponse.StatusCode
					max = $MaxRedirects
				}
				
				throw $e
			}
	
			
			$ResultData.text 	+= $HttpResult.text
			$ResultData.status 	= $HttpRequest.WebResponse.StatusCode
			$ResultData.headers = $HttpRequest.WebResponse.headers
			
			if($SseCallBack){
				$Params = [PsCustomObject]@{ line = $HttpResult.text }
				
				#This prevent continue inside script affect outerloop!
				$WrapContinue = $true;
				while($WrapContinue){
					$WrapContinue = $false;
					& $SseCallBack $Params 
				}
			}
			
			if($HttpResult.completed){
				break
			}
		
		}
	

		if($SseCallBack){
			$ResultData.stream = $true;
		}
		
		return $ResultData;
	} 
	
	catch [AggregateException] {
		
		$AllErrorsMsg = @()
		
		$ErrorActionPreference = "Continue";
		foreach($inex in $_.Exception.InnerExceptions){
			$AllErrorsMsg += $inex.Message;
		}
		
		$FullMsg = $AllErrorsMsg -Join "`n";
		$ex = New-Object System.AggregateException($FullMsg, $_.Exception.InnerExceptions)
		throw $ex;
	}
	
	finally {
		Close-HttpRequest -Force $HttpRequest
	}
	
}






# old http!
<#
	.DESCRIPTION 
		Faz requisicoes HTTP, com suporte a Upload de arquivos e Server side events.  
		O objetivo de usar essa funcao ao invés de uma pronta, como Invoke-WebRequest ou Invoke-RestMethod é ter um controle maior e prover opcoes que funcionem em versoes mais antigas do Powershell.
		Por exemplo, Server Side Events não é suportado nem no Invoke-WebRequest nem no INvoke-RestMethod.
		Assim, implementando um cmdlet para invocar HTTP, usando as classes nativas do .NET, conseguimos disponibuilizar uma gama de novas funcionalidades, mantendo um interface simples para o resto do PowershAI.
		
		
#>
Function Invoke-HttpOld {
	[CmdLetBinding()]
	param(
		# A  URL para deve ser enviado a requisicao 
			$url 			= $null
		,#Os dados a serem enviados. 
		 #Se for um texto, envia no body diretamente. 
		 #Se for uma hashtable, convete ela para o formato mais aporproiado, baseado no -ContentType.
			[object]$data 	= $null
		
		,#Método  HTTP
			$method 		= "GET"
		
		
		,#O Mime Type (que será enviado no Header ContentType). 
		 #Quando é application/json (ou apenas json), se -data for uma hashtable, ou objeto, converte ele para um JSON.
		 #Caso queria ter mais controle sobre o json gerado, passe -data como uma string direto no formato json desejado!
		 #Quando multipart/form-data (ou apenas form)
			$contentType 	= "application/json"
			
			
		,#A codificação dos dados a ser enviadas 
			$Encoding = "UTF-8"
			
		,$headers 		= @{}
		,$SseCallBack 	= $null
		
		,#Prefixod a variable de debug. 
		 #Se definido, seta a variavel com o formato Prefixo+InvokeHttp+_Debug = @{}
		 $DebugVarPrefix = "PowershAI_"
	)
	$ErrorActionPreference = "Stop";

	
	#Troca caracteres não-unicode por um \u + codigo!
	#Solucao adapatada da resposta do Douglas em: http://stackoverflow.com/a/25349901/4100116
	Function EscapeNonUnicodeJson {
		param([string]$Json)
		
		$Replacer = {
			param($m)
			
			return [string]::format('\u{0:x4}', [int]$m.Value[0] )
		}
		
		$RegEx = [regex]'[^\x00-\x7F]';
		verbose "  Original Json: $Json";
		$ReplacedJSon = $RegEx.replace( $Json, $Replacer)
		verbose "  NonUnicode Json: $ReplacedJson";
		return $ReplacedJSon;
	}
		
	#Converts objets to JSON and vice versa,
	Function ConvertTojson2($o) {
		
		if(Get-Command ConvertTo-Json -EA "SilentlyContinue"){
			verbose " Using ConvertTo-Json"
			return EscapeNonUnicodeJson(ConvertTo-Json $o -Depth 10);
		} else {
			verbose " Using javascriptSerializer"
			Movidesk_LoadJsonEngine
			$jo=new-object system.web.script.serialization.javascriptSerializer
			$jo.maxJsonLength=[int32]::maxvalue;
			return EscapeNonUnicodeJson ($jo.Serialize($o))
		}
	}
	
	
	Function UrlEncode {
		param($Value)
		
		try {
			$Encoded =  [Uri]::EscapeDataString($Value);
			return $Encoded;
		} catch {
			write-verbose "Failure on urlencode. Data:$Value. Error:$_";
			return $Value;
		}
	}
	
	function UrlDecode {

	}
		
	Function Hash2Qs {
		param($Data)
		
		
		$FinalString = @();
		$Data.GetEnumerator() | %{
			write-verbose "$($MyInvocation.InvocationName): Converting $($_.Key)..."
			$ParamName = UrlEncode $_.Key; 
			$ParamValue = UrlEncode $_.Value; 
		
			$FinalString += "$ParamName=$ParamValue";
		}

		$FinalString = $FinalString -Join "&";
		return $FinalString;
	}


	try {
		
		$VarName = $DebugVarPrefix+"InvokeHttp_Debug";
		
		$VarExists = Get-Variable -Scope Global -Name $VarName -EA SilentlyContinue;
		
		$DebugVar = @{};
		if($VarExists){
			write-warning "== DEBUG VAR ENABLED ===";
			$VarExists.Value = $DebugVar;
			
			$DebugVar.cmdlet = $PSCmdlet;
		}
		
		
	
		$ContentTypeAlias = @{
			"json" = "application/json"
			"form" = "multipart/form-data"
		}
		
		$ContentTypeAliasValue = $ContentTypeAlias[$ContentType]
		
		if($ContentTypeAliasValue){
			verbose "ContentType is alias: $ContentType -> $ContentTypeAliasValue"
			$ContentType = $ContentTypeAliasValue
		}
	
		#building the request parameters
		if($method -eq 'GET' -and $data){
			if($data -is [hashtable]){
					$QueryString = Hash2Qs $data;
			} else {
					$QueryString = $data;
			}
			
			if($url -match '\?'){
				$url += '&' + $QueryString
			} else {
				$url += '?' + $QueryString;
			}
		}
	
		verbose "  Creating WebRequest method... Url: $url. Method: $Method ContentType: $ContentType";
		$Web = [System.Net.WebRequest]::Create($url);
		$Web.Method = $method;
		$Web.ContentType = $contentType
		#Faz o close do connection group!
		#$AllSp = [Net.ServicePointManager]::FindServicePoint($url)
		#if($AllSp){
		#	
		#}
		
		
		@($headers.keys) | %{
			$Web.Headers.add($_, $headers[$_]);
		}
		
		$Utf8Enc = [Text.Encoding]::UTF8;
		$IsoEnc = [System.Text.Encoding]::GetEncoding("iso-8859-1");
		
		#Obtém o encoding!
		$SendEncoding = [System.Text.Encoding]::GetEncoding($Encoding);
						
		#building the body..
		if($data -and 'POST','PATCH','PUT' -Contains $method){

			[Byte[]]$ReqBytes = @()
			
			<#
				Aqui é onde montamos o body da requisição.
				Tem toda uam regra em volta disso aqui, o que está implementado aqui é exclusivo para que este módulo funcione corretamente!
				
				Basicamente, podemos enviar dados via HTTP de duas formas: Um body com texto simples ou via multipart/form-data.  
				O primeiro é mais amplamente usado em diversas APIs e é o que mais iremos usar qui nesse módulo.  
				
				Vamos começar pelo mais fácil: Quando enviamos os dados como texto simples.  
				Esse texto pode ser qualquer coisa: várias linhas, um JSON, um XMl, etc.   
				Por facilidade, se o usuario passa uma hashtable no parametro -data, assumimos que é um JSON, e por isso convertemos pra JSON.  
				
				Basicamente, o que precisamos fazer pra emontar a requisicao pro server é: Pegar o conteudo em texto e escrever no stream da requisicao.
				Essa escrita no stream é feita em bytes. Nao posso escrever diretamente uma string.  
				Por isso, precisamos obter os "bytes" que forma a string que queremos enviar.  
				No Powershell, para fazer isso, precisamos usar as classees "Text.Encoding".  
				Internamente, o Powershell/.NET aramazena tods os textos como Unicode.  
				Mas, eu posso usar essas clases Text.Enconding para obter essas strings em outras codificacoes.  
				No nosso caso, assumimos por padrão que o encoding seja UTF-8, isto é , iremos enviar todo o conteúdo codificado como UTF-8. O parametro -Encoding altera isso.
				Por isso, usamos a classe Text.Encoding.NomEncoding. Com ela, posso obter a representacao da minha string na memoria, no formato que o usuário deste cmdlet deseja!
				
				Uma vez que tenho os bytes, ja no formato do encoding desejado, entao, basta escreve-los no stream do request. E esses bytes serão transmitidos exatamente assim para o server.  
				No Header, como eu especifico em qual encoding os dados estão sendo enviados, o server entende e deve processar corretamente!
				Ou seja, independnete de como esse dado chegou aqui, eu sempre vou enviar no formato que o usuário quer, e o padrão é enviar como UTF-8.
				
				Agora vamos para o mais complexo: O multipart/form-data. 
				Esse é um formato suportado pelos protocolos HTTP, onde podemos enviar dados mais complexos que textos, como o binarios (conteudo de um arquivo, por exemplo).
				E nao posso enviar apenas arquivos, posso enviar varios "Campos", cada campo pode conter um binario ou um texto.  
				é o formato utilizado geralmente para fazer upload de arquivos. (imagina um form HTML com vários campos, e alguns destes campos pode ser escolher arquivos)
				
				Ele tem um formato complexo: Preciso criar um delimitador (que chama de boundary). É uma string aleatoria e ela nao pode conter nos dados que vou enviar.  
				Por isso no codigo abaixo gero com GUIDs, etc. Esse boundary vai no header da requisicao, assim, o server sabe onde cada campo começa e termina.  
				
				Entao, montamos cada field que queremos enviar (em um formato especifico), e separando ele pelo boundary.  
				Basicamente, o body da requisicao, é uma string, com esse formatato:
				
					--BOUNDARY 
					Content-Disposition: field="NomeCampo"; filename="NomeArrquivo"
					Content-Type: audio/mpeg
					
					DADOS
					--BOUNDARY 
					Content-Disposition: field="NomeCampo"; filename="NomeArrquivo"
					Content-Type: application/octet-stream
					
					DADOS
					--BOUNDARY 
					Content-Disposition:
					
					
					DADOS
					--BOUNDARY--
					
				Este é o formato para o envio sem chunking (o HTTP ainda suporta enviar esses dados em partes... mas nao implementamos este aqui ainda).
				Cada vez que o --BOUNDARY aparece, temos um novo field... O server deve ser capaz de entender isso e separar.  
				Para campos que são texto, DADOS é o conteudo direto do campo. E nao tem um "Content-Type". Assume sempre que seja texto codificado pelo encoding especificado em -Encoding (o encoding padrão da requisicao).
				Para campos que são arquivos, DADOS é o binário com o conteudo do arquivo.  
				
				E é aqui que começa um grande ponto de atencao: Quando lidamos com arquivos, DADOS é um binário, não e um base64, ou alguma outra forma de codificar o binario. É exatamente os bytes do arquivo...
				Isso significa que temos que concatenar o binario diretamente no corpo da requisicao. Se voce intercepar essas requisicoes, verá que nesse trecho tem caracters "estranhos".  
				simplesmente pq alguns bytes nao tem representacao ou sao um caracter completamente aleatorio.... E ao exibi-lo como texto, fica estranho.  
				
				Bom, para consegurimos implementar isso aqui, precisamos fazer um jogo de cintura com o Powershell... 
				Conforme documentado, quando o usuario passar multipart/form-data, assumimos que -data hashtable, e cada key é um field a ser enviado.
				É como se cada key fosse um campo HTML em que o usuário pode colocar informacoes. O nome do campo é o nome da key e o seu valor é o proprio valor dela.
				Se o valor de uma key é um array, então enviamos várias vezes com o mesmo field. Isso é suprotado no protocolo. O server deve ter condicoes de juntar isso em um array.
				Obviamente, que vai depender do server, o usuário deve especifciar conforme aceitável pelo server, mas o fato é: se puder enviar vários, é só usar arrays!
				
				Para cada field vamos gerar o que é comum: colocamos o boundary e em seguida o header padrão.
				Tudo isso vai como uma string direto. A codificação desses "metadados" não importa, pois nenhum caracter além de 127 é usado. Em qualquer encoding, os primeiros 127 são os mesmos.
				Na verdade, o único field que atrapalhar seria o "filename", pois o usuário pode nomear o arquivo como quiser, e o SO aceita caracteres unicode. 
				Por isso que ele tem um tratamento diferente, que você vai entender logo abaixo.
				
				Agora, vem o ponto mais complexo: Como concatenar o binario do arquivo, ou o conteudo do campo, na string que estamos construindo, e manter a corretamente a codificação solicitada pelo usuário?
				Por exemplo, suponha que o usuário tenha um arquivo de áudio, e um dos bytes desse arquivo seja o 225 (inpdenente do que ele signifique para este arquivo). Imagine que ele queria enviar os dados em UTF-8.
				Quando eu concatenar esse byte 225 na string original, e depois transformar em bytes UTF-8, Esse 225 vai virar 2 novos bytes, pois, para o UTF-8, 225 é um caracter codificado em 2 bytes.  
				Isso alteraria o conteúdo do arquivo.
				
				Por isso, precisamos tratar corretamente essa concatenção e conversão.  
				
				Para resolver isso, fazemos o seguinte:
					
					Semelhante ao que fazemos anteriormente, no caso de um texto simples, precisamos primeiro obter os bytes do arquivo (ou do campo de texto).
					Esses são os bytes crus que formam o conteúdo do usuário.  
					A menira como eu pego os bytes é diferente para arquivo e para o valor direto do campo.
					
					NO caso do arquivo, é exatamente os bytes e não me interesse o conteúdo do arquivo.  
					O método ReadAllBytes faz esse trabalho facilmente, lendo tudo e jogando na variável um array de bytes.  
					Obviamente que há formas melhores de fazer (usando chunk) para não carregar um arquivo gigante na memória do Powershell.  
					Mas, por enquanto, assumo que isso não será um problema, pois o usuário irá lidar apenas arquivos pequenos. Futuros ajustes podem melhorar isso.
					
					No caso de campos, os bytes do conteúdo é os bytes coforme o encoding solicitado. Isso é, se o usuário tem campo chamado "nome", vou enviar os bytes do valor usando o encoding que ele solicitou.
					Aqui fazemos igual no método simples: Precisamos obter os bytes conforme o encoding de origem, usando a classe respectiva, que vai converter a string UTF16 para o encoding que o usuário quer.
					Com isso, eu tenho a sequencia de bytes que representa aquela string, naquele encoding.
				
				Neste ponto, seja arquivo, seja campo, eu tenho os bytes que preciso enviar ao server. 
				Agora preciso concatenar esse binário, sem alteracoes, no corpo da requisicao que estou montando.  
				No PowerShell, nao consigo concatenar um array e bytes em uma string. Eu preciso converter para string. 
				Eu poderia fazer um loop, transformar cada byte em char e concatenar, mas isso deixar o codigo lento.. 
				Quero delegar essa tarefa para as funcoes builint do .net, que sao muito mais rapidas que o powershell!
				
				E, usando as proprias classes de Encoding, conseguimos gerar uma string a partir de uma sequencia de bytes.  
				Essas clases possuem um metodo chamado GetString, que a partir de uma sequencia de bytes, ele devolve uma string (basicamente é: converte esses bytes para os chars respectivos).	
				O segredo aqui é: Preciso de uma string que mantenha os bytes originais, sem alterar.  
				Nao é qualquer encoding que pode fazer isso, pois alguns deles fazem uma tradução dos bytes. Por exemplo, se o UTF8 encontrar os bytes 195 e 161 em sequencia, ele transforma em um byte com valor 225.
				Isso alteraria o dado do usuário.
				E um encoding que faz isso da forma que eu preciso é o iso-8859-1.
				Utilizando o GetString desse encoding, ele me retorna uma string com exatamente os mesmos bytes, na mesma ordem. Ele funcona pois ele tem um caractere em todo os bytes (0 a 255, 00 a ff).
				Obviamente, se você tentar exibir essa string, não vai conseguir ver alguns caracteres (especialmente os que estao acima do byte 127).
				Mas aqui o importante não é a exibição deles, e sim o conteúdo binário, que será enviado ao servidor e processado corretamente para que,quando recuperado, seja tratado corretamente.
				Qualquer encoding que tenha essa característica, poderia ser usado aqui.
				
				Uma vez que tenho a string, com os bytes originais, basta concatenar no body. Essa concatenção vai continuar preservando os bytes.  
				Isso é, se o meu arquivo tinha o binário (195,161) isso vai continuar depois de ser concatenado.
				
				Note que tudo isso explicado até aqui foi aprar gerar o body da requisicao, contendo os valores com seus respectivos binários peservados corretamente.
				A última etapa, depois que tenho todo o body gerado, eu preciso transformar iso de volta para bytes para escrever no stream.  
				E, de novo, preciso ler os bytes preservando a ordem. Novamente, uso a propria tecnica com o encoding iso, só que usando a funcao GetBytes, para obter os bytes que formam a string.
				
				Essa mesma técnica também usamos para gerar o nome filename. Uma vez que ele pode ser unicode, geramos a sua representação no encoding do usuario, e concatenamos esses bytes diretamente.
				
				Em suma, o segredo para não se perder aqui, em relação ao enconding é que o iso é apenas usado para fazer u jogo bytes entre tipos byte e string.  
				Isso é devido as pecularidades de como o PowerShell funciona!
			#>
			
			if($contentType -eq "multipart/form-data"){
				# É um form data!
				# Assume que os arquivos estarão nos fields de data que são do tiop FIle!
				# Demais fields enviados normalmente!
				
				#Itera...
				$BodyLines = @()
				#Vamos usar um boundary com esse formato: PowershAI_GUID.
				$boundary = "PowershaAI_" + [System.Guid]::NewGuid().ToString();
				
				foreach( $FieldName in @($data.keys) ){
					verbose "Adding field $FieldName"
					$FieldValues = $data[$FieldName];
					
					#Se for um array, esse trecho vai expandir autoamticamente os elementos do array!
					#Para cada item vamos processar e reusar o nome do field!
					foreach($FieldValue in @($FieldValues)){
						$ContentDisposition = @(
							"Content-Disposition: form-data"
							'name="'+$FieldName+'"'
						)
						
                                            $BodyLines += "--$boundary"
                                            $FieldContentType = $FieldContentTypes[$FieldName]
						
						# É u file?
                                                if($FieldValue -is [IO.FileInfo]){
                                                        $file = $FieldValue;
                                                        $FileNamedEnc = $IsoEnc.GetString($SendEncoding.GetBytes($File.name));
                                                        $ContentDisposition += 'filename="'+$FileNamedEnc+'"'
                                                        if(!$FieldContentType){
                                                                $FieldContentType = "application/octet-stream"
                                                        }

							#Isso aqui tambem funcionaria!
							verbose "	Reading file raw binary content"
							$FieldBytes =  [System.IO.File]::ReadAllBytes($file.FullName)
							verbose "	Bytes=$($Bytes.length). Converting to string..."
						} else {
							#Aqui vamos converter o valor em utf-8 e obter os bytes!
							#Entao, precisamos concatenar essa string "utf-8" diretamente na string finalq ue será transmitida.
							#Para conseguir fazer isso, sem alterar o conteudo, vamos usar o encoding iso para obter uma string com os bytes originais.  
							#SE você tentar ver essa string, vai ver no formato incorreto, pois os bytes acima de 127 estao quebrados como 2 chars. E isso é o que queremos, pois lá no server, ele vai interpretar como utf-8 e juntar as peças.
							$FieldBytes = $SendEncoding.GetBytes($FieldValue);
						}
						
						$FieldContent = $IsoEnc.GetString($FieldBytes);
						
						$BodyLines += $ContentDisposition -Join "; "
						
						if($FieldContentType){
							$BodyLines += "Content-Type: $FieldContentType"
						}
						
						$BodyLines += @(
							""
							$FieldContent
						)
					}
					
				}
				
				$BodyLines += @(
						"--$boundary--"
						""
				)

						
				#verbose "FormData Fields:`n$($BodyLines|out-string)";
				
				$data = $BodyLines -join "`r`n";
				$DebugVar.BodyLines = $BodyLines
				$contentType += "; boundary=`"$boundary`""
				$ReqBytes = $IsoEnc.GetBytes($data)
			} else {
				if($data -is [hashtable] -or $data -is [object]){
					verbose "Converting input object to json string..."
					$data = $data | ConvertTo-Json -Depth 5;
				}
				
				verbose "Data to be send:`n$data"

				# Transforma a string json em bytes...
				$ReqBytes = $SendEncoding.GetBytes($data);
			}
			
			$DebugVar.FinalBodyData = $data;
			$DebugVar.ReqBytes = $ReqBytes;
			
		
			$Web.ContentType = "$contentType; charset=" + $SendEncoding.HeaderName;
			
			#Escrevendo os dados
			$Web.ContentLength = $ReqBytes.Length;
			verbose "  Bytes lengths: $($Web.ContentLength)"
			
			
			verbose "  Getting request stream...."
			$RequestStream = $Web.GetRequestStream();
			
			
			
			try {
				verbose "  Writing bytes to the request stream...";
				$RequestStream.Write($ReqBytes, 0, $ReqBytes.length);
			} finally {
				verbose "  Disposing the request stream!"
				$RequestStream.Dispose() #This must be called after writing!
			}
		}
		
		
		$UrlUri = [uri]$Url;
		$Unescaped  = $UrlUri.Query.split("&") | %{ [uri]::UnescapeDataString($_) }
		verbose "Query String:`r`n$($Unescaped | out-string)"
		


		
		verbose "  Making http request... Waiting for the response..."
		try {
			$HttpResp = $Web.GetResponse();
		} catch [System.Net.WebException] {
			verbose "ResponseError: $_... Processing..."
			$ErrorResp = $_.Exception.Response;
			
			if($ErrorResp.StatusCode -ne "BadRequest"){
				throw;
			}
			
			verbose "Processing response error..."
			$ErrorResponseStream = $ErrorResp.GetResponseStream();
			verbose "Creating error response reader..."
			$ErrorIO = New-Object System.IO.StreamReader($ErrorResponseStream);
			verbose "Reading error response..."
			$ErrorText = $ErrorIO.ReadToEnd();
			throw $ErrorText;
		}
		
		verbose "Request done..."
		
		$Result  = @{};
		
		if($HttpResp){
			verbose "  Response: charset: $($HttpResp.CharacterSet) encoding: $($HttpResp.ContentEncoding) ContentType: $($HttpResp.ContentType)"
			verbose "  Getting response stream..."
			$ResponseStream  = $HttpResp.GetResponseStream();
			
			verbose "  Response streamwq1 size: $($ResponseStream.Length) bytes"
			
			$IO = New-Object System.IO.StreamReader($ResponseStream);
			
			$LineNum = 0;
			
			if($SseCallBack){
				verbose "  Reading SSE..."
				$LineNum++;
				$SseResult = $null;

				$Lines = @();
				
				while($SseResult -ne $false -and !$IO.EndOfStream){
					verbose "  Reading next line..."
					$line = $IO.ReadLine()
					
					verbose "	Content: $line";
					
					$Lines += $line;
					
					verbose "	Invoking callback..."
					$SseResult = & $SseCallBack @{ line = $line; num = $LineNum; req = $Web; res = $HttpResp; stream = $IO }
					
					verbose "		Callback ran. Result: $SseResult";
				}
				
				$Result.text = $Lines;
				$Result.stream = $true;
			} else {
				verbose "  Reading response stream...."
				$Result.text = $IO.ReadToEnd();
			}
			
			verbose "  response json is: $responseString"
		}
		
		$DebugVar.result = $Result;
		
		verbose " HttpResult:`n$($Result|out-string)"
		return $Result
	} finally {
		$BackupErrorAction = $ErrorActionPreference
		$ErrorActionPreference = "Continue";
		
		if($IO){
			$IO.close()
		}

		if($HttpResp){
			write-verbose "Ending http stream..."
			$HttpResp.Close();
		}
		
		
		if($ResponseStream){
			write-verbose "Ending response stream..."
			$ResponseStream.Close()
		}

		if($RequestStream){
			write-verbose "Ending request stream..."
			$RequestStream.Close()
		}
		
		$ErrorActionPreference = $BackupErrorAction;
	}


}


Set-Alias InvokeHttp Invoke-Http
