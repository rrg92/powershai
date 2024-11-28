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
	
	$Creds = Get-AiDefaultCredential -MigrateScript {
		$ApiKey = GetCurrentProviderData -Context Token;
		
		if($ApiKey){
			SetCurrentProviderData Token $null;
			$AiCredential = NewAiCredential
			$AiCredential.name = "default"
			$AiCredential.credential = $ApiKey;
			return $AiCredential
		}
	}
	
	
	$ApiKey = $Creds.credential.GetCredential()

	if(!$ApiKey){
		throw "POWERSHAI_GOOGLE_NOAPIKEY: Must set credentials with Set-AiCredential";
	}
	
	$headers = @{
			"x-goog-api-key" = "$ApiKey"
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

function google_SetCredential {
	param($AiCredential)
	
	$AiCredential.credential = Get-Credential "GOOGLE API KEY";
	
	Enter-AiCredential $AiCredential {
		$null = Get-GoogleModels
	}
	
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
		,$model 			= "gemini-1.5-flash"
		,$StreamCallback 	= $null
		,$RawParams 		= @{}
		,$Tools 			= $null
	)
	
	
	$GoogleContent = @(ConvertTo-GoogleContentMessage $messages)
	
	$Config = @{}
	
	$Data = @{
		contents = $GoogleContent.content
		systemInstruction  = @{
				parts = @(
						@{text = $GoogleContent.SystemMessage }
					)
			}
			
		generationConfig = $Config
	}
	
	if($Tools){
		$Data.tools = @{
			function_declarations = $Tools
		}
		
		$Data.tool_config = @{
				function_calling_config = @{
					mode = "AUTO"
				}
			}
	}
	
	
	$Data = HashTableMerge $Data $RawParams;
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

function ConvertTo-GoogleToolFunction {
	param($OpenaiTool)
	
	$FuncName = $OpenaiTool.function.name -replace '[\-\.]','';
	
	$GoogleFunction = HashTableMerge $OpenaiTool.function @{ name = $FuncName }
	
	if($GoogleFunction.contains('arguments')){
		$GoogleFunction.args = $GoogleFunction.arguments | ConvertFrom-Json;
		$GoogleFunction.remove('arguments');
	}
	
	return $GoogleFunction;
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
		,$RawParams		= @{}
		,$StreamCallback = $null
		,[switch]$IncludeRawResp
	)
	

	$CalcParams =  @{
		generationConfig = @{
			temperature 		= $temperature
			maxOutputTokens 	= $MaxTokens
		}
		
		safetySettings = @(
			@{ category = "HARM_CATEGORY_HATE_SPEECH"; threshold 		= "BLOCK_NONE"  }
			@{ category = "HARM_CATEGORY_SEXUALLY_EXPLICIT"; threshold 	= "BLOCK_NONE"  }
			@{ category = "HARM_CATEGORY_DANGEROUS_CONTENT"; threshold 	= "BLOCK_NONE"  }
			@{ category = "HARM_CATEGORY_HARASSMENT"; threshold 		= "BLOCK_NONE"  }
			@{ category = 'HARM_CATEGORY_CIVIC_INTEGRITY'; threshold 	= 'BLOCK_NONE' }
		)
	} 
	
	if($ResponseFormat.type -eq "json_object"){
		$CalcParams.generationConfig.response_mime_type = "application/json"
	}
	elseif($ResponseFormat.json_schema){
		$CalcParams.generationConfig.response_mime_type = "application/json"
		$CalcParams.generationConfig.response_schema = $ResponseFormat.json_schema.schema
	}
	
	$OpenApiFunctions = @()
	$FunctionMap = @{}
	
	foreach($Function in $Functions){	
		$GoogleFunction = ConvertTo-GoogleToolFunction $Function;
		$GoogleName = $GoogleFunction.name;
		$FunctionMap[$GoogleName] = $Function.function
		$OpenApiFunctions += $GoogleFunction
	}

	function Convert-GoogleFunctionCallToOpenai {
		param($Call)	
		
		$OriginalFunction = $FunctionMap[$Call.name]
		
		return [PsCustomObject]@{
			id 			= New-OpenaiToolCallId
			type 		= "function"
			'function'	= @{
					name 		= $OriginalFunction.name
					arguments	= $Call.args | ConvertTo-Json -Depth 10
				} 	
		}
	}
	
	function Convert-GoogleAnswerToOpenaiAnswer {
		param($Answer, $ChunkId)
		
		
		$Result = @{
			id 		= [guid]::NewGuid().Guid
			object 	= "chat.completion"
			created = [int](((Get-Date) - (Get-Date "1970-01-01T00:00:00Z")).TotalSeconds)
			service_tier = $null
			system_fingerprint = $null
			usage = @{
				completion_tokens 	= $Answer.usageMetadata.candidatesTokenCount
				prompt_tokens 		= $Answer.usageMetadata.promptTokenCount
				total_tokens 		= $Answer.usageMetadata.totalTokenCount
			}
			
			logprobs = $null
			choices = @()
			model = $Answer.modelVersion
		}
		
		$Result | Add-Member -Force ScriptMethod GetGoogleDetails {
			@{
				obj = $Answer
			}
		}.GetNewClosure()
		
		foreach($Candidate in $Answer.candidates){
			
			$FinishReason = "stop"
			switch($Candidate.finishReason){
				"MAX_TOKENS" {
					$FinishReason = "length"
				}
				
				{ $_ -in "SAFETY","RECITATION","LANGUAGE","BLOCKLIST","PROHIBITED_CONTENT","SPII" } {
					$FinishReason = "content_filter"
				}
				
				default {
					if($Candidate.finishReason){
						$FinishReason = $Candidate.finishReason.toLower();
					}
				}
			}
			
						
			if($FinishReason -eq "content_filter"){
				$Refusal = "Google:" + $Candidate.finishReason;
			}
			
			
			#Tools!
			$OpenAiTools = @()
			foreach($Part in $Candidate.content.parts){
				if($Part.functionCall){
					$OpenAiTools += Convert-GoogleFunctionCallToOpenai $Part.functionCall
				}
			}
			
			if($OpenAiTools){
				$FinishReason = "tool_calls"
			}
			
			$NewChoice = @{
				index 			= $Result.choices.length
				logprobs 		= $null
				finish_reason 	= $FinishReason
			}
			
			$RespContent = $null
			
			$Message = @{
				role 		= "assistant"
				refusal 	= $null
				content 	= @($Candidate.content.parts)[0].text
			}
			
			if($OpenAiTools){
				$Message.tool_calls = $OpenAiTools
			}
			
			if($ChunkId){
				$Result.object = "chat.completion.chunk"
				$Result.id = $ChunkId
				$NewChoice.delta = $Message
			} else {
				$NewChoice.message = $Message
			}
			
			$Result.choices += $NewChoice;
		}
		
		return $Result;
	}

	
	$Params = @{
		messages 	= $prompt
		model 		= $model
		RawParams 	= (HashTableMerge $CalcParams $RawParams)
		Tools 		= $OpenApiFunctions 
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
			ChunkId = [guid]::NewGuid().guid
			OpenaiAnswer = $null
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
			
			$Answer 			= $RawJson | ConvertFrom-Json;
			$Answer | Add-Member Noteproperty _raw $data;
			
			$StreamData.answers += $Answer;	
			
			$OpenaiAnswer = Convert-GoogleAnswerToOpenaiAnswer $Answer -ChunkId $StreamData.ChunkId
			
			
			if($StreamData.OpenaiAnswer){
				if($OpenaiAnswer.choices[0].delta.content){
					$StreamData.OpenaiAnswer.choices[0].delta.content += $OpenaiAnswer.choices[0].delta.content
				}				
			} else {
				$StreamData.OpenaiAnswer = $OpenaiAnswer
			}
			
			if(!$StreamData.OpenaiAnswer.usage.completion_tokens){
				$StreamData.OpenaiAnswer.usage.completion_tokens = 0
			}
			
			if($OpenaiAnswer.usage.completion_tokens){
				$StreamData.OpenaiAnswer.usage.completion_tokens += $OpenaiAnswer.usage.completion_tokens
			}
			
			
			& $UserScriptCallback $OpenaiAnswer
		}
		
		$Params['StreamCallback'] = $StreamScript 
	}
	
	try {
		
		$Resp = Invoke-GoogleGenerateContent @Params
	} catch {
		$_.Exception | Add-Member -Force Noteproperty GoogleProvider @{
					params = $params
				}
		
		throw;
	}
	

	if($resp.stream){
		$OpenaiAnswer = $StreamData.OpenaiAnswer;
		
		$OpenaiAnswer.stream = @{
				RawResp = $resp
				answers = $StreamData.answers
				tools 	= $StreamData.OpenaiAnswer.choices[0].delta.tool_calls
			}
			
		$OpenaiAnswer.message = @{ 
				role = "assistant"
				content 	= $StreamData.OpenaiAnswer.choices[0].delta.content
				tool_calls =  $StreamData.OpenaiAnswer.choices[0].delta.tool_calls
			}
	} else {
		$OpenaiAnswer = Convert-GoogleAnswerToOpenaiAnswer $resp
	}
	
	return $OpenaiAnswer;
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
	
	$CallsIds = @{}
	
	:MsgLoop foreach($m in $messages){
		
		$NewContent = @{
			parts 	= @()
			role 	= $null
		}
		
		$MsgContent = $m.content;
		$NewContent.role = $m.role;
		
		# default conversion!
		$MsgPart = @()
		if($MsgContent -is [string]){
			$MsgPart += @{ text = $MsgContent }
		} else {
			foreach($content in $MsgContent){
				if($content.text){
					$MsgPart += @{ text = $content.text }
				}
				
				if($content.type -eq "image_url" -and $content.image_url.url -match 'data:(.+?);base64,(.+)'){
					$MimeType	= $matches[1];
					$Base64 	= $matches[2];
					$MsgPart += @{ inlineData = @{ mimeType = $MimeType; data = $Base64 }}
				}
				
			}
		}
		
		switch($m.role){
			
			"user" {
				$NewContent.role = "user"
			}
			
			"assistant" {
				$NewContent.role = "model"
				if($m.tool_calls){
					
					$MsgPart = @()
					
					foreach($tool in $m.tool_calls){
						
						$GoogleFunction = ConvertTo-GoogleToolFunction $tool;

						$MsgPart += @{
							functionCall = $GoogleFunction
						}

						$CallsIds[$tool.id] = @{
							GoogleFunction = $GoogleFunction
						}
					}
				}
				
			}
			
			"tool" {
				$NewContent.role = "model"
				$MsgPart = @{ 
					functionResponse = @{
						name = $CallsIds[$m.tool_call_id].GoogleFunction.name
						response = @{
							result = $m.content
						}
					}
				}
			}
			
			"system" {
				$SystemMessage += $MsgContent;
				continue MsgLoop;
			}
			
			default {
				write-warning "Message role not recognized: $($NewContent.role)";
				break;
			}
			
		}
		

		$NewContent.parts = @($MsgPart)
		
		$ContentMessages += $NewContent;
	}
	
	
	return [PsCustomObject]@{
		SystemMessage = ($SystemMessage -Join "`n")
		content = $ContentMessages
	}
	
}

return @{
	RequireToken 		= $true
	ApiVersion 			= "v1"
	BaseUrl 			= "https://generativelanguage.googleapis.com"
	DefaultModel 		= "gemini-1.5-flash"
	CredentialEnvName 	= "GOOGLE_API_KEY"
	
	#Assume every openai model support tools.
	ToolsModels = "*"
	
	info = @{
		desc	= "Google Gemini"
		url 	= "https://ai.google.dev/"
	}
}

