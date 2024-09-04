<#
	Hugging Face e Gradio!
	Este provider fornece uma série de cmdlets para interagir com o Gradio e/ou Hugging Face (Hub, Spaces, Inference API, etc.)
#>

<#
###
### GRADIO (API WRRAPERS)
###		
		Os cmdlets a seguir provêm uma funcionalidade Low LEvel para invocar a API do Gradio, fazer upalods, etc.
		Eles são, em sua maioria, wrappers para as APIs oficiais (e não documentadas) do Gradio.
	
###	
###
###
#>	


<#
	.DESCRIPTION
		Executa chamadas HTTP para o Gradio e já adiciona os headers comuns, como autenticação, etc.
#>
function Invoke-GradioHttp {
	[CmdletBinding()]
	param(
		$url
		,$method = "GET"
		,$data
		,$ContentType = "application/json"
		,$StreamCallback = $null
	)
	
	$TokenRequired = $false;

	if(!$Token){
		$TokenEnvName = GetCurrentProviderData TokenEnvName;
		
		if($TokenEnvName){
			write-verbose "Trying get token from environment var: $($TokenEnvName)"
			$Token = (get-item "Env:$TokenEnvName"  -ErrorAction SilentlyContinue).Value
		}
	}	
	
	$headers = @{}
	if(!$NoToken){
		if($TokenRequired -and !$Token){
				$Token = GetCurrentProviderData Token;
				
				if(!$token){
					throw "POWERSHAI_HUGGINGFACE_GRADIOAPI_NOTOKEN: No token was defined and is required! Provider = $($Provider.name)";
				}
		}
		
		if($TokenRequired){
			 $headers["Authorization"] = "Bearer $token"
		}
	}
	
	
	$ReqParams = @{
		url 			= $url
		data 			= $data
		headers  		= $headers
		contentType 	= $ContentType
		method 			= $method 
		SseCallBack 	= $StreamCallback
	}
	
	$resp = InvokeHttp @ReqParams;
	
	if($resp.stream){
		return $resp
	}
	
	$resp.text | ConvertFrom-Json;
}

Set-Alias InvokeGradioApi Invoke-GradioHttp


