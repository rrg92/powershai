<#
	Esta função é usada como base para invocar a a API da Anthropic!
#>
function InvokeClaude {
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method = 'POST'
		,$StreamCallback = $null
		,$Token = $null
	)

	$Provider 		= Get-AiCurrentProvider

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
	
	
	$ApiKey = $Creds.credential.credential
	
    $headers = @{
		"anthropic-version" = "2023-06-01"
	}
	
	
	$headers["x-api-key"] = "$ApiKey"

	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		$BaseUrl = GetCurrentProviderData BaseUrl
		$url = "$BaseUrl/$endpoint"
	}

	if($StreamCallback){
		$body.stream = $true;
	}

	$JsonParams = @{Depth = 10}
	
	write-verbose "InvokeOpenai: Converting body to json (depth: $($JsonParams.Depth))..."
    $ReqBodyPrint = $body | ConvertTo-Json @JsonParams
	write-verbose "ReqBody:`n$($ReqBodyPrint|out-string)"
	
	$ReqBody = $body | ConvertTo-Json @JsonParams -Compress
    $ReqParams = @{
        data            = $ReqBody
        url             = $url
        method          = $method
        Headers         = $headers
		SseCallback		= $StreamCallback
    }

	
	write-verbose "ReqParams:`n$($ReqParams|out-string)"
    $RawResp 	= InvokeHttp @ReqParams
	write-verbose "RawResp: `n$($RawResp|out-string)"
	
	if($RawResp.stream){
		return $RawResp;
	}
	
	

    return $RawResp.text | ConvertFrom-Json
}

Set-Alias Set-ClaudeToken Set-AiCredential

function ConvertTo-ClaudeMessage {
	param($message)
	
	[object[]]$messages = @(ConvertTo-OpenaiMessage $messages)
	
	[object[]]$ContentMessages = @()
	$SystemMessage = @()
	
	$CallsIds = @{}
	
	:MsgLoop foreach($m in $messages){
		
		switch($m.role){
			
			"system" {
				$SystemMessage += $m.content.text;
			}
			
			default {
				$ClaudeMessage = @{
					content = $m.content 
					role = $m.role
				}
				
				foreach($content in $ClaudeMessage.content){
					$content = $_;

					if($content -is [string]){
						continue;
					}
					
					if($content.type -eq "image_url" -and $content.image_url.url -match 'data:(.+?);base64,(.+)'){
						$MimeType	= $matches[1];
						$Base64 	= $matches[2];
						
						$content.type = "image"
						$content.source = @{
							type = "base64"
							media_type = $MimeType
							data = $Base64
						}
						
						$content.remove("image_url");
					}
				}
				
				$ContentMessages += $ClaudeMessage
			}
			
		}

		
	}
	
	
	return [PsCustomObject]@{
		SystemMessage = ($SystemMessage -Join "`n")
		messages = $ContentMessages
	}
	
}

function Get-ClaudeMessages {
	[CmdletBinding()]
	param(
		 $messages
		,$model
		,$max_tokens = 200
		,$temperature = 0.5
		,$StreamCallback = $null
		,$RawParams = @{}
	)
	
	
	$Provider = Get-AiCurrentProvider
	
	#Note que reaproveitamos o convert to openai message do provider!
	$ClaudeMessages = @(ConvertTo-ClaudeMessage $messages)
	
	
	
	$data = HashTableMerge @{
		messages 	= @($ClaudeMessages.messages)
		max_tokens	= $max_tokens
		temperature	= $temperature
		model		= $model
		system 		= $ClaudeMessages.SystemMessage
	} $RawParams
	
	
	InvokeClaude "messages"  -body $data -StreamCallback $StreamCallback
}


