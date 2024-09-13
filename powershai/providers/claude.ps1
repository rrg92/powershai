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
	$TokenRequired 	= GetCurrentProviderData RequireToken;

	if(!$Token){
		$TokenEnvName = GetCurrentProviderData TokenEnvName;
		
		if($TokenEnvName){
			write-verbose "Trying get token from environment var: $($TokenEnvName)"
			$Token = (get-item "Env:$TokenEnvName"  -ErrorAction SilentlyContinue).Value
		}
	}	
	
	if($TokenRequired -and !$Token){
			$Token = GetCurrentProviderData Token;
			
			if(!$token){
				throw "POWERSHAI_CLAUDE_NOTOKEN: No token was defined and is required! Provider = $($Provider.name)";
			}
	}
	
    $headers = @{
		"anthropic-version" = "2023-06-01"
	}
	
	if($TokenRequired){
		 $headers["x-api-key"] = "$token"
	}


	
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
    }

	$StreamData = @{
		#Todas as respostas enviadas!
		answers = @()
		
		fullContent = ""
		
		FinishMessage = $null
		
		#Todas as functions calls
		calls = @{
			all = @()
			funcs = @{}
		}
		
		CurrentCall = $null
		CurrentEvent = $null
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
				
	if($StreamCallback){
		$CurrentEvent = $null;
		$ReqParams['SseCallBack'] = {
			param($data)

			$line = $data.line;
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

			if($CurrentEvent -eq "content_block_delta"){
				$RawJson = $line.replace("data: ","");
				$Answer = $RawJson | ConvertFrom-Json;
				$DeltaResp 		= $Answer.delta
				
				$StreamData.fullContent += $DeltaResp.text;
				
				$StreamData.answers += $Answer
				
				$StdAnswer = @{
					choices = @(
						@{
							delta = @{content = $DeltaResp.text}
						}
					)
				}
				
				& $StreamCallback $StdAnswer
			}
			
			
			if($CurrentEvent -eq "message_start"){
				$RawJson = $line.replace("data: ","");
				$Answer = $RawJson | ConvertFrom-Json;
				$Message = $Answer.message;			


				$StreamData.MessageMeta.usage.input_tokens	 = $Message.usage.input_tokens;
				$StreamData.MessageMeta.usage.output_tokens	+= $Message.usage.output_tokens;	
				$StreamData.MessageMeta.model	= $Message.model				
			}
			
			if($CurrentEvent -eq "message_delta"){
				$RawJson	= $line.replace("data: ","");
				$Answer 	= $RawJson | ConvertFrom-Json;
				$Usage	= $Answer.usage;		
				$StreamData.MessageMeta.usage.output_tokens	+= $Usage.output_tokens				
			}
			
		}
	}


	write-verbose "ReqParams:`n$($ReqParams|out-string)"
    $RawResp 	= InvokeHttp @ReqParams
	write-verbose "RawResp: `n$($RawResp|out-string)"
	
	if($RawResp.stream){
		
		#Isso imita a mensagem de resposta, para ficar igual ao resultado quando está sem Stream!
		$MessageResponse = @{
			role		 	= "assistant"
			content 		= $StreamData.fullContent
		}
		
		if($StreamData.calls.all){
			$MessageResponse.tool_calls = $StreamData.calls.all;
		}
		
		$Usage = @{
			completion_tokens = $StreamData.MessageMeta.usage.output_tokens
			prompt_tokens = $StreamData.MessageMeta.usage.input_tokens
			total_tokens = $StreamData.MessageMeta.usage.output_tokens + $StreamData.MessageMeta.usage.input_tokens
		}
		
		return @{
			stream = @{
				RawResp = $RawResp
				answers = $StreamData.answers
				tools 	= $StreamData.calls.all
				meta = $StreamData.MessageMeta
			}
			
			message = $MessageResponse
			finish_reason = $StreamData.MessageMeta.stop_reason
			usage = $Usage
			model = $StreamData.MessageMeta.model
		}
	}

    return $RawResp.text | ConvertFrom-Json
}