<#
	.SYNOPSIS
		Faz um upload de um ou mais arquivos.
		Retorna um objeto no mesmo formto de gradio FileData(https://www.gradio.app/docs/gradio/filedata). 
		Caso queria retornar apenas o path do arquivo no server, use o parametro -Raw.
		Thanks https://www.freddyboulton.com/blog/gradio-curl and https://www.gradio.app/guides/querying-gradio-apps-with-curl
#>
function Send-GradioFile {
	[CmdletBinding()]
	param(
		$AppUrl
		,#Lista de arquivos (paths ou FileInfo)
			$Files
		
		,#Retorna o resultado direto do servidor!
			[switch]$Raw
	)
	
	$UploadUrl = "$AppUrl/upload"
	
	$Form = @{
		files = @()
	}
	
	
	foreach($File in $Files){
		
		if($File -is [IO.FileInfo]){
			$Form.files += $File;
		} else {
			$Form.files += Get-Item (Resolve-Path $file)
		}
	}
	
	$Params = @{
		data 		= $Form
		contentType = "form"
		method 		= "POST"	
		url 		= $UploadUrl
	}
	
	
	$result = InvokeGradioApi @Params
	
	if($raw){
		return $result;
	}
	
	$i = -1;
	$result | %{
		$i++;
		[PsCustomObject]@{
			orig_name = $Form.files[$i].name
			path = $_
			url = "$AppUrl/file="+[Uri]::EscapeDataString($_)
			meta = [PsCustomObject]@{"_type" = "gradio.FileData"}
		}
	};
}


<#
	.DESCRIPTION
		Envia dados a um Gradio e retorna um objeto que representa o evento!
		Passe esse objeto para os demais cmdlets para obter os resultados.
		
		FUNCIONAMENTO DA API DO GRADIO 
		
			Baseado em: https://www.gradio.app/guides/querying-gradio-apps-with-curl
			
			Para entender melhor como usar este cmdlet, é importante entender como a API do Gradio funciona.  
			Quando invocamos algum endpoint da API, ele não retorna os dados imediatamente.  
			Isso se deve ao simples fato do processamento ser extenso, devido a natureza (IA e Machine Learning).  
			
			Então, ao invés de retornar o resultado, ou aguardar indefinidamente, o Gradio retorna um "Event Id".  
			Com esse evento, conseguimos periodicamente obter os resultaods gerados.  
			O gradio vai gerar mensagens de eventos com os dados que foram gerados. Precisamos passar o EventId gerado para obter os novos pedaços gerados.
			Estes eventos são enviados via Server Side Events (SSE), e podem ser um destes:
				- hearbeat 
				A cada 15 segundos, o Gradio vai enviar este evento para manter a conexão ativa.  
				Por isso que, ao usar o cmdlet Update-GradioApiResult, ele pode demorar um pouco para retornar.
				
				- complete 
				É a última mensagem enviada pelo Gradio quando os dados foram gerados com sucesso!
				
				- error 
				Enviado quando houve algum erro no processamento.  
				
				- generating
				É gerado quando a API já tem dados disponíveis, mas, ainda pode vir mais.
			
			Aqui no PowershAI, nós separamos isso também em 3 partes: 
				- Este cmdlet (Send-GradioApi) faz a requisição inicial para o Gradio e retorna um objeto que representa o evento (chamamods ele de um objeto GradioApiEvent)
				- Este objeto resultante, de tipo GradioApiEvent,  contém tudo o que é necessário para consultar o evento e ele também guarda os dados e erros obtidos.
				- Por fim, temos o cmdlet Update-GradioApiResult, onde você deve passar o evento gerado, e ele irá consultar a API do gradio e obter os novos dados.  
					Verifiaue o help deste cmdlet para mais informações de como controlar esse mecanismo de obter os dados.
					
			
			Então, em um flixo normal, você deve fazer o seguinte: 
			
				#INvoque o endpoint do graido!
				$MeuEvento = SEnd-GradioApi ... 
			
				# Obtenha resultados até que tenha temrinado!
				# Verifique o help deste cmdlet para aprender mais!
				$MeuEvento | Update-GradioApiResult
				
		Objeto GradioApiEvent
		
			O objeto GradioApiEvent resultante deste cmdlet contém tudo o que é necessário para que PowershAI controle o mecanismo e obtenha os dados.  
			É importante que você conheça sua estrutura para que saiba como coletar os dados gerados pela API.
			Propriedades:
			
				- Status  
				Indica o status do evento. 
				Quando este status for "complete", significa que a API já terminou o processamento e todos os dados possíveis já foram gerados.  
				Enquanto for diferente disso, você deve invocar Update-GradioApiResult para que ele chque o status e atualize as informacoes. 
				
				- QueryUrl  
				Valor interno que contém o endpoint exato par a consulta dos resultados
				
				- data  
				Um array contendo todos os dados de resposta gerado. Cada vez que você invoca Update-GradioApiResult, se houver dados, ele irá adicionar a este array.  
				
				- events  
				Lista de eventos que foram gerados pelo server. 
				
				- error  
				Se houve erros na resposta, esse campio conterá algum objeto, string, etc., descrevendo mais detalhes.
				
				- LastQueryStatus  
				Indica o status da última consulta na API.  
				Se "normal", indica que a API foi consultada e retornou até o fim normalmente.
				Se "HeartBeatExpired", indica que a consulta foi interrompida devido ao timeout de hearbeat configurado pelo usuário no cmdlet Update-GradioApiResult
				
				- req 
				Dados da requisicao feita!
#>
function Send-GradioApi {
	[CmdletBinding()]
	param(
		$AppUrl
		,$ApiName
		,$Params
		,#Se informado, não chamada a API, mas cria o objeto e usa esse valor como se fosse o retorno 
			$EventId = $null
	)
	

	[object[]]$ApiParamsValue = @();
	
	$ParamIndex = -1;
	foreach($ParamValue in $params){
		$ParamIndex++;
		
		# If file, add to upload...
		
		$ApiParamsValue += ,$ParamValue;
	}
	
	$DataBody = @{
		data = $ApiParamsValue
	}
	
			
	$InvokeParams = @{
		method 	= "POST"
		url 	= "$AppUrl/call/$ApiName"
		data 	= $DataBody
	}
	
	if(!$EventId){
		$ApiResult = InvokeGradioApi @InvokeParams
		$EventId = $ApiResult.event_id;
	}
	
	$ApiEvent = [PsCustomObject]@{}
	SetType $ApiEvent "GradioApiEvent"
	
	$QueryUrl = "$AppUrl/call/$ApiName/$EventId"
	
	#Status vai servir para controlar o status!
	$ApiEvent | Add-Member Noteproperty EventId $EventId
	$ApiEvent | Add-Member Noteproperty Status $null
	$ApiEvent | Add-Member Noteproperty update @{
		url 	= $QueryUrl
		http	= Start-HttpRequest -Url $QueryUrl
	} 
	$ApiEvent | Add-Member Noteproperty data @()
	$ApiEvent | Add-Member Noteproperty events @()
	$ApiEvent | Add-Member Noteproperty LastEventNum 0
	$ApiEvent | Add-Member Noteproperty error $null
	$ApiEvent | Add-Member Noteproperty LastQueryStatus $null
	$ApiEvent | Add-Member Noteproperty req $InvokeParams
	
	return $ApiEvent;
}


<#
	.DESCRIPTION
		Atualiza um evento retornado por Send-GradioApi com novos resultados do servidor e, por padrão, retorna os evenots no pipeline.
		
		Os resultados das Apis do Gradio não são gerados instantaneamente, como é na maioria dos serviços HTTP REST.  
		O help do comando Send-GradioApi explica no detalhe como funciona o processo.  
		
		Este comando deve ser usado para atualizar o objeto GradioApiEvent, retornado pelo Send-GradioApi.
		Este objeto representa a resposta de cada chamada que você na API, ele contém tudo o que é preciso para consultar o resultado, incluindo dados e histórico.
		
		Basicamente, este cmdlet funciona invocando o endpoint de consulta do status da invocação Api.
		Os parâmetros necessários para consulta estão disponíveis no próprio objeto passado no parametro -ApiEvent (que é criado e retornado pelo cmdlet Send-GradioApi)
		
		Sempre que este cmdlet executa, ele se comunica via conexão HTTP persistente com o servidor e aguarda os eventos.  
		A medida que o servidor envia os dados, ele atualiza o objeto passado no parâmetro -ApiEvent, e, por padrão, escreve o evento retornado no pipeline.
		
		O evento retornado é um objeto do tipo GradioApiEventResult, e representa um evento gerado pela resposta da execução da API.  
		
		Se o parametro -History é especificado, todos os eventos gerados ficam na propriedade events do objeto fornecido em -ApiEvent, bem como os dados retornados.
		
		Baiscamente, os eventos gerados podem enviar um hearbeat ou dados.
		
		OBJETO GradioApiEventResult
			num 	= número sequencial do evento. comeca em 1.
			ts 		= data em que o evento foi criado (data local,não do servidor).
			event 	= nome do evento
			data 	= dados retornados neste evento
		
		DADOS (DATA)
		
			Obter os dados do Gradio, é basicamente ler os eventos retornados por este cmdlet e olhar na propriedade data do GradioApiEventResult
			Geralmente a interface do Gradio sobrescreve o campo com o último evento recebido.  
			
			Se -History for usado, além de escrever no pipeline, o cmdle vai guardar o dado no campo data, e portanto, você terá acesso ao histórico compelto do que foi gerado pelo servidor.  
			Note que isso pode causar um consumo adicional de memória, se muitos dados forem retornados.
			
			Existe um caso "problemático" conhecido: eventualmente, o gradio pode emitir os 2 ultimos eventos com o mesmo dado (1 evento terá o nome "generating", e o ultimo será complete).  
			Ainda não temos uma solução para separar isso de maneira segura, e por isso, o usuário deve decidir a melhor forma de conduzir.  
			Se você usar sempre o último evento recebido, isso não é um problema.
			Se precisará usar todos os eventos a medida que forem sendo gerados, terá que tratar esses casos.
			Um exemplo simples seria comprar o conteudo, se fossem iguais, não repetir. Mas podem existir cenários onde 2 eventos com o mesm conteúdo, ainda sim, sejam eventos logicamente diferentes.
			
			
		
		HEARTBEAT 
		
			Um dos evetnos geraods pela API do Gradio são os Heartbeats.  
			A cada 15 segundos, o Gradio envia um evento do tipo "HeartBeat", apenas para manter a conexão ativa.  
			Isso faz com que o cmdlet "trave", pois, como a conexão HTTP está ativa, ele fica esperando alguma resposta (que será dados, erros ou o hearbeat).
			
			Se não houver um mecanismo de contorle disso, o cmdlet iria rodar indefiniamente, sem possibilidade de cancelar nem com o CTRL + C.
			Para resolver isso, este cmdlet disponibiliza o parãmetro MaxHeartBeats.  
			Este parâmetro indica quantos eventos de Hearbeat consecutivos serão tolerados antes que o cmdlet pare de tentar consultar a API.  
			
			Por exemplo, considere estes dois cenários de eventos enviados pelo servidor:
			
				cenario 1:
					generating 
					heartbeat 
					generating 
					heartbeat 
					generating 
					complete
					
				cenario 2:
					generating 
					generating
					heartbeat 
					heartbeat
					heartbeat 
					complete
		
			Considerando o valor default, 2, no cenario 1, o cmdlet nunca encerraria antes do complete, pois apenas nunca houve 2 hearbeats consecutivos.
			
			Já no cenário 2, após receber 2 eventos de dados (generating), no quarto evento (hearbeat), ele encerraria, pois 2 hearbeats consecutivos foram enviados.  
			Dizemos que o heartbeat expirou, neste caso.
			Neste caso, você deveria invocar novamente Update-GradioApiResult para obter o restante.
			
			Sempre que o comando encerra devido ao hearbeat expirado, ele irá atualizar o valor da propriedade LastQueryStatus para HeartBeatExpired.  
			Com isso, você pode checar e tratar corretamente quando deve chamar novamente
			
			
		STREAM  
			
			DEvido ao fato de que a Api do Gradio já responde usando SSE (Server Side Events), é possível usar um efeito parecido com o "stream" de muitas Apis.  
			Este cmdlet, Update-GradioApiResult, já processa os eventos do servidor usando o SSE.  
			Adicionalmente, caso você também queria fazer algum processamento a medida que o evento se torne disponível, você pode usar o parâmetro -Script e especificar uma scriptblock, funcoes, etc. que irá ser invocado a medisa que o evento é recebido.  
			
			Combianando com o parâmetro -MaxHeartBeats, você pode criar uma chamada que atualiza algo em tempo real. 
			Por exemplo, se for uma resposta de um chatbot, pode escreve imediatamente na tela.
			
			note que esse parâmetro é chamado em sequencia com o código que checa (isto é, mesma Thread).  
			Portanto, scripts que demorem muito, podem atrapalhar a detecção de novos eventos, e cosequentemente, a entrega dos dados.
			
.
			
			
#>
function Update-GradioApiResult {
	[CmdletBinding()]
	param(
		#Resultado de  Send-GradioApi
		[Parameter(position=0,ValueFromPipeline=$true)]
		$ApiEvent 
		
		,#script que será invocado  em cada evento gerado!
		 #Recebe uma hashtable com as seguintes keys:
		 # 	event - contém o evento gerado. event.event é o nome doe vento. event.data são os dados retornados.
			$Script
			
		,#Max heartbeats consecutivos até o stop!
		 #Faz com que o comando aguarde apenas esse número de hearbeats consecutivos do servidor.
		 #Quando o servidor enviar essa quantiodade, o cmdlet encerra e define o LastQueryStatus do evento para HeartBeatExpired
			$MaxHeartBeats = $null
			
		,#Não escreve o resultado para o output do cmdlet 
			[switch]$NoOutput
			
		,#Guarda o historico de eventos e dados no objeto ApiEvent
		 #Note que isso fará consumir mais memória do powershell!
			[switch]$History
	)
	
	if(-not(IsType $ApiEvent "GradioApiEvent")){
		throw "POWERSHAI_HUGGINFACE_GRADIO_UPDATE_INVALIDEVENT: -ApiEvent invalid!"
	}
	
	if($ApiEvent.status -eq "complete"){
		write-warning "Event already completed";
		return;
	}

	$UpdateData = $ApiEvent.update;
	$HttpRequest = $UpdateData.http;
	
	$CurrentEvent 	= $null
	$HeatSeq 		= 0;
	$EventNum 		= $ApiEvent.LastEventNum
	
	if($EventNum -eq $null){
		$EventNum = 0;
	}
	
	$ApiEvent.LastQueryStatus = "running";
	
	try {
		while(!$HttpResp.completed){
			#Query Http!
			#obtém a próxima linha de evento!
			verbose "Waiting next HTTP event...";
			$HttpResp = $HttpRequest | Get-HttpResponse -ReadMode line -Readcount 1;
			
			if($HttpResp.completed){
				verbose "HTTP finished!";
				$ApiEvent.status 			= "complete";
				$ApiEvent.LastQueryStatus 	= "complete"
				
				#If o array de linhas recebidos é 0!
				if($HttpResp.text.length -eq 0){
					break;
				}
			}
		
			$line = @($HttpResp.text)[0];
			
			if(!$CurrentEvent){
				$EventNum++
				$CurrentEvent = [PsCustomObject]@{ 
					num 	= $EventNum
					ts 		= (Get-Date) 
					event 	= $null
					data 	= $null
				};
				
				SetType $CurrentEvent "GradioApiEventResult"
			}
		
			verbose "LineLength: $($Line.length)"
			#Sempre que tiver uma linha vazia, processa o evento!
			if(!$line){
				verbose "Processing event: $($CurrentEvent.num) $($CurrentEvent.event)";
				
				$ThisEvent = $CurrentEvent
				$CurrentEvent = $null
				
				$ApiEvent.LastEventNum = $ThisEvent.num;
				
				if(!$NoOutput){
					verbose "Writing event to output...";
					write-output $ThisEvent
				}
				
				if($ThisEvent.event -eq "Heartbeat" -and $MaxHeartBeats){
					verbose "Is hearbeat"
					$HeatSeq++;
					verbose "	Seq: $($HeatSeq) Max:$MaxHeartBeats"
					
					#Encerra com o status de hearbeat expired!
					if($HeatSeq -ge $MaxHeartBeats){
						verbose "	MaxHeartBeats reached!"
						
						if($stream){
							write-warning "Max Hearbeat rechaed";
						}
						
						$ApiEvent.LastQueryStatus = "HeartBeatExpired"
						break;
					}
					
					continue;
				} else {
					$HeatSeq = 0;
				}
				
				if($History){
					verbose "	Adding to history..."
					$ApiEvent.events += $ThisEvent
					
					if($ThisEvent.data -ne $null){
						$ApiEvent.data += $ThisEvent.data
					}
				}
				
				$ApiEvent.status = $ThisEvent.event;
				
				
				if($Script){
					$Params = @{
						event 		= $ThisEvent
						ApiEvent 	= $ApiEvent
					}
					
					verbose "Invoking user script";
					& $Script $Params
				}
				
				if($ThisEvent.event -eq "error"){
					verbose "Error found";
					$ApiEvent.status 	= "complete"
					$ApiEvent.error 	= $ThisEvent.data;
					if(!$ApiEvent.error){
						$ApiEvent.error = "UnknownError"
					}
					
					break;	
				}
				
				
				continue;
			}
			
			#Preenche o evento atual!
			$Parts 		= $line -Split ": ",2;
			$MsgType 	= $Parts[0];
			$MsgContent = $Parts[1];

			verbose "Processing event message: $MsgType";
			switch($MsgType){
				"event" {
					$CurrentEvent.event = $MsgContent;
				}
				
				"data" {
					verbose "Parsing event data from JSON: $MsgContent";
					$CurrentEvent.data =  $MsgContent | ConvertFrom-Json;
				}
			}
		}
	
	} finally {
		
		if($ApiEvent.status -eq "completed"){
			verbose "Closing HTTP connection";
			 $HttpRequest | Close-HttpRequest -Force 
		}
		
	}
}

<#
	.DESCRIPTION
		Obtém as informacoes dos parâmeteros de um Space Gradio!
#>
function Get-GradioInfo {
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$true)]
		$AppUrl = "."
	)
	
	if($AppUrl -eq "."){
		$AppUrl = Get-GradioSession "."
	}
	
	if(IsType $AppUrl "GradioSession"){
		$AppUrl = $AppUrl.AppUrl
	}
			
	$InvokeParams = @{
		url 	= "$AppUrl/info"
	}
	InvokeGradioApi @InvokeParams
}

