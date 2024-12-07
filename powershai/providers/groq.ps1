# Compativel com openai!
Set-Alias groq_GetModels openai_GetModels
Set-Alias groq_Chat openai_Chat		
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
	
	return "🅾️$($ModelEmoji) $($model)";
}

return @{


	BaseUrl 			= "https://api.groq.com/openai/v1"
	DefaultModel		= "llama-3.2-70b-versatile"
	CredentialEnvName 	= "GROQ_API_KEY"
	
	info = @{
		desc	= "Modelos disponibilizados pela GroqCloud"
		url 	= "https://console.groq.com/"
	}
	
	#source: https://console.groq.com/docs/tool-use
	ToolsModels		= @(
		'gemma2-9b-it'
		'llama-3.1-405b-reasoning'
		'llama-3.1-70b-versatile'
		'llama-3.1-8b-instant'
		'llama3-70b-8192'
		'llama3-8b-8192'
		'mixtral-8x7b-32768'
		'gemma-7b-it'
		'llama3-groq-70b-8192-tool-use-preview'
		'llama3-groq-8b-8192-tool-use-preview'
	)


	IsOpenaiCompatible = $true
	
}