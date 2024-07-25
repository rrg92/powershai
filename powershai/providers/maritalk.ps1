function Invoke-MaritalkApi {
	param(
		$endpoint
		,$body
		,$method = 'GET'
		,$token = $Env:MARITALK_API_KEY
		,$StreamCallback = $null
	)
	
	$Provider = Get-AiCurrentProvider


	if(!$token){
		throw "POWERSHAI_MARITALK_NOTOKEN"
	}
	
    $headers = @{
        "Authorization" = "Key $Token"
    }
	
	$JsonParams = @{Depth = 10}
	if($StreamCallback){
		$body.stream = $true;
		#$body.stream_options = @{include_usage = $true};
	}
	$url =  "https://chat.maritaca.ai/api/" + $endpoint
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
		EndReceived = $false
		MessageMeta = $null
	}
	
	if($StreamCallback){
		$ReqParams['SseCallBack'] = {
			param($data)

			$line = $data.line;
			$StreamData.lines += $line;
			
			#End callback!
			if($line -eq "event: end"){
				$StreamData.EndReceived = $true;
				return;
			}
			
			if($line -like 'data: {*'){
				$RawJson = $line.replace("data: ","");
				$Answer = $RawJson | ConvertFrom-Json;
				
				if($StreamData.EndReceived){
					$StreamData.MessageMeta = $Answer;
					return $false;
				}
				
				$TextChunk = $Answer.text;
				
				$Role = $DeltaResp.role; #Parece vir somente no primeiro chunk...
				
				$StreamData.fullContent += $TextChunk
				
				$StreamData.answers += $Answer
				
				$StdAnswer = @{
					choices = @(
						@{
							delta = @{content = $TextChunk}
						}
					)
				}
				
				& $StreamCallback $StdAnswer
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
		
		#if($StreamData.calls.all){
		#	$MessageResponse.tool_calls = $StreamData.calls.all;
		#}
		
		return @{
			stream = @{
				RawResp = $RawResp
				answers = $StreamData.answers
				tools 	= $null #$StreamData.calls.all
				meta = $StreamData.MessageMeta
			}
			
			message = $MessageResponse
			finish_reason = $null #$StreamData.FinishMessage.choices[0].finish_reason
			usage = $StreamData.MessageMeta
			model = $StreamData.MessageMeta.model
		}
	}

    return $RawResp.text | ConvertFrom-Json
}

<#
	Esta função é usada como base para invocar a a API da MariTalk!
	https://github.com/maritaca-ai/maritalk-api/blob/main/examples/api/maritalk_via_requisi%C3%A7%C3%B5es_https.js
	
#>
function Invoke-MaritalkInference {
	[CmdletBinding()]
    param(
		$messages 
		,[switch]$do_sample
		,$max_tokens = 1000
		,$temperature = 0.5
		,$top_p = 0.95
		,$model = "sabia-2-medium"
		,$StreamCallback = $null
	)
	
	$Provider = Get-AiCurrentProvider
	
	#Note que reaproveitamos o convert to openai message do provider!
	[object[]]$messages = @(ConvertTo-OpenaiMessage $messages)
	
	#Junta todas as system message sem uma só!
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
	
	[object[]]$FinalMessages = @()
	
	if($SystemMessage){
		$FinalMessages += @{role="system";content = $SystemMessage}
	}
		
	$FinalMessages += $NewMessages
	
	$data = @{
		messages 	= $FinalMessages 
		do_sample	= ([bool]$do_sample)
		max_tokens	= $max_tokens
		temperature	= $temperature
		top_p		= $top_p
		model		= $model
	}
	
	Invoke-MaritalkApi "chat/inference" -method POST -body $data -StreamCallback $StreamCallback;
}

function maritalk_Chat {
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
	
	if(!$model){
		$model = "sabia-2-medium"
	}
	

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
	
	$result = Invoke-MaritalkInference @Params
	
	if($result.stream){
		return $result;
	}
	
	
	$ResultText = $result.answer;
	if($ResponseFormat -eq "json_object"){
		if($ResultText -match '(?s)```json(.*?)```'){
			$ResultText = $matches[1];
		} else {
			write-warning "Maritalk nao conseguiu retornar o JSON corretamente. A resposta será ajustada mas pode não ser no formato esperado!"
			$ResultText = @{PowerShaiJsonResult = $ResultText} | ConvertTo-Json -Compress;
		}
		
	}

	
	
	#converte para o mesmo formato da OpenAI!
	return @{
		choices = @(
			@{
				finish_reason 	= "stop"
				index 			= 0
				logprobs 		= $null
				message 		= @{
									role = "assistant"
									content = $ResultText
								}
			}
		)
		
		usage 	= $result.usage
		model 	= $result.model
		created = [int](((Get-Date) - (Get-Date "1970-01-01T00:00:00Z")).TotalSeconds)
		object	= "chat.completion"
		id 		= "chatcmpl-maritalkpowershai"
		system_fingerprint = $null
	}
	
	
}

# Retorna os models!
function Get-MaritalkModels {
	@(
		[PsCustomObject]@{name = "sabia-2-small"}
		[PsCustomObject]@{name = "sabia-2-medium"}
		[PsCustomObject]@{name = "sabia-3"}
	)
}

Set-Alias maritalk_GetModels Get-MaritalkModels


function maritalk_FormatPrompt {
	param($model)
	
	return "🦜 $($model): "
}

function Set-MaritalkToken {
	[CmdletBinding()]
	param()
	
	$ErrorActionPreference = "Stop";
	
	write-host "Forneça o token no campo senha na tela em que se abrir";
	$creds = Get-Credential "MARITALK TOKEN";
	$TempToken = $creds.GetNetworkCredential().Password;
	#
	#write-host "Checando se o token é válido";
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
	#write-host "	Tudo certo!";
	
	$Env:MARITALK_API_KEY = $TempToken
	
	return;
}





return @{
	info = @{
		desc	= "LLM Brasileiro, feito pela empresa Maritaca.ai"
		url 	= "https://www.maritaca.ai/"
	}
	
	desc 			= "Maritalk" 			
	DefaultModel 	= "sabia-2-medium"
}