<#
###
### GRADIO (GRADION SESSIONS)
###		
		Os cmdlets a seguir implementa o cocneito de "Gradio Session"
		Uma sessão combina o conceito de Session original do Gradio mais uma customização para funcionar aqui com o Powershell.
		
		Basicamente, uma sessão é uma conexão com uma app gradio (como se fosse uma abna do navegador com aquela página aberta).
		Cada session está associada a uma URL e controla seus arquivos em que foi feito upload, chamadas de api, etc.  
		
		O usuário pode criar múltipla sessiois (Como se abrisse múltipla abas do browser).
		Podem existir múltiplas sessions conectadas em url diferentes.
	
###	
###
###
#>


<#
	.SYNOPSIS
		Cria uma nova sessão Gradio. 
		
	.DESCRIPTION 
		Uma Sessions representa uma conexão para uma app Gradio.  
		Imagina que uma session seja como se fosse uma aba do browser aberto conectado em uma determinada app gradio.  
		Os arquivos enviados, chamadas feitas, logins, são todas gravas nesta session.
		
		Este cmndlet retorna um objeto que chamamos de "GradioSesison".  
		Este objeto pode ser usado em outros commandlets que dependem de session (e pode ser definido uma session ativa, que todos os cmdlets usam por padrão se não especificado).  
		
		Toda session tem um nome que a identifica unicamente. Se não informado pelo usuário, será criado autoamticamente com base na URL da app.  
		Não podem existir 2 sessions com o mesmo nome.
		
		Ao criar um session, este cmdlet salva esta session em um repositorio interno de sessions.
#>
function New-GradioSession {
	[CmdletBinding()]
	param(
		#Url da app 
			$AppUrl
			
		,#Nome unico que identifica esta sessao!
			$Name = $Null
			
		,#Diretório onde fazer o donwload dos arqiovpos 
			$DownloadPath = $null
			
		,#Force recreate
			[switch]$Force 
	)
	
	$Session = [PsCustomObject]@{
		#Id intenro gerado aleatoriamente da sessao!
		SessionId 		= [Guid]::NewGuid().Guid
		
		#Url da App Gradio
		AppUrl 			= $AppUrl
		
		#Lista de uploads feitos nesta sessão
		uploads 		= @{}
		
		#Cache das informacoes da app, retornado peloe ndpoint /info
		info 			= @()
		
		#Nome da sessao. Para consulta somente!
		name 			= $null
		
		#Irá guardar a lista de todas as chamadas feitas pela api, na ordem em que são feitas.
		ApiCalls = @{
			#Lista com todos os eventos gerados!
			AllEvents = @()
			
			#Lista de eventos gerados, usando id do evento como indice!
			ById = @{}
		}
		
		#Numero de versao do schema desse objeto!
		#Controla futuras adicoes!
		version = 1
		
		# Opcoes que podem ser alteradas pelo usuairos 
		options = @{
			MaxCalls 		= 10		# Max calls que podem ser feitos na API
			MaxCallsPolicy 	= "error"	# O que fazer quando MaxCalls for atingido.  Valore spossveis:
										#	error 	- gera um erro e nao deixa criar mais.
										#	remove 	- Remove a mais antiga.
										#	warning - Avisa somente, e prossegue com a criacao!
										#
		}
	}

	verbose "Check app info...";
	$Session.info = Get-GradioInfo $AppUrl;
	
	#Add to session list!
	$GradioSessions = GetCurrentProviderData -Context GradioSessions ;
	
	if(!$GradioSessions){
		$GradioSessions = @{}
		SetCurrentProviderData -Context GradioSessions $GradioSessions;
	}
	
	if(!$Name){
		$Name = $AppUrl
	}
	
	$Session.name = $Name;
	
	if($GradioSessions.contains($Name) -and !$Force){
		throw "POWERSHAI_HUGGINGFACE_GRADIOSESSION: Session $Name already exists. Specify another -Name to create new!"
	}
	
	$GradioSessions[$Name] = $Session;
	
	$Session | Add-Member -Force ScriptMethod toString { if($this.name){ return $this.name } else { $this.AppUrl } }
	
	SetType $Session "GradioSession"
	
	return $Session;
}

<#
	.SYNOPSIS
		Obtem toda as sessions criadas, ou uma com um nome específico.  
#>
function Get-GradioSession {
	[CmdletBinding()]
	param(
		#Especifique o nome da session.
		#* obtém todas 
		#. obtém a default
			[Parameter(ValueFromPipeline=$true)]
			[Alias("Name")]
			$Session = "*"
			
		,#Se -name é uma string, faz uma busca usando - operador -like 
			[switch]$Like
			
		,#Get by id (Session must by a id)
			[switch]$ById
	)
	
	$GradioSessions = GetCurrentProviderData -Context GradioSessions ;
	
	if(IsType $Session "GradioSession"){
		verbose "Is a GradioSession. Returning itself"
		
		if($ById){
			$Session = $Session.SessionId;
		} else {
			return $Session;
		}
	}
	
	$IsHfSpace = $false;
	if(IsType $Session "HuggingFaceSpace"){
		verbose "Is a HuggingFaceSpace"
		
		$ById = $true;
		$Session = $Session.control.GradioSession
		$IsHfSpace = $true;
	}
	
	if($ById){
		
		$Session = @($GradioSessions.values) | ? { $_.SessionId -eq $Session }
		
		if($Session){
			return $Session;
		}

		if($IsHfSpace){
			throw "POWERSHAI_HUGGINGFACE_GETSESSION_HFNOSESSION: Must connect to gradio using  Connect-HuggingFaceSpaceGradio"
		}
		
		throw "POWERSHAI_HUGGINGFACE_GETSESSION_HFNOSESSIONID: No session id foind (Id = $Session)";
		
		return;
	}
	
	#Assume que Sessio é u nome!
	[string]$Name = $Session
	
	
	if($name -eq "."){
		verbose "Asking default session";
		
		if($GradioSessions.count -eq 1){
			verbose "Just one session. Returning it as default";
			return @($GradioSessions.values)[0]
		}
		
		verbose "Getting current session name..."
		$Name = GetCurrentProviderData -Context DefaultGradioSession
		verbose "	IS: $Name"
		
		if(!$Name){
			throw "POWERSHAI_HUGGINGFACE_GRADIO_GETSESSIONS_DEFAULT: No default session defined!"
		}
	}

	if($Like){
		verbose "using like"
		@($GradioSessions.values) | ? { $_.Name -like $Name -or $_.Url -like $Name }
	}
	
	elseif($Name -eq "*"){
		verbose "Asking all"
		@($GradioSessions.values)
	} else {
		verbose "Getting by name $name";
		$Session = $GradioSessions[$Name];
		
		if(!$Session){
			throw "POWERSHAI_HUGGINGFACE_GRADIO_GETSESSIONS_NOTFOUND: $Name"
		}
		
		return $Session;
	}	
}


<#
	.SYNOPSIS
		Remove gradio session
#>
function Remove-GradioSession {
	[CmdletBinding()]
	param(
		#Especifique o nome da session.
		#* obtém todas 
		#. obtém a default
		[Parameter(ValueFromPipeline=$true)]
			$Name = "*"
	)
	
	begin {
		$GradioSessions = GetCurrentProviderData -Context GradioSessions;
		$DefaultSession = GetCurrentProviderData -Context DefaultGradioSession
	}

	process {
		if(IsType $Name "GradioSession"){
			$Name = $Name.name
		}
		
		$GradioSessions.Remove($Name);
		
		if($DefaultSession -eq  $name){
			SetCurrentProviderData -Context DefaultGradioSession $null
		}	
	}
}



<#
	.SYNOPSIS
		Define algumas opções da session.
