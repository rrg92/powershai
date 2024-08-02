<#
	Esta função é usada como base para invocar a a API da OpenAI!
#>
function InvokeOpenai {
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method = 'POST'
		,$StreamCallback = $null
		,$Token = $null
	)

	$Provider = Get-AiCurrentProvider
	write-verbose "InvokeOpenAI, current provider = $($Provider.name)"
	$TokenRequired = GetCurrentProviderData RequireToken;

	if(!$Token){
		$TokenEnvName = GetCurrentProviderData TokenEnvName;
		
		if($TokenEnvName){
			write-verbose "Trying get token from environment var: $($TokenEnvName)"
			$Token = (get-item "Env:$TokenEnvName"  -ErrorAction SilentlyContinue).Value
		}
	}	
	
	if($TokenRequired -and !$Token){
			$Token = GetCurrentProviderData Token;
			
			if(!$token){
				throw "POWERSHAI_OPENAI_NOTOKEN: No token was defined and is required! Provider = $($Provider.name)";
			}
	}
	
    $headers = @{}
	
	if($TokenRequired){
		 $headers["Authorization"] = "Bearer $token"
	}


	
	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		$BaseUrl = GetCurrentProviderData BaseUrl
		$url = "$BaseUrl/$endpoint"
	}

	if($StreamCallback){
		$body.stream = $true;
		$body.stream_options = @{include_usage = $true};
	}

	$JsonParams = @{Depth = 10}
	
	write-verbose "InvokeOpenai: Converting body to json (depth: $($JsonParams.Depth))..."
    $ReqBodyPrint = $body | ConvertTo-Json @JsonParams
	write-verbose "ReqBody:`n$($ReqBodyPrint|out-string)"
	
	$ReqBody = $body | ConvertTo-Json @JsonParams -Compress
    $ReqParams = @{
        data            = $ReqBody
        url             = $url
        method          = $method
        Headers         = $headers
    }

	$StreamData = @{
		#Todas as respostas enviadas!
		answers = @()
		
		fullContent = ""
		
		FinishMessage = $null
		
		#Todas as functions calls
		calls = @{
			all = @()
			funcs = @{}
		}
		
		CurrentCall = $null
	}
				
	if($StreamCallback){
		$ReqParams['SseCallBack'] = {
			param($data)

			$line = $data.line;
			$StreamData.lines += $line;
			
			if($line -like 'data: {*'){
				$RawJson = $line.replace("data: ","");
				$Answer = $RawJson | ConvertFrom-Json;
				
				$FinishReason 	= $Answer.choices[0].finish_reason;
				$DeltaResp 		= $Answer.choices[0].delta;
				
				$Role = $DeltaResp.role; #Parece vir somente no primeiro chunk...
				
				$StreamData.fullContent += $DeltaResp.content;
				
				if($FinishReason){
					$StreamData.FinishMessage = $Answer
				}
				

				foreach($ToolCall in $DeltaResp.tool_calls){
					$CallId 		= $ToolCall.id;
					$CallType 		= $ToolCall.type;
					verbose "Processing tool`n$($ToolCall|out-string)"
					
					
					if($CallId){
						$StreamData.calls.all += $ToolCall;
						$StreamData.CurrentCall = $ToolCall;
						continue;
					}
					
					$CurrentCall = $StreamData.CurrentCall;
				
					
					if($CurrentCall.type -eq 'function' -and $ToolCall.function){
						$CurrentCall.function.arguments += $ToolCall.function.arguments;
					}
				}
				
				
				$StreamData.answers += $Answer
				& $StreamCallback $Answer
			}
			elseif($line -eq 'data: [DONE]'){
				#[DONE] documentando aqui:
				#https://platform.openai.com/docs/api-reference/chat/create#chat-create-stream
				return $false;
			}
		}
	}


	write-verbose "ReqParams:`n$($ReqParams|out-string)"
    $RawResp 	= InvokeHttp @ReqParams
	write-verbose "RawResp: `n$($RawResp|out-string)"
	
	if($RawResp.stream){
		
		#Isso imita a mensagem de resposta, para ficar igual ao resultado quando está sem Stream!
		$MessageResponse = @{
			role		 	= "assistant"
			content 		= $StreamData.fullContent
		}
		
		if($StreamData.calls.all){
			$MessageResponse.tool_calls = $StreamData.calls.all;
		}
		
		return @{
			stream = @{
				RawResp = $RawResp
				answers = $StreamData.answers
				tools 	= $StreamData.calls.all
			}
			
			message = $MessageResponse
			finish_reason = $StreamData.FinishMessage.choices[0].finish_reason
			usage = $StreamData.answers[-1].usage
			model = $StreamData.answers[-1].model
		}
	}

    return $RawResp.text | ConvertFrom-Json
}




