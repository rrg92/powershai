<#
	Esta função é usada como base para invocar a a API da OpenAI!
#>
function InvokeGoogleApi {
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method = 'POST'
		,$StreamCallback = $null
		,$Token = $null
	)

	$Provider = Get-AiCurrentProvider
	verbose "InvokeGoogleApi, current provider = $($Provider.name)"
	$TokenRequired = GetCurrentProviderData RequireToken;

	if(!$Token){
		$TokenEnvName = GetCurrentProviderData TokenEnvName;
		
		if($TokenEnvName){
			verbose "Trying get token from environment var: $($TokenEnvName)"
			$Token = (get-item "Env:$TokenEnvName"  -ErrorAction SilentlyContinue).Value
			if($Token){
				verbose "	Token got from ENV VAR $TokenEnvName!";
			}
			
		}
	}	
	
	if($TokenRequired -and !$Token){
			$Token = GetCurrentProviderData Token;
			
			if(!$token){
				throw "POWERSHAI_GOOGLE_NOTOKEN: No token was defined and is required! Provider = $($Provider.name)";
			}
	}
	
    $headers = @{}
	
	if($TokenRequired){
		 $headers["x-goog-api-key"] = "$token"
	}


	
	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		$BaseUrl = GetCurrentProviderData BaseUrl
		$url = "$BaseUrl/$endpoint"
	}

	$JsonParams = @{Depth = 10}
	
	verbose "InvokeGoogleApi: Converting body to json (depth: $($JsonParams.Depth))... $($body|out-string)"
    $ReqBodyPrint = $body | ConvertTo-Json @JsonParams
	verbose "ReqBody:`n$($ReqBodyPrint|out-string)"
	
	$ReqBody = $null
	if($body){
		$ReqBody = $body | ConvertTo-Json @JsonParams -Compress
	}
	
    $ReqParams = @{
        data            = $ReqBody
        url             = $url
        method          = $method
        Headers         = $headers
    }

			
	if($StreamCallback){
		$ReqParams['SseCallBack'] = $StreamCallback
	}


	verbose "ReqParams:`n$($ReqParams|out-string)"
    $RawResp 	= InvokeHttp @ReqParams
	verbose "RawResp: `n$($RawResp|out-string)"

	if($RawResp.stream){
		return $RawResp;
	}

    return $RawResp.text | ConvertFrom-Json
}

<#
	.SYNOPSIS
		Define a API Key (o Token) da Api do Google.
#>
function Set-GoogleApiKey {
	[CmdletBinding()]
	param()
	
	$ErrorActionPreference = "Stop";
	
	write-host "Forneça o token no campo senha na tela em que se abrir";
	
	$Provider = Get-AiCurrentProvider
	$creds = Get-Credential "GOOGLE API KEY";
	
	$TempToken = $creds.GetNetworkCredential().Password;
	
	write-host "Checando se o token é válido";
	#try {
	#	$result = InvokeOpenai 'models' -m 'GET' -token $TempToken
	#} catch [System.Net.WebException] {
	#	$resp = $_.exception.Response;
	#	
	#	if($resp.StatusCode -eq 401){
	#		throw "INVALID_TOKEN: Token is not valid!"
	#	}
	#	
	#	throw;
	#}
	#write-host -ForegroundColor green "	TOKEN ALTERADO!";
	
	SetCurrentProviderData Token $TempToken;
	return;
}



<#
	.SYNOPSIS
		Obtém a lista de modelos do Google. Endpoint: https://ai.google.dev/api/models
#>
function Get-GoogleModels(){
	[CmdletBinding()]
	param()
	
	(InvokeGoogleApi -method GET "v1beta/models").models
}


function google_GetModels(){
	param()
	
	$Models = Get-GoogleModels
	$Models | %{
		$_.name = $_.name -replace '^models/',''
	}
	return $models;
}

<#
	.SYNOPSIS
		Endpoint: https://ai.google.dev/api/generate-content
		Stream: https://ai.google.dev/api/generate-content#method:-models.streamgeneratecontent
#>
function Invoke-GoogleGenerateContent {
	[CmdletBinding()]
	param(
		$messages = @()
		,$model = "gemini-1.5-flash"
		,$StreamCallback = $null
	)
	
	
	#Note que reaproveitamos o convert to openai message do provider!
	$GoogleContent = @(ConvertTo-GoogleContentMessage $messages)
	
	$Config = @{}
	
	if($ResponseFormat.type -eq "json_object"){
		$Config.responseMimeType = "application/json"
	}
	
	$Data = @{
		contents = $GoogleContent.content
		#tools = @()
		systemInstruction  = @{
				parts = @(
						@{text = $GoogleContent.SystemMessage }
					)
			}
			
		generationConfig = $Config
	}
	
	$ReqParams = @{
		body = $Data 
		method = "POST"
	}
	
	$OpName = "generateContent"
	if($StreamCallback){
		$ReqParams['StreamCallback'] = $StreamCallback 
		$OpName = "streamGenerateContent?alt=sse"
	}
	
	InvokeGoogleApi "v1beta/models/$($model):$OpName" @ReqParams
}

