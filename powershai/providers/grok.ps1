# Compativel com openai!
Set-Alias grok_GetModels Get-OpenaiModels
Set-Alias grok_Chat Get-OpenAiChat 			



return @{
	RequireToken 	= $true
	BaseUrl 		= "https://api.groq.com/openai/v1"
	DefaultModel	= "llama-3.1-70b-versatile"
	TokenEnvName 	= "GROK_API_KEY"
	
	info = @{
		desc	= "Modelos disponibilizados pela GroqCloud"
		url 	= "https://console.groq.com/"
	}
	
}