# Define o token a ser usado nas chamadas da OpenAI!
# Faz um testes antes para certificar de que é acessível!
function Set-ClaudeToken {
	[CmdletBinding()]
	param()
	
	$ErrorActionPreference = "Stop";
	
	write-host "Forneça o token no campo senha na tela em que se abrir";
	
	$Provider = Get-AiCurrentProvider
	$ProviderName = $Provider.name.toUpper();
	$creds = Get-Credential "$ProviderName API TOKEN";
	
	$TempToken = $creds.GetNetworkCredential().Password;
	
	SetCurrentProviderData Token $TempToken;
	return;
}

function Get-ClaudeMessages {
	[CmdletBinding()]
	param(
		 $messages
		,$model
		,$max_tokens = 200
		,$temperature = 0.5
		,$StreamCallback = $null
	)
	
	
	$Provider = Get-AiCurrentProvider
	
	#Note que reaproveitamos o convert to openai message do provider!
	[object[]]$messages = @(ConvertTo-OpenaiMessage $messages)
	
	#Separa a mensagens de system!
	$NewMessages = @()
	$SystemMessage = "";
	$PrevMessage = $null
	foreach($m in $messages){
		if($m.role -eq "system"){
			$SystemMessage += $m.content;
		} else {
			$NewMessage = @{ role = $m.role; content = $m.content };
			if($PrevMessage.role -eq $NewMessage.role){
				$PrevMessage.content += $NewMessage.content;
			} else {
				$NewMessages +=  $NewMessage;
			}
			
			$PrevMessage =  $NewMessage;
		}
	}
	
	[object[]]$FinalMessages = @(
		$NewMessages
	)
	
	$data = @{
		messages 	= $FinalMessages 
		max_tokens	= $max_tokens
		temperature	= $temperature
		model		= $model
		system 		= $SystemMessage
	}
	
	InvokeClaude "messages" -method POST -body $data -StreamCallback $StreamCallback;
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
		messages = $prompt
		temperature = $temperature 
		model = $model
		max_tokens = $MaxTokens
		StreamCallback = $StreamCallback
	}
	
	if($RawParams){
		foreach($Key in @($RawParams.keys)){
			$Params[$key] = $RawParams[$Key]
		}
	}
	
	$result = Get-ClaudeMessages @Params
	
	if($result.stream){
		return $result;
	}
	
	$ResultText = $result.content.text;
	
	#$ResultText = $result.answer;
	#if($ResponseFormat -eq "json_object"){
	#	if($ResultText -match '(?s)```json(.*?)```'){
	#		$ResultText = $matches[1];
	#	} else {
	#		write-warning "Maritalk nao conseguiu retornar o JSON corretamente. A resposta será ajustada mas pode não ser no formato esperado!"
	#		$ResultText = @{PowerShaiJsonResult = $ResultText} | ConvertTo-Json -Compress;
	#	}
	#	
	#}
	
	if($ResponseFormat){
		throw "POWERSHAI_CLAUDE_FORMAT_NOTSUPPORTED: ResponseFormat not suppoted yet!"
	}

	
	
	#converte para o mesmo formato da OpenAI!
	return @{
		choices = @(
			@{
				finish_reason 	= $res.stop_reason
				index 			= 0
				logprobs 		= $null
				message 		= @{
									role = "assistant"
									content = $ResultText
								}
			}
		)
		
		usage 	= @{
					prompt_tokens 		= $result.usage.input_tokens
					completion_tokens 	= $result.usage.output_tokens
					total_tokens 		= $result.usage.input_tokens + $result.usage.output_tokens
				}
		model 	= $result.model
		created = [int](((Get-Date) - (Get-Date "1970-01-01T00:00:00Z")).TotalSeconds)
		object	= "chat.completion"
		id 		= $result.id
		system_fingerprint = $null
	}
	
	
}



return @{
	RequireToken 	= $true
	BaseUrl 		= "https://api.anthropic.com/v1"
	DefaultModel 	= "claude-3-haiku-20240307"
	TokenEnvName 	= "CLAUDE_API_KEY"
	
	info = @{
		desc	= "Anthropic Claude"
		url 	= "https://docs.anthropic.com/"
	}
}