#>
function Set-GradioSession {
	param(
		#Sessão Gradio 
			$Session = "."
		 
		,#Define a session como a default 
			[switch]$Default
			
		,#Configurar o maximo de calls. Veja mais em Invoke-GradioSessionApi
			$MaxCalls = $null 
		
		,#Configurar a policy de max calls Veja mais em Invoke-GradioSessionApi
			[ValidateSet("error","warning","remove")]
			$MaxCallsPolicy = $null
	)
	
	
	$Session = Get-GradioSession $Session;
	
	if($Default){
		SetCurrentProviderData -Context DefaultGradioSession $Session.name;
	}
	
	[string[]]$NonOptionsParams = "default";
	
	foreach($ParamName in @($PsBoundParameters.keys)){
		$ParamValue = $PsBoundParameters[$ParamName];
		
		if($ParamName -in $NonOptionsParams){
			continue;
		}
		
		verbose "Option $ParamName set";
		$Session.options[$ParamName] = $ParamValue;
	}
	
	
}


<#
	.SYNOPSIS
		Faz o upload de arquivos em uma sessao do Gradio!
		Retorna um objeto FileData para arquivo em que foi feito o upload e salva internalmente a referencia.
#>
function Send-GradioSessionFiles {
	[CmdletBinding()]
	param(
		$files
		,$Session = "."
	)
	
	$Session = Get-GradioSession $session;
	
	$FileItems = @();
	
	foreach($file in $files){
		
		if($file -is [string]){
			$file = Get-Item (Resolve-Path $file) -EA SilentlyContinue;
			
			if(!$file){
				throw "POWERSHAI_HUGGINGFACE_GRADIO_SENDFILESESSIN_NOTFOUND: $file";
			}
		}
		
		$FileItems += $file;
	}
	
	
	foreach($file in $fileItems){
		verbose "Uploading file $file"
		$Uploaded = Send-GradioFile -AppUrl $Session.AppUrl -files $file
		$Session.uploads[$file.FullName] = $Uploaded
		$Uploaded
	}
}


<#
	.SYNOPSIS
		Cria uma nova call para um endpoint na session atual.
		
	.DESCRIPTION  
		Realiza uma call usando a API do Gradio, em um endpoint especifico e passando os parâmetros desejados.  
		Esta call irá gerar um GradioApiEvent (veja Send-GradioApi), que irá ser salva internamente nas configuraçoes da sessão.  
		Este objeto contém tudo o que é necessário para obter o resultado da API.  
		
		O cmdlet irá retornar um objeto do tipo SessionApiEvent contendo as seguintes propriedades:
			id - Id interno do evento gerado.
			event - O evento interno gerado. Pode ser usado diretamente com os cmdlets que manipulam eventos.
			
		As sessions possuem um limite de Calls definidas.
		O objetivo é impedir criar calls indefinidas de maneira que perca o controle.
		
		Existem duas opcoes da sessao que afetam a call (podem ser alteradas com Set-GradioSession):
			- MaxCalls 
			Controla o maximo de calls que podem ser criadas
			
			- MaxCallsPolicy 
			Conrola o que fazer quando o Max for atingido.
			Valores possiveis:
				- Error 	= resulta em erro!
				- Remove 	= remove a mais antiga 
				- Warning 	= Exibe um warning, mas permite ultrpassar o limte.
		
#>
function Invoke-GradioSessionApi {
	[CmdletBinding()]
	param(
		 #Nome do endpoint (sem a barra inicial)
			$ApiName
			
		,#Lista de parâmetros 
		 #Se é um array, passa diretamente para a Api do Gradio 
		 #Se é uma hashtable, monta o array com base na posição dos parâmetros retornados pelo /info 
			$Params = $null
			
		,#SE especificado, cria com um evento id ja existente (pode ter sido gerado fora do modulo).
			$EventId = $null
			
		,#Sessao 
			$session = "."
	)

	verbose "Starting invoke api $ApiName"
	
	$Session 		= Get-GradioSession $Session;
	
	verbose "	SessionId: $($Session.SessionId)"
	
	$PropName 		= '/'+$ApiName
	$ApiEndpoint 	= $Session.info.named_endpoints.$PropName
	
	if(!$ApiEndpoint){
		throw "POWERSHAI_HUGGINGFACE_GRADIO_INVOKEAPI_NOAPI: Api name $ApiName not found"
	}
	
	if($EventId){
		$params = $mull
	}

	$ParamArray = @()
	if($params -is [hashtable]){
		verbose "Param is hashtable. Converting to array..."
		foreach($param in $ApiEndpoint.parameters){
			verbose "	Converting $ParamName";
			$ParamName = $param.parameter_name
			$UserValue = $Params[$ParamName];
			$ParamArray += ,$UserValue;
		}	
	} else {
		$ParamArray = $params;
	}
	
	$MyCalls 	= $Session.ApiCalls
	$CurrentCount = $MyCalls.AllEvents.count;
	
	$MaxCalls 		= $Session.options.MaxCalls
	$MaxCallsPolicy = $Session.options.MaxCallsPolicy

	if(!$MaxCalls){
		$MaxCalls = 10
	}

	if(!$MaxCallsPolicy){
		$MaxCallsPolicy = "error";
	}
	
	verbose "Calls: $CurrentCount/$MaxCalls, Policy = $MaxCallsPolicy"
	
	if($CurrentCount -ge $MaxCalls){
		verbose "MaxCalls reached: $CurrentCount/$MaxCalls";
		
		switch($MaxCallsPolicy.toLower()){
			"error" {
				throw "POWERSHAI_HUGINGFACE_GRADIOAPI_MAXCALLS: Max calls reached. $CurrentCount/$MaxCalls"
			}
			
			"remove" {
				$RemoveCount = $CurrentCount - $MaxCalls + 1;
				
				[object[]]$AllEvents = $MyCalls.AllEvents;
				
				1..$RemoveCount | %{ 
					$OldestEvent,$AllEvents  = @($AllEvents); 
					verbose "	Removed $($OldestEvent.EventId)" 
				}
				
				$MyCalls.AllEvents = @($AllEvents);
			}
			
			"warning" {
				write-warning "Max calls reached. $CurrentCount/$MaxCalls"
			}
		}
	}
	
	
	verbose "Invoking api..."
	$Evt 		= Send-GradioApi -AppUrl $Session.AppUrl -ApiName $ApiName -Params $ParamArray -EventId $EventId
	verbose "	Event: $($Evt.EventId)"
	
	$Id = $Evt.EventId;
	$SessionEvent = [PsCustomObject]@{
		id 			= $Id			# Id do evento !
		ApiEvent 	= $Evt			# objeto usado pra consultar os dados do evento e os resultados da api'
		Received 	= $false		# Flag que indica que o usuário já recebeyu os dados!
		LastReceivedIndex = $null 	# Controla o index do último pedaço de dados recebido!
	}
	
	$MyCalls.AllEvents += $SessionEvent;
	
	
	
	<# Pq nao usar apenas um id simples, numerico?
		Para evitar confucoes!
		O usuario tende a querer usar a sessao ativa.
		Ele erroneamente pode querer atualiar um evento que pertence a outra sessao, mas esquecer de mudar a sessao ativa.  
		Com Ids numrico, a chance do comando concluir é maior (concluir no id incorreto).
		Com ids alatorios (tipo o retornoado pela api) a chance de ser o mesmo é qual nula.
		Com isso evitamos que ele use ume vento enquanto está com outra sessao ativa.
	#>
	
	$MyCalls.ById[$Id] = $SessionEvent;
	SetType $SessionEvent "SessionApiEvent" 
	return $SessionEvent;
	
}

<#
	.SYNOPSIS
		Atualiza o retorno de uma call gerado como Invoke-GradioSessionApi
		
	.DESCRIPTION  
		Este cmdlet segue o mesmo princípcio dos seus equivalentes em Send-GradioApi e Update-GradioApiResult.
		Porém ele funciona apenas para os eventos gerados em uma sessão específica.
		Retorna o próprio evento para que possa ser usado com outos cmdlets que deendam do evento atualizado!
		
#>
function Update-GradioSessionApiResult {
	[CmdletBinding()]
	param(
		 #Id do evento, retornado por  Invoke-GradioSessionApi ou o próprio objeto retornado.
			[Parameter(ValueFromPipeline=$true)]
			$Id
			
		,#Não jogar o resultado de volta pro output!
			[switch]$NoOutput

		,#Max hearbeats consecutivos.
			$MaxHeartBeats = $null
			
		,#Id da sessão 
			$session = "."
			
	)
	
	$Session 	= Get-GradioSession $Session;
	
	if(IsType $Id "SessionApiEvent"){
		$Id = $Id.Id;
	}
	
	$Evt = $Session.ApiCalls.ById[$Id]
	
	if(!$Evt){
		throw "POWERSHAI_HUGGINGFACE_UPDATESESSIONAPI_INVALIDEVENT: Event with id $Id not found! Current session ok?";
	}
	
	$Evt.ApiEvent | Update-GradioApiResult -NoOutput:$NoOutput -MaxHeartBeats $MaxHeartBeats
}






