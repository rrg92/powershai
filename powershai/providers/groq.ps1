# Compativel com openai!
Set-Alias groq_GetModels openai_GetModels
Set-Alias groq_Chat openai_Chat		


function Set-GroqToken {
	<#
		.SYNOPSIS  
			Configura o token de autenticação do Groq Cloud.  
	#>
	[CmdletBinding()]
	param()
	SetOpenaiTokenBase
}

return @{
	RequireToken 	= $true
	BaseUrl 		= "https://api.groq.com/openai/v1"
	DefaultModel	= "llama-3.1-70b-versatile"
	TokenEnvName 	= "GROQ_API_KEY"
	
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


	
	
}