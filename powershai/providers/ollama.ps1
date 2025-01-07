$POWERSHAI_OLLAMA = @{
	ModelsCache = @{}
}

function Invoke-OllamaApi {
<#
	.SYNOPSIS 
		Base para invocar a API do ollama (parte da api que nao é compativel com a openai)
#>
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method 			= 'POST'
		,$token 			= $Env:OLLAMA_API_KEY
		,$StreamCallback 	= $null
		,[switch]$GetRawResp
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
		SseCallback		= $StreamCallback
    }

	verbose "ReqParams:`n$($ReqParams|out-string)"
	try {
		$RawResp 	= InvokeHttp @ReqParams
		
	} catch [System.Net.WebException] {
		$ex = $_.exception;
		
		if($ex.PowershaiDetails){
			$ResponseError = $ex.PowershaiDetails.ResponseError.text;
			
			if($ResponseError){
				$err = New-PowershaiError "POWERSHAI_OLLAMA_ERROR" "Error: $ResponseError" -Prop @{
					HttpResponseText 	= $ResponseError
					HttpResponse		= $ex.PowershaiDetails.ResponseError.Response
				}
				throw $err
			}
		}
		
		throw;
	}
	verbose "RawResp: `n$($RawResp|out-string)"
	
	if($GetRawResp){
		return $RawResp;
	}
	
    return $RawResp.text | ConvertFrom-Json
}
Set-Alias InvokeOllamaApi Invoke-OllamaApi


# Change ollama urls!
function Set-OllamaUrl {
<#
	.SYNOPSIS 
		Muda a URL do ollama. Formato protocolo://endereço:porta
#>
	[CmdletBinding()]
	param(
		#Especifique a URL base somente (a url antes do /v1 ou /api).
		$url
	)
	
	SetCurrentProviderData BaseUrl "$url/v1" # requerido pela openai
	SetCurrentProviderData ApiUrl "$url/api"
}



# Get all models!
function Get-OllamaTags {
<#
	.SYNOPSIS 
		Lista as tags do ollama. Equivalente ao endpoint /api/tags
		
	.DESCRIPTION 
		Mais info em https://github.com/ollama/ollama/blob/main/docs/api.md#list-local-models
#>
	[CmdletBinding()]
	param()
	
	return (InvokeOllamaApi "tags" -m 'GET').models
}
Set-Alias Get-OllamaModels Get-OllamaTags 
Set-Alias OllamaTags Get-OllamaTags 

function Get-OllamaEmbeddings {
	<#
		.SYNOPSIS
			Obtém os embeddings usando um modelo de IA que suporta embeddings (Endpoint /api/embed)
			
		.DESCRIPTION
			Mais info: https://github.com/ollama/ollama/blob/main/docs/api.md#generate-embeddings
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
<#
	.SYNOPSIS 
		Obtém detalhes de um modulo (/api/show)
		
	.DESCRIPTION 
		Mais info em https://github.com/ollama/ollama/blob/main/docs/api.md#show-model-information
#>
	[CmdletBinding()]
	param(
		# nome do modelo no formato modelo:tag (deve ser o nome exato)
		$model
	)
	
	InvokeOllamaApi "show" -body @{
		model = $model
	}
}
Set-Alias OllamaShow Get-OllamaModel
Set-Alias Show-OllamaModel Get-OllamaModel


function Update-OllamaModel {
<#
	.SYNOPSIS 
		Atualiza (ou baixa) um modelo do ollama (api/pull)
		
	.DESCRIPTION 
		Mais info em https://github.com/ollama/ollama/blob/main/docs/api.md#pull-a-model
#>
	[CmdletBinding()]
	param(
		# nome do modelo no formato modelo:tag (deve ser o nome exato)
		$model
		
		,[switch]$Print
	)
	
	
	$Stats = @{
		StartTime 	= (Get-Date)
		StartTs		= $null
		StartBytes 	= $null
		status		= @()
	}
	
	$Sse = {
		param($data)
		
		if($Print){
			write-host $data.line
		}
		
		try {
			$Event = $data.line | ConvertFrom-Json
		} catch {
			write-warning "Converting event status to json failed: $_";
			write-host $Event;
			return;
		}
		
		if(!$Event.status){
			return;
		}
		
		
		$PercentCompleted = 0;
		$CompletedBytes = $Event.completed;
		
		if(!$CompletedBytes){
			$CompletedBytes = 0;
		}
		
		if($CompletedBytes){
			[int]$PercentCompleted = ($CompletedBytes/$Event.Total)*100
		}

		
		$PercentText 		= $PercentCompleted
		$TotalHuman 		= Bytes2Human $Event.total 
		$CompletedHuman 	= Bytes2Human $Event.completed
		
		$HumanSpeed = $null;
		$EstimatedSeconds = $null
		
		if($Stats.StartBytes -eq $null){
			$Stats.StartBytes 	= $Event.completed
			$Stats.StartTs 		= (Get-Date)
		} else {
			$Elapsed 			= (Get-Date) - $Stats.StartTs
			$CompletedDelta 	= $CompletedBytes - $Stats.StartBytes;
			$Speed 				= $CompletedDelta/$Elapsed.TotalSeconds;
			$HumanSpeed 		= Bytes2Human $Speed 
			
			$LeftBytes 			= $Event.total -  $Event.completed;
			
			if($Speed -gt 0){
				$EstimatedSeconds	= $LeftBytes/$Speed
			} else {
				$EstimatedSeconds 	= 0
				$Speed 				= 0
				$HumanSpeed 		= 0
			}
		}
		
		if($Print){
			write-host "`t" $Elapsed  $CompletedDelta
		}
		
		$LastStatus = $Stats.status[-1]
		
		if($LastStatus -ne $Event.status){
			$Stats.status += $Event.status
		}
		
		$EventId = $Stats.status.count;
		
		$ProgressParams = @{
			Activity 		= $Event.status
			ID				= $EventId
		}
		
		if($Event.completed){
			$ProgressParams.PercentComplete = $PercentCompleted
			if($HumanSpeed){
				$Status += "$HumanSpeed/s"
			}
			$Status = "$PercentText%","$CompletedHuman/$TotalHuman"
			
			if($EstimatedSeconds){
				$ProgressParams.SecondsRemaining = $EstimatedSeconds
			}
			
			$ProgressParams.Status = $Status -Join " | "
		}
		

		
		write-progress @ProgressParams
		
		$Stats.LastRec = Get-Date;
		$Stats.LastCompleted = $CompletedBytes;
		

	}
	
	$resp = Invoke-OllamaApi 'pull' -method POST -body @{ model = $model } -StreamCallback $Sse -GetRawResp
	Reset-OllamaPowershaiCache
}


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