<#
	.SYNOPSIS
		Retorna os dados recebidos por uma call da api e marca como recebido
		
	.DESCRIPTION
		Retorna os dados enviados pela API e marca como recebido (flag Received)
		O cmdlet irá marcar como recebido apenas quando o status for "complete". 
	
		Quando uma call é marcada como "received", é considerado que o usuário já processou os dados retornados.  
		Neste caso, assumimos que o objeto iuntero que represetna esta call não é mais necessário, e pode ser, por exemplo, removido autoamticamente!
		
		Por padrão, a função retorna todas os dados disponíveis.  
		Caso queria um retorno parcial, use parâmetro -Incremental, que ele irá retornar soemnte o pedaço retornado desde o último
		
		
		A chamadas e resultados das Apis do Gradio são feitos com Send-GradioApi e Update-GradioApiResult.
		Eles seguem a arquitetura da API do gradio , enviando as respostas gerados através de eventos.  
		Por isso, as chamadas da API nem sempre estarão disponíveis de imediato. 
		E, por isso, temos estes recursos de "receber" os dados de forma completa ou parcial.  
		Esta é apenas uma extensão do funcionamento da API Do Gradio de uma forma que funcione  melhro aqui no PowerShell.  
		Verifique a doc dos cmdlets mencionaods acimas para mais detalhes de como  API do Gradio e funciona e para conhecer os termos comuns.
		
		Retorna um objeto do tipo "GradioCallResult", que contém as seguintes props:
		
			data 		- Os dados recebeidos. Se -Incremental, somente os dados recebidos desde o último.
			start 		- Índice do array de ApiEvent.data onde o resultado começa.
			end 		- Último indcice do array em ApiEvent.data retornado. A próxima chamada incremental começará a partir desse.
			complete 	- Se true, indica que a api retornou todos os dados já e não há mais resultados 
			incremental - Se trye, indica que essa foi uma resposta incrementlal  
			error 		- Se houve erros, conterám os erros retornados pelo server.
			
		Se este cmdlet retornar $null, indica que ainda não há dados para retornar (ou não foi gerado nenhum desde o último , se -Incremental foi usado).
#>
function Receive-GradioSessionApi {
	[CmdletBinding()]
	param(
		 #Especifica o evento, ou eventos, a serem removidos
		 #Id também pode ser um desses valores especiais:
			[Parameter(ValueFromPipeline=$true)]
			$Id
			
		,#Obtém os dados que chegaram desde o últimor eceive!
			[switch]$Incremental

		,#Id da sessão 
			$session = "."
	)
	
	begin {
		$Session = Get-GradioSession $Session;
		$MyCalls = $Session.ApiCalls
	}
	
	process {
		
		if(IsType $Id "SessionApiEvent"){
			$EvtId = $Id.Id;
		} else {
			$EvtId = $Id;
		}
		
		$Evt = $MyCalls.ById[$EvtId]
		

		$CurrentIndex = $Evt.ApiEvent.data.length - 1;
		
		if($CurrentIndex -eq -1){
			#No data available!
			return;
		}
		
		$LastReceived 			= $Evt.LastReceivedIndex
		
		$RecData = [PsCustomObject]@{
			data 	= $Evt.ApiEvent.Data
			start 	= 0
			end 	= $CurrentIndex
			complete 	= $false 
			incremental = $Incremental.IsPresent
			error 		= $RecData.ApiEvent.error
		}
		
		if($Incremental){
			if($CurrentIndex -eq $LastReceivedIndex){
				#No new data!	
				return;
			}
			
			if($LastReceivedIndex -eq $null){
				$Start = 0
			} else {
				$Start = $LastReceivedIndex + 1
			}
			
			$End = $CurrentIndex
			
			$RecData.start 	= $Start
			$RecData.end 	= $End 
			$RecData.data 	= $RecData.data[$Start..$End]
		}
		
		
		$Evt.LastReceivedIndex 	= $CurrentIndex;
		
		if($Evt.ApiEvent.status -eq "complete"){
			$Evt.Received = $true;
			$RecData.complete = $true
		}
		
		
		SetType $RecData "GradioCallResult"
		write-output $RecData
	}
	
	
}




<#
	.SYNOPSIS
		Lista todos as calls de uma sessão
#>
function Get-GradioSessionApi {
	param(
		$Session = "."
	)
	
	$session = Get-GradioSession $Session
	$Evts = $Session.ApiCalls.AllEvents
	$Evts;
}


<#
	.SYNOPSIS
		Remove api cals da lista interna da sessão
		
	.DESCRIPTION  
		Este cmdlet auxilia na remoção de evenots gerados por Invoke-GradioSessionApi da lista internas de calls. 
		Normalmente, você quer remover os eventos que já processou, passanso o id direto.  
		Mas, este cmdlet permite fazer vários tipos de removação, incluindo eventos não procesando.  
		Use com cautela, pois, uma vez que um vento é removido da lista, os dados associados com ele também são removidos.  
		A menos que você tenha feito uma cópia do evento (ou dos dados resultantes) para uma outra variável, você não será mais capaz de recuperar estas informações.  
		
		A removação de evenots também é útil para ajudar a liberar a memória consumida, que, dependendo da quantidade de eventos e dados, pode ser alta.
		
#>
function Remove-GradioSessionApi {
	[CmdletBinding()]
	param(
		 #Especifica o evento, ou eventos, a serem removidos
		 #Id também pode ser um desses valores especiais:
		 #	clean - Remove todos as calls que não são mais necessária
		 
			[Parameter(ValueFromPipeline=$true)]
			$Id
			
		,#Força a remoção dos eventos, independente do status.  
		 #Por padrão, este cmdlet só remove os eventos em que o usuário marcou como "Recebido", usando Receive-GradioSessionApi
		 #Usando o -Force, ignora essa trava!
		 #Ao usar esta opção, uma confirmação é requerida, se está no modo interativo!
			[switch]$Force 
			
		
		
		,#Id da sessão 
			$session = "."
	)
	
	begin {
		$Session = Get-GradioSession $Session;
		$MyCalls = $Session.ApiCalls
		$RemoveCandidatesIds = @()
	}
	
	process {
		
		if(IsType $Id "SessionApiEvent"){
			$EvtId = $Id.Id;
		} else {
			$EvtId = $Id;
		}
		
		$RemoveCandidatesIds += $EvtId
		
		if($Id -eq "clean"){
			$force = $false
		}
	}
	
	end {
		
		$RemovedEvents = @();
		$UpdatedList = @()
		
		verbose "CurrentCallCount: $($MyCalls.AllEvents.count)"
		
		foreach($Event in $MyCalls.AllEvents){
			verbose "Checking call $($Event.id)";
			
			$IsCandidate = $Event.id -in $RemoveCandidatesIds -or $id -eq "clean"
			
			if($IsCandidate){
				verbose "	IsCandidate!"
				
				$MustRemove = $Event.received -eq $true -or $Force;
				
				verbose "	MustRemove? $MustRemove";
				
				if($MustRemove){
					verbose "	Added to removed list!"
					$RemovedEvents += $Event;
					$MyCalls.ById.Remove($Event.id);
					continue;
				}
			}
			
			
			$UpdatedList += $Event;
		}
		
		verbose "UpdatedCallCount: $($UpdatedList.count)"
		$MyCalls.AllEvents = $UpdatedList;
		
		return $RemovedEvents;
	}
	
	
}



<#
	.SYNOPSIS
		Invoca um endpoint da API. 
		
	.DESCRIPTION 
		Este é maisum cmdlet disponibilizado para invocar a API do Gradio!
		Os parâmetros são disponibilizados dinamicamente, portanto, o help deles não está dispnível com Get-Help.  
#>
function Invoke-GradioDynamicApi {
	[CmdletBinding()]
	param($ApiName, $Session = ".")
	

	DynamicParam {
		
		if(!$Session){
			$Session = "."
		}
		
		$Session = Get-GradioSession $session
		
		$PropName = '/'+$ApiName
		$ApiEndpoint = $Session.info.named_endpoints.$PropName
		
		if(!$ApiEndpoint){
			return;
		}
		
		$ParamDic = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()
		
		
		foreach($Param in $ApiEndpoint.parameters){
			$ParamName 		= $Param.parameter_name;
			
			$Attributes 	= [System.Collections.ObjectModel.Collection[System.Attribute]]::new()
			$ParamAttribute =  [Management.Automation.ParameterAttribute]@{ParameterSetName = "Api:$ApiName"; Mandatory = $false}
			$Attributes.Add($ParamAttribute);
			
			$CmdLetParam 	= [Management.Automation.RuntimeDefinedParameter]::new($ParamName, [string], $Attributes);
			
			$ParamDic.Add($ParamName, $CmdLetParam)
		}
		
		return $ParamDic
	}
	
	begin {
		if(!$ApiEndpoint){
			throw "POWERSHAI_HUGGINGFACE_GRADIO_APIINVOKE: Api name $ApiName not found"
		}
	}
	
	
	end {
		 $PsBoundParameters;
		 $ParamDic;
	}
}

<#


#>
function Convert-GradioParamPowershell {
	param(
		$Param
		,$value = $null
	)

	$TypeResult = [string]
	
	$TypeSchema = $Param.type
	$PythonType = $Param.python_type
	
	if($TypeSchema.title -eq "ListFiles"){
		return [IO.FileInfo[]]
	}
	
	if($TypeSchema.title -eq "FileData"){
		return [IO.FileInfo]
	}
	
	if($Param.component -in "Audio","Image"){
		return [IO.FileInfo]
	}
	
	
	if($TypeSchema.type -eq "array"){
		$TypeResult = Convert-GradioParamPowershell $TypeSchema.type.items
		$TypeName = $TypeResult.name;
		return [type]"$TypeName[]"
	}
	
	if($TypeSchema.type -like "*FileData*"){
		$TypeResult = [IO.FileInfo]
	}
	
	if($TypeSchema.type -eq "number"){
		$TypeResult = [int]
		
		if($PythonType.type -eq "float"){
			$TypeResult = [decimal]
		}
	}
	
	
	return $TypeResult;
}


