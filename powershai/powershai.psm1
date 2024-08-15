<#
	POWERSHAI - Powershell + Inteligência Artificial 
	Autor: Rodrigo Ribeiro Gomes
	https://powertuning.com.br/
	https://iatalk.ing
	
	
	LICENÇA DE USO 
		
		Este projeto tomou várias horas minhas, da minha família e até com minha filha recém nascida.
		Dia, tarde, madrugada. Vários conhecimentos embutidos aqui da PowerShell que acumulei em uma vida...
		
		Mas, mesmo assim, eu resolvi manter ele aberto e free, e o objetivo é mantê-lo FREE para sempre!
		É uma forma também de retribuir a comunidade técnica por tudo que já aprendi com ela!
		
		Isto é, você pode baixar, usar no seu computador, na sua empresa, vender embutido com algum produto, etc.
		Em suma, você é livre para usá-lo de forma comercial e não-comercial.
		
		Meu único pedido é que sempre mantenha a menção ao projeto original: https://github.com/rr92/powershai
		Deixe os créditos para o autor Rodrigo Ribeiro Gomes, da empresa Power Tuning, o qual também permitiu que eu usasse horas do meu trabalho para mexer com este código.
		Se o PowershAI te ajuda em algum projeto, eu ficarei muito orgulhoso em saber disso e essa menção certamente ajudará minha carreira de algum forma!
		Esta menção pode ser feita em qualquer lugar do seu projeto, como:
			- créditos 
			- help 
			- documentações públicas
			- Git do seu projeto 
			- menu de help
		
	
		Um OBRIGADO ESPECIAL à Power Tuning que sempre me deu a liberdade para conduzir esses projetos, mesmo usando horas da empresa!
		https://powertuning.com.br/
	
	
	USAGE LICENSE (English)

		This project took several hours of my time, my family’s time, and even time with my newborn daughter.  
		Day, afternoon, and late night. Several pieces of PowerShell knowledge accumulated over a lifetime are embedded here...

		But even so, I decided to keep it open and free, and the goal is to keep it FREE forever!  
		It's also a way of giving back to the technical community for everything I've learned from it!

		That means you can download it, use it on your computer, in your company, sell it embedded with a product, etc.  
		In short, you are free to use it commercially and non-commercially.

		My only request is that you always keep the mention of the original project: https://github.com/rr92/powershai  
		Give credit to the author, Rodrigo Ribeiro Gomes, from Power Tuning, who also allowed me to use work hours to deal with this code.  
		If PowershAI helps you in any project, I would be very proud to know that, and this mention will certainly help my career in some way!  
		This mention can be made anywhere in your project, such as:  
		  - credits  
		  - help  
		  - public documentation  
		  - your project’s Git  
		  - help menu

		A SPECIAL THANK YOU to Power Tuning, who has always given me the freedom to lead these projects, even using company hours!  
		https://powertuning.com.br/  
#>
$ErrorActionPreference = "Stop";

if(!$Global:POWERSHAI_SETTINGS){
	$Global:POWERSHAI_SETTINGS = @{
		provider = $null #ollama, huggingface
		baseUrl  = $null
		
		#providers settings!
		providers = @{}
		
		# commands 
		# Lista de comandos adicionados pelo usuario!
		UserTools = @{}
	}
}

$PROVIDERS = @{}
$POWERSHAI_USER_TOOLBOX = $null;

if(!$Global:POWERSHAI_SETTINGS.chats){
	$Global:POWERSHAI_SETTINGS.chats = @{}
}

if(!$Global:POWERSHAI_SETTINGS.OriginalPrompt){
	$Global:POWERSHAI_SETTINGS.OriginalPrompt = $Function:prompt
}

if(!$Global:POWERSHAI_SETTINGS.UserTools){
	$Global:POWERSHAI_SETTINGS.UserTools = @{}
}


