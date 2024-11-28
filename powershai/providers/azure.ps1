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
	
	Também, para não conflitar com o módulo  powershell oficial do Azure, que costuma ter comandos Az*, Azure*, iremos usar o nomes no formato AiAzure*
		
	
#>


<#
	.DESCRIPTION  
		Configura as credenciais para acesso ao LLMs disponíveis em assinaturas do Azure
		Você deve fornecer, além do token, algumas informações adicionais requeridas pelo azure. Veja abaixo para entender.
		
		No Azure, basicamente, existem 2 tipos de URL que iremos usar:
			- URLs específicas do serviço Azure OpenAI, que contém os modelos OpenAI 
			- URLs compatíveis com OpenAI, para outros modelos open source, como llama, phi3, etc.
	
		O primeiro caso é o formato de URL disponibilizado quando se usa um serviço Azure OpenAI.  
		Ele geralmente possui esse formato de URL:
			https://<RESOURCE-NAME>.openai.azure.com/openai/deployments/DEPLOYMENT-NAME/chat/completions?api-version=API-VERSION
		Essas URLS dão acesso à API do Azure OpenAI, e são exclusivas para apenas estes deployments de serviços do tipo "Azure OpenAI".  
		
		
		O segundo caso de URLs disponibilizadas pelo Azure, são essas que dão acesso Inference API do Azure.  
		Essas URLs são geradas quando se faz o deploy de modelos da comunidade ou de outras empreas que não sejam a OpenaI.  
		Exemplos: phi3, llama, qwen, etc.  
		O formato é:
			https://DEPLOYMENT-NAME.REGIAO.models.ai.azure.com
			
		
		Ambas as URLs implementam o mesmo padrão de comunicação da API da OpenAI, isto é, possui um endpoint /chat/completions, etc.  
		Porém, dependendo do tipo, há mais elementos que precisam ser configurados na URl, e por isso, é importante determinar o formato correto usado.  
		
		Este cmdlet detecta automaticamente o formato e faz as configurações necessárioas.  
		Ainda sim, é possível especificar estas informacoes separadamente, se precisar. Veja a documentação dos parâmetros para mais detalhes.
		Este comando aceita ambos estes formatos e, conforme o formato, ele irá configurar as chamadas da OpenAI corretamente.
	.LINK
		# Aprenda mais como funciona a API e os modelos no Azure
		https://learn.microsoft.com/en-us/azure/machine-learning/concept-model-catalog
		
	.LINK 
		# Sobre a API de Inferência
		https://learn.microsoft.com/en-us/azure/machine-learning/reference-model-inference-api?view=azureml-api-2&tabs=pythonm
#>
function azure_SetCredential {
	param(
		$AiCredential
		
		,#Nome do resource onde foi criado. Esta informação pode ser obtida no portal 
		#Ou, pode ser uma url. Dependendo do formato, serão extraído as informações necessárias.
		#VOcê pode usar qualquer URL que foi gerada no portal ou no AI Studio e colar aqui que os elementos identificados serão extraídos.  
		#Se um parâmetro obrigatório não for encontrado, um erro será retornado.
		#Se não informado, usa o atual preivamente configurado!
			[Alias('url')]
			$ResourceName
		
		,#Nome do deployment (configurado no portal ou azure ai studio)
		#Se não informado, usa o atual preivamente configurado!
			$DeploymentName
		
		,#Versão da API a ser usada 
		#Se não informado, usa o atual preivamente configurado!
			$ApiVersion = "2024-06-01"
			
		,#Força mudar a API key
			[switch]$ChangeApiKey
	)
	
	$UrlType = "AzureOpenai"
	
	
	
	if($ResourceName -match '^https:'){
		$ParsedUrl = [uri]$ResourceName
		
		if(!$ParsedUrl.Host){
			throw "POWERSHAI_AZUREOPENAI_INVALID_URL: $ResourceName";
		}
		
		switch -Regex ($ParsedUrl.Host){
			"([^\.]+)\.openai.azure.com" {
				$UrlType = "AzureOpenai";
				
				$ResourceName = $matches[1];
				if($ParsedUrl.PathAndQuery -match 'deployments/(.+?)/'){
					$DeploymentName = $matches[1];
				}
				
				if($ParsedUrl.PathAndQuery -match 'api-version=(\d{4}-\d{2}-\d{2}(-preview)?)'){
					$ApiVersion = $matches[1]
				}
			}
			
			'\.models\.ai\.azure\.com$' {
				$UrlType = "AzureInferenceApi";
				$BaseUrl = $ResourceName
			}
			
			 default {
				 throw "POWERSHAI_AZUREOPENAI_INVALID_URL_DOMAIN: $Domain. Expected *.openai.azure.com,*.models.azure.com, FullUrl = $ResourceName"
			 }
		}
	}

	$TempCred = NewAiCredential
	$TempCred.credential = HashTableMerge $AiCredential.old.credential @{
			ResourceName	= $ResourceName
			DeploymentName 	= $DeploymentName
			ApiVersion 		= $ApiVersion
			UrlType 		= $UrlType
			BaseUrl 		= $BaseUrl
			ApiKey 			= $ApiKey
		} -filter {
			param($k)
					
			$k.new -ne $null
		}
		
	$CredApiKey = $TempCred.credential.ApiKey;
	
	if(!$CredApiKey -or $ChangeApiKey){
		$Creds = Get-Credential "Azure Api key"
		$TempCred.credential.ApiKey = $Creds.GetNetworkCredential().Password;
	}

	Enter-AiCredential $TempCred {
		Get-OpenaiChat -prompt "Powershai Access Test! Just answer 'test ok'" -MaxTokens 100;
	}
	
	$AiCredential.credential = $TempCred.credential;
	
}
Set-Alias Set-OpenaiToken openai_SetCredential