function claude_Chat {
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

	
	$Params = @{
		messages 		= $prompt
		temperature 	= $temperature 
		model 			= $model
		max_tokens 		= $MaxTokens
		RawParams		= $RawParams
	}
	
	$StreamData = @{
		#Todas as respostas enviadas!
		answers = @()
		LastOpenaiAnswer = $null
		CurrentEvent = $null
		ChunkId = [guid]::NewGuid().guid
		MessageMeta = @{
			stop_reason = $null
			model = $null
			id = $null
			usage = @{
				input_tokens = 0
				output_tokens = 0
			}
		}
	}
	$CurrentEvent = $null;
	
	
	
	function Convert-ClaudeToOpenaiAnswer {
		param($Answer, $StreamData)
		
		
		$Result = @{
			id 		= [guid]::NewGuid().Guid
			object 	= "chat.completion"
			created = [int](((Get-Date) - (Get-Date "1970-01-01T00:00:00Z")).TotalSeconds)
			service_tier = $null
			system_fingerprint = $null
			usage = @{
				completion_tokens 	= $Answer.usage.output_tokens
				prompt_tokens 		= $Answer.usage.input_tokens 
				total_tokens 		= $null
			}
			
			logprobs = $null
			choices = @()
			model = $Answer.model
		}
		
		$Result | Add-Member -Force ScriptMethod GetClaudeDetails {
			@{
				obj = $Answer
			}
		}.GetNewClosure()
		
		if($StreamData){
			$Result.model = $StreamData.MessageMeta.model
		}
		
	
			
		$NewChoice = @{
			index 			= $Result.choices.length
			logprobs 		= $null
			finish_reason 	= $Answer.stop_reason
		}
		
		$Result.choices += $NewChoice;
		
		$Message = @{
			role 		= "assistant"
			refusal 	= $null
			content 	= $null
		}
		
		if($Answer.content){
			$Message.content = $Answer.content[0].text
		}
			
		if($StreamData){
			$Result.object = "chat.completion.chunk"
			$Result.id = $StreamData.ChunkId
			$Message.content = $Answer.delta.text
			$NewChoice.delta = $Message
		} else {
			$NewChoice.message = $Message
		}
		
		return $Result;
	}

	
	$StreamScript = $null			
	if($StreamCallback){
		$UserScriptCallback = $StreamCallback
		$StreamScript  = {
			param($data)

	
			$line = @($data.line)[0];
			$StreamData.lines += $line;
			
			if(!$line){
				return;
			}

			if($line -match "event: (.+)"){
				$StreamData.CurrentEvent = $matches[1];
				return;
			}
			
			$CurrentEvent = $StreamData.CurrentEvent
			
			if($CurrentEvent -eq "message_stop"){
				return $false;
			}
			
			$Answer = $null
			if($line -like "data: *"){
				$RawJson = $line.replace("data: ","");
				$Answer = $RawJson | ConvertFrom-Json;
				$StreamData.answers += $Answer
			}
			
			if($CurrentEvent -eq "message_start"){
				$Message = $Answer.message;			
				$StreamData.MessageMeta.usage.input_tokens	 = $Message.usage.input_tokens;
				$StreamData.MessageMeta.usage.output_tokens	+= $Message.usage.output_tokens;	
				$StreamData.MessageMeta.model	= $Message.model;
				return;
			}

			if($CurrentEvent -eq "content_block_delta"){
				$OpenaiAnswer 	= Convert-ClaudeToOpenaiAnswer $Answer $StreamData
				$DeltaResp 		= $Answer.delta
				
				if($StreamData.LastOpenaiAnswer){
					$StreamData.LastOpenaiAnswer.choices[0].delta.content += $OpenaiAnswer.choices[0].delta.content
				} else {
					$StreamData.LastOpenaiAnswer = $OpenaiAnswer
				}
				
				& $UserScriptCallback $OpenaiAnswer
			}

			if($CurrentEvent -eq "message_delta"){
				$Usage	= $Answer.usage;		
				$StreamData.MessageMeta.usage.output_tokens += $Usage.output_tokens			
				$StreamData.LastOpenaiAnswer.usage.completion_tokens = $StreamData.MessageMeta.usage.output_tokens	
				
				
				
			}
		}
	}

	$resp = Get-ClaudeMessages @Params -StreamCallback $StreamScript
	
	if($resp.stream){
		
		if(!$StreamData.LastOpenaiAnswer){
			throw "POWERSHAI_CLAUDE_CHAT_NOOPENAI: No openai message was returned. Probably a bug in claude for powershai!"
		}
		
		$StreamData.LastOpenaiAnswer.stream =  @{
				RawResp = $resp
				answers = $StreamData.answers
			}
			
		$StreamData.LastOpenaiAnswer.choices | %{
			$_.message = $_.delta 
			$_.remove('delta');
		}
		
		$OpenaiAnswer = $StreamData.LastOpenaiAnswer
	} else {
		$OpenaiAnswer = Convert-ClaudeToOpenaiAnswer $resp
	}
	
	
	
	$Choices = @();
	foreach($choice in $OpenaiAnswer.choices){
		
		#$tools = @()
		#foreach($call in $_.message.tool_calls){
		#	$tools += New-AiChatResultToolCall -FunctionName $call.function.name -FunctionArgs $call.function.arguments -CallId $call.id
		#}
		#
		
		$FinishReason = "stop";
		
		switch($choice.finish_reason){
			"end_turn" {
				$FinishReason = "stop"
			}
			
			"max_tokens" {
				$FinishReason = "length"
			}
			
			"stop_sequence" {
				$FinishReason = "stop"
			}
			
			"tool_use" {
				$FinishReason = "tool_calls"
			}
			
			default {
				verbose "Unkown claude finish reason: $($choice.finish_reason). Using default!";
			}
		}
		
	
		$Choices += New-AiChatResultChoice -FinishReason $FinishReason -role $choice.message.role -Content $choice.message.content #-tools $tools
	}
	
	$params = @{
		id 		= $OpenaiAnswer.id
		model 	= $OpenaiAnswer.model
		choices = $Choices
		SystemFingerprint 	= $OpenaiAnswer.system_fingerprint
		PromptTokens 		= $OpenaiAnswer.usage.prompt_tokens
		CompletionTokens 	= $OpenaiAnswer.usage.completion_tokens
		TotalTokens 		= $OpenaiAnswer.usage.total_tokens
	}
			
	$ChatResult = New-AiChatResult @params
	

	return $ChatResult;
	
}

function claude_GetModels() {
	
	return @(
		@{ name = 'claude-3-5-sonnet-latest' }
		@{ name = 'claude-3-5-sonnet-20241022' }
		@{ name = 'claude-3-5-haiku-20241022' }
		@{ name = 'claude-3-5-haiku-latest' }
		@{ name = 'claude-3-opus-20240229' }
		@{ name = 'claude-3-opus-latest' }
		@{ name = 'claude-3-sonnet-20240229' }
		@{ name = 'claude-3-haiku-20240307' }
	) | %{ [PsCustomObject]$_ }
	
}


return @{
	RequireToken 	= $true
	BaseUrl 		= "https://api.anthropic.com/v1"
	DefaultModel 	= "claude-3-5-haiku-latest"
	CredentialEnvName 	= "CLAUDE_API_KEY"
	
	info = @{
		desc	= "Anthropic Claude"
		url 	= "https://docs.anthropic.com/"
	}
}

