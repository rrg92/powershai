<#
	POWERSHAI
	Autor: Rodrigo Ribeiro Gomes (https://iatalk.ing)
	
	NÃO ESTÁ PRONTO PARA USO EM PRODUÇÃO!
	Você é livre para usar e modificar, mas deve deixar o crédito ao projeto original!
	
	
	Este script implementa algumas funções simples para facilitar sua interação com a API da OpenAI!
	O objetivo deste script é mostrar como você pode facilmente invocar a API do OpenAI com PowerShell, ao mesmo tempo que prover uma interface simples para 
	as chamadas mais importantes.  
	
	Antes de continuar, o que você precisa?
	
		Gere um token no site da OpenAI!
		Coloca na variável de ambiente OPENAI_API_KEY.
		
	# AUTENTICAÇÃO
	
		> import-module Caminho\powershai.psm1
		> Set-OpenaiToken # Define a sua api token
		> $res = OpenAiTextCompletion "Olá, estou falando com você direto do PowerShell"
		> $res.choices[0].text
		
	Verifique os comentáros em cada funçã abaixo para mais informações!
	
	ATENÇÃO: LEMBRE-SE que as chamadas realizadas irão consumir seus créditos da OpenAI!  
	Certifique-se que você compreendeu o modelo de cobrança da OpenAI para evitar surpresas.  
	Além disso, esta é uma versão sem testes e para uso livre por sua própria conta e risco.
#>



<#
	Esta função é usada como base para invocar a a API da OpenAI!
#>
function InvokeOpenai {
    param($endpoint, $body, $method = 'POST', $token = $Env:OPENAI_API_KEY)


    if(!$token){
        throw "OPENAI_NO_KEY";
    }


    $headers = @{
        "Authorization" = "Bearer $token"
    }
	
	$BaseUrl = $Env:OPENAI_API_BASE;
	
	if(!$BaseUrl){
		$BaseUrl = "https://api.openai.com/v1"
	}
    
    $url = "$BaseUrl/$endpoint"

	$JsonParams = @{Depth = 10}
	$Global:Dbg_LastBody = $body;
	write-verbose "InvokeOpenai: Converting body to json (depth: $($JsonParams.Depth))..."
    $ReqBodyPrint = $body | ConvertTo-Json @JsonParams
	write-verbose "ReqBody:`n$($ReqBodyPrint|out-string)"
	
	$ReqBody = $body | ConvertTo-Json @JsonParams -Compress
    $ReqParams = @{
        body            = $ReqBody
        ContentType     = "application/json; charset=utf-8"
        Uri             = $url
        Method          = $method
        UseBasicParsing = $true
        Headers         = $headers
    }

	write-verbose "ReqParams:`n$($ReqParams|out-string)"
    $RawResp 	= Invoke-WebRequest @ReqParams
    $result 	= [System.Text.Encoding]::UTF8.GetString($RawResp.RawContentStream.ToArray())
    
    $ResponseResult = $result | ConvertFrom-Json

    return $ResponseResult;
}



# Define o token a ser usado nas chamadas da OpenAI!
# Faz um testes antes para certificar de que é acessível!
function Set-OpenaiToken {
	param()
	
	$ErrorActionPreference = "Stop";
	
	write-host "Forneça o token no campo senha na tela em que se abrir";
	
	$creds = Get-Credential "OPENAI TOKEN";
	
	$TempToken = $creds.GetNetworkCredential().Password;
	
	write-host "Checking if token is valid...";
	try {
		$result = InvokeOpenai 'models' -m 'GET' -token $TempToken
	} catch [System.Net.WebException] {
		$resp = $_.exception.Response;
		
		if($resp.StatusCode -eq 401){
			throw "INVALID_TOKEN: Token is not valid!"
		}
		
		throw;
	}
	write-host "	Sucess! Token is valid!";
	
	$Env:OPENAI_API_KEY = $TempToken
	
	return;
}

# Get all models!
function Get-OpenaiModels(){
	return (InvokeOpenai 'models' -m 'GET').data
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
		DICA 2: Note que eu usei o parâmetro MaxTokens para aumentar o limite padrão de 200.
#>
function Get-OpenaiChat {
    [CmdletBinding()]
	param(
         $prompt
        ,$temperature   = 0.6
        ,$model         = $null
        ,$MaxTokens     = 200
		,$ResponseFormat = $null
		
		,#Function list, as acceptable by Openai
		 #OpenAuxFunc2Tool can be used to convert from powershell to this format!
			$Functions 	= @()	
			
		,$PrevContext 	= $null
		
		#Add raw params directly to api!
		#overwite previous
		,$RawParams	= @{}
		
    )
	
	if(!$model){
		$model  = $Env:OPENAI_DEFAULT_MODEL 
	}

    $Messages = @();

    $ShortRoles = @{
        s = "system"
        u = "user"
        a = "assistant"
    }
	
	if(!$model){
		$model = "gpt-3.5-turbo"
	}
	
	
	if($PrevContext){
		$Messages += $PrevContext;
	}

	

	[object[]]$InputMessages = @($prompt);
	foreach($m in $InputMessages){
		
		$ChatMessage =  $null;
		
		if($m -is [PsCustomObject] -or $m -is [hashtable]){
			write-verbose "Adding chat message directly:`n$($m|out-string)"
			$ChatMessage = $m;
		} else {
			if($m -match '(?s)^([s|u|a]): (.+)'){
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

		$Messages += $ChatMessage
	}
	
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
    InvokeOpenai -endpoint 'chat/completions' -body $Body
}


Set-Alias -Name OpenAiChat -Value Get-OpenaiChat;

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
	
	if($func.__is_functool_result){
		return $func;
	}
	
	#Defs is : @{ FuncName = @{}, FuncName2 ..., FuncName3... }
	$FunctionDefs = @{};

	# func é um file?
	if($func -is [string]){
		# existing path!
		$IsPs1 			= $func -match '\.ps1$';
		$ResolvedPath 	= Resolve-Path $func -EA SilentlyContinue;
		
		if(!$IsPs1 -or !$ResolvedPath){
			throw "POSHAI_FUNC2TOOL_NOTSUPPORTED: $func"
		}
		
		[string]$FilePath = $ResolvedPath
		
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
			. $FilePath
			
			$AllFunctions = @{}
			
			#Obtem todas as funcoes definidas no arquivo.
			#For each function get a object 
			Get-Command | ? {$_.scriptblock.file -eq $FilePath} | %{
				$AllFunctions[$_.name] = @{
						func = $_
						help = get-help $_.name
					}
			}
			
			return $AllFunctions;
		}

		$FunctionDefs = & $GetFunctionsScript
	}
	
	[object[]]$AllTools = @();
	
	#for each function!
	foreach($func in $FunctionDefs.GetEnumerator()){
		
		$FuncName 	= $func.key;
		$FuncDef 	= $func.value;
		$FuncHelp 	= $FuncDef.help;
		$FuncCmd 	= $FuncDef.func;
		
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
		
		#Is in cache?
		$CachedMatch = $POWERSHAI_CACHED_MODELS_PRICE[$model]
		
		if(!$CachedMatch){
			# Find high pricing...
			$SortedPrices = $Pricings.GetEnumerator() | ? {$model -match $_.value.match} | sort {$_.value.match.length} -Desc
			
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

<#
	Esta é uma função auxiliar para ajudar a fazer o processamento de tools mais fácil com powershell.
	Ele lida com o processamento das "Tools", executando quando o modelo solicita!
	Apenas converse normalmente, defina as funções e deixe que este comando faça o resto!
	Não se preocupe em processar a resposta do modelo, se tem que executar a função, etc.
	O comando abaixo já faz tudo isso pra você. 
	Você precisa apenas concentrar em definir as funções que podem ser invocadas e o prompt(veja o comando OpenAuxFunc2Tool).
#>
function Invoke-OpenAiChatFunctions {
	[CmdletBinding()]
	param(
		$prompt
		
		,# Passe as funcoes aqui
		 # Atualmente, suporta apenas um arquivo .ps1 onde as fucnoes estao definidas.
		 # Crie seu arquivo e documente ele usando a propria sintaxe do powershell.
		 # Essa documentação será enviada ao modelo. Quanto melhor você documentar, melhor o modelo saberá quando invocar.
			$Functions		= $null
			
		,$PrevContext		= $null
		,# máx output!
			$MaxTokens			= 500	
		,# No total, permitir no max 5 iteracoes!
			$MaxRequests  		= 5		
		,# Quantidade maximo de erros consecutivos que sua funcao pode gerar antes que ele encerre.
			$MaxSeqErrors 		= 2	

			
		,$temperature		= 0.6	
		,$model 			= $null
		
		,# Event handler
		# Cada key é um evento que será disparado em algum momento por esse comando!
		# eventos:
		#	answer: disparado após obter a resposta do modelo
		#	func: disparado antes de iniciar a execução de uma tool solicitada pelo modelo.
		# 	exec: disparado após o modelo executar a funcao.
		# 	error: disparado quando a funcao executada gera um erro
			$on				= @{} 	
									
									
		,# Envia o response_format = "json", forçando o modelo a devolver um json.
			[switch]$Json				
	
		
		
		,#Adicionar parâmetros customizados diretamente na chamada (irá sobrescrever os parâmetros definidos automaticamente).
			$RawParams			= $null
	)
	
	$ErrorActionPreference = "Stop";
	
	# Converts the function list user passed to format acceptable by openai!
	$OpenAiTools = OpenAuxFunc2Tool $Functions
	
	# initliza message!
	[object[]]$Message 	= @($prompt);
	
	$TotalPromptTokens 	= 0;
	$TotalOutputTokens 	= 0;
	
	$AllInteractions = @();
	
	$emit = {
		param($evtName, $interaction)
		
		$evtScript = $on[$evtName];
		
		if(!$evtScript){
			return;
		}
		
		try {
			$null = & $evtScript $interaction
		} catch {
			write-warning "EventCallBackError: $evtName";
			write-warning $_
			write-warning $_.ScriptStackTrace
		}
	}
	

	
	# Vamos iterar em um loop chamando o model toda vez.
	# Sempre que o model retornar pedindo uma funcao, vamos iterar novamente, executar a funcao, e entregar o resultado pro model!
	$ReqsCount = 0;
	$FuncSeqErrors = 0; #Indicates how many consecutive errors happens!
	:Main while($true){
		#Vamos avançr o numero de requests totais que ja fizemos!!
		$ReqsCount++;
		
		#This object is created every request and will store all data bout interaction!
		$AiInteraction = NewAiInteraction
		$AiInteraction.req = $ReqsCount;
		
		# Parametros que vamos enviar a openai usando a funcao openai!
		$Params = @{
			prompt 			= $Message
			temperature   	= $temperature
			MaxTokens     	= $MaxTokens
			Functions 		= $OpenAiTools.tools
			model 			= $model
			RawParams		= $RawParams
		}
		
		if($Json){
			#https://platform.openai.com/docs/guides/text-generation/json-mode
			$Params.ResponseFormat = "json_object";
			$Params.prompt += "s: Response in JSON";
		}
		
		$AiInteraction.sent = $Params;
		$AiInteraction.message = $Message;
		
		# Se chegamos no limite, então naos vamos enviar mais nada!
		if($ReqsCount -gt $MaxRequests){
			$AiInteraction.stopReason = "MaxReached";
			write-warning "MaxRequests reached! ($ReqsCount)";
			break;
		}
		
		
		write-verbose "Sending Request $ReqsCount";
		# manda o bla bla pro gpt...
		& $emit "send" $AiInteraction
		$Answer = OpenAiChat @Params;
		$AiInteraction.rawAnswer = $Answer;
		$AllInteractions += $AiInteraction;
		
		& $emit "answer" $AiInteraction
		
		$ModelResponse = $Answer.choices[0];
		
		$WarningReasons = 'length','content_filter';
		
		if($ModelResponse.finish_reason -in $WarningReasons){
			write-warning "model finished answering due to $($ModelResponse.finish_reason)";
		}
	
		# Model asked to call a tool!
		if($ModelResponse.finish_reason -eq "tool_calls"){
			# A primeira opcao de resposta...
			$AnswerMessage = $ModelResponse.message;
		
			# Add current message to original message to provided previous context!
			$Message += $AnswerMessage;
			
			$ToolCalls = $AnswerMessage.tool_calls
				
			write-verbose "TotalToolsCals: $($ToolCalls.count)"
			foreach($ToolCall in $ToolCalls){
				
				$CallType = $ToolCall.type;
				$ToolCallId = $ToolCall.id;
				
				try {
					if($CallType -ne'function'){
						throw "Tool type $CallType not supported"
					}
					
					$FuncCall = $ToolCall.function
					
					#Get the called function name!
					$FuncName = $FuncCall.name
					
					#Build the response message that will sent back!
					$FuncResp = @{
						role 			= "tool"
						tool_call_id 	= $ToolCallId
						
						#Set to a default message!
						content	= "ERROR: Some error ocurred processing function!";
					}
					
					
					# Lets get func defintion!
					$FuncDef = $OpenAiTools.functions[$FuncName];
					
					#Functino not found!
					#This can be erros of model? Or bug of code...
					#Say back this to model...
					if(!$FuncDef){
						throw "Function $FuncName not found!";
					}
					
					# Get the function itself!
					# TODO: Talvez o GPT tenha pedido uma funcao erraa também, precisamos tratar este caso!
					# Por enquanto, assumimos que ele sempre manda uma funcao existente...
					$TheFunc = $FuncDef.func;
					
					if(!$TheFunc){
						write-warning "Model asked function $FuncName but the body was not found. Fix that bug!!!";
						throw "Function was defined, but code not found. This is a bug of function source."
					}
					
					#Here wil have all that we need1
					$FuncArgsRaw =  $FuncCall.arguments
					
					#We assuming model sending something that can be converted...
					$funcArgs = $FuncArgsRaw | ConvertFrom-Json;
					
					#Then, we can call the function!
					$ArgsHash = @{};
					$funcArgs.psobject.properties | %{ $ArgsHash[$_.Name] = $_.Value  };
					
					$CurrentToolResult = @{ 
						hash 	= $ArgsHash
						obj 	= $funcArgs 
						name 	= $FuncName
						id 		= $ToolCallId
						resp 	= $FuncResp
					}
					
					$AiInteraction.toolResults += $CurrentToolResult
					
					& $emit "func" $AiInteraction $CurrentToolResult
					
					write-verbose "Calling function $FuncName ($FuncInfo)"
					$FuncResp.content = & $TheFunc @ArgsHash | ConvertTo-Json -Depth 10
					$FuncSeqErrors = 0;
				} catch {
					$err = $_;
					
					& $emit "error" $AiInteraction
					
					#Add curent error to this object to caller debug...
					$AiInteraction.error = $_;
					
					#just log in screen to caller know about these errors!
					write-warning "Processing answer of model resulted in error. Id = $ToolCallId";
					write-warning "FuncName:$FuncName, Request:$ReqsCount"
					write-warning ("ERROR:")
					write-warning $err
					write-warning $err.ScriptStackTrace
					
					$FuncResp.content = "ERROR:"+$err;
					
					#Resets the seq errorS!
					$FuncSeqErrors++;
					$AiInteraction.seqError = $FuncSeqErrors;
					if($FuncSeqErrors -ge $MaxSeqErrors){
						$AiInteraction.stopReason = "MaxSeqErrorsReached";
						write-warning "Stopping due to max consecutive errors";
						break Main;
					}
				}
				
				& $emit "exec" $AiInteraction
				
				$Message += $FuncResp;
			}
			
			#Start sending again...
			continue;
		}
		
		# se chegou aqui é pq o gpt processou tudo e nao precisou invocar uma funcao!
		#entao, podemos encerrar a bagaça!
		break;
	}
	
	$AllAnswers = $AllInteractions | %{ $_.rawAnswer };
	$AnswerCost = Get-OpenAiAnswerCost $AllAnswers
	
	return @{
		answer 			= $Answer 			# last answer					
		interactions	= $AllInteractions
		tools 			= $OpenAiTools
		costs 			= $AnswerCost
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


<#
	Comando ChaTest.
	Com este comando você pode conversar direto do prompt com o modelo!.
	Ele também é um belo teste de todos os outros comandos e funcionalidades disponíveis aqui!
	
	Note que isso pode consumir bastante dos seus tokens!
	
	Syntaxe:
		Converse com
	
#>
function Invoke-PowershaiChat {
	[CmdletBinding()]
	param(
		$Functions 		= $Null
		,$MaxTokens 	= 200
		,$MaxRequests	= 10
		,$SystemMessages = @()
		
		,#Specify a hash table where you want store all results 
			$ChatMetadata 	= @{}
	)
	
	$ErrorActionPreference = "Stop";
	
	function WriteModelAnswer($interaction){
		$ans = $interaction.rawAnswer;
		$cont = $ans.choices[0].message.content;
		$model = $ans.model;
		
		if($cont){
			write-host ""
			write-host "`🤖 $($model):" $cont -ForegroundColor Cyan
			write-host ""
		}
	}

	$ChatHistory = @()
	$ChatStats = @{
		TotalChats 	= 0
		
		TotalCost 	= 0
		TotalInput 	= 0
		TotalOutput = 0
		
		TotalTokensI = 0
		TotalTokensO = 0
	}
	
	$ChatMetadata.history 	= $ChatHistory;
	$ChatMetadata.stats 	= $ChatStats
	
	$VerboseEnabled = $False;
	
	write-host "Checando token..."
	$Ret = Invoke-OpenAiChatFunctions -temperature 1 -prompt @(
		"Gere uma saudação inicial para o usuário que está conversando com você a partir do módulo powershell chamado PowerShai"
	);
	
	write-host "Obtendo moels suportados..."
	$SupportedModels = Get-OpenaiModels
	
	write-verbose "Gerando lista de Tools..."
	$Funcs = OpenAuxFunc2Tool $Functions;
	
	
	WriteModelAnswer $Ret.interactions
	
	$model = $null
	$UseJson = $false;
	$ShowFullSend = $false;
	$ShowTokenStats = $false;
	$MaxContextSize = 8192 # Vou considerar isso como o número de caracter por uma questão simples...
						   # futuramente, o correto é trabalhar com tokens!
	
	$ChatUserParams = @{
		model 		= $model
		MaxRequest 	= $MaxRequests
		MaxTokens 	= $MaxTokens
		Json 		= $false
	}
	
	function ParsePrompt($prompt) {
		$parts 		= $prompt -split ' ',2
		$cmdName	= $parts[0];
		$remain		= $parts[1];
		
		$result = @{
			action = $null
			prompt = $null;
		}
		
		write-verbose "InputPrompt: $cmdName"
		
		switch($cmdName){
			"/reload" {
				write-host "Reloading function list...";
				$Funcs = OpenAuxFunc2Tool $Functions;
				Set-Variable -Scope 1 -Name Funcs -Value $Funcs
			}
			
			"/retool" {
				write-host "Redefinindo a lista de tools: $remain";
				$Funcs = OpenAuxFunc2Tool $remain;
				Set-Variable -Scope 1 -Name Funcs -Value $Funcs
			}
			
			"/maxcontext" {
				Set-Variable -Scope 1 -Name MaxContextSize -Value ([int]$remain)
			}
			
			"/models" {write-host $($SupportedModels|out-string)}
			{'.cls','/clear','/cls','.c' -contains $_} {clear-host}
			
			# sets 
			"/von"  {Set-Variable -Scope 1 -Name VerboseEnabled -Value $true;}
			"/voff" {Set-Variable -Scope 1 -Name VerboseEnabled -Value $false;}
			"/json" {Set-Variable -Scope 1 -Name UseJson -Value $true }
			"/jsoff" {Set-Variable -Scope 1 -Name UseJson -Value $false }
			"/fullon" {Set-Variable -Scope 1 -Name ShowFullSend -Value $true }
			"/fulloff" {Set-Variable -Scope 1 -Name ShowFullSend -Value $false }
			"/tokon" {Set-Variable -Scope 1 -Name ShowTokenStats  -Value $true }
			"/tokoff" {Set-Variable -Scope 1 -Name ShowTokenStats  -Value $false }
			"/p" { 
				#Split!
				$paramPair = $remain -split ' ',2
				$paramName = $paramPair[0]
				$paramValStr = $paramPair[1];
				
				if(!$paramValStr){
					write-host $($ChatUserParams|out-string);
					return;
				}
				
				if(!$ChatUserParams.contains($paramName)){
					write-warning "No parameter existing with name: $paramName"
					return;
				}

				$ParamVal = $ChatUserParams[$paramName];
				
				if($ParamVal -eq $null){
					write-warning "Value is null. Setting as str value!";
					$NewVal = $paramValStr
					return;
				} else {
					$NewVal = $ParamVal.getType()::Parse($paramValStr);
				}
				
				$ChatUserParams[$paramName] = $NewVal;
				write-host "Changed PARAM $paramName from $ParamVal to $NewVal" 
			}
			
			"/reqs" { 
				$OldVal = $MaxRequests;
				Set-Variable -Scope 1 -Name MaxRequests -Value [int]$remain;
				write-host "Changed Maxtokens from $OldVal to $MaxRequests"
			}
			
			"/ps" {
				function prompt(){ "PowershAI>> " }
				write-warning "Entering in nested prompt";
				$host.EnterNestedPrompt();
			}
			
			"/model" {
				write-host "Changing model...";
				$newModel 		= $remain;
				$chosenModel 	= $null;
				
				#find all candidates!
				while($true){
					$ElegibleModels = @( $SupportedModels | ? { $_.id -like $newModel } );
					
					if($ElegibleModels.length -eq 1){
						$model = $ElegibleModels[0].id;
						break;
					}
					
					write-warning "Refine your search (search:$newModel)";
					write-host $($ElegibleModels|sort id|out-string)
					$newModel = read-host "Filter model"
				}
				
				$ChatUserParams['model'] = $model
				write-host "	Changed model to: $model"
			}
			
			default {
				$result.action = "prompt";
				$result.prompt = $prompt;
			}
		}
		
		return $result;
	}
	
	$ChatContext = @{
		messages = @()
		size = 0
	}
	function AddContext($msg) {

		while($ChatContext.size -ge $MaxContextSize -and $ChatContext.messages){
			$removed,$LeftMessages = $ChatContext.messages;
			
			$ChatContext.messages = $LeftMessages;
			
			$RemovedCount = $removed.length;
			if($removed.content){
				$RemovedCount = $removed.content.length;
			}
			
			write-verbose "Removing Length: $removed $RemovedCount"
			$ChatContext.size -= [int]$RemovedCount;
		}
		
		$ChatContext.messages += @($msg);

		if($msg.content){
			$ChatContext.size += $msg.content.length;
		} else {
			$ChatContext.size += $msg.length;
		}
	}
	
	:MainLoop while($true){
		try {
			write-verbose "Verbose habilitado..." -Verbose:$VerboseEnabled;
			write-host -NoNewLine "Você>>> "
			$prompt = read-host
			
			$parsedPrompt = ParsePrompt $Prompt
			
			switch($parsedPrompt.action){
				"stop" {
					break MainLoop;
				}
				
				"prompt" {
					$prompt = $parsedPrompt.prompt;
				}
				
				default {
					continue MainLoop;
				}
			}
			
			AddContext "u: $prompt";
			$Msg = @(
				@($SystemMessages|%{"s: $_"})
				"u: $prompt"
			)
			
			if($ShowFullSend){
				write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
			}
			
			$ChatParams = $ChatUserParams + @{
				prompt 		= $ChatContext.messages
				Functions 	= $Funcs 
				on 			= @{
							
							send = {
								if($VerboseEnabled){
									write-host -ForegroundColor DarkYellow "-- waiting model... --";
								}
							}
							
							answer = {
								param($interaction)
								
								WriteModelAnswer $interaction
							}
							
							func = {
								param($interaction)
								
								$ans = $interaction.rawAnswer;
								$model = $ans.model;
								$funcName = $interaction.toolResults[-1].name
								
								write-host -ForegroundColor Blue "$funcName{..." -NoNewLine
							}
					
							exec = {
								param($interaction)
								
								write-host -ForegroundColor Blue "}"
								write-host ""
							}
					}
			}
			
			if($VerboseEnabled){
				$ChatParams.Verbose = $true;
			}
			
			
			
			$Start = (Get-Date);
			$Ret 	= Invoke-OpenAiChatFunctions @ChatParams;
			$End = Get-Date;
			$Total = $End-$Start;
			
			foreach($interaction in $Ret.interactions){ 
				$Msg = $interaction.rawAnswer.choices[0].message;

				AddContext $Msg
				
				$toolsResults = $interaction.toolResults;
				if($toolsResults){
					$toolsResults | %{ AddContext $_.resp }
				}
				
				
				
			}
			
			
			#Store the historu of chats!
			$ChatMetadata.history += @{
									Ret = $Ret
									Elapsed = $Total
								}
			$ChatHistory = $ChatMetadata.history;
			
			$AllAnswers 	= @($Ret.interactions | %{$_.rawAnswer});
			$AnswersCost	= $Ret.costs
			
			
			# current chat
			$AnswerCount 	= $AllAnswers.count;
			$TotalCost 		= $AnswersCost.total
			$InputCost 		= $AnswersCost.input
			$OutputCost 	= $AnswersCost.output
			$TotalTokens 	= $AnswersCost.tokensTotal
			$InputTokens 	= $AnswersCost.tokensInput
			$OutputTokens 	= $AnswersCost.tokensOutput
			
			# all chats
			$ChatStats.TotalChats += $ChatHistory.count;
			$TotalChats = $ChatStats.TotalChats
			
			## COSTS (total, input,output)
			$ChatStats.TotalCost += $TotalCost 
			$ChatStats.TotalInput += $InputCost
			$ChatStats.TotalOutput += $OutputCost
			
			## TOKENS QTY (total, input, output)
			$ChatStats.TotalTokens += $TotalTokens 
			$ChatStats.TotalTokensI += $InputTokens
			$ChatStats.TotalTokensO += $OutputTokens
			
			
			$AnswerLog = @(
				"Answer: $AnswerCount"
				"Cost: $TotalCost (i:$InputCost/o:$OutputCost)"
				"Tokens: $TotalTokens (i:$InputTokens/o:$OutputTokens)"
				"time: $($Total.totalMilliseconds) ms"
			) -Join " "
			
			$HistoryLog = @(
				"AllChats: $($ChatStats.TotalChats)"
				
				@(
					"Cost: $($ChatStats.TotalCost)"
					"(i:$($ChatStats.TotalInput)"
					"/"
					"o:$($ChatStats.TotalOutput))"
				) -Join ""
				
				@(
					"Tokens: $($ChatStats.TotalTokens)"
					"(i:$($ChatStats.TotalTokensI)"
					"/"
					"o:$($ChatStats.TotalTokensO))"
				) -Join ""
				
			) -Join " "
			
			if($ShowTokenStats){
				write-host "** $AnswerLog"
				write-host "** $HistoryLog"
			}
		} catch {
			write-host ($_|out-string)
			write-host "==== ERROR STACKTRACE ==="
			write-host "StackTrace: " $_.ScriptStackTrace;
		}
	}
	
	
	return $ChatHistory;
}

Set-Alias -Name Chatest -Value Invoke-PowershaiChat;