# Aux/helper functions!
# funcoes usadas para auxiliar alguma operacao ou encasuplar logica complexa!
# Função genérica para invocar HTTP e com um minimo de suporte a SSE (Server Sent Events)
Function InvokeHttp {
	[CmdLetBinding()]
	param(
		$url 			= $null
		,[object]$data 	= $null
		,$method 		= "GET"
		,$contentType 	= "application/json; charset=utf-8"
		,$headers 		= @{}
		,$SseCallBack 	= $null
	)
	$ErrorActionPreference = "Stop";
	

	
	#Converts a hashtable to a URLENCODED format to be send over HTTP requests.
	Function verbose {
		$ParentName = (Get-Variable MyInvocation -Scope 1).Value.MyCommand.Name;
		write-verbose ( $ParentName +':'+ ($Args -Join ' '))
	}
		
		
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
		
	Function Hash2Qs {
		param($Data)
		
		
		$FinalString = @();
		$Data.GetEnumerator() | %{
			write-verbose "$($MyInvocation.InvocationName): Converting $($_.Key)..."
			$ParamName = MoviDesk_UrlEncode $_.Key; 
			$ParamValue = Movidesk_UrlEncode $_.Value; 
		
			$FinalString += "$ParamName=$ParamValue";
		}

		$FinalString = $FinalString -Join "&";
		return $FinalString;
	}


	try {
	
		#building the request parameters
		if($method -eq 'GET' -and $data){
			if($data -is [hashtable]){
					$QueryString = Hash2Qs $data;
			} else {
					$QueryString = $data;
			}
			
			if($url -like '*?*'){
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

		
		#building the body..
		if($data -and 'POST','PATCH','PUT' -Contains $method){
			if($data -is [hashtable]){
				verbose "Converting input object to json string..."
				$data = $data | ConvertTo-Json;
			}
			
			verbose "Data to be send:`n$data"

			# Transforma a string json em bytes...
			[Byte[]]$bytes = [system.Text.Encoding]::UTF8.GetBytes($data);
			
			#Escrevendo os dados
			$Web.ContentLength = $bytes.Length;
			verbose "  Bytes lengths: $($Web.ContentLength)"
			
			
			verbose "  Getting request stream...."
			$RequestStream = $Web.GetRequestStream();
			
			
			try {
				verbose "  Writing bytes to the request stream...";
				$RequestStream.Write($bytes, 0, $bytes.length);
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
			verbose "  charset: $($HttpResp.CharacterSet) encoding: $($HttpResp.ContentEncoding). ContentType: $($HttpResp.ContentType)"
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
				
				while($SseResult -ne $false){
					verbose "  Reading next line..."
					$line = $IO.ReadLine()
					
					verbose "	Content: $line";
					
					$Lines += $line;
					
					verbose "	Invoking callback..."
					$SseResult = & $SseCallBack @{ line = $line; num = $LineNum; req = $Web; res = $HttpResp; stream = $IO }
				}
				
				$Result.text = $Lines;
				$Result.stream = $true;
			} else {
				verbose "  Reading response stream...."
				$Result.text = $IO.ReadToEnd();
			}
			
			verbose "  response json is: $responseString"
		}
		
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

function JoinPath {
	$Args -Join [IO.Path]::DirectorySeparatorChar
}


function RegArgCompletion {
	param(
		$Command
		,$Parameter
		,$Script
	)
	
	if(Get-Command -EA SilentlyContinue Register-ArgumentCompleter){
		@($Command) | %{
			Register-ArgumentCompleter -CommandName $_ -ParameterName $Parameter -ScriptBlock $Script
		}
	}
}

#Thanks from: https://www.powershellgallery.com/packages/DRTools/4.0.2.3/Content/Functions%5CInvoke-AESEncryption.ps1
function Invoke-AESEncryption {
    [CmdletBinding()]
    [OutputType([string])]
    Param
    ( 
        [Parameter(Mandatory = $true)]
        [ValidateSet('Encrypt', 'Decrypt')]
        [String]$Mode,

        [Parameter(Mandatory = $true)]
        [String]$Key,

        [Parameter(Mandatory = $true, ParameterSetName = "CryptText")]
        [String]$Text,

        [Parameter(Mandatory = $true, ParameterSetName = "CryptFile")]
        [String]$Path
    )

    Begin {
        $shaManaged = New-Object System.Security.Cryptography.SHA256Managed
        $aesManaged = New-Object System.Security.Cryptography.AesManaged
        $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::CBC
        $aesManaged.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
        $aesManaged.BlockSize = 128
        $aesManaged.KeySize = 256
    }

    Process {
        $aesManaged.Key = $shaManaged.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Key))

        switch ($Mode) {
            'Encrypt' {
                if ($Text) {$plainBytes = [System.Text.Encoding]::UTF8.GetBytes($Text)}
                
                if ($Path) {
                    $File = Get-Item -Path $Path -ErrorAction SilentlyContinue
                    if (!$File.FullName) {
                        Write-Error -Message "File not found!"
                        break
                    }
                    $plainBytes = [System.IO.File]::ReadAllBytes($File.FullName)
                    $outPath = $File.FullName + ".aes"
                }

                $encryptor = $aesManaged.CreateEncryptor()
                $encryptedBytes = $encryptor.TransformFinalBlock($plainBytes, 0, $plainBytes.Length)
                $encryptedBytes = $aesManaged.IV + $encryptedBytes
                $aesManaged.Dispose()

                if ($Text) {return [System.Convert]::ToBase64String($encryptedBytes)}
                
                if ($Path) {
                    [System.IO.File]::WriteAllBytes($outPath, $encryptedBytes)
                    (Get-Item $outPath).LastWriteTime = $File.LastWriteTime
                    return "File encrypted to $outPath"
                }
            }

            'Decrypt' {
                if ($Text) {$cipherBytes = [System.Convert]::FromBase64String($Text)}
                
                if ($Path) {
                    $File = Get-Item -Path $Path -ErrorAction SilentlyContinue
                    if (!$File.FullName) {
                        Write-Error -Message "File not found!"
                        break
                    }
                    $cipherBytes = [System.IO.File]::ReadAllBytes($File.FullName)
                    $outPath = $File.FullName -replace ".aes"
                }

                $aesManaged.IV = $cipherBytes[0..15]
                $decryptor = $aesManaged.CreateDecryptor()
                $decryptedBytes = $decryptor.TransformFinalBlock($cipherBytes, 16, $cipherBytes.Length - 16)
                $aesManaged.Dispose()

                if ($Text) {return [System.Text.Encoding]::UTF8.GetString($decryptedBytes).Trim([char]0)}
                
                if ($Path) {
                    [System.IO.File]::WriteAllBytes($outPath, $decryptedBytes)
                    (Get-Item $outPath).LastWriteTime = $File.LastWriteTime
                    return "File decrypted to $outPath"
                }
            }
        }
    }

    End {
        $shaManaged.Dispose()
        $aesManaged.Dispose()
    }
}

function PowerShaiEncrypt {
	param($str, $password)
	
	Invoke-AESEncryption -Mode Encrypt -text $str -key $password
}

function PowerShaiDecrypt {
	param($str, $password)
	
	Invoke-AESEncryption -Mode Decrypt -text $str -key $password
}

function PowershaiHash {
	param($str)
	
	$shaManaged = New-Object System.Security.Cryptography.SHA256Managed
	[System.Convert]::ToBase64String($shaManaged.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($str)))
}

# Meta functions
# Esssas funcoes devem ser usadas para obter informacoes!
function Get-AiCurrentProvider {
	$ProviderName = $POWERSHAI_SETTINGS.provider;
	$ProviderSlot = $PROVIDERS[$ProviderName];
	return $ProviderSlot;
}

# Muda o provider!
function Set-AiProvider {
	[CmdletBinding()]
	param($provider, $url)
	
	$ProviderSettings = $PROVIDERS[$provider];
	
	if(!$ProviderSettings){
		throw "POWERSHAI_PROVIDER_INVALID: $provider";
	}
	
	switch($provider){
		"ollama" {
			if($url){
				$ProviderSettings.DefaultUrl 	= "$url/v1"
				$ProviderSettings.ApiUrl 		= "$url/api"	
			}
		}

		default {
			if($url){
				$ProviderSettings.DefaultUrl 	= "$url/v1"
			}
		}
	}
	
	
	$POWERSHAI_SETTINGS.provider = $provider;
	$POWERSHAI_SETTINGS.funcbase = $provider+"_";
}



# Invoca uma funcao do provider atual!
function PowerShaiProviderFunc {
	param($FuncName, $FuncParams, [switch]$Ignore)
	
	$FuncPrefix = $POWERSHAI_SETTINGS.funcbase;
	$FullFuncName = $FuncPrefix + $FuncName;
	
	if(!$FuncParams){
		$FuncParams = @{}
	}
	
	if(Get-Command $FullFuncName -EA SilentlyContinue){
		& $FullFuncName @FuncParams
	} else {
		if(!$Ignore){
			throw "POWERSHAI_PROVIDERFUNC_NOTFOUND: FuncName = $FuncName, FuncPrefix = $FuncPrefix, FullName = $FullFuncName. This erros can be a bug with powershai. Ask help in github or search!"
		}
	}
	
}

# function 
function GetProviderData {
	param($name, $Key)
	
	$UserDefined 	= $POWERSHAI_SETTINGS.providers[$name];
	$provider 		= $PROVIDERS[$name]
	
	$UserSetting 	= $UserDefined[$Key];
	$DefaultSetting	= $Provider[$key];
	
	if($UserDefined.contains($Key)){
		return $UserSetting
	}
	
	return $DefaultSetting
}

function SetProviderData {
	param($name, $Key, $value)
	
	$UserDefined = $POWERSHAI_SETTINGS.providers[$name];
	$UserDefined[$key] = $value;
}

function GetCurrentProviderData {
	param($key)
	
	$Provider = Get-AiCurrentProvider
	GetProviderData -name $Provider.name -key $key
}

function SetCurrentProviderData {
	param($key, $value)
	$Provider = Get-AiCurrentProvider
	SetProviderData -name $provider.name -key $key -value $value;
}

# obtem a lista de providers !
function Get-AiProviders {
	param()
	
	@($PROVIDERS.keys) | %{
		$Provider = $PROVIDERS[$_];
		$ProviderInfo = [PSCustomObject](@{name = $_} + $Provider.info)
		
		$ProviderInfo
	}
}


# Get all models!
$POWERSHAI_MODEL_CACHE = @{
	Provider = $null
	ModelList = $null
}

<#
	.DESCRIPTION
		Lista os modelos disponíveis no provider atual.  
		A única informação garantida de retorno em qualquer provider é o "id", ue é o id do modelo.  
		As demais proproiedades são exclusivas de cada provider.
		O id é o valor referenciado nos demais cmdlets desse módulo.
#>
function Get-AiModels {
	[CmdletBinding()]
	param()
	$ModelList = PowerShaiProviderFunc "GetModels"
	
	$POWERSHAI_MODEL_CACHE.ModelList = $ModelList | %{$_.name} 
	$POWERSHAI_MODEL_CACHE.Provider = (Get-AiCurrentProvider).name
	
	return $ModelList
}


function GetModelsId {
	
	$CurrentProvider = Get-AiCurrentProvider
	
	
	if(!$POWERSHAI_MODEL_CACHE.ModelList){
		$null = Get-AiModels
	}
	
	if($CurrentProvider.name -ne $POWERSHAI_MODEL_CACHE.Provider){
		$null = Get-AiModels
	}

	$POWERSHAI_MODEL_CACHE.ModelList
}


# Configura o default model!
function Set-AiDefaultModel {
	[CmdletBinding()]
	param($model, [switch]$Force)
	
	$ElegibleModels = @(Get-AiModels | ? { $_.name -like $model+"*" })
	$ExactModel 	= $ElegibleModels | ?{ $_.name -eq $model }
	
	write-verbose "ElegibleModels: $($ElegibleModels|out-string)"
	
	if(!$ElegibleModels){
		if($Force){
			write-warning "Model not found with that name. Forcing usage...";
			SetCurrentProviderData DefaultModel $model;
			return;
		} else {
			throw "POWERSHAI_INVALID_MODEL: $model. Use -force to for usage!";
		}
	}
	
	if($ElegibleModels.count -ge 2 -and !$ExactModel){
		throw "POWERSHAI_DEFAULTMODEL_AMBIGUOUS: Existem vários modelos com o mesmo nome $model e nenhum com este nome exato. Seja mais específico."
	}
	
	$model = $ElegibleModels[0].name
	
	if($ElegibleModels.count -eq 1 -and !$ExactModel){
		write-warning "Modelo exato $model nao encontrado. Usnado o único mais próximo: $model"
	}
	
	SetCurrentProviderData DefaultModel $model;
}


RegArgCompletion Set-AiDefaultModel model {
	param($cmd,$param,$word,$ast,$fake)
	
	GetModelsId | ? {$_ -like "$word*"} | %{$_}
}

# Funcao generica de chat. Segue a especificacao da OpenAI
function Get-AiChat {
	[CmdletBinding()]
	param(
         $prompt
        ,$temperature   = 0.6
        ,$model         = $null
        ,$MaxTokens     = 200
		,$ResponseFormat = $null
		
		,#Sobrescrever a lista de funcoes!
		 #Por padrão, este cmdlet irá checar adicionar estas funcoes a lista:
		 #		InternalFunctions 	- Lista de funcoes internas
		 #		UserFunctions		- Lista de funcoes adiconadas usandos os cmdslet *-AiTool
		 #Ao usar este parametro, voce sobrescreve esse comportamento
			$Functions 	= @()	
			
		#Add raw params directly to api!
		#overwite previous
		,$RawParams	= @{}
		
		,$StreamCallback = $null
	)
	
	$Provider = Get-AiCurrentProvider
	$FuncParams = $PsBoundParameters;

	if(!$model){
		$FuncParams['model'] = GetCurrentProviderData DefaultModel
	}

	
	PowerShaiProviderFunc "Chat" -FuncParams $FuncParams;
}


<#
	.DESCRIPTION
		Esta é uma função auxiliar para ajudar a fazer o processamento de tools mais fácil com powershell.
		Ele lida com o processamento das "Tools", executando quando o modelo solicita!
		Apenas converse normalmente, defina as funções e deixe que este comando faça o resto!
		Não se preocupe em processar a resposta do modelo, se tem que executar a função, etc.
		O comando abaixo já faz tudo isso pra você. 
		

		COMO AS TOOLS SÃO INVOCADAS  

			Este comando irá usar as tools enviadas no parâmetro -Functions para invocá-las e executá-las diretamente nesta sessão do Powershell.
			Ele espera um objeto que chamammos de OpenaiTool, contendo as seguintes props:
			
			@{
				# é o objeto com o schema, documentado da OpenAI, a ser passado ao modelo (parametro tools da API)
				# O nome das funcoes enviados segue um padrão, documentado abaixo.
				tools = @{} 
				
				#Este é um scriptblock que deve retonar um comando a ser executado 
				# se nao informaod, usa o proprio nome de comando como executável!
				map = {
					param(
						$Name # Nome da tool 
						$OpenaiTool #Este proprio objeto Openaitool
					)
					
					return @{
						# comando a ser executado!
						# Deve ser um comando invocavel pelo powershell como scrip block, nome de funcao, funao em arquivo, script, etc.
						func = function|scriptblock|funcao
					}
				}
			}
			
			Além dessas propriedades, qualquer outra é livre para ser retornado, que pode ser usada pelo script de map!
			
			Quando o modelo solicita a execucao de uma (ou mais) funcoes, este cmdlet irá determinar qual a OpenaiTool onde este comando foi definido.
			Ele faz isso olhando o "tools" que é apssado e filtrando pelo nome retronado pelo modelo.  
			
			Então, ele executa o script "map" dessa tool passando o nome da tool invocada e o proprio obejto OpenaiTool onde foi definido.  
			E o script então segue sua logica para devolver uma funcao executável.  
			Cada cmdlet de cada provider deve implementar sua propria logica para execucao dessa funcao!
			
			Os argumentos dessas funcoes são enviados pelo modelo, conforme o schema que foi montando e enviado em tools.  
			Note que, este recurso só funciona com providers que suportem modelos que suportem o Tool Calling com exatamente o mesmo params e retorno da OpenAI.  
				
				
					

		Para um exemplo de como implementar funcoes que retornem esse format, veja no provider openai.ps1, os comandos que comecam com Get-OpenaiTool*
#>
function Invoke-AiChatTools {
	[CmdletBinding()]
	param(
		$prompt
		
		,# Array de tools, conforme explicado na doc deste comando
		 # Use os resultado de Get-OpenaiTool* para gerar os valores possíveis.  
		 # Você pode passar um array de objetos do tipo OpenaiTool.
		 # Se uma mesma funcoes estiver definida em mais de 1 tool, a primeira encontrada na ordem definida será usada!
			$Tools		= $null
			
		,$PrevContext		= $null
		,# máx output!
			$MaxTokens			= 500	
		,# No total, permitir no max 5 iteracoes!
			$MaxRequests  		= 5		
		,# Quantidade maximo de erros consecutivos que sua funcao pode gerar antes que ele encerre.
			$MaxSeqErrors 		= 2	

			
		,$temperature		= 0.6	
		,$model 			= $null
		
		,# Event handler
		# Cada key é um evento que será disparado em algum momento por esse comando!
		# eventos:
		#	answer: disparado após obter a resposta do modelo (ou quando uma resposta fica disponivel ao usar stream).
		#	func: disparado antes de iniciar a execução de uma tool solicitada pelo modelo.
		# 	exec: disparado após o modelo executar a funcao.
		# 	error: disparado quando a funcao executada gera um erro
		# 	stream: disparado quando uma resposta foi enviada (pelo stream) e -DifferentStreamEvent
		# 	beforeAnswer: Disparado após todas as respostas. Util quando usado em stream!
		# 	afterAnswer: Disparado antes de iniciar as respostas. Util quando usado em stream!
			$on				= @{} 	
									
		,# Envia o response_format = "json", forçando o modelo a devolver um json.
			[switch]$Json				
		
		,#Adicionar parâmetros customizados diretamente na chamada (irá sobrescrever os parâmetros definidos automaticamente).
			$RawParams			= $null
			
		,[switch]$Stream
	)
	
	$ErrorActionPreference = "Stop";
	
	# Converts the function list user passed to format acceptable by openai!
	$OpenaiTools = @()

	#toolbox = conjutno de várias tools que foi gerada a partir de um script file, grupo de funcoes, etc.
	# é cada item passado em Tools (Chamamos de toolbox para desambiguar com o cocneito original de tool da openai)
	$FunctionMap = @{}
	foreach($Toolbox in @($Tools)){
		foreach($Tool in $Toolbox.tools){
			$OpenaiTools += $Tool ;
			$FunctionName 	= $Tool.function.name;
			
			if($FunctionMap[$FunctionName]){
				write-warning "Tool $ToolName duplicate..."
			} else {
				$FunctionMap[$FunctionName] = @{
					SrcBox = $Toolbox
				}
			}
		}
	}
	
	# initliza message!
	[object[]]$Message 	= @($prompt);
	
	$TotalPromptTokens 	= 0;
	$TotalOutputTokens 	= 0;
	
	$AllInteractions = @();
	
	$emit = {
		param($evtName, $interaction)
		
		$evtScript = $on[$evtName];
		
		if(!$evtScript){
			return;
		}
		
		try {
			$null = & $evtScript $interaction @{event=$evtName}
		} catch {
			write-warning "EventCallBackError: $evtName";
			write-warning $_
			write-warning $_.ScriptStackTrace
		}
	}
			
	
	# Vamos iterar em um loop chamando o model toda vez.
	# Sempre que o model retornar pedindo uma funcao, vamos iterar novamente, executar a funcao, e entregar o resultado pro model!
	$ReqsCount = 0;
	$FuncSeqErrors = 0; #Indicates how many consecutive errors happens!
	:Main while($true){
		#Vamos avançr o numero de requests totais que ja fizemos!!
		$ReqsCount++;
		
		#This object is created every request and will store all data bout interaction!
		$AiInteraction = NewAiInteraction
		$AiInteraction.req = $ReqsCount;
		
		# Parametros que vamos enviar a openai usando a funcao openai!
		$Params = @{
			prompt 			= $Message
			temperature   	= $temperature
			MaxTokens     	= $MaxTokens
			Functions 		= $OpenaiTools
			model 			= $model
			RawParams		= $RawParams
		}
		
		$StreamProcessingData = @{
			num = 1
		}
		$ProcessStream = {
			param($Answer)
			
			$AiInteraction.stream = @{
				answer 	= $Answer
				emiNum 	= 0
				num 	= $StreamProcessingData.num++
			}
			
			
			
			& $emit "stream" $AiInteraction
		}
	
		
		if($Stream){
			$Params['StreamCallback'] = $ProcessStream
		}
		
		if($Json){
			#https://platform.openai.com/docs/guides/text-generation/json-mode
			$Params.ResponseFormat = "json_object";
			$Params.prompt += "s: Response in JSON";
		}
		
		$AiInteraction.sent = $Params;
		$AiInteraction.message = $Message;
		
		# Se chegamos no limite, então naos vamos enviar mais nada!
		if($ReqsCount -gt $MaxRequests){
			$AiInteraction.stopReason = "MaxReached";
			write-warning "MaxRequests reached! ($ReqsCount)";
			break;
		}
		
		
		write-verbose "Sending Request $ReqsCount";
		# manda o bla bla pro gpt...
		& $emit "send" $AiInteraction
		$Answer = Get-AiChat @Params;
		$AiInteraction.rawAnswer = $Answer;
		$AllInteractions += $AiInteraction;
		
		& $emit "answer" $AiInteraction
		
		if($Answer.stream){
			$ModelResponse = $Answer
		} else {
			$ModelResponse = $Answer.choices[0];
		}
		
		write-verbose "FinishReason: $($ModelResponse.finish_reason)"
		
		$WarningReasons = 'length','content_filter';
		
		if($ModelResponse.finish_reason -in $WarningReasons){
			write-warning "model finished answering due to $($ModelResponse.finish_reason)";
		}
	
		# Model asked to call a tool!
		if($ModelResponse.finish_reason -eq "tool_calls"){
			
			# A primeira opcao de resposta...
			$AnswerMessage = $ModelResponse.message;
		
			# Add current message to original message to provided previous context!
			$Message += $AnswerMessage;
			
			$ToolCalls = $AnswerMessage.tool_calls
			
			write-verbose "TotalToolsCals: $($ToolCalls.count)"
			foreach($ToolCall in $ToolCalls){
				$CallType = $ToolCall.type;
				$ToolCallId = $ToolCall.id;
				
				write-verbose "ProcessingTooll: $ToolCallId"
				
				try {
					if($CallType -ne 'function'){
						throw "POWERSHAI_CHATTOOLS_INVALID_LLM_CALLTYPE: Tool type $CallType not supported"
					}
					
					$FuncCall = $ToolCall.function
					
					#Get the called function name!
					$FuncName = $FuncCall.name
					write-verbose "	FuncName: $FuncName"
					
					#Build the response message that will sent back!
					$FuncResp = @{
						role 			= "tool"
						tool_call_id 	= $ToolCallId
						
						#Set to a default message!
						content	= "ERROR: Some error ocurred processing function!";
					}
					
					# acha a tool na lista!
					$FunctionInfo = $FunctionMap[$FuncName]
					
					if(!$FunctionInfo){
						throw "POWERSHAI_CHATTOOLS_NOFUNCTIONMAP: Function $FuncName was invoked, but no function map found. This can be PowershAI bug or LLM incorrect call!"
					}
					
					$SrcToolbox = $FunctionInfo.SrcBox;
					$NoSplatArgs = $false;
					if($SrcToolbox.map){
						try {
							$MapResult = (& $SrcToolbox.map $FuncName $SrcToolbox)
							$TheFunc = $MapResult.Func
							$NoSplatArgs = $MapResult.NoSplatArgs;
						} catch {
							write-warning "POWERSHAI_CHATTOOLS_PSMAP_ERROR: ChatTools failed get command name for tool $FuncName"
							throw
						}
					} else {
						$TheFunc = $FuncName
					}
					
					if(!$TheFunc){
						throw "POWERSHAI_CHATTOOLS_NOFUNCTION: No function name was returned by map of $FuncName. This can be a bug of Powershai or LLM wrong call."
					}
					
					#Here wil have all that we need1
					$FuncArgsRaw =  $FuncCall.arguments
					write-verbose "	Arguments: $FuncArgsRaw";
					
					#We assuming model sending something that can be converted...
					$funcArgs = $FuncArgsRaw | ConvertFrom-Json;
					
					#Then, we can call the function!
					$ArgsHash = @{};
					$funcArgs.psobject.properties | %{ $ArgsHash[$_.Name] = $_.Value  };
					
					$CurrentToolResult = @{ 
						hash 	= $ArgsHash
						obj 	= $funcArgs 
						name 	= $FuncName
						id 		= $ToolCallId
						resp 	= $FuncResp
					}
					
					$AiInteraction.toolResults += $CurrentToolResult
					
					& $emit "func" $AiInteraction $CurrentToolResult
					
					write-verbose "Calling function $FuncName ($FuncInfo)"
					
					if($NoSplatArgs){
						$ArgsHash = @($ArgsHash)
					}
					
					$FuncResult = & $TheFunc @ArgsHash 
					
					if($FuncResult -eq $null){
						$FuncResult = @{};
					}
					
					$FuncResp.content = (Format-PowershaiContext $FuncResult)
					& $emit "funcresult" $AiInteraction $CurrentToolResult $FuncResult
					
					
					
					# TODO: Add formatter!
					
					
					$FuncSeqErrors = 0;
				} catch {
					$err = $_;
					
					& $emit "error" $AiInteraction
					
					#Add curent error to this object to caller debug...
					$AiInteraction.error = $_;
					
					#just log in screen to caller know about these errors!
					write-warning "Processing answer of model resulted in error. Id = $ToolCallId";
					write-warning "FuncName:$FuncName, Request:$ReqsCount"
					write-warning ("ERROR:")
					write-warning $err
					write-warning $err.ScriptStackTrace
					
					$FuncResp.content = "ERROR:"+$err;
					
					#Resets the seq errorS!
					$FuncSeqErrors++;
					$AiInteraction.seqError = $FuncSeqErrors;
					if($FuncSeqErrors -ge $MaxSeqErrors){
						$AiInteraction.stopReason = "MaxSeqErrorsReached";
						write-warning "Stopping due to max consecutive errors";
						break Main;
					}
				}
				
				& $emit "exec" $AiInteraction
				
				$Message += $FuncResp;
			}
			
			#Start sending again...
			continue;
		}
		
		# se chegou aqui é pq o gpt processou tudo e nao precisou invocar uma funcao!
		#entao, podemos encerrar a bagaça!
		break;
	}
	
	$AllAnswers = $AllInteractions | %{ $_.rawAnswer };
	$AnswerCost = Get-OpenAiAnswerCost $AllAnswers
	
	return @{
		answer 			= $Answer 			# last answer					
		interactions	= $AllInteractions
		tools 			= $OpenAiTools
		costs 			= $AnswerCost
	}
}







# security FUNCTIONS


<#
	.SYNOPSIS 
		Export current settings protected by user password
#>
function Export-PowershaiSettings {
	[CmdletBinding()]
	param(
		$ExportDir = $Env:POWERSHAI_EXPORT_DIR
		,[switch]$Chats
	)
	
	$Password = Get-Credential "ExportPassword";
	
	$FinalData = @{
		IsRemoved = $true
	}
	
	if(!$ExportDir){
		$ExportDir = JoinPath $Home .powershai 
		$null = New-Item -Force -Itemtype Directory -Path $ExportDir;
	}
	
	write-verbose "ExportDir: $ExportDir";
	$ExportFile = JoinPath $ExportDir "exportedsession.xml"
	
	$Check 		= [Guid]::NewGuid().Guid
	
	write-verbose "Hashing check: $Check";
	$CheckHash 	= PowershaiHash $Check
	
	$ExportData = @{};
	
	foreach($KeyName in @($POWERSHAI_SETTINGS.keys) ){
		$ExportData[$KeyName] = $POWERSHAI_SETTINGS[$KeyName];
	}
	
	if(!$Chats){
		$ExportData.Remove("chats");
	}
	
	write-verbose "Serializaing..."
	$Serialized =  [System.Management.Automation.PSSerializer]::Serialize($ExportData);
	$Decrypted = @(
		"PowerShai:$($Check):$CheckHash"
		$Serialized;
	) -Join "`n"
	
	
	write-verbose "Encrypting... Serialized: $($Serialized.length)"
	$Encrypted = PowerShaiEncrypt -str 	$Decrypted -password $Password.GetNetworkCredential().Password
	
	Set-Content -Path $ExportFile  -Value $Encrypted;
	
	write-host "Exported to: $ExportFile";
	#$POWERSHAI_SETTINGS | Export-CliXml $ExportFile
}

<#
	.SYNOPSIS 
		Import current settings
#>
function Import-PowershaiSettings {
	[CmdletBinding()]
	param($ExportDir = $Env:POWERSHAI_EXPORT_DIR)
	

	if(!$ExportDir){
		$ExportDir = JoinPath $Home .powershai;
	}
	
	write-verbose "ExportDir: $ExportDir";
	$ExportedFile = JoinPath $ExportDir "exportedsession.xml"
	
	if(-not(Test-Path $ExportedFile)){
		write-warning "Nothing to import at $ExportedFile";
		return;
	}
	
	$Encrypted = Get-Content $ExportedFile;
	write-verbose "	Encrypted content length: $($Encrypted.length)"
	$Password = Get-Credential "file password";
	$DecryptKey = $Password.GetNetworkCredential().Password
	
	try {
		$Decrypted = PowerShaiDecrypt $Encrypted $DecryptKey;
	} catch {
		write-warning "Decrypted process failed. Can be some bug of powershai. Check errors!";
		throw;
	}
	
	$Lines 		= $Decrypted -split "`n",2
	$CheckData 	= $Lines[0]
	$Data 		= $Lines[1];
	
	write-verbose "CheckData: $CheckData";
	$CheckParts = $CheckData -split ":";
	$CheckGuid  = $CheckParts[1]
	$CheckExpected = $CheckParts[2];
	$CurrentCheckGuid = PowershaiHash $CheckGuid
	
	
		
	if($CheckExpected -ne $CurrentCheckGuid){
		write-verbose "Expected: $CheckExpected | Current = $CurrentCheckGuid | SavedGuid = $CheckGuid"
		throw "POWERSHAI_IMPORTSESSION_INVALIDGUID: Failed decrypt. Check if your password is correct!";
	}
	
	$ExportedObject =  [System.Management.Automation.PSSerializer]::Deserialize($Data);
	
	foreach($key in @($ExportedObject.keys)){
		write-verbose "Importing setting key $key";
		$POWERSHAI_SETTINGS[$key] = $ExportedObject[$key]
	}
	write-host "Session settings imported";
}

# POWESHAI CHAT 
# Implementacao do Chat Client do POWERSHAI

<#
	Comando ChaTest.
	Com este comando você pode conversar direto do prompt com o modelo!.
	Ele também é um belo teste de todos os outros comandos e funcionalidades disponíveis aqui!
	
	Note que isso pode consumir bastante dos seus tokens!
	
	Syntaxe:
		Converse com
	
	DEPRECIADO. SErá substuido em beve polos *-PowershaiChat
#>
function Invoke-PowershaiChat {
	[CmdletBinding()]
	param(
		$Functions 		= $Null
		,$MaxTokens 	= 200
		,$MaxRequests	= 10
		,$SystemMessages = @()
		
		,#Desliga o stream 
			[switch]$NoStream
		
		,#Specify a hash table where you want store all results 
			$ChatMetadata 	= @{}
	)
	
	$ErrorActionPreference = "Stop";
	
	function WriteModelAnswer($interaction, $evt){
		$WriteParams = @{
			NoNewLine = $false
			ForegroundColor = "Cyan"
		}
		
		$Stream = $interaction.stream;
		$str = "";
		$EventName = $evt.event;
		
		function FormatPrompt {
			$str = PowerShaiProviderFunc "FormatPrompt" -Ignore -FuncParams @{
				model = $model
			}
			
			write-host "Prompt format: $str"
			if($str -eq $null){
				$str = "🤖 $($model):";
			}
			
			return $str;
		}
		
		
		if($Stream){
			$PartNum 	= $Stream.num;
			$text 		= $Stream.answer.choices[0].delta.content;
			
			$WriteParams.NoNewLine = $true;
			
			if($PartNum -eq 1){
				$str = FormatPrompt
			}

			if($text){
				$Str += $text
			}
			
			if($EventName -eq "answer"){
				$str = "`n`n";
			}
		} else {
			#So entrará nesse quando o stream estiver desligado!
			$ans 	= $interaction.rawAnswer;
			$text 	= $ans.choices[0].message.content;
			$model 	= $ans.model;
			$prempt = FormatPrompt;
			$str 	= "`$($prempt): $text`n`n" 
		}
		
		if($str){
			write-host @WriteParams $Str;
		}
	}

	$ChatHistory = @()
	$ChatStats = @{
		TotalChats 	= 0
		
		TotalCost 	= 0
		TotalInput 	= 0
		TotalOutput = 0
		
		TotalTokensI = 0
		TotalTokensO = 0
	}
	
	$ChatMetadata.history 	= $ChatHistory;
	$ChatMetadata.stats 	= $ChatStats
	
	$VerboseEnabled = $False;
	$MustStream = $true;
	
	if($NoStream){
		$MustStream = $False;
	}
	
	write-host "Carregando lista de modelos..."
	$SupportedModels = Get-AiModels
	
	write-host "Montando estrutura de functions..."
	$Funcs = OpenAuxFunc2Tool $Functions;
	
	try {
		$CurrentUser = Get-LocalUser -SID ([System.Security.Principal.WindowsIdentity]::GetCurrent().User)
		$FullName = $CurrentUser.FullName;
		$UserAllNames = $FullName.split(" ");
		$UserFirstName = $UserAllNames[0];
	} catch {
		write-verbose "Cannot get logged username: $_"
	}
	

	
	write-host "Iniciando..."
	# $Ret = Invoke-AiChatTools -temperature 1 -prompt @(
	# 	"Gere uma saudação inicial para o usuário que está conversando com você a partir do módulo powershell chamado PowerShai"
	# )  -on @{
	# 	stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
	# 	answer = {param($inter,$evt) WriteModelAnswer $inter $evt}
	# }  -Stream:$MustStream
	
	
	$model = $null
	$UseJson = $false;
	$ShowFullSend = $false;
	$ShowTokenStats = $false;
	$MaxContextSize = 8192 # Vou considerar isso como o número de caracter por uma questão simples...
						   # futuramente, o correto é trabalhar com tokens!
	
	$ChatUserParams = @{
		model 		= $model
		MaxRequest 	= $MaxRequests
		MaxTokens 	= $MaxTokens
		Json 		= $false
		RawParams	= @{
			options = @{
				stop = "|fim|"
			}
		}
	}
	
	function ParsePrompt($prompt) {
		$parts 		= $prompt -split ' ',2
		$cmdName	= $parts[0];
		$remain		= $parts[1];
		
		$result = @{
			action = $null
			prompt = $null;
		}
		
		write-verbose "InputPrompt: $cmdName"
		
		switch($cmdName){
			"/reload" {
				write-host "Reloading function list...";
				$Funcs = OpenAuxFunc2Tool $Functions;
				Set-Variable -Scope 1 -Name Funcs -Value $Funcs
			}
			
			"/retool" {
				write-host "Redefinindo a lista de tools: $remain";
				$Funcs = OpenAuxFunc2Tool $remain;
				Set-Variable -Scope 1 -Name Funcs -Value $Funcs
			}
			
			"/maxcontext" {
				Set-Variable -Scope 1 -Name MaxContextSize -Value ([int]$remain)
			}
			
			"/models" {write-host $($SupportedModels|out-string)}
			{'.cls','/clear','/cls','.c' -contains $_} {clear-host}
			
			# sets 
			"/von"  {Set-Variable -Scope 1 -Name VerboseEnabled -Value $true;}
			"/voff" {Set-Variable -Scope 1 -Name VerboseEnabled -Value $false;}
			"/json" {Set-Variable -Scope 1 -Name UseJson -Value $true }
			"/jsoff" {Set-Variable -Scope 1 -Name UseJson -Value $false }
			"/fullon" {Set-Variable -Scope 1 -Name ShowFullSend -Value $true }
			"/fulloff" {Set-Variable -Scope 1 -Name ShowFullSend -Value $false }
			"/tokon" {Set-Variable -Scope 1 -Name ShowTokenStats  -Value $true }
			"/tokoff" {Set-Variable -Scope 1 -Name ShowTokenStats  -Value $false }
			"/p" { 
				#Split!
				$paramPair = $remain -split ' ',2
				$paramName = $paramPair[0]
				$paramValStr = $paramPair[1];
				
				if(!$paramValStr){
					write-host $($ChatUserParams|out-string);
					return;
				}
				
				if(!$ChatUserParams.contains($paramName)){
					write-warning "No parameter existing with name: $paramName"
					return;
				}

				$ParamVal = $ChatUserParams[$paramName];
				
				if($ParamVal -eq $null){
					write-warning "Value is null. Setting as str value!";
					$NewVal = $paramValStr
					return;
				} else {
					$NewVal = $ParamVal.getType()::Parse($paramValStr);
				}
				
				$ChatUserParams[$paramName] = $NewVal;
				write-host "Changed PARAM $paramName from $ParamVal to $NewVal" 
			}
			
			"/reqs" { 
				$OldVal = $MaxRequests;
				Set-Variable -Scope 1 -Name MaxRequests -Value [int]$remain;
				write-host "Changed Maxtokens from $OldVal to $MaxRequests"
			}
			
			"/ps" {
				function prompt(){ "PowershAI>> " }
				write-warning "Entering in nested prompt";
				$host.EnterNestedPrompt();
			}
			
			"/model" {
				write-host "Changing model...";
				$newModel 		= $remain;
				$chosenModel 	= $null;
				
				#find all candidates!
				while($true){
					$ElegibleModels = @( $SupportedModels | ? { $_.id -like $newModel } );
					
					if($ElegibleModels.length -eq 1){
						$model = $ElegibleModels[0].id;
						break;
					}
					
					write-warning "Refine your search (search:$newModel)";
					write-host $($ElegibleModels|Sort-Object id|out-string)
					$newModel = read-host "Filter model"
				}
				
				$ChatUserParams['model'] = $model
				write-host "	Changed model to: $model"
			}
			
			default {
				$result.action = "prompt";
				$result.prompt = $prompt;
			}
		}
		
		return $result;
	}
	
	$ChatContext = @{
		messages = @()
		size = 0
	}
	function AddContext($msg) {

		while($ChatContext.size -ge $MaxContextSize -and $ChatContext.messages){
			$removed,$LeftMessages = $ChatContext.messages;
			
			$ChatContext.messages = $LeftMessages;
			
			$RemovedCount = $removed.length;
			if($removed.content){
				$RemovedCount = $removed.content.length;
			}
			
			write-verbose "Removing Length: $removed $RemovedCount"
			$ChatContext.size -= [int]$RemovedCount;
		}
		
		$ChatContext.messages += @($msg);

		if($msg.content){
			$ChatContext.size += $msg.content.length;
		} else {
			$ChatContext.size += $msg.length;
		}
	}
	
	$LoopNum = 0;
	$InternalMessages = @();
	
	try {
		write-verbose "Verbose habilitado..." -Verbose:$VerboseEnabled;
		$LoopNum++;
		
		if($LoopNum -eq 1){
			$Prompt = @()
			
			$InternalMessages += @(
				"Você é um agente que está conversando com o usuário partir do PowershAI, um módulo powershell para interagir com IA"
			)

			if($UserFirstName){
				$InternalMessages += "O nome do usuário é: "+$UserFirstName;
			}
			
			$Prompt = "Conversa iniciada: Gere uma mensagem inicial:"
			$Prompt = $Prompt -Join "`n";
		} else {
			$InternalMessages = @();
			
			if($UserFirstName){
				$PromptLabel = $UserFirstName
			} else {
				$PromptLabel = "Você"
			}
			
			write-host -NoNewLine "$PromptLabel>>> "
			$prompt = read-host
		}
		
		$Msg = @(
			@($SystemMessages|%{ [string]"s: $_"})
			@($InternalMessages|%{ [string]"s: $_"})
			[string]"u: $prompt"
		)
		
		
		$Msg | %{ AddContext $_ };
		
		if($ShowFullSend){
			write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
		}
	

		$ChatParams = $ChatUserParams + @{
			prompt 		= $ChatContext.messages
			Functions 	= $Funcs 
			Stream		= $MustStream
			on 			= @{
						
						send = {
							if($VerboseEnabled){
								write-host -ForegroundColor DarkYellow "-- waiting model... --";
							}
						}
						
						stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
						answer = {param($inter,$evt) WriteModelAnswer $inter $evt}

						
						func = {
							param($interaction)
							
							$ans = $interaction.rawAnswer;
							$model = $ans.model;
							$funcName = $interaction.toolResults[-1].name
							
							write-host -ForegroundColor Blue "$funcName{..." -NoNewLine
						}
				
						exec = {
							param($interaction)
							
							write-host -ForegroundColor Blue "}"
							write-host ""
						}
				}
		}
		
		if($VerboseEnabled){
			$ChatParams.Verbose = $true;
		}
		
		
		
		$Start = (Get-Date);
		$Ret 	= Invoke-AiChatTools @ChatParams;
		$End = Get-Date;
		$Total = $End-$Start;
		
		foreach($interaction in $Ret.interactions){ 
		
			if($interaction.stream){
				$Msg = $interaction.rawAnswer.message
			} else {
				$Msg = $interaction.rawAnswer.choices[0].message;
			}
		
			

			AddContext $Msg
			
			$toolsResults = $interaction.toolResults;
			if($toolsResults){
				$toolsResults | %{ AddContext $_.resp }
			}
			
			
			
		}
		
		
		#Store the historu of chats!
		$ChatMetadata.history += @{
								Ret = $Ret
								Elapsed = $Total
							}
		$ChatHistory = $ChatMetadata.history;
		
		$AllAnswers 	= @($Ret.interactions | %{$_.rawAnswer});
		$AnswersCost	= $Ret.costs
		
		
		# current chat
		$AnswerCount 	= $AllAnswers.count;
		$TotalCost 		= $AnswersCost.total
		$InputCost 		= $AnswersCost.input
		$OutputCost 	= $AnswersCost.output
		$TotalTokens 	= $AnswersCost.tokensTotal
		$InputTokens 	= $AnswersCost.tokensInput
		$OutputTokens 	= $AnswersCost.tokensOutput
		
		# all chats
		$ChatStats.TotalChats += $ChatHistory.count;
		$TotalChats = $ChatStats.TotalChats
		
		## COSTS (total, input,output)
		$ChatStats.TotalCost += $TotalCost 
		$ChatStats.TotalInput += $InputCost
		$ChatStats.TotalOutput += $OutputCost
		
		## TOKENS QTY (total, input, output)
		$ChatStats.TotalTokens += $TotalTokens 
		$ChatStats.TotalTokensI += $InputTokens
		$ChatStats.TotalTokensO += $OutputTokens
		
		
		$AnswerLog = @(
			"Answer: $AnswerCount"
			"Cost: $TotalCost (i:$InputCost/o:$OutputCost)"
			"Tokens: $TotalTokens (i:$InputTokens/o:$OutputTokens)"
			"time: $($Total.totalMilliseconds) ms"
		) -Join " "
		
		$HistoryLog = @(
			"AllChats: $($ChatStats.TotalChats)"
			
			@(
				"Cost: $($ChatStats.TotalCost)"
				"(i:$($ChatStats.TotalInput)"
				"/"
				"o:$($ChatStats.TotalOutput))"
			) -Join ""
			
			@(
				"Tokens: $($ChatStats.TotalTokens)"
				"(i:$($ChatStats.TotalTokensI)"
				"/"
				"o:$($ChatStats.TotalTokensO))"
			) -Join ""
			
		) -Join " "
		
		if($ShowTokenStats){
			write-host "** $AnswerLog"
			write-host "** $HistoryLog"
		}
	} catch {
		write-host ($_|out-string)
		write-host "==== ERROR STACKTRACE ==="
		write-host "StackTrace: " $_.ScriptStackTrace;
	}
	
	
	return $ChatHistory;
}

Set-Alias -Name Chatest -Value Invoke-PowershaiChat
Set-Alias -Name PowerShait -Value Invoke-PowershaiChat


function NewChatContext {
	return @{
		messages = @()
		size = 0
	}
}

<#
	.DESCRIPTION
		Cria um ojbeto padrao contendo todos o spossveis parametros que podem ser usados no chat!
		O usuário pode usar um get-help New-PowershaiParameters para obter a doc dos parametros.  
#>
function New-PowershaiParameters {
	[CmdLetBinding()]
	param(
		#Quando true, usa o modo stream, isto é, as mensagens são mostradas a medida que o modelo as produz
		$stream = $true 
		
		,#Sem funcao. Será removido emnbeve 
			$VerboseEnabled = $false
			
		,# Habilia o modo JSON. Nesse modo, o modelo é forçado a retornar uma resposta com JSON.  
		 # Quandoa ativado, as mensagens geradas via stream não sãoe xibidas a medida que são produzidas, e somente o resultado final é retornado.  
			$UseJson
		
		,#Printa o prompt inteiro que está sendo enviado ao LLM 
			$ShowFullSend = $False 
			
		,#Ao final de cada mensagem, exibe as estatísticas de consumo, em tokens, retornadas pela API 
			$ShowTokenStats  = $False 
			
		,#Tamanho máximo do contexto, em caracteres 
		 #No futuro, será em tokens 
		 #Controla a quantidade de mensagens no contexto atual do chat. Quando esse número ultrapassar, o Powershai limpa automaticamente as mensagens mais antigas.
			$MaxContextSize = 8192
		
		,#Função usada para formatação dos objetos passados via pipeline 
			$ContextFormatterFunc = "ConvertTo-PowershaiContextOutString"
			
		,#Argumentos para ser passados para a ContextFormatterFunc
			$ContextFormatterParams = $null 
			
		,#Se true, exibe os argumenots das funcoes quando o Tool Calling é ativado para executar alguma funcao 
			$ShowArgs = $true 
			
		,#Exibe os resultados das tools quando são executadas pelo PowershAI em resposta ao tool calling do modelo 
			$PrintToolsResults = $false
			
		,#System Message que é garantida ser enviada sempre, independente do histórico e clenaup do chat!
			$SystemMessageFixed = $null
	)
	
    # Get the command name
    $CommandName = $PSCmdlet.MyInvocation.InvocationName;
    # Get the list of parameters for the command
    $ParameterList = (Get-Command -Name $CommandName).Parameters;
	
	$NewParams = @{}
	
	foreach($ParamName in @($ParameterList.keys) ){
		
		if($ParamName -in [System.Management.Automation.PSCmdlet]::CommonParameters){
			continue;
		}
		
		$ParamValue = Get-Variable $ParamName -ValueOnly -EA SilentlyContinue
		
		$NewParams[$ParamName] = $ParamValue;
	}
	
	return $NewParams;
	
}

<#
	.SYNOPSIS 
		Cria um novo Powershai Chat.
		
	.DESCRIPTION 
		O PowershaAI traz um conceito de "chats", semelhantes aos chats que você vê na OpenAI, ou as "threads" da API de Assistants.  
		Cada chat criado tem seu próprio conjunto de parâmetros, contexto e histórico.  
		Quando você usa o cmdlet Send-PowershaiChat (alias ia), ele está enviando mensagens ao modelo, e o histórico dessa conversa com o modelo fica no chat criado aqui pelo PowershAI.  
		Ou seja, todo o histórico da sua conversa com o modelo é mantido aqui na sua sessão do PowershAI, e não lá no modelo ou na API.  
		Com isso o PowershAI mantém todo o controle do que enviar ao LLM e não depende de mecanismos das diferentes APIs de diferentes providers para gerenciar o histórico. 
		
		
		Cada Chat possui um conjunto de parâmetros que ao serem alterados afetam somente quele chat.  
		Certos parâmetros do PowershAI são globais, como por exemplo, o provider usado. Ao mudar o provider, o Chat passa a usar o novo provider, mas mantém o mesmo histórico.  
		Isso permite conversar com diferentes modelos, enquanto mantém o mesmo histórico.  
		
		Além destes parâmetros, cada Chat possui um histórico.  
		O histórico contém todas as conversas e interações feitas com os modelos, guardando as repostas retornadas pelas APIs.
		
		Um Chat também tem um contexto, que é nada mais do que todas as mensagesn enviadas.  
		Cada vez que uma nova mensagem é enviada em um chat, o Powershai adiciona esta mensage ao contexto.  
		Ao receber a resposta do modelo, esta resposta é adicionada ao contexto.  
		Na próxima mensagem enviada, todo ess ehistórico de mensagem do contexto é enviado, fazendo com que o modelo, independente do provider, tenha a memória da conversa.  
		
		o fato do contexto ser mantido aqui na sua sessão do Powershell permite funcionaldiades como gravar o seu histórico em disco, implementar um provider exclusivo para guardar o seu hitórico na nuvem, manter apenas no seu Pc, etc. Futuras funcionalidades podem se beneficiar disso.
		
		Todos os comandos *-PowershaiChat giram em todos do chat ativo ou do chat que voce explicitamente especifica no parametro (geralmente com o nome -ChatId).  
		O ChatAtivo é o chat em que as mensagens serão enviadas, caso nao seja especificado o ChatId  (ou se o comando não permite especificar um chat explicito).  

		Existe um chat especial chamado "default" que é o chat criado sempre que voce usa o Send-PowershaiChat sem especifciar um chat e se não houver chat ativo definido.  
		
		Se você fechar sua sessão do Powershell, todo esse histoico de Chats é perdido.  
		Você pode salvar em disco, usando o comando Export-PowershaiSettings. O conteudo é salvo criptografado por uma senha que voce especificar.
		
		Ao emviar mensagens, o PowershaAI mantém um mecanismo interno que limpa o contexto do chat, para evitar enviar mais do que o necessário.
		O tamanho do contexto local (aqui na sua sessao do Powershai, e nao do LLM), é controlado por um parametro (use Get-PowershaiChatParameter para ver a lista de parametros)
		
		Note que, devido a essa maneira do Powershai funcionar, dependendo da quantidade de informacoes enviadas e retornadas, mais as configuracoes dos parametros, voce pode fazer seu Powershell consumir bastante memória. Voce pode limpar o contexto e historico manualmente do seu chat usando Reset-PowershaiCurrentChat
#>
function New-PowershaiChat {
	[CmdletBinding()]
	param(
		$ChatId
		,$model  		= $null
		,$MaxRequests 	= 10
		,$MaxTokens 	= 1024
		,[switch]$Json
		
		,#Desliga o stream 
			[switch]$NoStream
			
		,[switch]$IfNotExists
		,#Forçar recriar o chat se ele já estiver criado!
			[switch]$Recreate
	)
	
	if(!$ChatId){
		$ChatId = (Get-Date).toString("yyyyMMddHHmmss")
	}
	
	# Create chat!
	$Chats = $POWERSHAI_SETTINGS.chats;
	
	$ChatSlot = $Chats[$ChatId];
	
	if($ChatSlot){
		if($IfNotExists){
			return $ChatSlot;
		}
		
		if(!$Recreate){
			throw "POWERSHAI_START_CHAT: Chat $ChatId already exists";
		}
	}
	
	try {
		$CurrentUser = Get-LocalUser -SID ([System.Security.Principal.WindowsIdentity]::GetCurrent().User)
		$FullName = $CurrentUser.FullName;
		$UserAllNames = $FullName.split(" ");
		$UserFirstName = $UserAllNames[0];
	} catch {
		write-verbose "Cannot get logged username: $_"
	}
	
	$ApiParams = @{					
		#Parametros que vão para a api...
		model 		= $model
		MaxRequest 	= $MaxRequests
		MaxTokens 	= $MaxTokens
		Json 		= ([bool]$Json)
		RawParams	= @{}
		MaxSeqErrors = 5
	}
	
	$ChatParams = New-PowershaiParameters -stream (!([bool]$NoStream))
	
	$ChatSlot = [PsCustomObject]@{
		#Id unico e interno do chat!
		id 			 	= $ChatId
		
		#Data/hora de criacao do chat!
		CreateDate 		= (Get-Date)
		
		#Numero sequencia da msg atual enviada
		num 			= 0
		
		#Ultimo prompt enviado!
		LastPrompt 		= $null
		
		#Metados de controle do chat!
		metadata 		= @{}
		
		#Historico completo de todas as mensagens enviadas, com os objetos
		history 		= @()
		
		#Parametros especifos do provider 
		ApiParams 		= $ApiParams
		
		#Parametros configuraveis do chat
		params 			= $ApiParams + $ChatParams 
		
		#Contexto dos chats. é onde fica as mensagens que deve ser enviadas
		context  = (NewChatContext)
		
		#Informacoes do usuario atual
		UserInfo = @{
			FullName = $FullName
			AllNames = @($UserAllNames)
		}
		
		#Estatisticas de uso de tokens ao longo de todo o chat!
		stats = @{
			TotalChats 	= 0
			
			TotalCost 	= 0
			TotalInput 	= 0
			TotalOutput = 0
			
			TotalTokensI = 0
			TotalTokensO = 0
		}
		
		#Slot contendo tudo o que é necessario para controlar as tools dos chats!
		Tools = @{
			compiled = $null
			raw = @{}
		}
	}

	$Chats[$ChatId] = $ChatSlot;
	
	$null = Get-PowershaiChat -SetActive $ChatId
	return $ChatSlot;
}

function Invoke-PowershaiChatStart {
	$InternalMessages = @(
		"Você é um agente que está conversando com o usuário partir do PowershAI, um módulo powershell para interagir com IA"
		"O chat está sendo iniciado agora"
	)

	if($UserFirstName){
		$InternalMessages += "O nome do usuário é: "+$UserFirstName;
	}
	$Prompt = @(
		"Gere uma saudação inicial para o usuário"
	)
	$Prompt = $Prompt -Join "`n";
	Send-PowershaiChat -Prompt $Prompt -SystemMessages $InternalMessages;
}

<#
	.SYNOPSIS
		Remove um chat e retorna o objeto com todo o histórico e contexto
#>
function Remove-PowershaiChat {
	[CmdletBinding()]
	param(
		#Id do chat a ser removido, ou objeto representando o chat!
		[Parameter(ValueFromPipelineByPropertyName=$true)]
		[Alias("id")]
		$ChatId
	)
	
	$CurrentChat = Get-PowershaiChat "."
	$TargetChat = Get-PowershaiChat $ChatId
	
	if($CurrentChat -eq $TargetChat){
		throw "POWERSHAI_REMOVECHAT: Cannot remove active chat!";
	}
	
	#return removed!
	$Chats = $POWERSHAI_SETTINGS.chats;
	$Chats.remove($TargetChat.id);
	
	return $TargetChat;
}

# Get a chatid!
function Get-PowershaiChat {
	[CmdletBinding()]
	param(
		[string]$ChatId # . active chat
		,[switch]$SetActive
		,[switch]$NoError
	)
	
	try {
		if(!$ChatId){
			throw "POWERSHAI_GET_CHAT: Must inform -ChatId"
		}
		
		if($ChatId -eq '*'){
			@($POWERSHAI_SETTINGS.chats) | Sort-Object CreateDate
			return;
		}
		
		# Create chat!
		$Chats 	= $POWERSHAI_SETTINGS.chats;
		
		if(!$Chats){
			 $POWERSHAI_SETTINGS.chats = @();
		}
		
		$OriginalChatId =$ChatId 
		
		if($ChatId -eq "."){
			$ChatId = $POWERSHAI_SETTINGS.ActiveChat;
			
			if(!$ChatId -or $ChatId -isnot [string]){
				throw "POWERSHAI_GET_CHAT: No active ChatId!"
			}
			
		}
		
		$Chat = $Chats[$ChatId];
		
		if(!$Chat){
			throw "POWERSHAI_GET_CHAT: Chat $ChatId not found!";
		}
		
		if($SetActive -and $OriginalChatId -ne "."){
			$POWERSHAI_SETTINGS.ActiveChat = $ChatId;
		}
	
		return $Chat
	} catch {
		if($NoError){
			return;
		}
		
		throw;
	}
	
	
	
}

function Set-PowershaiActiveChat {
	[CmdletBinding()]
	param($ChatId)
	
	Get-PowershaiChat -SetActive $ChatId;
}

<#
	.DESCRIPTION 
		Atualiza o valor de um parâmetro do chat do Powershai Chat.  
		Se o parâmetro não existe, o cmdlet retorna um erro, a menos que -Force é usado!
		-Force deve ser usado normalmente em casos de testes internos ou em raras si
#>
function Update-PowershaiChatParameter {
	param(
		#Nome do parâmetro 
			$parameter
		,#Valor do parâmetro
			$value
		,# Chat que deseja atualizar. Por padrão atualiza o chat ativo 
			$ChatId = "."
			
		,#Forçar atualização, mesmo se o parâmetro não existe na lista de parâmetros 
			[switch]$Force
	)
	
	$AllParameters = Get-PowershaiChatParameter
	
	$Param = $AllParameters | ? { $_.name -eq $parameter }
	
	if(!$Param -and $Force){
		throw "POWERSHAI_CHAT_SETPARAM: Parameter $Parameter not found";
	}
	
	$Chat = Get-PowershaiChat $ChatId;
	$CurrentValue = $Chat.params[$parameter];
	
	$Chat.params[$parameter] = $value;
	write-host "Changed $parameter from $CurrentValue to $value";
}


function Get-PowershaiChatParameter {
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId;
	
	$ParamsHelp = @()
	$ParamBaseHelp = @(get-help New-PowershaiParameters).parameters.parameter
	
	#Lista tudo para garantir mesmo os chats criados previamente possam exibir novas opcoes que aparecem!
	$AllParams = @($Chat.params.keys) + @($ParamBaseHelp | %{$_.name}) | sort -Unique
	
	foreach($ParamName in $AllParams){
		$ParamHelp = $ParamBaseHelp | ? {$_.name -eq $ParamName}
		
		
		if($ParamHelp){
			$help = @($ParamHelp.description | %{$_.text}) -Join "`n"
		} else {
			$help = "Raw API param. Check model docs"
		}
		
		$ParameterInfo = [PsCustomObject]@{}
		$ParameterInfo | Add-Member Noteproperty name $ParamName
		$ParameterInfo | Add-Member Noteproperty value $Chat.params[$ParamName]
		$ParameterInfo | Add-Member Noteproperty description $help
		
		$ParamsHelp += $ParameterInfo
	}
	
	return $ParamsHelp;
}


function Set-PowershaiChatParameter {
	param($parameter, $value, $ChatId = ".")
	
	if($parameter -eq $null){
		Get-PowershaiChatParameter $ChatId
		return;
	} 
	
	Update-PowershaiChatParameter $parameter $value $chatId
}

$PARAM_LIST = @();

RegArgCompletion Set-PowershaiChatParameter,Update-PowershaiChatParameter parameter {
	param($cmd,$param,$word,$ast,$fake)
	 
	Get-PowershaiChatParameter -ChatId . | ? {$_.name -like "$word*"} | %{$_.Name};
}



function Invoke-PowershaiCommand {
	[CmdletBinding()]
	param(
		#Command name
			[ValidateSet("params","tools")]
			$CommandName
		
		,[Parameter(ValueFromRemainingArguments=$true)]
			$RemArgs
	)
	
	switch($CommandName){
		"params" {
			Set-PowershaiChatParameter @RemArgs
		}
		
		"tools" {
			Get-AiTools
		}
		
		default {
			write-warning "Unkown command";
		}
	}
	
}

Set-Alias pshai Invoke-PowershaiCommand


<#
	.SYNOPSIS
		Define qual será a funcao usada para formatar os objetos passados pro parâmetro Send-PowershaiChat -Context
	
	.DESCRIPTION
		Ao invocar Send-PowershaiChat em um pipe, ou passando diretamente o parâmetro -Context, ele irá injetar esse objeto no prompt do LLM.  
		Antes de injetar, ele deve converter esse objeto para uma string.  
		Essa conversão é chamada de "Context Formatter" aqui no Powershai.  
		O Context Formatter é uma funcao que irá pegar cada objeto passado e convertê-lo para uma string para ser injetada no prompt.
		A função usada deve receber como primeiro parametro o objeto a ser convertido.  
		Os demais parametros ficam a criterio. Os valor deles pode ser especicicados usando o parametro -Params dessa funcao!
#>
$POWERSHAI_FORMATTERS_SHORTCUTS = @{}
function Set-PowershaiChatContextFormatter {
	param(
		$ChatId = "."
		,#Nome da funcao powershell
		 #Use o comando Get-PowershaiContextFormatters para ver a lista
			$Func = "Str"
		
		,$Params = $null
	)
	
	$Chat = Get-PowershaiChat -ChatId $ChatId
	$Chat.params.ContextFormatterFunc 	=  $Func 
	$Chat.params.ContextFormatterParams =  $Params
}

function  Get-PowershaiContextFormatters {
	param()
	
	@($POWERSHAI_FORMATTERS_SHORTCUTS.keys) |  %{ [PsCustomObject]@{name = $_; func = $POWERSHAI_FORMATTERS_SHORTCUTS[$_]} }
}

function ConvertTo-PowershaiContextJson {
	param($context)
	
	$context | convertto-json @params
}
$POWERSHAI_FORMATTERS_SHORTCUTS['json'] = 'ConvertTo-PowershaiContextJson'

function ConvertTo-PowershaiContextOutString {
	param($context)
	
	$context | out-string @params
}
$POWERSHAI_FORMATTERS_SHORTCUTS['str'] = 'ConvertTo-PowershaiContextOutString'

function ConvertTo-PowershaiContextList  {
	param($context, $FlParams = @{})
	
	$context | Format-List @FlParams | out-string
}
$POWERSHAI_FORMATTERS_SHORTCUTS['list'] = 'ConvertTo-PowershaiContextList'

function ConvertTo-PowershaiContextTable {
	param($context, $FlParams = @{})
	
	$context | Format-Table -AutoSize @FlParams | out-string
}
$POWERSHAI_FORMATTERS_SHORTCUTS['table'] = 'ConvertTo-PowershaiContextTable'



function Format-PowershaiContext {
	[CmdletBinding()]
	param(
		$obj
		,$params
		,$func 
		,$ChatId = "."
	)
	
	write-verbose "Getting ChatId..."
	$Chat = Get-PowershaiChat -ChatId $ChatId
	
	if(!$func){
		$func = $Chat.params.ContextFormatterFunc
		
		if(!$func){
			$func = "str"
		}
	}
	
	$ShortCut = $POWERSHAI_FORMATTERS_SHORTCUTS[$Func];
	if($ShortCut){
		$Func = $ShortCut
	}
	
	write-verbose "FormatFunction: $func"
	
	if(!$params){
		$params =  $Chat.params.ContextFormatterParams
	}
	
	
	if($params -eq $null){
		$params = @{}
	}
	
	write-verbose "FormatParams: $($params|out-string)";

	
	write-verbose "Invoking formatter..."
	& $func $obj @params

}

<#
	.DESCRIPTION 
		Envia uma mensagem para o modelo do provider configurado e escreve a resposta na tela!
#>
function Send-PowershaiChat {
	[CmdletBinding()]
	param(
		[parameter(mandatory=$false, position=1)]
		# o prompt a ser enviado ao modelo 
			$prompt
		
		,#System messages 
			$SystemMessages = @()
		
		,#O contexto 
		 #Esse parâmetro é pra usado preferencialmente pelo pipeline.
		 #Ele irá fazer com que o comando coloque os dados em tags <contexto></contexto> e injeterá junto no prompt.
		[parameter(mandatory=$false, ValueFromPipeline=$true)]
			$context = $null
			
		,#Força o cmdlet executar para cada objeto do pipeline
		 #Por padrão, ele acumula todos os objetos em uma string só e envia de um só vez pro LLM.
			[switch]$ForEach
			
		,#Habilia o modo json 
		 #nesse modo os resultados retornados sempre será um JSON.
			[switch]$Json
			
		,#Modo Object!
		 #neste modo o modo JSON será ativado automaticamente!
		 #O comando não vai escrever nada na tela, e vai retornar os resultados como um objeto!
		 #Que serão jogados de volta no pipeline!
			[switch]$Object
			
		,# Mostra os dados de contexto enviados ao LLM antes da resposta!
			[switch]$PrintContext
			
		,#Desliga o historico anterior, mas colcoa a resposta atual no historico!
			[switch]$NoContext 
		,#DEsliga o historico e nao inclui o atual no historico!
			[switch]$Temporary 
			
		,# Desliga o function call para esta execução somente!
			[Alias('NoCalls')]
			[switch]$DisableFunctions
			
		,# Alterar a funcao de formatacao  para esta execucao apenas!
			$FormatterFunc = $null
			
		,# Parametros da funcao de formatacao
			$FormatterParams = $null
	)
	
	
	begin {
		$ErrorActionPreference = "Stop";
		
		$MyInvok = $MyInvocation;
		$CallName = $MyInvok.InvocationName;
		
		if($CallName -eq "io"){
			write-verbose "Invoked vias io alias. Setting Object to true!";
			$Object = $true;
		}
		
		if($CallName -eq "iat"){
			write-verbose "Invoked vias iat alias. Setting Temporary to true!";
			$Temporary = $true;
		}
		
		$ActiveChat = Get-PowershaiChat "." -NoError
		
		if(!$ActiveChat){
			write-verbose "Creating new default chat..."
			$NewChat = New-PowershaiChat -ChatId "default" -IfNotExists
			
			write-verbose "Setting active...";
			$ActiveChat = Get-PowershaiChat -SetActive $NewChat.id;
		}
		
		$AllContext = @()
		$IsPipeline = $PSCmdlet.MyInvocation.ExpectingInput   
		
		function ProcessPrompt {
			param($prompt)
			
			$prompt = @($prompt) -join "`n";
			
			function WriteModelAnswer($interaction, $evt){
				
				if($Object){
					write-verbose "ObjectMode enabled. No writes...";
					return;
				}
				
				$WriteParams = @{
					NoNewLine = $false
					ForegroundColor = "Cyan"
				}
				
				$Stream = $interaction.stream;
				$str = "";
				$EventName = $evt.event;
				
				
				function FormatPrompt {
					$str = PowerShaiProviderFunc "FormatPrompt" -Ignore -FuncParams @{
						model = $model
					}
					
					if($str -eq $null){
						$str = "🤖 $($model): ";
					}
					
					return $str;
				}
		


				if($Stream){
					$PartNum 	= $Stream.num;
					$text 		= $Stream.answer.choices[0].delta.content;
					$WriteParams.NoNewLine = $true;
					
					if($PartNum -eq 1){
						$str = FormatPrompt
					}

					if($text){
						$Str += $text
					}
					
					if($EventName -eq "answer"){
						$str = "`n`n";
					}
				} else {
					#So entrará nesse quando o stream estiver desligado!
					$ans 	= $interaction.rawAnswer;
					$text 	= $ans.choices[0].message.content;
					$model 	= $ans.model;
					$prempt = FormatPrompt;
					$str 	= "`$($prempt)$text`n`n" 
				}
				
				if($str){
					write-host @WriteParams $Str;
				}
			}

			#Get active chat!
			$Chat = Get-PowershaiChat "."
			
			if(!$Chat){
				throw "POWERSHAI_SEND: No active chats"
			}
			
			#Parameters 
			$ChatStats 			= $Chat.stats;
			$ChatMetadata 		= $Chat.metadata;
			$UserFirstName		= $Chat.UserInfo.AllNames[0];
			$ChatUserParams		= $Chat.params;
			$ApiParamsKeys		= @($Chat.ApiParams.keys);
			$ChatContext 		= $Chat.context;
			
			write-verbose "Iniciando..."
			
			$VerboseEnabled = $ChatUserParams.VerboseEnabled;
			$model 			= $ChatUserParams.model;
			$UseJson 		= $ChatUserParams.UseJson
			$ShowFullSend 	= $ChatUserParams.ShowFullSend
			$ShowTokenStats = $ChatUserParams.ShowTokenStats
			# Vou considerar isso como o número de caracter por uma questão simples...
			 # futuramente, o correto é trabalhar com tokens!
			$MaxContextSize = $ChatUserParams.MaxContextSize 
			
			function AddContext($msg) {

				if($Temporary){
					return;
				}
					
				while($ChatContext.size -ge $MaxContextSize -and $ChatContext.messages){
					$removed,$LeftMessages = $ChatContext.messages;
					
					$ChatContext.messages = $LeftMessages;
					
					$RemovedCount = $removed.length;
					if($removed.content){
						$RemovedCount = $removed.content.length;
					}
					
					write-verbose "Removing Length: $removed $RemovedCount"
					$ChatContext.size -= [int]$RemovedCount;
				}
				
				$ChatContext.messages += @($msg);

				if($msg.content){
					$ChatContext.size += $msg.content.length;
				} else {
					$ChatContext.size += $msg.length;
				}
			}
			
			
			$Chat.num++
			$InternalMessages = @();
			try {
				write-verbose "Verbose habilitado..." -Verbose:$VerboseEnabled;
				
				$Chat.LastPrompt = $prompt
				
				if($Object){
					$Exemplo1Json = @{PowerShaiJsonResult = @{
						prop1 = 123
						prop2 = "text value..."
						someArray = 1,2,3
					}} | ConvertTo-Json -Compress;
					
					$Exemplo2Json = @{PowerShaiJsonResult = "valor 1",123,"valor 3"} | ConvertTo-Json -Compress;
					
					$InternalMessages += @(
						"
							Retornar o resultado como JSON no formato: PowerShaiJsonResult:{JSON}
							EXEMPLO 1: $Exemplo1Json
							EXEMPLO 2: $Exemplo2Json
						"
					)
				}
				
				
				$Msg = @(
					@($SystemMessages|%{ [string]"s: $_"})
					@($InternalMessages|%{ [string]"s: $_"})
					[string]"u: $prompt"
				)
				
				if($ShowFullSend){
					write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
				}
				
				if($Temporary){
					write-warning "Temporary Chat enabled";
					$FullPrompt = $Msg;
				} else {
					$Msg | %{ AddContext $_ };
					$FullPrompt = $ChatContext.messages;
				}
				

				$ApiParams = @{};
				$ApiParamsKeys | %{
					$ApiParams[$_] = $ChatUserParams[$_]
				}
						

				if($NoContext){
					$FullPrompt = $Msg
				}
				
				#Generate functions!
				if($Chat.Tools.compiled -eq $null){
					$Chat.Tools.compiled  = @{
						CachedTime 	= (Get-Date)
						Tools 		= $null
					}
					
					write-verbose "Updating ParsedTools cached...";
					$Chat.Tools.compiled = Get-AiUserToolbox
				}
				
				
				$ToolList = @(
					$Chat.Tools.compiled
				)
				
				if($Chat.params.SystemMessageFixed){
					#Envia essa system message sempre!
					$FullPrompt = @("s: " + $Chat.params.SystemMessageFixed) + @($FullPrompt)
				}
				

				$ChatParams = $ApiParams + @{
					prompt 		= $FullPrompt
					Tools 		= $ToolList
					Stream		= $Chat.params.stream
					on 			= @{
								
								send = {
									if($VerboseEnabled){
										write-host -ForegroundColor DarkYellow "-- waiting model... --";
									}
								}
								
								stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
								answer = {param($inter,$evt) WriteModelAnswer $inter $evt}

								
								func = {
									param($interaction)
									
									$ans = $interaction.rawAnswer;
									$model = $ans.model;
									$funcName = $interaction.toolResults[-1].name
									
									
									write-host -ForegroundColor Blue "$funcName{" -NoNewLine
									
									if($Chat.params.ShowArgs){
										write-host ""
										write-host "Args:"
										$ToolArgs = $interaction.toolResults[-1].obj;
										write-host ($ToolArgs|fl|out-string)
									} else {
										write-host -ForegroundColor Blue -NoNewLine ...
									}
									
								}
								
								funcresult = {
									param($interaction)
									
									$LastResult = $funcName = $interaction.toolResults[-1].resp.content;
									
									if($Chat.params.PrintToolsResults){
										write-host "Result:"
										write-host $LastResult
									}
									
								}
						
								exec = {
									param($interaction)
									
									write-host -ForegroundColor Blue "}"
									write-host ""
								}
						}
				}
				
				if($Json){
					$ChatParams.Json = $true;
				}
				
				if($Object){
					$ChatParams.Json = $true;
					$ChatParams.Stream = $false;
				}
				
				if($VerboseEnabled){
					$ChatParams.Verbose = $true;
				}
				
				if($DisableFunctions){
					$ChatParams.Remove('Functions');
				}
				
				write-verbose "Params: $($ChatParams|out-string)"
				
				$Start = (Get-Date);
				$Ret 	= Invoke-AiChatTools @ChatParams;
				$End = Get-Date;
				$Total = $End-$Start;

				foreach($interaction in $Ret.interactions){ 
				
					if($interaction.stream){
						$Msg = $interaction.rawAnswer.message
					} else {
						$Msg = $interaction.rawAnswer.choices[0].message;
					}
				
					AddContext $Msg
					
					$toolsResults = $interaction.toolResults;
					if($toolsResults){
						$toolsResults | %{ AddContext $_.resp }
					}

				}
				
				#Store the history of chats!
				$HistoryEntry = @{
					Ret = $Ret
					Elapsed = $Total
					object = $null
				}
				$Chat.history += $HistoryEntry
						
				if($Object){
					write-verbose "Object mode! Parsing json..."
					$JsonContent = @($Ret.answer)[0].choices[0].message.content
					write-verbose "Converting json to object: $JsonContent";
					$JsonObject = $JsonContent | ConvertFrom-Json;
					$ResultObj = $JsonObject;
					
					if($JsonObject.PowerShaiJsonResult){
						$ResultObj = $JsonObject.PowerShaiJsonResult
					}
					
					$HistoryEntry.object = $ResultObj
					write-output $ResultObj
				}
				
				
				$AllAnswers 	= @($Ret.interactions | %{$_.rawAnswer});
				$AnswersCost	= $Ret.costs
				
				

				
				# current chat
				$AnswerCount 	= $AllAnswers.count;
				$TotalCost 		= $AnswersCost.total
				$InputCost 		= $AnswersCost.input
				$OutputCost 	= $AnswersCost.output
				$TotalTokens 	= $AnswersCost.tokensTotal
				$InputTokens 	= $AnswersCost.tokensInput
				$OutputTokens 	= $AnswersCost.tokensOutput
				
				# all chats
				$ChatStats.TotalChats += $Chat.history.count;
				$TotalChats = $ChatStats.TotalChats
				
				## COSTS (total, input,output)
				$ChatStats.TotalCost += $TotalCost 
				$ChatStats.TotalInput += $InputCost
				$ChatStats.TotalOutput += $OutputCost
				
				## TOKENS QTY (total, input, output)
				$ChatStats.TotalTokens += $TotalTokens 
				$ChatStats.TotalTokensI += $InputTokens
				$ChatStats.TotalTokensO += $OutputTokens
				
				
				$AnswerLog = @(
					"Answer: $AnswerCount"
					"Cost: $TotalCost (i:$InputCost/o:$OutputCost)"
					"Tokens: $TotalTokens (i:$InputTokens/o:$OutputTokens)"
					"time: $($Total.totalMilliseconds) ms"
				) -Join " "
				
				$HistoryLog = @(
					"AllChats: $($ChatStats.TotalChats)"
					
					@(
						"Cost: $($ChatStats.TotalCost)"
						"(i:$($ChatStats.TotalInput)"
						"/"
						"o:$($ChatStats.TotalOutput))"
					) -Join ""
					
					@(
						"Tokens: $($ChatStats.TotalTokens)"
						"(i:$($ChatStats.TotalTokensI)"
						"/"
						"o:$($ChatStats.TotalTokensO))"
					) -Join ""
					
				) -Join " "
				
				
				if($ShowTokenStats){
					write-host "** $AnswerLog"
					write-host "** $HistoryLog"
				}
			} catch {
				write-host ($_|out-string)
				write-host "==== ERROR STACKTRACE ==="
				write-host "StackTrace: " $_.ScriptStackTrace;
				throw;
			}
		}

		function ProcessContext {
			param($context)
			
			IF($PrintContext){
				write-host -ForegroundColor Blue Contexto:
				write-host -ForegroundColor Blue $Context;
			}
			
			write-verbose "Adding to context: $($Context|out-string)"
			$FinalPrompt = @(
				"Responda a mensagem com base nas informacoes de contexto que estao na tag <contexto></contexto>"
				"<contexto>"
				$context
				"</contexto>"
				"Mensagem:"
				$prompt
			)
			
			ProcessPrompt $FinalPrompt
		}
	

		$ContextFormatParams = @{
			func = $FormatterFunc
			params = $FormatterParams
			ChatId = $ActiveChat.id
		}
		

	}
	
	process {
		
		

		
		if($ForEach -and $IsPipeline){
			# Convete o contexto para string!
			$StrContext = Format-PowershaiContext -obj $context @ContextFormatParams;
			ProcessContext $StrContext;
		} else {
			$AllContext += $context
		}
	}
	
	
	end {
		if(!$IsPipeline){
			ProcessPrompt $prompt
			return;
		}
		
		if($AllContext.length){
			# Convete o contexto para string!
			$StrContext = Format-PowershaiContext -obj $AllContext @ContextFormatParams;
			ProcessContext $StrContext;
		}

		if($Temporary){
			write-warning "Temporary chat"
		}
	}
	
	
	

}

function Enter-PowershaiChat {
	param(
		$ChatId = "."
		,[switch]$StartMessage
	)
	
	$Chat = Get-PowershaiChat $ChatId -SetActive
	$UserFirstName = $Chat.UserInfo.AllNames[0];
	
	if($UserFirstName){
		$PromptLabel = $UserFirstName
	} else {
		$PromptLabel = "Você"
	}
	
	if($StartMessage){
		Invoke-PowershaiChatStart
	}
		
	while($true){
		$InternalMessages = @();
		write-host -NoNewLine "$PromptLabel>>> "
		$prompt = read-host
		
		try {
			Send-PowershaiChat -prompt $prompt
			
			if($Chat.LastPrompt.action -eq "ExplicitExit"){
				break;
			}
		} catch {
			$ErrorActionPreference = "Continue";
			write-error -ErrorRecord $_
			$ErrorActionPreference = "Stop";
		}
	}
}

function Start-PowershaiChat {
	[CmdletBinding()]
	param(
		$ChatId = "default"
		,$Functions = $null
	)
	
	if(!$NoCreate){
		$NewChat = New-PowershaiChat -ChatId $ChatId -IfNotExists
	}
	
	if($Functions){
		Update-PowershaiChatFunctions -ChatId $NewChat.id -File $Functions;
	}
	
	
	Enter-PowershaiChat -StartMessage
}

function Update-PowershaiChatFunctions {
	[CmdletBinding()]
	param($File, $ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId
	
	if($File){
		$FunctionSrc = $File;
	} else {
		$FunctionSrc = $Chat.src
	}
	
	write-verbose "Loading functions from $FunctionSrc"
	$Chat.Functions.src 	= $FunctionSrc;
	$Chat.Functions.Tools 	= Get-OpenaiToolFromScript $FunctionSrc;
}

function Clear-PowershaiChat {
	<#
		.SYNOPSIS
			Apaga elementos de um chat!
	#>
	param(
		
		#Apaga todo o histórico
			[switch]$History
			
		,#Apaga o contexto 
			[switch]$Context
		
		#Id do chat. Padrão: ativo.
		,$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat -ChatId $ChatId;
	
	if($context){
		write-verbose "Clearing context..."
		$Chat.context = NewChatContext
	}
	
	if($history){
		write-verbose "Clearing history"
		$Chat.history = @();
	}
	
}

function Reset-PowershaiCurrentChat {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat -ChatId $ChatId
	
    if($PSCmdlet.ShouldProcess("Current chat: $($Chat.id)")) {
        Clear-PowershaiChat -History -Context
    }
}



<#
	.SYNOPSIS
		Limpa o cache de de tools
	
	.DESCRIPTION
		O PowershAI mantém um cache com as tools "compiladas".
		Quando o PowershAI envia a lsita de tools pro LLM, ele precisa enviar junto a descrição da tools, lista de paraemtros, descrição, etc.  
		Montar essa lista pode consumir um tempo signifciativo, uma vez que ele vai varrer a lista de tools, funcoes, e pra cada um, varrer o help (e o help de cada parametro).
		
		Ao dicionar um cmdlet como Add-AiTool, ele não compila naquele momento.
		Ele deixa para fazer isso quando ele precisa invocar o LLM, na funcao Send-PowershaiChat.  
		Se o cache não existe, então ele compila ali na hora, o que pode fazer com que esse primeiro envio ao LLM, demora alguns millisegundos ou segundos a mais que o normal.  
		
		Esse impacto é proprocional ao numero de funcoes e parâmetros enviados.  
		
		Sempre que você usa o Add-AiTool ou Add-AiScriptTool, ele invalida o cache, fazendo com que na proxima execução, ele seja gerado.  
		ISso permite adicionar muitas funcoes de uma só vez, sem que seja compilado cada vez que você adicona.
		
		Porém, se você altera sua função, o cache não é recalcuado.  
		Então, você deve usar esse cmdlet para que a proxima execução contenha os dados atualizados das suas tools após alteracoes de código ou de script.
#>
function Reset-PowershaiChatToolsCache {
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId
	
	$ChatTools = $Chat.Tools
	
	if($ChatTools.compiled){
		$ChatTools.compiled = $null
	}
}

<#
	.SYNOPSIS
		Adiciona um ou mais cmdlets, ou scripts, para a lista de comandos que podem ser invocados pela IA, via tool caling!
	
	.DESCRIPTION
		Adiciona funcoes na sessao atual para a lista de Tool caling permitidos!
		Quando um comando é adicionado, ele é enviado ao modelo atual como uma opcao para Tool Calling.
		O help dsponivel da função será usado para descrevê-la, iuncluindo os parâmetros.
		Com isso, você pode, em runtime, adicionar novas habilidades na IA que poderão ser invocadas pelo LLM e executadas pelo PowershAI.  
		
		AO adicionar scritps, todas as funcoes dentro do script são adicionadas de uma só vez.
		
		MUITO IMPORTANTE: 
		NUNCA ADICIONEI COMANDOS QUE VOCÊ NÃO CONHEÇA OU QUE POSSAM COMPROMETER SEU COMPUTADOR.  
		O POWERSHELL VAI EXECUTÁ-LO A PEDIDO DO LLM E COM OS PARÂMETROS QUE O LLM INVOCAR, E COM AS CREDENCIAIS DO USUÁRIO ATUAL.  
		SE VOCÊ ESTIVER LOGADO COM UMA CONTA PRIVILEGIADA, COMO O ADMINISTRADOR, NOTE QUE VOCÊ PODERÁ EXECUTAR QUALQUER AÇÃO A PEDIDO DE UM SERVER REMOTO (O LLM).
#>
function Add-AiTool {
	param(
		$names
		,$parameters
		,$description
		,$formatter
		,[switch]$script
		,$ChatId = "."
		,[switch]$Global
	)
	
	$Chat = Get-PowershaiChat $ChatId
	$Tools = $Chat.tools.raw;
	
	if($Global){
		$Tools = $POWERSHAI_SETTINGS.UserTools
	}
	
	
	foreach($CommandName in $names){
		$ToolIndex = $CommandName;
		$ToolType = "command"
		
		if($script){
			[string]$AbsPath = Resolve-Path $CommandName -EA SilentlyContinue
			
			if(!$AbsPath){
				throw "POWERSHAI_AITOOL_SCRIPT_FILENOTFOUND: $CommandName";
			}
	
			$ToolIndex = "Path:" + $AbsPath;
			$CommandName = $AbsPath;
			$ToolType = "file"
		}
		
		$ToolInfo = @{
			name 			= $CommandName
			UserDescription = $description
			type 			= $ToolType 
			formatter 		= $formatter
			enabled 		= $true
			chats 			= @()
		}
		
		$Tools[$ToolIndex] = $ToolInfo;
	}
	
	#Atualiza o cache das tools!
	Reset-PowershaiChatToolsCache -ChatId $ChatId
}

<#
	.SYNOPSIS
		Lista todas as Tools disponíveis e seu tipo
	
	.DESCRIPTION
		Obtém a lista de tools
#>
function Get-AiTools {
	param(
		[switch]$Enabled
		,$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat $ChatId

	function ListTools {
		param($src, $scope)
		
		$Names = @($src.keys)
		foreach($ToolName in $Names){
			$ToolInfo = $src[$ToolName];
			
			
			if($Enabled -and !$ToolInfo.enabled){
				continue
			}
			
			$Result = [PsCustomObject]@{};
			$Result | Add-Member Noteproperty type $ToolInfo.type;
			$Result | Add-Member Noteproperty name $ToolInfo.name;
			$Result | Add-Member Noteproperty enabled $ToolInfo.enabled;
			$Result | Add-Member Noteproperty formatter $ToolInfo.formatter;
			$Result | Add-Member Noteproperty scope $scope

			
			$Result
		}
	}

	
	ListTools $Chat.Tools.raw "chat"
	ListTools $POWERSHAI_SETTINGS.UserTools "global"
}

<#
	.SYNOPSIS
		Remove uma tool definitivamente
#>
function Remove-AiTool {
	[CmdletBinding()]
	param(
		[parameter(ValueFromPipeline=$true)]
		$tool
		,[switch]$script
		,$ChatId = "."
		,[switch]$global
	)
	
	$Chat = Get-PowershaiChat $ChatId
	$Tools = $Chat.Tools.Raw;
	
	if($tool -is [string]){
		$name = $tool
	} else {
		$name = $tool.name 
		
		if($tool.type -eq "file"){
			$IsPath = $True
		}
	}
		
	if($global){
		$Tools = $POWERSHAI_SETTINGS.UserTools
	}
	
	$ToolIndex = $name;
	if($script){
		[string]$AbsPath = Resolve-Path $CommandName -EA SilentlyContinue
		$ToolIndex = "Path:" + $AbsPath;
	}
	
	
	if($Tools.contains($ToolIndex)){
		$Tools.Remove($ToolIndex);
	}
	
	#Atualiza o cache das tools!
	Reset-PowershaiChatToolsCache -ChatId $ChatId
}

<#
	.SYNOPSIS
		Desabilita um tool (mas não remove). Tool desabiltiada não é enviada ao LLM.
#>
function Set-AiTool {
	[CmdletBinding()]
	param(
		#The name of tool or object 
			[parameter(ValueFromPipeline=$true)]
			$tool 
		
		,#habilita
			[Parameter(ParameterSetName="Enable")]
			[switch]$Enable
			
		,#desabilita
			[Parameter(ParameterSetName="Disable")]
			[switch]$Disable
		
		,#Se informado, resolve o name como um path 
			[switch]$Script
			
		,$ChatId = "."
		,[switch]$Global
	)
	
	begin {
		$Chat = Get-PowershaiChat $ChatId
		$Tools = $Chat.Tools.Raw;
		if($global){
			$Tools = $POWERSHAI_SETTINGS.UserTools
		}
	}
	
	process {	
		[bool]$IsPath = $Script
	
		if($tool -is [string]){
			$name = $tool
		} else {
			$name = $tool.name 
			
			if($tool.type -eq "file"){
				$IsPath = $True
			}
		}
		
		if($IsPath){
			$name = "path:" + (Resolve-Path $name -EA SilentlyContinue)
		}
		
		write-verbose "Processing tool $name"
		
		

		
		$Tool = $Tools[$name];
		
		if($Tool){
			$OldState = $Tool.enabled
			
			if($Enable){
				$Tool.enabled = $true
			}
			
			if($Disable){
				$Tool.enabled = $false
			}
			
			write-verbose "	Setting from $OldState to $($Tool.enabled)"
		}
		
	}
	
	end {
		Reset-PowershaiChatToolsCache
	}
	
}


RegArgCompletion Set-AiTool,Remove-AiTool tool {
	param($cmd,$param,$word,$ast,$fake)
	
	Get-AiTools | ? { $_.name -like "$word*" } | %{
		if($_.type -eq "file"){
			"path:" + $_.name
		} else {
			$_.name
		}
		
	}
}



<#
	.DESCRIPTION  
		Obtém todas as tools cadastradas pelo usuário com Set-AiTool e compila em um único objeto para ser enviado ao LLM usando Invoke-AiChatTools.  
		
#>
function Get-AiUserToolbox {
	[CmdletBinding()]
	param(
		$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat $ChatId
	$Compiled = @{
		ToolList = @()
	}
	
	function CompileTools {
		param($src, $scope)
		
		$Names = @($src.keys)
		
		
		
		$CmdIndex = @{}
		$CmdTools = @{
			tools = @()
			CmdIndex = $CmdIndex
			src = $scope
			type = "toolbox"
			map = {
				param($ToolName,$Me)
				
				$ToolData = $Me.CmdIndex[$ToolName];
				$Original = $ToolData.original
				
				# obtém a tool!
				$Tool = & $Original.map $ToolName $Original
				
				$Script = {
					param($HashArgs)
					
					$Result = & $Tool.func @HashArgs
					
					if($ToolData.formatter -and $ToolData.formatter -is [scriptblock]){
						return & $ToolData.formatter $Result
					} else {
						return $Result
					}
				}.GetNewClosure()
				
				@{func = $Script; NoSplatArgs = $true}
			}
			
		}
			
		foreach($name in $names){
			$Tool = $src[$name];
			
			if(!$Tool.enabled){
				continue;
			}
			
			if($Tool.type -eq "file"){
				$Compiled.ToolList += Get-OpenaiToolFromScript $Tool.name
			}
			
			if($Tool.type -eq "command"){
				
				$ParamList = "*"
				
				if($Tool.parameter){
					$ParamList = $Tool.parameter 
				}
				
				$OpenaiTools = @(Get-OpenaiToolFromCommand -functions $Tool.name -parameters $ParamList -UserDescription $Tool.UserDescription)
				$OriginalTool = $OpenaiTools[0]
				
				$ToolData = @{
					original 	= $OriginalTool
					formatter 	= $Tool.formatter
				}
				
				$CmdIndex[$Tool.name] = $ToolData
				$CmdTools.tools += $OriginalTool.tools;
			}
		}
		
		$Compiled.ToolList += $CmdTools
	}
	

	CompileTools $Chat.Tools.raw "chat"
	CompileTools $POWERSHAI_SETTINGS.UserTools "global"
	
	
	return $Compiled.ToolList
}







Set-Alias -Name PowerShai -Value Start-PowershaiChat
Set-Alias -Name ia -Value Send-PowershaiChat
Set-Alias -Name iat -Value Send-PowershaiChat
Set-Alias -Name io -Value Send-PowershaiChat
Set-Alias -Name iaf -Value Update-PowershaiChatFunctions

<#
function prompt {
	$ExistingPrompt = [scriptblock]::create($POWERSHAI_SETTINGS.OriginalPrompt);
	
	try {
		$Chat = Get-PowershaiChat ".";
		$Id = $Chat.id;
	} catch {
		
	}
	
	if($Id){
		$Id = "💬 $Id"
	} else {
		$Id = ""
	}
	
	
	
	$NewPrompt = (& $ExistingPrompt);
	
	if($Id){
		$NewPrompt = "$Id $NewPrompt"
	}
	
	return $NewPrompt
}
#>



# Carrega os providers!
$ProvidersPath = JoinPath $PsScriptRoot "providers" "*.ps1"

$ProvidersFiles = gci $ProvidersPath

foreach($File in $ProvidersFiles){
	$ProviderName = $File.name.replace(".ps1","");
	write-verbose "Loading provider $ProviderName";
	
	$ProviderData = . $File.FullName;
	
	if(!$ProviderData.info.desc){
		throw "POWERSHAI_PROVIDER_NODESC: Provider $ProviderName must have desc"
	}
	
	if($ProviderData -isnot [hashtable]){
		throw "POWERSHAI_LOADPROVIDER_INVALIDRESULT: Provider script dont returned hashtable. This can be a bug with Powershai";
	}
	
	$ProviderData.name = $ProviderName;
	$UserDefinedSettings = $POWERSHAI_SETTINGS.providers[$ProviderName];

	if(!$UserDefinedSettings){
		$UserDefinedSettings = @{};
	}
	
	$PROVIDERS[$ProviderName] = $ProviderData;
	$POWERSHAI_SETTINGS.providers[$ProviderName] = $UserDefinedSettings;	
}

# Set default provider to openai!
if(!$POWERSHAI_SETTINGS.provider){
	Set-AiProvider openai
}

Export-ModuleMember -Function * -Alias * -Cmdlet *

