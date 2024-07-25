<#
	Base para invocar a API do ollama (parte da api que nao é compativel com a openai)
#>
function InvokeOllamaApi {
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method 			= 'POST'
		,$token 			= $Env:OLLAMA_API_KEY
		,$StreamCallback 	= $null
	)

	$Provider = Get-AiCurrentProvider
	
    $headers = @{}
	
	if($token){
		 $headers["Authorization"] = "Bearer $token"
	}
	
	$OllamaBaseUrl = $POWERSHAI_SETTINGS.OllamaApiUrl;
	
	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		write-verbose "Getting ApiURL"
		$url = GetCurrentProviderData ApiUrl
		$url += "/$endpoint"
	}
	
	

	write-verbose "OllamaBaseUrl: $url";
	
	if($StreamCallback){
		$body.stream = $true;
		$body.stream_options = @{include_usage = $true};
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
	}
				
	if($StreamCallback){
		$ReqParams['SseCallBack'] = {
			param($data)

			$line = $data.line;
			$StreamData.lines += $line;
			
			if($line -like 'data: {*'){
				$RawJson = $line.replace("data: ","");
				$Answer = $RawJson | ConvertFrom-Json;
				
				$FinishReason 	= $Answer.choices[0].finish_reason;
				$DeltaResp 		= $Answer.choices[0].delta;
				
				$Role = $DeltaResp.role; #Parece vir somente no primeiro chunk...
				
				$StreamData.fullContent += $DeltaResp.content;
				
				if($FinishReason){
					$StreamData.FinishMessage = $Answer
				}
				

				foreach($ToolCall in $DeltaResp.tool_calls){
					$CallId 		= $ToolCall.id;
					$CallType 		= $ToolCall.type;
					verbose "Processing tool`n$($ToolCall|out-string)"
					
					
					if($CallId){
						$StreamData.calls.all += $ToolCall;
						$StreamData.CurrentCall = $ToolCall;
						continue;
					}
					
					$CurrentCall = $StreamData.CurrentCall;
				
					
					if($CurrentCall.type -eq 'function' -and $ToolCall.function){
						$CurrentCall.function.arguments += $ToolCall.function.arguments;
					}
				}
				
				
				$StreamData.answers += $Answer
				& $StreamCallback $Answer
			}
			elseif($line -eq 'data: [DONE]'){
				#[DONE] documentando aqui:
				#https://platform.openai.com/docs/api-reference/chat/create#chat-create-stream
				return $false;
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
		
		return @{
			stream = @{
				RawResp = $RawResp
				answers = $StreamData.answers
				tools 	= $StreamData.calls.all
			}
			
			message = $MessageResponse
			finish_reason = $StreamData.FinishMessage.choices[0].finish_reason
			usage = $StreamData.answers[-1].usage
			model = $StreamData.answers[-1].model
		}
	}

    return $RawResp.text | ConvertFrom-Json
}



# Change ollama urls!
function Set-OllamaUrl {
	param($url)
	
	SetCurrentProviderData BaseUrl "$url/v1" # requerido pela openai
	SetCurrentProviderData ApiUrl "$url/api"
}



# Get all models!
function Get-OllamaTags(){
	[CmdletBinding()]
	param()
	
	#http://localhost:11434/api/tags
	return (InvokeOllamaApi "tags" -m 'GET').models
}

Set-Alias ollama_GetModels Get-OllamaTags 
Set-Alias ollama_Chat Get-OpenAiChat # usa o mesmo da openai!

return @{
	RequireToken 	= $false
	BaseUrl 		= "http://localhost:11434/v1"
	ApiUrl 			= "http://localhost:11434/api"
	DefaultModel	= $null
	TokenEnvName 	= "OLLAMA_API_KEY"
	
	info = @{
		desc	= "Permite acesso aos modelos disponibilizados pelo Ollama"
		url 	= "https://github.com/ollama/ollama"
	}
	
}