function google_Chat {
	[CmdletBinding()]
	param(
         $prompt
        ,$temperature   = 0.6
        ,$model         = $null
        ,$MaxTokens     = 200
		,$ResponseFormat = $null
		,$Functions 	= @()	
		,$RawParams	= @{}
		,$StreamCallback = $null
		,[switch]$IncludeRawResp
	)
	
	$Params = @{
		messages = $prompt
		model = $model
	}
	
	if($StreamCallback){
		
		# dados para serem usados durante a leitura do stream!
		$StreamData = @{
			#Todas as respostas enviadas!
			answers = @()
			fullContent = ""
			
			#Todas as functions calls
			calls = @{
				all = @()
				funcs = @{}
			}
			
			CurrentCall = $null
		}
		
		$UserScriptCallback = $StreamCallback
		$StreamScript = {
			param($data)
			
			$line = $data.line
			
			if($line -like 'data: {*'){
				$RawJson = $line.replace("data: ","");
			} else {
				return;
			}
			
			$AnswerJson = $RawJson | ConvertFrom-Json;
			
			$AnswerText = @($AnswerJson.candidates)[0].content.parts[0].text;
			$StreamData.answers += $AnswerJson;
			
			$StreamData.fullContent += $AnswerText
				
			$StdAnswer = @{
				choices = @(
					@{
						delta = @{content = $AnswerText }
					}
				)
			}

			& $UserScriptCallback $StdAnswer
			
			
				
			#	foreach($ToolCall in $DeltaResp.tool_calls){
			#		$CallId 		= $ToolCall.id;
			#		$CallType 		= $ToolCall.type;
			#		verbose "Processing tool`n$($ToolCall|out-string)"
			#		
			#		
			#		if($CallId){
			#			$StreamData.calls.all += $ToolCall;
			#			$StreamData.CurrentCall = $ToolCall;
			#			continue;
			#		}
			#		
			#		$CurrentCall = $StreamData.CurrentCall;
			#	
			#		
			#		if($CurrentCall.type -eq 'function' -and $ToolCall.function){
			#			$CurrentCall.function.arguments += $ToolCall.function.arguments;
			#		}
			#	}
			
			# 
		}
		
		$Params['StreamCallback'] = $StreamScript 
	}
	
	$Resp = Invoke-GoogleGenerateContent @Params
	
	if($resp.stream){
		#Isso imita a mensagem de resposta, para ficar igual ao resultado quando está sem Stream!
		$MessageResponse = @{
			role		 	= "assistant"
			content 		= $StreamData.fullContent
		}
		
		#if($StreamData.calls.all){
		#	$MessageResponse.tool_calls = $StreamData.calls.all;
		#}
		
		return @{
			stream = @{
				RawResp = $resp
				answers = $StreamData.answers
				tools 	= $null
			}
			
			message = $MessageResponse
			finish_reason = $StreamData.answers[-1].candidates[0].finishReason
			usage = @{
					prompt_tokens 		= $StreamData.answers[-1].usageMetadata.promptTokenCount
					completion_tokens 	= $StreamData.answers[-1].usageMetadata.candidatesTokenCount
					total_tokens 		= $StreamData.answers[-1].usageMetadata.totalTokenCount
				}
			model = $model
		}
		
	}

	#Nao-stream!
	$ResultObj = @{
		choices = @(
			@{
				finish_reason 	= $resp.candidates[0].finishReason.ToLower()
				index 			= $resp.candidates[0].index
				logprobs 		= $null
				message 		= @{
									role = "assistant"
									content = $resp.candidates[0].content.parts[0].text
								}
			}
		)
		
		usage 	= @{
					prompt_tokens 		= $resp.usageMetadata.promptTokenCount
					completion_tokens 	= $resp.usageMetadata.candidatesTokenCount
					total_tokens 		= $resp.usageMetadata.totalTokenCount
				}
		model 	= $model
		created = [int](((Get-Date) - (Get-Date "1970-01-01T00:00:00Z")).TotalSeconds)
		object	= "chat.completion"
		id 		= $null
		system_fingerprint = $null
	}
	
	if($IncludeRawResp){
		$ResultObj.RawResp = $Resp
	}
	
	return $ResultObj;
}

<#
	.SYNOPSIS
		Converte OpenAI messages para um array de Content message
		https://ai.google.dev/api/caching#Content
		
#>
function ConvertTo-GoogleContentMessage {
	param($messages)
	
	[object[]]$messages = @(ConvertTo-OpenaiMessage $messages)
	
	
	$ContentMessages = @()
	$SystemMessage = @()
	
	foreach($m in $messages){
		
		$NewContent = @{
			parts = @()
			role = $null
		}
		
		$MsgContent = $m.content;
		$NewContent.role = $m.role;
		if($m.role -ne "user"){
			$NewContent.role = "model"
		}
		
		if($m.role -eq "system"){
			$SystemMessage += $MsgContent;
			continue;
		}
		
		$NewContent.parts = @(
				@{ text = $MsgContent }
			)
		
		$ContentMessages += $NewContent;
		
	}
	
	
	return [PsCustomObject]@{
		SystemMessage = ($SystemMessage -Join "`n")
		content = $ContentMessages
	}
	
}


Set-Alias -Name OpenAiChat -Value Get-OpenaiChat;
Set-Alias -Name openai_Chat -Value Get-OpenaiChat;





return @{
	RequireToken 	= $true
	ApiVersion 		= "v1"
	BaseUrl 		= "https://generativelanguage.googleapis.com"
	DefaultModel 	= "gemini-1.5-flash"
	TokenEnvName 	= "GOOGLE_API_KEY"
	
	info = @{
		desc	= "Google Gemini"
		url 	= "https://ai.google.dev/"
	}
}

