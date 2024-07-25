
# Get all models!
function Get-OllamaTags(){
	[CmdletBinding()]
	param()
	$BaseUrl 	= $POWERSHAI_SETTINGS.baseUrl
	$DefaultUrl = $POWERSHAI_SETTINGS.providers.ollama.ApiUrl;
	
	if(!$baseUrl){
		$BaseUrl = $DefaultUrl
	}
	
	#http://localhost:11434/api/tags
	return (InvokeOpenai "$BaseUrl/tags" -m 'GET').models
}