function ollama_FormatPrompt {
	param($model)
	
	$ModelEmoji = "";
	
	
	if($model -like "llama*"){
		$ModelEmoji = "🦙"
	}
	
	if($model -like "smollm*"){
		$ModelEmoji = "🤗"
	}
	
	if($model -like "gemma*"){
		$ModelEmoji = "💎"
	}
	
	if($model -like "aya*"){
		$ModelEmoji = "❄️"
	}
	
	if($model -like "phi*"){
		$ModelEmoji = "🟦"
	}
	
	if($model -like "qwen*"){
		$ModelEmoji = "🟣"
	}
	
	
	
	return "⚪$($ModelEmoji) $($model): ";
	
}



function ollama_GetModels {
	$AllModels = Get-OllamaTags
	
	$Models = @();
	
	
	foreach($model in $AllModels){
		
		$ModelDetails = $POWERSHAI_OLLAMA.ModelsCache[$model.name] 
		
		if(!$ModelDetails){
			$ModelDetails = Get-OllamaModel $model.name
			$POWERSHAI_OLLAMA.ModelsCache[$model.name]  = $ModelDetails
		}
		
		# Check tools based on that: https://github.com/ollama/ollama/blob/cdf3a181dcdb42ba72d9162c4f3461f218c33d5f/server/images.go#L98
		# using that doc as variable source:https://github.com/ollama/ollama/blob/main/docs/template.md
		
		$ModelTemplate = $ModelDetails.template
		
		$SupportTools = $ModelTemplate -match '\.\b(Tools)\b'
		
		$ModelInfo = [PsCustomObject]@{
			name 	= $model.name
			tools 	= $SupportTools
			tags 	= $model
			details	= $ModelDetails
		}
		
		$Models += $ModelInfo;
	}
	
	return $Models;
}




function Reset-OllamaPowershaiCache {
<#
	.SYNOPSIS 
		Reseta o cache de modelos do ollama no powershai
		
	.DESCRIPTION 
		O ollama mantém um cache de modelos para evitar consultar informações detalhadas a todo momento.  
		Este comando reseta esse cache. Ao obter as informações da próxima vez (usando Get-AiModels), o cache é populado novamente.
		
		Este cache também é resetado automaticamente sempreque o powershai é importado novamente.
#>
	[CmdletBinding()]
	param()
	
	$POWERSHAI_OLLAMA.ModelsCache = @{}
}

Set-Alias ollama_Chat Get-OpenAiChat # usa o mesmo da openai!



function OllamaReqHooks {
	param($p)
	
	
	$MyData = $p.UserData;
	
	
	if($p.hook -eq "end"){

		$c0 = $p.data.StreamData.FullAnswer.choices;
		
		if($c0){
			$c0 = $c0[0]
		} else {
			return;
		}
		
		if($c0.delta.tool_calls){
			$c0.finish_reason = "tool_calls"
		}
		
	}
	
	
	
}


return @{
	RequireToken 	= $false
	BaseUrl 		= "http://localhost:11434/v1"
	ApiUrl 			= "http://localhost:11434/api"
	DefaultModel	= $null
	
	
	CredentialEnvName 	= "OLLAMA_API_KEY"
	
	DefaultEmbeddingsModel = "nomic-embed-text:latest"
	
	EmbeddingsModels = @(
		"nomic-embed-.+"
	)
	
	ReqHooks 		= (Get-Command OllamaReqHooks)
	
	info = @{
		desc	= "Permite acesso aos modelos disponibilizados pelo Ollama"
		url 	= "https://github.com/ollama/ollama"
	}
	
	IsOpenaiCompatible = $true
	
}