<#
	.DESCRIPTION
		Cria funcoes que encapsulam as chamadas de um endpoint do Gradio (ou todos os endpoints).  
		Este cmdlet é muito útil para criar um interface (ou uma proxy funcitons) paraa API do Gradio, onde os parâmetros da API são criados como parâmetros da função.  
		Assim, recursos nativos do powershell, como auto complete, tipo de dados e documentação, podem ser usados e fica muito fácil invocar qualquer endpoint de uma sessão.
		
		O comando consulta os metadados dos endpoints e parâmetros e cria as funcoes powershell no escopo global.  
		Com isso, o usu[ario consegue invocar as funções diretamente, como se fossem funcoes normal.  
		
		O nome das funcoes criado segue o formato:  <Prefix><NomeOp>
			<Prefix> é o valor do parametro -Prefix deste cmdlet. 
			<NomeOp> é o nome da operacao, mantido somente letras e números
			
			Por exemploi, se a operção é /Op1, e o PRefixo INvoke-GradioApi, a seguinte funcao será criad: Invoke-GradioApiOp1
	
		
		As funcoes criadas contém a lógica necessária para transformar os parâmetros passados e executar o cmdlet Invoke-GradioSessionApi.  
		Ou seja, o mesmo retorno se aplica como se estivesse invocando este cmdlet diretamente.  
		(Isto é, um evento será retornado e adicionaod alista de eventos da sessao atual).
		
		Os parâmetros das funcoes podem variar conforme o endpoint, pois depende do endpoint. 
		Parâmetros que são arquivos, possuem um passo adicional de upload. O arquivo pode ser referenciado localemnte e o upload dele sera feito para o servidor.  
		Isso é uma oura grande vantagem de se usar esse cmdlet, pois isso fica transparente, e o usuário não precisa lidar com uploads.
		
		O seguinte diagrama resume as dependencias envolvidas:
		
			New-GradioSessionApiProxyFunction(Prefix)
				---> function <Prefix><OpName>
					---> Send-GradioSessionFiles (quando houer arquivos)
					---> return Invoke-GradioSessionApi
		
		Uma vez que Invoke-GradioSessionApi é a executada no fim das contas, todas as regras delas se aplicam.
		Você pode usar Remove-Item para remover estas funcoes!
#>
function New-GradioSessionApiProxyFunction {
	[CmdletBinding()]
	param(
		 #Criar somente para este endpoint em especifico 
			$ApiName = @()
		
		,#Prefixo das funcoes criadas 
			$Prefix 	= "Invoke-GradioApi"
		
		,#Sessao 
			[Parameter(ValueFromPipeline=$true)]
			$Session 	= "."
		
		,#Força  a criação da funcão, mesmo se já existir uma com o mesmo nome!
			[switch]$Force
	)
		
	$Session 	= Get-GradioSession $session	
	$AllProps	= $Session.info.named_endpoints.psobject.properties;
	
	foreach($Prop in $AllProps){
		$EpName = $Prop.Name -replace '^/','';
	
		if($ApiName -and $EpName -notin @($ApiName) ){
			continue;
		}
		
		$ApiEndpoint = $Prop.Value;
		
		$EpNameClean = (Get-Culture).TextInfo.ToTitleCase($EpName) -replace '[^A-z0-9]|_',''
		
		$FunctionName = $Prefix + $EpNameClean
		
		$FunctionParams = @();
		
		$ApiParams = $ApiEndpoint.parameters
		
		$DefaultParams = @(
			@{
					name 		= "Manual"
					type 		= '[switch]'
					IsDefault 	= $true
					Help		= 'Retorna o objeto que pode ser usado com Update-GradioSessionApiResult para manualmente obter os resultados!'
				}
				
			@{
					name 		= "DebugData"
					type 		= '[switch]'
					IsDefault 	= $true
					help 		= "Apenas para fins e debug. Retorna dados uteis para o debug da execucao da funcao"
			}
		)
		
		$ApiParams += $DefaultParams
	
		#Mapearo nome do prametro para o nome real!
		#Alguns nomes  de parametro podem não ser exatamente o nome na api, devido a limitacoes de nomenclatura do powershell!
		#Com esse map, consegumos manter a relacao!
		$ParamMap = @{}
		
		# Reserved Param anmes
		$ReserverParamsNames = $DefaultParams| %{ $_.name  }
		
		$ParamNum = -1;
		foreach($Param in $ApiParams){
			$ParamNum++;
			verbose "	Processig param $ParamNum"
			
			if($Param.IsDefault){
				
				$ParamDef = $Param.type + '$'+$Param.name
			
				$FunctionParams += @(
					($Param.help|%{"#$_"})
					$ParamDef
				) -Join "`n"	
				
				continue;
			}
			
			$ParamHelp 			= @();
			$GradioParamName 	= $Param.parameter_name;
			
			if($GradioParamName -in $ReserverParamsNames){
				$GradioParamName = $null
			}
			
			if(!$GradioParamName){
				$GradioParamName = "param" + $ParamNum;
			}
			
			
			$PsParamName 	= (Get-Culture).TextInfo.ToTitleCase($GradioParamName) -replace '[^A-z0-9]|_',''
			verbose "	GradioName: $GradioParamName, PsName: $PsParamName"
			
			$ParamName 		= '$' + $PsParamName
			$ParamDefault 	= '$null'
			

			$MapData = @{
				ParamNum 	= $ParamNum
				SrcParam 	= $Param
				MustUpload  = $false
				IsArray 	= $false
			}
			$ParamMap[$PsParamName] = $MapData;
		
			verbose "Getting type"
			$ParamType = Convert-GradioParamPowershell $Param
			verbose "	ParamType: $ParamType"

			$MapData.IsArray = $ParamType.IsArray
			$ElType = $ParamType.GetElementType()
			
			$TypeName = $ParamType.name;
			if($ElType){
				$TypeName = $ElType.Name;
			}
			
			if( [IO.FileInfo] -in $ElType,$ParamType){
				$MapData.MustUpload = $true
			}

			
			if($Param.parameter_has_default -and $Param.parameter_default){
				verbose "Parameter has default"
				$ParamDefault = $Param.parameter_default
				
				if($ParamType -eq [string]){
					$ParamDefault = "`"$ParamDefault`""
				}
			}
			
			$ParamDef = "[$ParamType]$ParamName = $ParamDefault"
			
			if($Param.label){
				$ParamHelp += $Param.label
			}
			
			if($Param.Component){
				$ParamHelp += "Gradio Component: " + $Param.Component;
			}
			
			if($MapData.MustUpload){
				$ParamHelp += "Upload!"
			}
			
			$FunctionParams += @(
					($ParamHelp|%{"#$_"})
					$ParamDef
				) -Join "`n"
		}
		
		$ParamBlock = $FunctionParams -Join "`n,"
		

			
		$FuncScript = {
			[CmdletBinding()]
			param($FuncData)
			
			$ErrorActionPreference = "Stop";
			
			if($FuncData.BoundParams.DebugData){
				return $FuncData;
			}
			
			$InvokedParams = @{};
			
			foreach($ParamName in $FuncData.ParamNames){
				$InvokedParams[$ParamName] = ($FuncData.Vars | ?{$_.Name -eq $ParamName}).Value
				
			}
			
			[bool]$IsVerbose = [bool]($FuncData.BoundParams.Verbose)
			
			#garante que usará a versão mais recente da sessão!
			write-verbose "checking existing session"
			$ExistingSession = Get-GradioSession -Name $Session.Name -EA SilentlyContinue -Verbose:$IsVerbose;
			
			if(!$ExistingSession){
				$msg = "POWERSHAI_HUGGINGFACE_GRADIO_APIPROXY_INVOKE_NOSESSION: Session was deleted or name was changed since proxy creation. Recreate the functions (SessonId = $($Session.SessionId))"
				throw New-PowershaiError $msg @{Session=$Session}
			}
			
			$Session = $ExistingSession
			
			

			
			#Construir o param map!
			$ParamNames = @($InvokedParams.keys);
			$ParamIndexes = @{}
			
			write-verbose "Processing Script..."
			
			
			
			foreach($ParamName in $ParamNames){
				write-verbose "	Processing parameter $ParamName";
				
				$PsParam = $ParamMap[$ParamName];
				
				if(!$PsParam){ # common parameter...
					continue;
				}
				
				$SrcParam = $PsParam.SrcParam;
				$MustUpload = $PsParam.MustUpload;
				
				
				$ParamValue = $InvokedParams[$ParamName];

				
				if($MustUpload){
					write-verbose "	Uploading...";
					$ParamValue = Send-GradioSessionFiles $ParamValue -Session $Session.Name
				}
				
				if($PsParam.IsArray -and $ParamValue -isnot [Array]){
					$ParamValue = ,$ParamValue
				}
				
				write-verbose "Setting param num $($PsParam.ParamNum)"
				$ParamIndexes[$PsParam.ParamNum] = $ParamValue;
			}
			
			$v = @{ ParamList = @() }
			@($ParamIndexes.keys) | Sort-Object | %{ $v.ParamList += ,$ParamIndexes[$_] }
			
	
			$InvokeParams = @{
				Session = $Session.Name # Força usar o name da session para busca, plois caso não exista mais forçará o erro!
				ApiName = $EpName
				Params 	= $v.ParamList
				Verbose = $IsVerbose 
			}
			
			$ApiResult = Invoke-GradioSessionApi @InvokeParams
			
			if($FuncData.BoundParams.Manual){
				return $ApiResult
			} 
			
			$ApiResult | Update-GradioSessionApiResult -Session $session.name
		}.GetNewClosure()
	
		#Este script cria a funcao com os parametros da API e suas docs.
		#Basicamente é um wrapper
		#Devido ao fato de ser uma func dinamica, quero evitar o maximo de codigo possível dentro dela, devido aos escapes
		#A maior parte do processamento é delgado pro ScriptBlock FuncScript. Nessa deixamos apenas a passagem dos parametros essenciais.
		$FunctionCreateScript = "
			<#
				.DESCRIPTION
					Proxy para App $($Session.AppUrl), Api: $EpName
			#>
			function global:$FunctionName {
				[CmdletBinding()]
				param(
					$ParamBlock	
				)
				
				[bool]`$IsVerbosePresent = [bool](`$PsBoundParameters.Verbose)
				
				write-verbose `"Wrapper Function: Calling internal FuncScript...`"
				& `$FuncScript -Verbose:`$IsVerbosePresent @{
					ParamNames 	= @(`$MyInvocation.MyCommand.parameters.keys) 
					BoundParams = `$PsBoundParameters
					Args 		= `$Args
					Vars 		= Get-Variable
				} 
			}
		"
		
		$ExistingCommand = Get-Command $FunctionName -EA SilentlyContinue
		$IsProxyFunction = IsType $ExistingCommand "GradioProxyFunction"
		
		if($ExistingCommand -and !$IsProxyFunction -and !$Force) {
			throw "POWERSHAI_HUGGINGFACE_NEWGRADIOPROXY_EXISTS: A function with name $FunctionName already exists. Remove it or use -force";
		}
		
		$ModScript = {
			param($data)
			
			$ErrorActionPreference = "Stop";
			
			$FuncScript = $data.FunctionBody
			
			Invoke-Expression $data.CreateScript
			Export-ModuleMember -Function $data.FunctionName
		}
		
		$ModData = @{
			CreateScript 	= $FunctionCreateScript
			FunctionBody 	= $FuncScript
			FunctionName  	= $FunctionName
		}
		
		verbose "Creating dummy module... FunctionScript:`n$FunctionCreateScript"
		$DummyMod = New-Module -Name PowershaiHfGradioProxy -ScriptBlock $ModScript  -ArgumentList $ModData
		verbose "	Importing dummy module"
		import-module -force $DummyMod 
		

		#verbose "	Getting function object...";
		#$DummyFunc = Get-Command -mo $DummyMod.name -name DummyFunction


		
		#Aqui vamos criar a funcao, no global scope, para ser acessivel ao user!
		#Um novo closure é necessario para que o script tenha acesso as variaveis FuncScript.
		#Set-Item "Function:$FunctionName" -Value $DummyFunc.ScriptBlock.GetNewClosure();
		
		$Function = Get-Command $FunctionName
		
		SetType $Function "GradioProxyFunction"
		
		$ProxyInfo = [PsCustomObject]@{
			session 	= $Session
			script 		= $FuncScript
			ApiName 	= $ApiName
		}
		
		$Function | Add-Member -Force Noteproperty GradioProxy $ProxyInfo
		
		write-output $Function;
	}
}
Set-Alias GradioApiFunction New-GradioSessionApiProxyFunction


<#
	.SYNOPSIS
		Retorna as funcoes criadas com New-GradioSessionApiProxy
#>
function Get-GradioSessionApiProxyFunction {
	[CmdletBinding()]
	param(
		$Session = "."
	)

	if($session -eq '*'){
		$filter = { $true }
	} else {
		$session = Get-GradioSession $Session
		$filter = { (IsType $_ "GradioProxyFunction") -and $_.GradioProxy.session -in @($session) }
	}
	

	Get-Command -Module PowershaiHfGradioProxy | ? $filter
}


<#
	.SYNOPSIS
		Remove funcoes criadas com  New-GradioSessionApiProxy (use Get-GradioSessionApiProxyFunction) para retornar!
#>
function Remove-GradioSessionApiProxyFunction {
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$true)]
		$Function
	)

	process {
		Remove-Item "Function:\$($Function.name)"
	}
	
}


# 🤗🤗🤗🤗🤗🤗 cmdlets
# Desde ponto em diantes são implementados cmdlets para uso com o Hugging Face.


<#
	Esta função é usada como base para invocar a API da OpenAI!
#>
function InvokeHfApi {
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method = 'GET'
		,$StreamCallback = $null
		,$Token = $null
		,[switch]$NoToken
		,$timeout = $null
	)

	$Provider = Get-AiCurrentProvider
	verbose "current provider = $($Provider.name)"

	if(!$Token){
		$Token = GetCurrentProviderData -Context Token;
	}

	if(!$Token){
		$TokenEnvName = GetCurrentProviderData -Context TokenEnvName;
		
		if($TokenEnvName){
			write-verbose "Trying get token from environment var: $($TokenEnvName)"
			$Token = (get-item "Env:$TokenEnvName"  -ErrorAction SilentlyContinue).Value
		}
	}	
	
	$headers = @{}
	if($Token){
		 $headers["Authorization"] = "Bearer $token"
	}


	
	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		$BaseUrl = GetCurrentProviderData BaseUrl
		$url = "$BaseUrl/$endpoint"
	}

	$JsonParams = @{Depth = 10}
	
	if($method -eq "GET"){
		$ReqBody = $body
	} else {
		verbose "InvokeGoogleApi: Converting body to json (depth: $($JsonParams.Depth))... $($body|out-string)"
		$ReqBodyPrint = $body | ConvertTo-Json @JsonParams
		verbose "ReqBody:`n$($ReqBodyPrint|out-string)"
		$ReqBody = $body | ConvertTo-Json @JsonParams -Compress	
	}

	
	
    $ReqParams = @{
        data            = $ReqBody
        url             = $url
        method          = $method
        Headers         = $headers
		timeout 		= $timeout
    }

			
	if($StreamCallback){
		$ReqParams['SseCallBack'] = $StreamCallback
	}


	write-verbose "ReqParams:`n$($ReqParams|out-string)"
    $RawResp 	= InvokeHttp @ReqParams
	write-verbose "RawResp: `n$($RawResp|out-string)"
	
	$ContentTypeParts =  $RawResp.headers["Content-Type"] -split ";\s?"
	$ContentType = $ContentTypeParts[0];
	
	if($contentType -eq "application/json"){
		 return $RawResp.text | ConvertFrom-Json
	}
	
	return $RawResp;
}