# Define o token a ser usado nas chamadas da OpenAI!
# Faz um testes antes para certificar de que é acessível!
function Set-OpenaiToken {
	[CmdletBinding()]
	param()
	
	$ErrorActionPreference = "Stop";
	
	write-host "Forneça o token no campo senha na tela em que se abrir";
	
	$Provider = Get-AiCurrentProvider
	$ProviderName = $Provider.name.toUpper();
	$creds = Get-Credential "$ProviderName API TOKEN";
	
	$TempToken = $creds.GetNetworkCredential().Password;
	
	write-host "Checando se o token é válido";
	try {
		$result = InvokeOpenai 'models' -m 'GET' -token $TempToken
	} catch [System.Net.WebException] {
		$resp = $_.exception.Response;
		
		if($resp.StatusCode -eq 401){
			throw "INVALID_TOKEN: Token is not valid!"
		}
		
		throw;
	}
	write-host -ForegroundColor green "	TOKEN ALTERADO!";
	
	SetCurrentProviderData Token $TempToken;
	return;
}

# Configura a Url base a ser usada!
function Set-OpenaiBase {
	[CmdletBinding()]
	param($url)
	
	$Global:POWERSHAI_SETTINGS.baseUrl = $url
}



# Get all models!
function Get-OpenaiModels(){
	return (InvokeOpenai 'models' -m 'GET').data
}

function openai_GetModels(){
	param()
	
	$Models = Get-OpenaiModels
	$Models | Add-Member -Type noteproperty -Name name -Value $null 
	$Models | %{ $_.name = $_.id }
	return $models;
}




