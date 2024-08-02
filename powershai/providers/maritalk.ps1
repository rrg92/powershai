function Invoke-MaritalkApi {
	[CmdletBinding()]
	param(
		$endpoint
		,$body
		,$method = 'GET'
		,$Token = $Env:MARITALK_API_KEY
		,$StreamCallback = $null
		,[switch]$OpenAI
	)
	
	$Provider = Get-AiCurrentProvider
	$TokenRequired = $true;

	if(!$Token){
			$Token = GetCurrentProviderData Token;
			
			if(!$token){
				throw "POWERSHAI_MARITALK_NOTOKEN: No token was defined and is required!";
			}
	}
	
    $headers = @{}
	
	if($TokenRequired){
		 $headers["Authorization"] = "Bearer $token"
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
		EmptySeq	= 0
	}
	
	if($StreamCallback){
		$ReqParams['SseCallBack'] = {
			param($data)

			$line = $data.line;
			$StreamData.lines += $line;
			
			if(!$line -or $line.length -eq 0){
				$StreamData.EmptySeq++;
				
				if($StreamData.EmptySeq -ge 3){
					return $false;
				}
				
				return;
			}
			
			$StreamData.EmptySeq = 0;
			
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
				
				if($Answer.choices){
					$DeltaResp 	= $Answer.choices[0].delta;
					$TextChunk = $DeltaResp.content;
				}
				
			
				if($TextChunk -eq $null){
					$TextChunk 	= $Answer.text;
				}
				
				
				
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
		
		$Usage = $StreamData.MessageMeta
		
		if(!$Usage){
			$Usage = @{}
		}
		
		return @{
			stream = @{
				RawResp = $RawResp
				answers = $StreamData.answers
				tools 	= $null #$StreamData.calls.all
				meta = $StreamData.MessageMeta
			}
			
			message = $MessageResponse
			finish_reason = $null #$StreamData.FinishMessage.choices[0].finish_reason
			usage = $Usage
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
		[Alias('prompt')]
			$messages 
		,[switch]$do_sample
		,$MaxTokens = 1000
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
		max_tokens	= $MaxTokens
		temperature	= $temperature
		top_p		= $top_p
		model		= $model
	}
	
	Invoke-MaritalkApi "chat/inference" -method POST -body $data -StreamCallback $StreamCallback;
}

function Get-MaritalkChat {
    [CmdletBinding()]
	param(
		 $prompt
        ,$temperature   = 0.6
        ,$model         = $null
        ,$MaxTokens     = 1000
		,$ResponseFormat = $null
		
		,#Function list, as acceptable by Openai
		 #OpenAuxFunc2Tool can be used to convert from powershell to this format!
			$Functions 	= @()	
			
		#Add raw params directly to api!
		#overwite previous
		,$RawParams	= @{}
		
		,$StreamCallback = $null
	)

	$Provider = Get-AiCurrentProvider;
	if(!$model){
		$DefaultModel = $Provider.DefaultModel;
		
		if(!$DefaultModel){
			throw "POWERSHAI_NODEFAULT_MODEL: Must set default model using Set-AiDefaultModel"
		}
		
		$model = $DefaultModel
	}

	[object[]]$Messages = @(ConvertTo-OpenaiMessage $prompt);
	
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
	
    $Body = @{
        model       = $model
        messages    = $FinalMessages 
        max_tokens  = $MaxTokens
        temperature = $temperature 
    }
	
	if($RawParams){
		$RawParams.keys | %{ $Body[$_] = $RawParams[$_] }
	}
	
	if($ResponseFormat){
		$Body.response_format = @{type = $ResponseFormat}
	}
	
	#if($Functions){
	#	$Body.tools = $Functions
	#	$Body.tool_choice = "auto";
	#}
	
	write-verbose "Body:$($body|out-string)"
	Invoke-MaritalkApi -openai -method POST -endpoint 'chat/completions' -body $Body -StreamCallback $StreamCallback	
}

Set-Alias maritalk_Chat Get-MaritalkChat

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
		prompt = $prompt
		temperature = $temperature 
		model = $model
		MaxTokens = $MaxTokens
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
	$Result = Invoke-MaritalkApi "chat/models" -method GET
	
	$ModelList = $Result.models
	
	$m.models.psobject.Properties | %{ 
		$ModelInfo = $_.Value 
		$ModelInfo | Add-Member Noteproperty name $_.Name -Force;
		$ModelInfo;
	}
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
	
	$Provider = Get-AiCurrentProvider
	
	SetCurrentProviderData Token $TempToken;
	
	return;
}





return @{
	info = @{
		desc	= "LLM Brasileiro, feito pela empresa Maritaca.ai"
		url 	= "https://www.maritaca.ai/"
	}
	
	RequireToken 	= $true
	BaseUrl 		= "https://chat.maritaca.ai/api"
	desc 			= "Maritalk" 			
	DefaultModel 	= "sabia-2-medium"
}

