<#
	POWERSHAI
	Autor: Rodrigo Ribeiro Gomes (https://iatalk.ing)
	
	NÃO ESTÁ PRONTO PARA USO EM PRODUÇÃO!
	Você é livre para usar e modificar, mas deve deixar o crédito ao projeto original!
	
	
	Este script implementa algumas funções simples para facilitar sua interação com a API da OpenAI!
	O objetivo deste script é mostrar como você pode facilmente invocar a API do OpenAI com PowerShell, ao mesmo tempo que prover uma interface simples para 
	as chamadas mais importantes.  
	
	Antes de continuar, o que você precisa?
	
		Gere um token no site da OpenAI!
		Coloca na variável de ambiente OPENAI_API_KEY.
		
	# AUTENTICAÇÃO
	
		> import-module Caminho\powershai.psm1
		> Set-OpenaiToken # Define a sua api token
		> $res = OpenAiTextCompletion "Olá, estou falando com você direto do PowerShell"
		> $res.choices[0].text
		
	Verifique os comentáros em cada funçã abaixo para mais informações!
	
	ATENÇÃO: LEMBRE-SE que as chamadas realizadas irão consumir seus créditos da OpenAI!  
	Certifique-se que você compreendeu o modelo de cobrança da OpenAI para evitar surpresas.  
	Além disso, esta é uma versão sem testes e para uso livre por sua própria conta e risco.
#>
$ErrorActionPreference = "Stop";

if(!$Global:POWERSHAI_SETTINGS){
	$Global:POWERSHAI_SETTINGS = @{
		provider = 'openai' #ollama, huggingface
		baseUrl  = $null
		providers = @{
			grok = @{
				RequireToken 	= $true
				DefaultUrl 		= "https://api.groq.com/openai/v1"
				DefaultModel 	= "llama-3.1-70b-versatile"
			}
			
			ollama	= @{
				RequireToken 	= $false
				DefaultUrl 		= "http://localhost:11434/v1"
				ApiUrl 			= "http://localhost:11434/api"
				DefaultModel	=  $null
			}
			

		}
	}
}

if(!$Global:POWERSHAI_SETTINGS.chats){
	$Global:POWERSHAI_SETTINGS.chats = @{}
}

if(!$Global:POWERSHAI_SETTINGS.OriginalPrompt){
	$Global:POWERSHAI_SETTINGS.OriginalPrompt = $Function:prompt
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


# Meta functions
# Esssas funcoes devem ser usadas para obter informacoes!
function Get-AiCurrentProvider {
	$ProviderName = $POWERSHAI_SETTINGS.provider;
	$ProviderSlot = $POWERSHAI_SETTINGS.providers[$ProviderName];
	return $ProviderSlot;
}

# Muda o provider!
function Set-AiProvider {
	[CmdletBinding()]
	param($provider, $url)
	
	$ProviderSettings = $POWERSHAI_SETTINGS.providers[$provider];
	
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
	
	if(Get-Command $FullFuncName -EA SilentlyContinue){
		& $FullFuncName @FuncParams
	} else {
		if(!$Ignore){
			throw "POWERSHAI_PROVIDERFUNC_NOTFOUND: FuncName = $FuncName, FuncPrefix = $FuncPrefix, FullName = $FullFuncName. This erros can be a bug with powershai. Ask help in github or search!"
		}
	}
	
}

# Configura o default model!
function Set-AiDefaultModel {
	[CmdletBinding()]
	param($model)
	
	$SelectedModel = Get-AiModels | ? { $_.name -eq $model }
	
	if(!$SelectedModel){
		throw "POWERSHAI_SET_MODEL: Model NotFound $Model";
	}
	
	$Provider = Get-AiCurrentProvider
	$Provider.DefaultModel = $model;
}

# Get all models!
function Get-AiModels {
	[CmdletBinding()]
	param()
	$AiProvider = $POWERSHAI_SETTINGS.provider;
	
	$models = $null
	#TODO: Migrar tudo para PowerShaiProviderFunc
	
	if($AiProvider -eq 'ollama'){
		$Models = Get-OllamaTags
	} 
	elseif($AiProvider -eq "maritalk"){
		$Models = PowerShaiProviderFunc "GetModels"
	}
	else {
		$Models = (InvokeOpenai 'models' -m 'GET').data
		$Models | Add-Member -Type noteproperty -Name name -Value $null 
		$Models | %{ $_.name = $_.id }
	}
	
	return $Models | select ;
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
		
		,#Function list, as acceptable by Openai
		 #OpenAuxFunc2Tool can be used to convert from powershell to this format!
			$Functions 	= @()	
			
		#Add raw params directly to api!
		#overwite previous
		,$RawParams	= @{}
		
		,$StreamCallback = $null
	)
	
	$Provider = Get-AiCurrentProvider
	$FuncParams = $PsBoundParameters;
	
	if(!$model){
		$FuncParams['model'] = $Provider.DefaultModel;
	}
	
	PowerShaiProviderFunc "Chat" -FuncParams $FuncParams;
}


<#
	Esta é uma função auxiliar para ajudar a fazer o processamento de tools mais fácil com powershell.
	Ele lida com o processamento das "Tools", executando quando o modelo solicita!
	Apenas converse normalmente, defina as funções e deixe que este comando faça o resto!
	Não se preocupe em processar a resposta do modelo, se tem que executar a função, etc.
	O comando abaixo já faz tudo isso pra você. 
	Você precisa apenas concentrar em definir as funções que podem ser invocadas e o prompt(veja o comando OpenAuxFunc2Tool).
#>
function Invoke-AiChatFunctions {
	[CmdletBinding()]
	param(
		$prompt
		
		,# Passe as funcoes aqui
		 # Atualmente, suporta apenas um arquivo .ps1 onde as fucnoes estao definidas.
		 # Crie seu arquivo e documente ele usando a propria sintaxe do powershell.
		 # Essa documentação será enviada ao modelo. Quanto melhor você documentar, melhor o modelo saberá quando invocar.
			$Functions		= $null
			
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
	$OpenAiTools = OpenAuxFunc2Tool $Functions
	
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
			Functions 		= $OpenAiTools.tools
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
						throw "Tool type $CallType not supported"
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
					
					
					# Lets get func defintion!
					$FuncDef = $OpenAiTools.functions[$FuncName];
					
					#Functino not found!
					#This can be erros of model? Or bug of code...
					#Say back this to model...
					if(!$FuncDef){
						throw "Function $FuncName not found!";
					}
					
					# Get the function itself!
					# TODO: Talvez o GPT tenha pedido uma funcao erraa também, precisamos tratar este caso!
					# Por enquanto, assumimos que ele sempre manda uma funcao existente...
					$TheFunc = $FuncDef.func;
					
					if(!$TheFunc){
						write-warning "Model asked function $FuncName but the body was not found. This is a bug of PowershIA";
						throw "Function was defined, but code not found. This is a bug of function source."
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
					$FuncResult = & $TheFunc @ArgsHash 
					
					if($FuncResult -eq $null){
						$FuncResult = @{};
					}
					
					$FuncResp.content = $FuncResult | ConvertTo-Json -Depth 10;
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
	# $Ret = Invoke-AiChatFunctions -temperature 1 -prompt @(
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
	:MainLoop while($true){
		try {
			write-verbose "Verbose habilitado..." -Verbose:$VerboseEnabled;
			$LoopNum++;
			
			if($LoopNum -eq 1){
				$Prompt = @(
					
				)
				
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
			
			$parsedPrompt = ParsePrompt $Prompt
			
			switch($parsedPrompt.action){
				"stop" {
					break MainLoop;
				}
				
				"prompt" {
					$prompt = $parsedPrompt.prompt;
				}
				
				default {
					continue MainLoop;
				}
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
			$Ret 	= Invoke-AiChatFunctions @ChatParams;
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
	Inicializa o chat, mas sem travar o prompt!
#>
function New-PowershaiChat {
	[CmdletBinding()]
	param(
		$ChatId
		,$Functions 	= $null
		,$model  		= $null
		,$MaxRequests 	= 10
		,$MaxTokens 	= 1024
		,[switch]$Json
		
		,#Desliga o stream 
			[switch]$NoStream
			
		,[switch]$IfNotExists
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
		
		throw "POWERSHAI_START_CHAT: Chat $ChatId already exists";
	}
	
	write-verbose "Carregando lista de modelos..."
	$SupportedModels = Get-AiModels
	
	
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
	
	$ChatSlot = [PsCustomObject]@{
		id 			 	= $ChatId
		CreateDate 		= (Get-Date)
		num 			= 0
		LastPrompt 		= $null
		metadata 		= @{}
		history 		= @()
		ApiParams 		= $ApiParams
		params 			= $ApiParams + @{
				stream 			= !([bool]$NoStream)
				VerboseEnabled 	= $False;
				UseJson 		= $false;
				ShowFullSend 	= $false;
				ShowTokenStats 	= $false;
				MaxContextSize 	= 8192  # Vou considerar isso como o número de caracter por uma questão simples...
										# futuramente, o correto é trabalhar com tokens!
		}
		
		context  = (NewChatContext)
		Functions 		= @{
			src = $Functions
			parsed = $null
		}
		SupportedModels = $SupportedModels
		UserInfo = @{
			FullName = $FullName
			AllNames = @($UserAllNames)
		}
		stats = @{
			TotalChats 	= 0
			
			TotalCost 	= 0
			TotalInput 	= 0
			TotalOutput = 0
			
			TotalTokensI = 0
			TotalTokensO = 0
		}
	}

	$Chats[$ChatId] = $ChatSlot;
	
	$null = Get-PowershaiChat -SetActive $ChatId
	Update-PowershaiChatFunctions -File $Functions
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

function Set-PowershaiChatParameter {
	param($parameter, $value, $ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId;
	$CurrentValue = $Chat.params[$parameter];
	
	$Chat.params[$parameter] = $value;
	write-host "Changed $parameter from $CurrentValue to $value";
}

function Get-PowershaiChatParameter {
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId;
	$Chat.params
}

function Send-PowershaiChat {
	<#
		.SYNOPSIS 
			Envia uma mensagem para o modelo do provider configurado e escreve a resposta na tela!
	#>
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
			
		,#Desliga o historico anterior, mas colcoa a resposta atual no historico!
			[switch]$NoContext 
		,#DEsliga o historico e nao inclui o atual no historico!
			[switch]$Temporary 
			
		,# Desliga o function call para esta execução somente!
			[Alias('NoCalls')]
			[switch]$DisableFunctions
	)
	
	
	begin {
		$ErrorActionPreference = "Stop";
		
		$MyInvok = $MyInvocation;
		$CallName = $MyInvok.InvocationName;
		
		if($CallName -eq "io"){
			write-verbose "Invoked vias io alias. Setting Object to true!";
			$Object = $true;
		}
		
		$ActiveChat = Get-PowershaiChat "." -NoError
		
		if(!$ActiveChat){
			write-verbose "Creating new default chat..."
			$NewChat = New-PowershaiChat -ChatId "default" -IfNotExists
			
			write-verbose "Setting active...";
			$null = Get-PowershaiChat -SetActive $NewChat.id;
		}
		
		$AllContext = @()
		$IsPipeline = $PSCmdlet.MyInvocation.ExpectingInput   
		
		function ProcessPrompt {
			param($prompt)
			
			$prompt = $prompt -join " ";
			
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
			$SupportedModels 	= $Chat.SupportedModels
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
			
			function ParsePrompt($prompt) {
				$parts 		= $prompt -split ' ',2
				$cmdName	= $parts[0];
				$remain		= $parts[1];
				
				$result = @{
					action = $null
					prompt = $null;
				}
				
				write-verbose "InputPrompt: $cmdName"
				
				$ShortCut = @{
					'/von' 		= "VerboseEnabled true"
					'/voff' 	= "VerboseEnabled false"
					'/json' 	= "UseJson true"
					'/jsoff' 	= "UseJson false"
					'/fullon' 	= "ShowFullSend true"
					'/fulloff' 	= "ShowFullSend false"
					'/tokon' 	= "ShowTokenStats true"
					'/tokoff' 	= "ShowTokenStats false"
					'/reqs' 	= "MaxRequest "+$remain
				}[$cmdName]
				
				if($ShortCut){
					$cmdName = "/p";
					$remain = $ShortCut;
				}
				
				switch($cmdName){
					"/reload" {
						write-host "Reloading function list...";
						
						$FuncFile = $remain;
					
						if(!$FuncFile){
							$FuncFile = $Chat.Functions.src;
						}
						
						$Chat.Functions.parsed = OpenAuxFunc2Tool $FuncFile;
						$Chat.Functions.src = $remain
					}
					
					"/models" {
							write-host $($Chat.SupportedModels|out-string)
					}
					
					{'.cls','/clear','/cls','.c' -contains $_}{
							clear-host
					}
					
					
					"/p" { 
						#Split!
						$paramPair 		= $remain -split ' ',2
						$paramName 		= $paramPair[0]
						$paramValStr 	= $paramPair[1];
						
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
							$ElegibleModels = @( $Chat.SupportedModels | ? { $_.id -like $newModel } );
							
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
					
					{'/exit','/end' -contains $_} {
						$result.action = "ExplicitExit";
						$result.prompt = $prompt;
					}
					
					default {
						$result.action = "prompt";
						$result.prompt = $prompt;
					}
				}
				
				return $result;
			}

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
				
				$parsedPrompt = ParsePrompt $Prompt
				$Chat.LastPrompt = $parsedPrompt
				
				switch($parsedPrompt.action){
					"prompt" {
						$prompt = $parsedPrompt.prompt;
					}
					
					default {
						return;
					}
				}
				
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
				
				$Msg | %{ AddContext $_ };
				
				if($ShowFullSend){
					write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
				}
				
				$ApiParams = @{};
				$ApiParamsKeys | %{
					$ApiParams[$_] = $ChatUserParams[$_]
				}
				
				$FullPrompt = $ChatContext.messages;
				
				
				if($NoContext){
					$FullPrompt = $Msg
				}
				
			
				$ChatParams = $ApiParams + @{
					prompt 		= $FullPrompt
					Functions 	= $Chat.Functions.parsed 
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
									
									write-host -ForegroundColor Blue "$funcName{..." -NoNewLine
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
				
				$Start = (Get-Date);
				$Ret 	= Invoke-AiChatFunctions @ChatParams;
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
	}
	
	process {
		if($ForEach -and $IsPipeline){
			ProcessContext $context;
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
			ProcessContext $AllContext;
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
	$Chat.Functions.parsed 	= OpenAuxFunc2Tool $FunctionSrc;
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

Set-Alias -Name PowerShai -Value Start-PowershaiChat
Set-Alias -Name ia -Value Send-PowershaiChat
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
	
	if($ProviderData -eq $null){
		$ProviderData = @{};
	}
	
	if($ProviderData -isnot [hashtable]){
		throw "POWERSHAI_LOADPROVIDER_INVALIDRESULT: Provider script dont returned hashtable. This can be a bug with Powershai";
	}
	
	$ProviderData.name = $ProviderName;
	$ExistingProvider = $POWERSHAI_SETTINGS.providers[$ProviderName];
	
	$CurrentDefaultModel = $null
	if($ExistingProvider){
		$CurrentDefaultModel = $ExistingProvider.DefaultModel;
	}
	
	$POWERSHAI_SETTINGS.providers[$ProviderName] = $ProviderData
	
	if($CurrentDefaultModel){
		$ProviderData.DefaultModel = $CurrentDefaultModel
	}
	
}

Export-ModuleMember -Function * -Alias * -Cmdlet *