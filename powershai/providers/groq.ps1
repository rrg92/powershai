# Compativel com openai!
Set-Alias groq_GetModels openai_GetModels	
Set-Alias Set-GroqToken Set-AiCredential


function groq_FormatPrompt {
	param($model)
	
	$ModelEmoji = "";
	
	
	if($model -like "llama*"){
		$ModelEmoji = "🦙"
	}
	
	if($model -like "gemma*"){
		$ModelEmoji = "💎"
	}
	
	if($model -like "mixtral*"){
		$ModelEmoji = "🟠"
	}
	
	return "🅾️$($ModelEmoji) $($model): ";
}

function groq_Chat {
	$RawParams = $ProviderFuncRawData.params;
	
	$prompt = $RawParams.prompt
	$model 	= $RawParams.model;
	
	if(!$model){
		$model = GetCurrentProviderData DefaultModel
	}
	
	
	if(!$model){
		throw "POWERSHAI_GROQ_NOMODEL: Must inform a model. Can set default model with Set-AiDefaultModel. List available with Get-AiModels"
	}
	
	# Remove refusal from messages!
	[object[]]$OpenaiMessages = @(ConvertTo-OpenaiMessage $prompt);
	
	[Collections.ArrayList]$GroqMessages = @()
	foreach($m in $OpenaiMessages){
		$GroqMessage = HashTableMerge @{} $m;
		
		if($GroqMessage.contains("refusal")){
			$GroqMessage.remove("refusal");
		}
		
		[void]$GroqMessages.Add($GroqMessage)
	}
	
	$RawParams.prompt 	= @($GroqMessages)
	$RawParams.model 	= $model
	
	try {
		openai_Chat @RawParams
	} catch  {
		$ex = $_.Exception;
		if($ex.ErrorName -ne "POWERSHAI_OPENAI_ERROR"){
			throw;
		}
		
		$GroqError = $ex.HttpResponseText
		$GroqResponseType = $ex.HttpResponse.ContentType;
		
		if($GroqResponseType -eq "application/json"){
			$GroqError = ($GroqError | ConvertFrom-Json).error
			
			$err = New-PowershaiError "POWERSHAI_GROQ_ERROR" "$($GroqError.code):$($GroqError.message)" -Prop @{
				error = $GroqError
			}
			
			throw $err;
		}
		
		throw;
	}
}

return @{


	BaseUrl 			= "https://api.groq.com/openai/v1"
	DefaultModel		= "llama-3.3-70b-versatile"
	CredentialEnvName 	= "GROQ_API_KEY"
	
	info = @{
		desc	= "Modelos disponibilizados pela GroqCloud"
		url 	= "https://console.groq.com/"
	}
	
	#source: https://console.groq.com/docs/tool-use
	ToolsModels		= @(
		'gemma2-9b-it'
		'mixtral-8x7b-32768'
		'gemma-7b-it'
		'llama-3*'
	)


	IsOpenaiCompatible = $true
	
}