<#
	Base para invocar a API do ollama (parte da api que nao é compativel com a openai)
#>
function Invoke-OllamaApi {
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
	$OllamaBaseUrl = $POWERSHAI_SETTINGS.OllamaApiUrl;
	
	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		verbose "Getting ApiURL"
		$url = GetCurrentProviderData ApiUrl
		$url += "/$endpoint"
	}
	

	
	verbose "OllamaBaseUrl: $url"
    $ReqParams = @{
        data            = $body
        url             = $url
        method          = $method
        Headers         = $headers
    }

	verbose "ReqParams:`n$($ReqParams|out-string)"
    $RawResp 	= InvokeHttp @ReqParams
	verbose "RawResp: `n$($RawResp|out-string)"
	
    return $RawResp.text | ConvertFrom-Json
}
Set-Alias InvokeOllamaApi Invoke-OllamaApi


# Change ollama urls!
function Set-OllamaUrl {
	param($url)
	
	SetCurrentProviderData BaseUrl "$url/v1" # requerido pela openai
	SetCurrentProviderData ApiUrl "$url/api"
}



# Get all models!
function Get-OllamaTags {
	[CmdletBinding()]
	param()
	
	return (InvokeOllamaApi "tags" -m 'GET').models
}
Set-Alias ollama_GetModels Get-OllamaTags 
Set-Alias Get-OllamaModels Get-OllamaTags 
Set-Alias OllamaTags Get-OllamaTags 

function Get-OllamaEmbeddings {
	<#
		.SYNOPSIS
			Obtém os embeddings usando um modelo de IA!
	#>
	param(
		$text
		
		,# o modelo a ser usado 
		 # use Get-AiModels para uma lista de modelos que suportam embeddings!
			$model
	
	)
	
	$DefaultModel = GetCurrentProviderData -Context DefaultEmbeddingsModel
	
	if(!$model){
		$model = $DefaultModel
	}
	
	InvokeOllamaApi "embed" @{
		model = $model
		input = $text
	}
}

function Get-OllamaModel {
	param($model)
	
	InvokeOllamaApi "api/show" -body @{
		model = $model
	}
}
Set-Alias OllamaShow Get-OllamaModel
Set-Alias Show-OllamaModel Get-OllamaModel

function ollama_GetEmbeddings {
	param(
		$text 
		,$model
		,[switch]$IncludeText
		,$dimensions
	)
	
	$text = @($text);
	
	if($dimensions){
		throw "POWERSHAI_OLLAMA_DIMENSIONS_NOTSUPPORTED: Ollama dont support specify dimensions."
	}
	
	verbose "Invoking native get embeddings..."
	$resp = Get-OllamaEmbeddings $text -model $model
	
	$i = -1;
	$resp.embeddings | %{
		$i++;
		$emb = @{
			embeddings = $_
		}
		
		if($IncludeText){
			$emb.text = $text[$i];
		}
		
		return [PsCustomObject]$emb
	}
}




Set-Alias ollama_Chat Get-OpenAiChat # usa o mesmo da openai!








return @{
	RequireToken 	= $false
	BaseUrl 		= "http://localhost:11434/v1"
	ApiUrl 			= "http://localhost:11434/api"
	DefaultModel	= $null
	TokenEnvName 	= "OLLAMA_API_KEY"
	
	DefaultEmbeddingsModel = "nomic-embed-text:latest"
	
	EmbeddingsModels = @(
		"nomic-embed-.+"
	)
	
	info = @{
		desc	= "Permite acesso aos modelos disponibilizados pelo Ollama"
		url 	= "https://github.com/ollama/ollama"
	}
	
	IsOpenaiCompatible = $true
	
}
