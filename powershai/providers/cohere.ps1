<#
	Esta função é usada como base para invocar a a API da OpenAI!
#>
function Invoke-CohereApi {
	[CmdletBinding()]
    param(
		 $endpoint
		,$body
		,$method = 'GET'
		,$StreamCallback = $null
		,$Token = $null
	)

	$Provider = Get-AiCurrentProvider -Context
	
	$Creds = Get-AiDefaultCredential
	$ApiKey = $Creds.credential.credential;

	if(!$ApiKey){
		throw "POWERSHAI_COHERE_NOAPIKEY: No Api Key provided!";
	}
	
	$headers = @{
		Authorization = "Bearer $ApiKey"
	}
	
	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		$BaseUrl = GetCurrentProviderData BaseUrl
		$url = "$BaseUrl/$endpoint"
	}

	
    $ReqParams = @{
        data            = $body
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

function Get-CohereModels {
	param()
	
	
	$resp = Invoke-CohereApi 'models' -body @{page_size = 1000}
	
	return $resp.models;
}
Set-Alias cohere_GetModels Get-CohereModels

function Convert-Openai2CohereMessage {
	param($messages)
	
	[object[]]$OpenAiMessages = @(ConvertTo-OpenaiMessage $messages)
	
	[object[]]$CohereMessages = @()
	
	foreach($m in $OpenAiMessages){
		$CohereMessages += @{
					content = $m.content
					role = $m.role
				}
	}
	
	return $CohereMessages;
}


function Get-CohereChat {
	param(
		$messages = @()
		
		,$model 			= $null
		
		,$RawParams = @{}
		,$StreamCallback = $null
	)
	
	[object[]]$CohereMessages = @(Convert-Openai2CohereMessage $messages)
	
	if(!$model){
		$model = GetCurrentProviderData -Context DefaultModel
	}
	
	$stream = $false;
	
	if($StreamCallback){
		$stream = $true;
	}
	
	$Data = HashTableMerge @{
		model 		= $model 
		messages 	= $CohereMessages
		stream 		= $stream
	} $RawParams
	
	
	
	$ReqParams = @{}
	Invoke-CohereApi "chat" -method POST -body $Data -StreamCallback $StreamCallback;
}



function Convert-CohereAnswerToOpenai {
	param($Answer, $StreamData)
	

	$Result = @{
		id 		= $Answer.id
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
		model = $model
	}
	
	$OpenaiFinishReason = $null
	
	switch($Answer.finish_reason){
		"COMPLETE" {
			$OpenaiFinishReason = "stop"
		}
	}
	
	$NewChoice = @{
		index 			= 0
		logprobs 		= $null
		finish_reason 	= $OpenaiFinishReason
	}
			
	$RespContent = $null
	
	$Message = @{
		role 		= "assistant"
		refusal 	= $null
		content 	= $null
	}
			
	$OpenAiTools = $null
	if($OpenAiTools){
		$Message.tool_calls = $OpenAiTools
	}
			
	if($StreamData.ChunkId){
		$Result.object 		= "chat.completion.chunk"
		$Result.id 			= $StreamData.ChunkId
		$Message.content 	= $Answer.delta.message.content.text;
		$NewChoice.delta 	= $Message
	} else {
		$Message.content 	= $Answer.message.content[0].text;
		$NewChoice.message 	= $Message
	}
			
	$Result.choices += $NewChoice;
	
	
	return $result;
}

function cohere_Chat {
	param(
		$prompt
		,$model
		,$StreamCallback
		,$RawParams
	)
	
	$StreamData = @{
		ChunkId = [guid]::NewGuid().Guid
	}
	
	
	$StreamScript = $null
	if($StreamCallback){
		$UserScriptCallback = $StreamCallback
		$StreamScript = {
			param($data)
			
			$line = @($data.line)[0];
			
			if($line -like "event: *"){
				$StreamData.CurrentEvent = $line.replace("event: ","");
				return;
			}
			
			$Answer = $null;
			if($line -match 'data: (.+)'){
				$data = $matches[1];
				
				if($data -eq "[DONE]"){
					return $false;
				}
				
				$Answer = $matches[1] | ConvertFrom-Json;
			}
			
			if($StreamData.CurrentEvent -eq "message-start"){
				$OpenaiAnswer = Convert-CohereAnswerToOpenai $Answer $StreamData;
				
				#Copy to message 
				$OpenaiAnswer.choices[0].message = $OpenaiAnswer.choices[0].delta;
				
				$OpenaiAnswer.choices[0].remove('delta');
				
				
				$StreamData.OpenaiAnswer = $OpenaiAnswer;
			}
			
			if($StreamData.CurrentEvent -eq "content-delta"){
				$DeltaAnswer = Convert-CohereAnswerToOpenai $Answer $StreamData
				$StreamData.OpenaiAnswer.choices[0].message.content += $Answer.delta.message.content.text;
				& $UserScriptCallback $DeltaAnswer
			}
			
			if($StreamData.CurrentEvent -eq "message-end"){
				$StreamData.OpenaiAnswer.choices[0].finish_reason = $Answer.delta.finish_reason;
			}
		}
	}
	
	
	$resp = Get-CohereChat -messages $prompt -model $model -RawParams $RawParams -StreamCallback $StreamScript
	
	if($resp.stream){
		$Result = $StreamData.OpenaiAnswer;
	} else {
		$Result = Convert-CohereAnswerToOpenai $resp
	}
	
	return $Result;
}



return @{
	BaseUrl 			= "https://api.cohere.com/v2"
	DefaultModel 		= "command-r"
	CredentialEnvName 	= "COHERE_API_KEY"
	
	#Assume every openai model support tools.
	ToolsModels = @(
		"command-r-*"
		"ch4ai-*"
	)
	
	EmbeddingsModels = @(
		"embed-*"
	)
	
	info = @{
		desc	= "Cohere"
		url 	= "https://docs.cohere.com/"
	}
}

