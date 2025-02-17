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
		,$JsonDepth = 15
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
		JsonDepth		= $JsonDepth
    }

			
	if($StreamCallback){
		$ReqParams['SseCallBack'] = $StreamCallback
	}


	verbose "ReqParams:`n$($ReqParams|out-string)"
	try {
		 $RawResp 	= InvokeHttp @ReqParams
	} catch [System.Net.WebException] {
		$ex = $_.exception;
		
		if($ex.PowershaiDetails){
			$ResponseError = $ex.PowershaiDetails.ResponseError.text;
			
			if($ResponseError){
				$err = New-PowershaiError "POWERSHAI_COHERE_ERROR" "Error: $ResponseError" -Prop @{
					HttpResponseText 	= $ResponseError
					HttpResponse		= $ex.PowershaiDetails.ResponseError.Response
				}
				throw $err
			}
		}
		
		throw;
	}
   
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

function Convert-OpenaiToolName2Cohere {
	param($OpenaiName)
	
	$COhereName = $OpenaiName -replace '[^A-Za-z0-9_]',''
	
	# Prevent start with digit!
	if($CohereName -match '^\d'){
		$CohereName = "t" + $CohereName;
	}
		
	return $CohereName;
}

function Convert-Openai2CohereMessage {
	param($messages)
	
	[object[]]$OpenAiMessages = @(ConvertTo-OpenaiMessage $messages)
	
	[object[]]$CohereMessages = @()
	
	foreach($m in $OpenAiMessages){
		
		switch($m.role){
			
			"tool" {
				$CohereMessage = $m;
			}
			
			"assistant" {
				$CohereMessage = HashTableMerge @{} $m;
				$CohereMessage.remove("refusal");
				
				if($CohereMessage.tool_calls -and $CohereMessage.content -eq $null){
					$CohereMessage.Remove("content");
				}
				
				foreach($Call in $CohereMessage.tool_calls){
					$Call.function.name = Convert-OpenaiToolName2Cohere $Call.function.name
				}
				
			}
			
			default {
				$CohereMessage = @{
						content = $m.content
						role = $m.role
					}
			}
			
			
		}
		
		$CohereMessages += $CohereMessage 
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
			completion_tokens 	= $Answer.usage.tokens.input_tokens
			prompt_tokens 		= $Answer.usage.tokens.output_tokens
			total_tokens 		= $null
		}
		
		logprobs = $null
		choices = @()
		model = $model
	}
	
	$OpenaiFinishReason = $null

	$NewChoice = @{
		index 			= 0
		logprobs 		= $null
		finish_reason 	= $Answer.finish_reason
	}
			
	$RespContent = $null
	
	$Message = @{
		role 		= "assistant"
		refusal 	= $null
		content 	= $null
	}
			
	$OpenAiTools = $Answer.message.tool_calls
	if($OpenAiTools){
		$Message.tool_calls = $OpenAiTools
	}
			
	if($StreamData.ChunkId){
		$Result.object 		= "chat.completion.chunk"
		$Result.id 			= $StreamData.ChunkId
		$Message.content 	= $Answer.delta.message.content.text;
		$NewChoice.delta 	= $Message
	} else {
		if($Answer.message.content){
			$Message.content 	= $Answer.message.content[0].text;
		}
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
	
	$AiChatParams 	= $ProviderFuncRawData.params;
	$Tools 			= $AiChatParams.Functions;
	
	# fix tools arguments!
	$AllTools = @()
	$ToolMap = @{} #Maps cohere names to original name
	foreach($Tool in $Tools){
		$NewTool = HashTableMerge @{} $Tool
		
		if(!$NewTool.function){
			continue;
		}
		
		$OriginalCallName = $NewTool.function.name;
		$CohereName = Convert-OpenaiToolName2Cohere $NewTool.function.name
		
		
		$NewTool.function.name = $CohereName;
		
		$ToolMap[$CohereName] = $OriginalCallName
		
		if(!$NewTool.function.parameters){
			$NewTool.function.parameters = @{
					type = "object"
				}
		}
		
		
		$AllTools += $NewTool;
	}
	
	if(!$RawParams.tools){
		$RawParams.tools = $AllTools
	}
	
	$StreamData = @{
		ChunkId 	= [guid]::NewGuid().Guid
		AllToolCalls 	= @()
		CurrentToolCall	= $null
	}
	
	
	$StreamScript = $null
	if($StreamCallback){
		$UserScriptCallback = $StreamCallback
		$StreamScript = {
			param($data)
			
			$line = @($data.line)[0];
			
			if(!$line){
				return;
			}
			
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
			
			#https://docs.cohere.com/v2/reference/chat-stream#response.body.tool-call-start
			if($StreamData.CurrentEvent -eq "tool-call-start"){
				$ToolCallParams = @{
					FunctionName = $Answer.delta.message.tool_calls.function.name
					FunctionArgs = $Answer.delta.message.tool_calls.function.arguments
					CallId 		 = $Answer.delta.message.tool_calls.id
				}
				$StreamData.CurrentToolCall = New-AiChatResultToolCall @ToolCallParams
				$StreamData.AllToolCalls += $StreamData.CurrentToolCall
			}
			
			if($StreamData.CurrentEvent -eq "tool-call-delta"){
				$StreamData.CurrentToolCall.function.arguments +=  $Answer.delta.message.tool_calls.function.arguments
			}
			
			if($StreamData.CurrentEvent -eq "tool-call-end"){}
			
			
			if($StreamData.CurrentEvent -eq "message-end"){
				$StreamData.OpenaiAnswer.choices[0].finish_reason = $Answer.delta.finish_reason;
			}
		}
	}
	
	
	$resp = Get-CohereChat -messages $prompt -model $model -RawParams $RawParams -StreamCallback $StreamScript
	
	if($resp.stream){
		
		$StreamData.OpenaiAnswer.choices[0].message.tool_calls = $StreamData.AllToolCalls;
		$OpenaiAnswer = $StreamData.OpenaiAnswer;
	} else {
		$OpenaiAnswer = Convert-CohereAnswerToOpenai $resp
	}
	
	$Choices = @();
	foreach($choice in $OpenaiAnswer.choices){
		
		$tools = @()
		foreach($call in $choice.message.tool_calls){
			#Map back!
			$ToolRealName = $ToolMap[$call.function.name]
			$CallArgs = $call.function.arguments;
			
			if(!$CallArgs){
				$CallArgs = '{}'
			}
			
			
			$tools += New-AiChatResultToolCall -FunctionName $ToolRealName -FunctionArgs $CallArgs -CallId $call.id
		}
		
	
		switch( $choice.finish_reason){
			"COMPLETE" {
				$OpenaiFinishReason = "stop"
			}
			
			"STOP_SEQUENCE" {
				$OpenaiFinishReason = "stop"
			}
			
			"MAX_TOKENS" {
				$OpenaiFinishReason = "length"
			}
			
			"ERROR" {
				$OpenaiFinishReason = "stop"
				write-warning "Cohere reported error when finished!!";
			}
			
			"TOOL_CALL" {
				$OpenaiFinishReason  = "tool_calls"
			}
			
			default {
				verbose "Unknown cohere complete length: $OpenaiFinishReason"
				$OpenaiFinishReason = "stop"
			}
		}
	

		$Choices += New-AiChatResultChoice -FinishReason $OpenaiFinishReason -role $choice.message.role -Content $choice.message.content -tools $tools
	}
	
	if(!$OpenaiAnswer.id){
		[string]$OpenaiAnswer.id = [guid]::NewGuid()
	}
	
	$params = @{
		id 					= $OpenaiAnswer.id
		model 				= $OpenaiAnswer.model
		choices 			= $Choices
		SystemFingerprint 	= $OpenaiAnswer.system_fingerprint
		PromptTokens 		= $OpenaiAnswer.usage.prompt_tokens
		CompletionTokens 	= $OpenaiAnswer.usage.completion_tokens
		TotalTokens 		= $OpenaiAnswer.usage.total_tokens
	}
	$ChatResult = New-AiChatResult @params
	
	return $ChatResult;
}


function cohere_FormatPrompt {
	param($model)
	
	$ModelEmoji = "🟣";
	
	
	if($model -like "c4ai-aya*"){
		$ModelEmoji = "❄️"
	}
	
	return "🟠$($ModelEmoji) $($model): ";
}


return @{
	BaseUrl 			= "https://api.cohere.com/v2"
	DefaultModel 		= "command-r"
	CredentialEnvName 	= "COHERE_API_KEY"
	
	#Assume every openai model support tools.
	ToolsModels = @(
		"command-r-*"
		"command-r"
		"command-r7b*"
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

