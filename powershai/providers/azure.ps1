<#
	Azure OpenAI Powershai Provider
	
		Este arquivo implementa o provider do Azure OpenAI.
		Link úteis:
			- https://ai.azure.com/
			- https://learn.microsoft.com/en-us/azure/ai-services/openai/reference
			- 	Latest GA APIs: https://learn.microsoft.com/en-us/azure/ai-services/openai/reference#api-specs
			- https://learn.microsoft.com/en-us/azure/ai-services/openai/api-version-deprecation
			


	A API do Azure OpenAI difere um pouco da OpenAI base devido ao formato da URL. 
	Na OpenAI, a url é fixa, mudando apenas o token.  
	No Azure OpenAI, a URL depende de nomes configurados pelo usuário.  
	
		POST https://YOUR_RESOURCE_NAME.openai.azure.com/openai/deployments/YOUR_DEPLOYMENT_NAME/completions?api-version=2024-06-01
		
		Variaveis que precisamos:
			- ResourceName
			- DeploymentName 
			- ApiVersion
	
	TAmbém, além da autenticação por API Key, há a autenticação usando EntraID.  
	Nesta primeira versão, não iremos implementar autenticação por EntraID.  
	
	Também, para não conflitar com o módulo powershell Azure, que costuma ter comandos Az*, Azure*, iremos usar o nomes no formato OpenaiAzure*.
#>




<#
	.SYNOPSIS 
		Configura a URL para o OpenAI Azure.
#>
function Set-OpenaiAzureUrl {
	[CmdLetBinding()]
	param(
		#Nome do resource onde foi criado. Esta informação pode ser obtida no portal 
			[Alias('url')]
			$ResourceName
		
		,#Nome do deployment (configurado no portal ou azure ai studio)
			$DeploymentName
		
		,#Versão da API a ser usada 
			$ApiVersion = "2024-06-01"
	)
	
	
	if($ResourceName -match '^https:'){
		$ParsedUrl = [uri]$ResourceName
		
		if(!$ParsedUrl.Host){
			throw "POWERSHAI_AZUREOPENAI_INVALID_URL: $ResourceName";
		}
		
		$ResourceName = @($ParsedUrl.Host.split("."))[0]
		
		if($ParsedUrl.PathAndQuery -match 'deployments/(.+?)/'){
			$DeploymentName = $matches[1];
		}
		
		if($ParsedUrl.PathAndQuery -match 'api-version=(\d{4}-\d{2}-\d{2}(-preview)?)'){
			$ApiVersion = $matches[1]
		}
	}
	
	
	$CurrentData = GetCurrentProviderData UrlData 
	
	SetCurrentProviderData -Context UrlData @{
		ResourceName	= $ResourceName
		DeploymentName 	= $DeploymentName
		ApiVersion 		= $ApiVersion
	}
	
	$Token = GetCurrentOpenaiToken
	
	if(!$Token){
		Set-OpenaiAzureApiKey;
	}
	
	try {
		$Result = Get-OpenaiChat -prompt "Powershai Access Test! Just answer 'test ok'" -MaxTokens 100;
	} catch {
		SetCurrentProviderData -Context UrlData $CurrentData
		throw;
	}
}

<#
	.SYNOPSIS 
		Configurar a API key padrão para ser usada com o provider azure.
#>
function Set-OpenaiAzureApiKey {
	[CmdLetBinding()]
	param()
	
	SetOpenaiTokenBase "AzureOpenai Api Key" -Test {
		param($token)
		
		try {
			$Result = Get-OpenaiChat -prompt "Powershai Access Test! Just answer 'test ok'" -MaxTokens 100;
		} catch {
			throw "POWERSHAI_AZUREOPENAI_TOKENTEST_FAILED: Token is invalid";
		}
	
	}
}

# Used to change request!
function OpenaiAzureChangeRequest {
	param($Req, $OriginalParams)
	
	verbose "Chaning ApiRequest";
	
	$UrlData 		= GetProviderData "azure" UrlData;
	$Token 			= GetCurrentOpenaiToken
	$ResourceName 	= $UrlData.ResourceName;
	$DeploymentName = $UrlData.DeploymentName
	$ApiVersion 	= $UrlData.ApiVersion
	
	if(!$Token){
		throw "POWERSHAI_AZUREOPENAI_NOTOKEN"
	}
	
	$Req.headers['api-key'] = $Token
	
	$Endpoint = $OriginalParams.bound.endpoint;
	switch -Regex ($Endpoint){
		
		"^models$" {
			$Req.url = "https://$ResourceName.openai.azure.com/openai/models?api-version=2024-06-01"
		}
		
		'^chat/completions$' {
			$Req.url = "https://$ResourceName.openai.azure.com/openai/deployments/$DeploymentName/chat/completions?api-version=2024-06-01"
		}
		
		'^https?:' {
			verbose "IsHttp endpoint. Nothing to do...";
		}
		
		default {
			throw "POWERSHAI_AZUREOPENAI_ENDPOINT_NOTSUPPORTED: $Endpoint";
		}
		
	}
}

function azure_FormatPrompt {
	param($model)
	
	return "🔵☁️ $($model): "
}




# re-use openai provider
Set-Alias azure_Chat Get-OpenaiChat
Set-Alias azure_GetModels Get-OpenaiModels


return @{
	
	RequireToken 	= $false
	DefaultModel 	= "gpt-4o-mini"
	TokenEnvName 	= "AZURE_OPENAI_API_KEY"
	
	info = @{
		desc	= "AzureOpenAI "
		url 	= "https://learn.microsoft.com/en-us/azure/ai-services/openai/overview"
	}
	
	# Req changer
	ReqChanger = (Get-Command OpenaiAzureChangeRequest)
}