<#
	Esta função chama o endpoint /completions (https://platform.openai.com/docs/api-reference/completions/create)
	Exemplo:
		$res = Get-OpenAiTextCompletion "Gere um nome aleatorio"
		$res.choices[0].text;
	
	Ela retorna o mesmo objeto retornado pela API da OpenAI!
	Por enquanto, apenas os parâmetros temperature, model e MaxTokens foram implementados!
#>
function Get-OpenAiTextCompletion {
	[CmdletBinding()]
    param(
            $prompt 
            ,$temperature   = 0.6
            ,$model         = "gpt-3.5-turbo-instruct"
            ,$MaxTokens     = 200
    )
	
	write-warning "LEGACY! This endpoint is legacy. Use Chat Completion!"

    $FullPrompt = @($prompt) -Join "`n";

    $Body = @{
        model       = $model
        prompt      = $FullPrompt
        max_tokens  = $MaxTokens
        temperature = $temperature 
    }

    InvokeOpenai -endpoint 'completions' -body $Body
}



<#
	Esta função chama o endpoint /chat/completions (https://platform.openai.com/docs/api-reference/chat/create)
	Este endpoint permite você conversar com modelos mais avançados como o GPT-3 e o GPT-4 (veja a disponiblidadena doc)
	
	O Chat Completion tem uma forma de conversa um pouco diferente do que o Text Completion.  
	No Chat Completion, você pode especificar um role, que é uma espécie de categorização do autor da mensagem.  
	
	A API suporta 3 roles:
		user 
			Representa um prompt genérico do usuário.
			
		system
			Representa uma mensagem de controle, que pode dar instruções que o modelo vai levar em conta para gerar a resposta.
			
		assistant
			Representa mensagens prévias. É útil para que o modelo possa aprender como gerar, entender o contexto, etc.  
			
	Basicamente, o system e o assistant são úteis para calibrar melhor a resposta.  
	Enquanto que o user, é o que de fato você quer de resposta (você, ou o seu usuário)
	
	
	Nesta função, para tentar facilitar sua vida, eu deixei duas formas pela qual você usar.  
	A primeira forma é a mais simples:
	
		$res = OpenAiChat "Oi GPT, tudo bem?"
		$res.choices[0].message;
		
		Nesta forma, você passa apenas uma mensagem padrão, e a função vai cuidar de enviar como o role "user".
		Você pode passar várias linhas de texto, usando um simples array do PowerShell:
		
		$res = OpenAiChat "Oi GPT, tudo bem?","Me de uma dica aleatoria sobre o PowerShell"
		
		Isso vai enviar o seguinte prompt ao modelo:
			Oi,GPT, tudo bem?
			Me de uma dica aleatoria sobre o PowerShell
		
		
	Caso, você queria especificar um role, basta usar um dos prefixos. (u - user, s - system, a - assitant"
	
		$res = OpenAiChat "s: Use muita informalidade e humor!","u: Olá, me explique o que é o PowerShell!"
		$res.choices[0].message.content;
	
	Você pode usar um array no script:
	
		$Prompt = @(
			'a: function Abc($p){ return $p*100 }'
			"s: Gere uma explicação bastante dramática com no máximo 100 palavras!"
			"Me explique o que a função Abc faz!"
		)
		
		$res = OpenAiChat $Prompt -MaxTokens 1000
		
		DICA: Note que na última mensagem, e não precisei especificar o "u: mensagem", visto que ele ja usa como default se não encontra o prefixo.
		DICA 2: Note que eu usei o parâmetro MaxTokens para aumentar o limite padrão.
#>
function Get-OpenaiChat {
    [CmdletBinding()]
	param(
         $prompt
        ,$temperature   = 0.6
        ,$model         = $null
        ,$MaxTokens     = 1000
		,$ResponseFormat = $null
		
		,#Function list, as acceptable by Openai
		 #OpenAuxFunc2Tool can be used to convert from powershell to this format!
			$Functions 	= @()	
			
		#Add raw params directly to api!
		#overwite previous
		,$RawParams	= @{}
		
		,$StreamCallback = $null
		
    )
	
   
	$Provider = Get-AiCurrentProvider;
	if(!$model){
		$DefaultModel = $Provider.DefaultModel;
		
		if(!$DefaultModel){
			throw "POWERSHAI_NODEFAULT_MODEL: Must set default model using Set-AiDefaultModel"
		}
		
		$model = $DefaultModel
	}

	[object[]]$Messages = @(ConvertTo-OpenaiMessage $prompt);
	
    $Body = @{
        model       = $model
        messages    = $Messages 
        max_tokens  = $MaxTokens
        temperature = $temperature 
    }
	
	if($RawParams){
		$RawParams.keys | %{ $Body[$_] = $RawParams[$_] }
	}
	
	if($ResponseFormat){
		$Body.response_format = @{type = $ResponseFormat}
	}
	
	if($Functions){
		$Body.tools = $Functions
		$Body.tool_choice = "auto";
	}
	
	write-verbose "Body:$($body|out-string)"
    InvokeOpenai -endpoint 'chat/completions' -body $Body -StreamCallback $StreamCallback
}


Set-Alias -Name OpenAiChat -Value Get-OpenaiChat;
Set-Alias -Name openai_Chat -Value Get-OpenaiChat;



<#
	.SYNOPSIS 
		Converte array de string e objetos para um formato de mensagens padrão da OpenAI!
	
	.DESCRIPTION
		Voce pode passar uma array misto onde cada item pode ser uma string ou um objeto.
		Se for uma string, pode iniciar com o prefixo s, u ou a, que significa, respestivamente, system, user ou assistant.
		Se for um objeto, ele adicionado diretamente ao array resultanete.
		
		Veja: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages
		
	.EXAMPLE
		ConvertTo-OpenaiMessage "Isso é um texto",@{role:"assistant";content="Resposta assistant"}, "s:Msg system"
		
		Retorna o seguinte array:
			
			@{ role = "user", content = "Isso é um texto" }
			@{role:"assistant";content="Resposta assistant"}
			@{ role = "system", content = "Msg system" }
#>
function ConvertTo-OpenaiMessage {
	[CmdletBinding()]
	param($prompt)
	
	$Messages = @();

    $ShortRoles = @{
        s = "system"
        u = "user"
        a = "assistant"
    }
	
	[object[]]$InputMessages = @($prompt);
	
	foreach($m in $InputMessages){
		$ChatMessage =  $null;
		
		#Se não for uma string, assume que é um objeto message contendo as props necessarias
		if($m -isnot [string]){
			write-verbose "Adding chat message directly:`n$($m|out-string)"
			$ChatMessage = $m;
		} else {
			if($m -match '(?s)^([sua]): (.+)'){
				$ShortName  = $matches[1];
				$Content    = $matches[2];

				$RoleName = $ShortRoles[$ShortName];

				if(!$RoleName){
					$RoleName   = "user"
					$Content    = $m;
				}
			} else {
				$RoleName   = "user";
				$Content    = $m;
			}
			
			$ChatMessage = @{role = $RoleName; content = $Content};
		}
		
		write-verbose "	ChatMessage: $($ChatMessage|out-string)"

		$Messages += $ChatMessage
	}
	
	return $Messages;
}


<#

	Função auxiliar para converter um script .ps1 em um formato de schema esperado pela OpenAI.
	Basicamente, o que essa fução faz é ler um arquivo .ps1 (ou string) juntamente com sua help doc.  
	Então, ele retorna um objeto no formato especifiado pela OpenAI para que o modelo possa invocar!
	
	Retorna um hashtable contendo as seguintes keys:
		functions - A lista de funções, com seu codigo lido do arquivo.  
					Quando o modelo invocar, você pode executar diretamente daqui.
					
		tools - Lista de tools, para ser enviando na chamada da OpenAI.
		
	Você pode documentar suas funções e parâmetros seguindo o Comment Based Help do PowerShell:
	https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4
#>
function OpenAuxFunc2Tool {
	[CmdLetBinding()]
	param(
		$func
	)
	
	write-verbose "Processing Func: $($func|out-string)";
	
	if($func.__is_functool_result){
		write-verbose "Functions already processed. Ending...";
		return $func;
	}
	
	#Defs is : @{ FuncName = @{}, FuncName2 ..., FuncName3... }
	$FunctionDefs = @{};

	# func é um file?
	if($func -is [string] -and $func){
		# existing path!
		$IsPs1 			= $func -match '\.ps1$';
		$ResolvedPath 	= Resolve-Path $func -EA SilentlyContinue;
		
		if(!$IsPs1 -or !$ResolvedPath){
			throw "POSHAI_FUNC2TOOL_NOTSUPPORTED: $func"
		}
		
		[string]$FilePath = $ResolvedPath
		write-verbose "Loading function from file $FilePath"
		
		<#
			Aqui é onde fazemos uma mágica interessante... 
			Usamos um scriptblock para carregar o arquivo.
			Logo, o arquivo será carregado apenas no contexto desse scriptblock.
			Então, obtemos todas os comandos, usando o Get-Command, e filtramos apenas os que foram definidos no arquivo.
			Com isso conseguimos trazer uma referencia para todas as funcoes definidas no arquivo, aproveitando o proprio interpretador
			do PowerShell.
			Assim, conseguimos acessar tanto a DOC da funcao, quanto manter um objeto que pode ser usado para executá-la.
		#>
		$GetFunctionsScript = {
			write-verbose "Running $FilePath"
			. $FilePath
			
			$AllFunctions = @{}
			
			#Obtem todas as funcoes definidas no arquivo.
			#For each function get a object 
			Get-Command | ? {$_.scriptblock.file -eq $FilePath} | %{
				write-verbose "Function: $($_.name)"
				
				$help = get-help $_.name;
				
				$AllFunctions[$_.name] = @{
						func = $_
						help = get-help $_.Name
					}
			}
			
			return $AllFunctions;
		}

		$FunctionDefs = & $GetFunctionsScript
	}
	
	[object[]]$AllTools = @();
	
	
	
	#for each function!
	foreach($KeyName in @($FunctionDefs.keys) ){
		$Def = $FunctionDefs[$KeyName];

		$FuncName 	= $KeyName
		$FuncDef 	= $Def
		$FuncHelp 	= $Def.help;
		$FuncCmd 	= $Def.func;
		
		write-verbose "Creating Tool for Function $FuncName"
		
		$OpenAiFunction = @{
					name = $null 
					description = $nul 
					parameters = @{}
				}
		
		$OpenAiTool = @{
			type 		= "function"
			'function' 	= $OpenAiFunction
		}
		
		$AllTools += $OpenAiTool;
		
		
		$OpenAiFunction.name 		= $FuncHelp.name;
		$description 				= ( @($FuncHelp.Synopsis) + @($FuncHelp.description|%{$_.text})) -join "`n"
		$OpenaiFunction.description = $description;
		
		# get all parameters!
		$FuncParams = $FuncHelp.parameters.parameter;
		
		$FuncParamSchema = @{}
		$OpenaiFunction.parameters = @{
			type 		= "object"
			properties 	= $FuncParamSchema
			required 	= @()
		}
		
		if(!$FuncParams){
			continue;
		}
		
		foreach($param in $FuncParams){
			$ParamHelp = $param; 
			
			$ParamName = $ParamHelp.name;
			$ParamType = $ParamHelp.type;
			$ParamDesc = @($ParamHelp.description|%{$_.text}) -Join "`n"
			
			$ParamSchema = @{
					type 		= "string"
					description = $ParamDesc
					
					#enum?
					#items:@{type}
			}
			
			$FuncParamSchema[$ParamName] = $ParamSchema
			
			#Get the typename!
			try {
				$ParamRealType = [type]$ParamType.name
				if($ParamRealType -eq [int]){
					$ParamSchema.type = "number"
				}
			} catch{
				write-warning "Cannot determined type of param $ParamName! TypeName = $($ParamType.name)"
			}
		}
		
	}
	
	
	return @{
		tools = $AllTools
		functions = $FunctionDefs
		
		#Esta é uma flag indicando que este objeto já foi processado.
		#Caso envie novamente, ele apenas devolve!
		__is_functool_result = $true
	}
}

#Gets cost of answer!
$POWERSHAI_CACHED_MODELS_PRICE = @{};
function Get-OpenAiAnswerCost($answers){
	
	#Pricings at 17/01/2024
	$Pricings = @{
		'estimated' = @{
			input 	= 0.1
			output  = 0.3
			match 	= '.+'
		}
		
		'gpt-4-turbo' = @{
			match 	= "gpt-4.+-preview"
			input 	= 0.01
			output 	= 0.03 
		}
		
		'gpt-4' = @{
			match 	= "^gpt-4"
			input 	= 0.03
			output 	= 0.06 
		}
		
		'gpt-3' = @{
			match   = "gpt-3.+"
			input 	= 0.0010 
			output 	= 0.0020
		}
		
		'embedding' = @{
			match 	= '.+embedding.+'
			input	= 0.0001
			output	= 0
		}
	}
	
	$AllAnswers = @();
	

	$costs = @{
		answers = @()
		input 	= 0
		output 	= 0
		total 	= 0
		tokensTotal = 0
		tokensInput = 0
		tokensOutput = 0
	}
	
	
	foreach($answer in @($answers)){
	
		$model = $answer.model;
		$inputTokens = $answer.usage.prompt_tokens;
		$outputTokens = $answer.usage.completion_tokens;
		
		if(!$outputTokens){
			$outputTokens = 0;
		}
		
		if(!$model){
			break;
		}
		
		#Is in cache?
		$CachedMatch = $POWERSHAI_CACHED_MODELS_PRICE[$model]
		
		if(!$CachedMatch){
			# Find high pricing...
			$SortedPrices = $Pricings.GetEnumerator() | ? {$model -match $_.value.match} | Sort-Object {$_.value.match.length} -Desc
			
			if($SortedPrices){
				$BestMatch = $SortedPrices[0];
			} else {
				$BestMatch = $SortedPrices['estimated'];
			}
			
			$CachedMatch = $BestMatch
			$POWERSHAI_CACHED_MODELS_PRICE[$model] = $CachedMatch
		}

		$AnswerCosts = @{
			pricings 	= $CachedMatch.value
			table  		= $CachedMatch.key
			inputCost 	= [decimal]($CachedMatch.value.input * $inputTokens/1000)
			outputCost 	= [decimal]($CachedMatch.value.output * $outputTokens/1000)
			totalCost	= $null
		}
		
		$AnswerCosts.totalCost = $AnswerCosts.inputCost + $AnswerCosts.outputCost;

		$costs.answers 	+= $AnswerCosts;
		$costs.input 	+= $AnswerCosts.inputCost;
		$costs.output 	+= $AnswerCosts.outputCost;
		$costs.tokensTotal += $inputTokens + $outputTokens;
		$costs.tokensInput += $inputTokens;
		$costs.tokensOutput += $outputTokens;
	}
	
	$costs.total = $costs.output + $costs.input;
	
	return $costs;
}


# Representa cada interação feita com o modelo!
function NewAiInteraction {
	return @{
			req  		= $null	# the current req count!
			sent 		= $null # Sent data!
			rawAnswer  	= $null # the raw answer returned by api!
			stopReason 	= $null	# The reason stopped!
			error 		= $null # If apply, the error ocurred when processing the answer!
			seqError 	= $null # current sequence error
			toolResults	= @() # lot of about running functino!
		}
}




# Obtéms os embegginds de um texto
function OpenaiEmbeddings {
	param($inputText,$model)
	
	if(!$model){
		$model = 'text-embedding-ada-002'
	}
	
	$body = @{
		input = $inputText 
		model = $model 
	}
	
	InvokeOpenai -endpoint 'embeddings' -body $Body
}

<#
	Gera o embedding de um texto!
#>
function Invoke-OpenaiEmbedding {
	[CmdletBinding()]
	param(
		$text
		,$model
	)
	
    $ans = OpenaiEmbeddings  -input $text -model $model
	$costs = Get-OpenAiAnswerCost $ans
	
	[object[]]$AllEmbeddings = @($null) * $ans.data.length;
	
	$ans.data | %{ $AllEmbeddings[$_.index] = $_.embedding }
	
	return @{
		rawAnswer 	= $ans
		costs 		= $costs
		embeddings 	= $AllEmbeddings
	}
}




#quebra o texto em tokens...
function SplitOpenAiString {
	write-host "TODO..."
}



return @{
	RequireToken 	= $true
	BaseUrl 		= "https://api.openai.com/v1"
	DefaultModel 	= "gpt-4o-mini"
	TokenEnvName 	= "OPENAI_API_KEY"
	
	info = @{
		desc	= "OpenAI"
		url 	= "https://openai.com/"
	}
}