<#
	.SYNOPSIS
		Invoca a API do Hugging Hub.
		https://huggingface.co/docs/hub/en/api
#>
function Invoke-HuggingFaceHub {
	[CmdletBinding()]
	param(
		$endpoint
		,$search  = $null
		,$author = $null
		,$filter = $null
		,$direction = $null
		,$limit = $null
		,$sort = $null
		,[switch]$Desc
		,[switch]$full
		,[switch]$config
		,$RawParams = @{}
		,#Igora o token atual e lista somente recursos públicos 
			[switch]$Public
			
		,#usa um token especifico
			$Token = $null
	)
	
	$BaseUrl = "https://huggingface.co"
	
	$FullUrl = "$BaseUrl/api/$endpoint"
	

	$params = @{}
		
	if($search){
		$params.search = $search
	}
	
	if($author){
		$params.author = $author
	}
	
	if($filter){
		$params.filter = $filter
	}
	
	if($direction){
		$params.direction = $direction
	}
	
	if($limit){
		$params.limit = $limit
	}
	
	if($sort){
		$params.sort = $sort
	} else {
		if($Desc){
			$params.sort = -1
		}
	}
	
	if($full){
		$params.full = $true
	}
	
	if($config){
		$params.config = $true
	}
	
	foreach($k in @($RawParams.keys)){
		$params[$k] = $RawParams[$k];
		write-verbose " Parameter $k comes from raw"
	}
	
	$DynParams = @{}
	
	if($Public){
		$DynParams['NoToken'] = $true;
	}
	
	InvokeHfApi $FullUrl -body $Params -token $token @DynParams
}
Set-alias Set-HfToken Set-HuggingFaceToken
Set-alias Invoke-HfHub Invoke-HuggingFaceHub

<#
	.SYNOPSIS
		Obtém informacoes do usuário logado atualmente
		https://huggingface.co/docs/hub/api#get-apiwhoami-v2
#>
function Get-HuggingFaceWhoami {
	[CmdletBinding()]
	param(
		# usar um token alternaitvo para checar validade!
		$token = $null
	)
	
	Invoke-HuggingFaceHub 'whoami-v2' -token $token
}
Set-Alias Get-HfWhoami Get-HuggingFaceWhoami
Set-Alias Get-HfMe Get-HuggingFaceWhoami


<#
	.SYNOPSIS
		Define o token do Hugging Face
#>
function Set-HuggingFaceToken {
	[CmdletBinding()]
	param()
	
	$ErrorActionPreference = "Stop";
	
	$Provider = Get-AiCurrentProvider -Context
	$creds = Get-Credential "HUGGING FACE ACCESS TOKEN";
	
	$TempToken = $creds.GetNetworkCredential().Password;
	
	verbose "Checking token...";
	try {
		$Me = Get-HuggingFaceWhoami -token $TempToken
	} catch [System.Net.WebException] {
		$resp = $_.exception.Response;
		
		verbose "Error: $_";
		if($resp.StatusCode -eq 401){
			throw "INVALID_TOKEN: Token is not valid!"
		}
		
		throw;
	}
	
	SetCurrentProviderData -Context Token $TempToken;
	write-host -ForegroundColor green "	TOKEN ALTERADO!";
	return;
}
Set-alias Set-HfToken Set-HuggingFaceToken


<#
	.SYNOPSIS
		Invoca a API de Inferência Hugging Face
		https://huggingface.co/docs/hub/en/api
