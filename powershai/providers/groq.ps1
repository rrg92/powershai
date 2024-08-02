# Compativel com openai!
Set-Alias groq_GetModels openai_GetModels
Set-Alias groq_Chat openai_Chat		



return @{
	RequireToken 	= $true
	BaseUrl 		= "https://api.groq.com/openai/v1"
	DefaultModel	= "llama-3.1-70b-versatile"
	TokenEnvName 	= "GROQ_API_KEY"
	
	info = @{
		desc	= "Modelos disponibilizados pela GroqCloud"
		url 	= "https://console.groq.com/"
	}
	
}