<#
	.SYNOPSIS 
		Obtém informacoes do modelo. Mesmo retorno do endpoint /info da API de Inferência do Azure.
		
	.DESCRIPTION	
		Este endpoint funciona somente com urls compativeis com a API de Inferência do Azure.  
		
#>
function Get-AiAzureApiInfo {
	InvokeOpenai 'info' -method GET
}


# Used to change request!
function OpenaiAzureChangeRequest {
	param($Req, $OriginalParams)
	
	verbose "Changing ApiRequest";
	
	$Credential		= (Get-AiDefaultCredential).credential.credential
	$ResourceName 	= $Credential.ResourceName;
	$DeploymentName = $Credential.DeploymentName
	$ApiVersion 	= $Credential.ApiVersion
	$UrlType 		= $Credential.UrlType;
	$BaseUrl 		= $Credential.BaseUrl;
	$ApiKey 		= $Credential.ApiKey;
	
	if($UrlType -eq "AzureInferenceApi"){
		$TokenHeader = "Authorization";
		
		if(!$BaseUrl){
			throw "POWERSHAI_AZURE_HTTPREQ_NOBASEURL";
		}
		
	} else {
		$TokenHeader = "api-key";
	}
	
	$Req.headers[$TokenHeader] = $ApiKey
	
	
	$Endpoint = $OriginalParams.bound.endpoint;
	switch -Regex ($Endpoint){
		
		"^(models|info)$" {
			if($UrlType -eq "AzureInferenceApi"){
				$Req.url = "$BaseUrl/info"
			} else {
				$Req.url = "https://$ResourceName.openai.azure.com/openai/models?api-version=2024-06-01"
			}
			
		}
		
		'^chat/completions$' {
			if($UrlType -eq "AzureInferenceApi"){
				$Req.url = "$BaseUrl/v1/chat/completions"
			} else {
				$Req.url = "https://$ResourceName.openai.azure.com/openai/deployments/$DeploymentName/chat/completions?api-version=2024-06-01"
			}
			
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

function azure_GetModels {
	
	$UrlData = GetCurrentProviderData -Context UrlData;
	
	if($UrlData.UrlType -eq "AzureInferenceApi"){
		$info = Get-AiAzureApiInfo
		$info | Add-Member -Type AliasProperty -Name name -Value "model_name"
		return $info
	}
	
	openai_GetModels;
}

function azure_Chat {
	$RawParams = $ProviderFuncRawData.params;
	
	$UrlData = GetCurrentProviderData -Context UrlData;
	
	if($UrlData.UrlType -eq "AzureInferenceApi"){
		$RawParams.Remove('Functions');
	}
	
	openai_Chat @RawParams
}

return @{
	
	RequireToken 	= $false
	TokenEnvName 	= "AZURE_OPENAI_API_KEY"
	
	info = @{
		desc	= "AzureOpenAI "
		url 	= "https://learn.microsoft.com/en-us/azure/ai-services/openai/overview"
	}
	
	# Req changer
	ReqChanger = (Get-Command OpenaiAzureChangeRequest)
	
	#Assume every openai model support tools.
	ToolsModels = "gpt-4*","o1-*"
}