#>
function Invoke-HuggingFaceInferenceApi {
	[CmdletBinding()]
	param(
		$model
		,$params
		,[switch]$Public
		,#Forçar usar endpoint de chat completion 
		 #Params deverá ser tratado como o mesmo params da Api da Openai (Veja o cmdle Get-OpenaiChat).
		 #Mais info: https://huggingface.co/blog/tgi-messages-api
		 #So funciona com modelos que possuem um chat template!
			[switch]$OpenaiChatCompletion
		
		,#Stream Callback para ser usado no caso de streamS!
			$StreamCallback = $null
	)
	
	$BaseUrl = "https://api-inference.huggingface.co/models/"
	
	
	$FullUrl = $BaseUrl + $model
	
	if($OpenaiChatCompletion){
		$FullUrl += "/v1/chat/completions"
		
		$NewParams = @{}
		$params.keys | %{ $NewParams[$_] = $Params[$_] }
		
		$NewParams.remove("messages");
		
		$OpenAiChat = @{
			prompt 			= $Params.messages 
			RawParams 		= $NewParams
			model 			= $model
			StreamCallback 	= $StreamCallback
			endpoint 		= $FullUrl
		}
		
 		$result = Get-OpenaiChat @OpenAiChat
		return $result;
	}
	
	$DynParams = @{}
	if($Public){
		$DynParams['NoToken'] = $true;
	}
	
	InvokeHfApi $FullUrl -body $Params -method POST -StreamCallback $StreamCallback @DynParams;
}
Set-alias Invoke-HfInference Invoke-HuggingFaceInferenceApi



function huggingface_FormatPrompt {
	param($model)
	
	return "🤗 $($model): "
}

#Retorna os top 50 models de texto mais baixados!
function huggingface_GetModels {
	param()
	
	$Models = Invoke-HuggingFaceHub "models" -config -filter "text-generation-inference" -limit 200 -sort downloads -desc 
	$Models = $models | ? { $_.config.tokenizer_config.chat_template } | select -first 50
	
	$Models | Add-Member -Force AliasProperty -Name name -Value "id"
	
	return $models;
}

function huggingface_Chat {
	param(
         $prompt
        ,$temperature   = 0.6
        ,$model         = $null
        ,$MaxTokens     = 1000
		,$ResponseFormat = $null
		
		,#Function list, as acceptable by Openai
		 #OpenAuxFunc2Tool can be used to convert from powershell to this format!
			$Functions 	= @()	
			
		#Add raw params directly to api!
		#overwite previous
		,$RawParams	= @{}
		
		,$StreamCallback = $null
    )
	
	if($Functions){
		throw "POWERSHAI_HUGGINGFACE_CHAT: Functions no supported";
	}
	
	$OriginalParams = $PsBoundParameters;
	$OriginalParams.messages = $PsBoundParameters.prompt;
	$OriginalParams.remove("prompt");
	$OriginalParams.remove("StreamCallback");
	
	$Params = @{
		model 					= $model
		OpenaiChatCompletion	= $true 
		StreamCallback			= $StreamCallback
		params 				 	= $OriginalParams
	}
	
	Invoke-HuggingFaceInferenceApi @Params	
}


<#
	.SYNOPSIS
		Obtém informacoes de um model especifico
#>
function Get-HuggingFaceModel {
	[CmdletBinding()]
	param(
		#Filtra por um space especifico
		$Model
	)
	

	$ResultModel = Invoke-HuggingFaceHub "models/$Model" -full
	
	$ResultModel | Add-Member -Force Noteproperty control $control
	
	SetType $ResultModel "HuggingFaceModel"
	
	return $ResultModel;
	
}
Set-alias Get-HfModel Get-HuggingFaceModel

<#
	.SYNOPSIS
		Obtém informacoes de um space específocp!
#>
function Get-HuggingFaceSpace {
	[CmdletBinding()]
	param(
		#Filtra por um space especifico
			[Parameter(Position=0,ParameterSetName="Single")]
			$Space 
			
		,#Filtrar todos os spaces por autor
			[Parameter(ParameterSetName="Multiple")]
			$author
				
		,#Filtrar todos os spaces do usuario atual!
			[Parameter(ParameterSetName="Multiple")]
			[switch]$My
	)
	
	if(IsType $space "HuggingFaceSpace"){
		return $Space;
	}
	
	if($My){
		$Me = Get-HuggingFaceWhoami
		$author = $Me.name;
	}
	
	if($author){
		Invoke-HuggingFaceHub "spaces" -author $author
		return;
	}
	
	$ResultSpace = Invoke-HuggingFaceHub "spaces/$space" -full
	
	$control = @{
		GradioSession = $null
	}
	
	$ResultSpace | Add-Member -Force Noteproperty control $control
	
	SetType $ResultSpace "HuggingFaceSpace"
	
	return $ResultSpace;
	
}
Set-alias Get-HfSpace Get-HuggingFaceSpace


<#
	.SYNOPSIS
		Aguarda o space iniciar. Retorna $true se iniciou cmo sucesso ou $false se deu timeout!
#>
function Wait-HuggingFaceSpace {
	[CmdletBinding()]
	param(
		#Filtra por um space especifico
		[Parameter(Position=0,ValueFromPipeline=$true)]
			[object]$Space
		
		,#Quantos segundos, no maximo, augardar. Se null, entaoa guarda indefinidamente!
			$timeout = $null
			
		,#Tempo de espera até o próxomo chechk, em ms
			$SleepTime = 5000
			
		,#dont print progress status...
			[switch]$NoStatus
			
		,#Nao inicia, apenas faz o wait!
			[switch]$NoStart
	)
	
	$LastStage = $null;
	
	if($Space -is [string]){
		$SpaceId = $space
	} elseif($Space.id) {
		$LastStage = $Space.runtime.stage
		if($LastStage -eq "RUNNING"){
			return $true;
		}
		
		$SpaceId = $Space.id
		
		write-warning "Stage: $LastStage" ;
	}
	
	$Started = ([bool]$NoStart)

	$Start = (Get-Date);
	while($true){
		$Space = Get-HuggingFaceSpace -space $SpaceId
		$SpaceStage = $Space.runtime.stage;
		
		if($LastStage -ne $SpaceStage){
			write-warning " Stage changed to $SpaceStage";
		}
		$LastStage = $SpaceStage;
		
		
		#Força o start no space...
		if(!$Started){
			$null = Start-HuggingFaceSpace $SpaceId
			$Started = $true;
		}
	
		
		write-verbose "	Space $space stage is $SpaceStage"
		
		if($Space.runtime.stage -eq "RUNNING"){
			return $true;
		}
		
		$Elapsed = (Get-Date) - $Start;
		
		if($timeout -ne $null -and $Elapsed.TotalSeconds -gt $timeout){
			return $false;
		}
		
		write-verbose "Sleeping before check space status again. Time: $SleepTime ms"
		start-sleep -m $SleepTime;
	}
}
Set-alias Wait-HfSpace Wait-HuggingFaceSpace


<#
	.SYNOPSIS
		Faz um Space do Hugging Face iniciar, caso esteja em sleeping.
#>
function Start-HuggingFaceSpace {
	[CmdletBinding()]
	param($space)
	
	$Space = Get-HuggingFaceSpace $space;
	
	$SpaceHost 			= $Space.host;
	$HuggingFaceToken 	= GetCurrentProviderData Token
	$JobTimeout 		= 5;
	
	#$Job = Start-Job {
	#	param($SpaceHost,$Token,$JobTimeout)
	#	$ErrorActionPreference = "Stop";
	#	
	#	$result = Invoke-WebRequest -Method HEAD -MaximumRedirection 0 -TimeoutSec $JobTimeout -uri $SpaceHost -Headers @{Authorization = "Bearer $Token"}
	#	
	#	return $result.StatusCode
	#} -ArgumentList  $SpaceHost,$HuggingFaceToken,$JobTimeout  | Wait-Job -Timeout $JobTimeout 
	
	
	try {
		#$JobResult = $job | Receive-Job
		
		try {
			verbose "touching space for startup..."
			$result = InvokeHfApi $SpaceHost -method HEAD -timeout 5000
		} catch {
			if ($_.Exception -eq "timeout"){
				verbose "Wait timedout...";
			} else {
				throw;
			}
		}
		
		if($result.status -notin 200,206){
			throw "StatusResult: $($result.status) $($result.text)";
		}
	} catch {
		write-warning "Start Failed: $_"
	}
}





<#
	.SYNOPSIS
		Conecta com o Gradio de um Hugging Face Space!
#>
function Connect-HuggingFaceSpaceGradio {
	[CmdletBinding()]
	param(
		#Space no qualc onectar!
		[Parameter(ValueFromPipeline=$true)]
		$space
	
		,#Force connect 
			[switch]$Force
	)
	
	$Space = Get-HuggingFaceSpace $Space;
	
	$GradioSession = $Space.control.GradioSession
	
	$SessionExists = Get-GradioSession -ById $GradioSession -EA SilentlyContinue;
	
	if($SessionExists -and !$Force){
		verbose "Session already connected";
		return;
	}
	
	$GradioHost = $Space.Host;
	verbose "Creating session: $GradioHost"
	$GradioSession = New-GradioSession -Name "Space:$($space.id)" -AppUrl $GradioHost
	$Space.control.GradioSession = $GradioSession.SessionId
	return $GradionSession
}



return @{
	RequireToken 	= $false
	TokenEnvName 	= "HF_API_TOKEN"
	
	info = @{
		desc	= "Hugging Face"
		url 	= "https://huggingface.co/"
		
	}
}

