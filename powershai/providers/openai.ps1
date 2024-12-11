<#
	OpenAI Powershai Provider
	
		Este arquivo implementa o provider da OpenAI.
		Link úteis:
			- https://platform.openai.com/docs/api-reference
			
	A OpenAI foi o primeiro provider a ser implementado no PowershAI. 
	Quando o PowershAI nasceu, eu inicialmente tinha chamado ele de "Poshai" (posh + openai, posh = abrevição alternative de powershell).
	O objetivo inicial era aprender a usar a openai e ter algum scritp fácil para que eu conseguisse, a partir do powershell, conversar com algum LLM e estudar, fazer testes, etc.  
	
	Então, o poshai virou esse provider, quando vi que poderíamos resuar muita coisa da OpenAI para implementar outros LLM.  
	A partir daí, além de ser um provider de acesso a API da OpenAI, esse provider também é "reusável", isto é, serve de base para outros providers que usam os mesmos princípios da OpenAI.  
	
	Qualquer provider que seja compatível coma OpenAI, pode reusar esse provider.  
	Eventualmente, algum ajuste pode ser feito para melhor abstrair, mas a ideia é que a cada novo provider, menos ajustes precisem ser feitos aqui.
	Para que um provider possa usar este, basta retornar as keys (documentadas no final deste arquivo) e invocar as funcoes.

	
#>

function GetNearestOpenaiProvider {
	
	$Provider = Get-AiCurrentProvider
	
	if($Provider.IsOpenaiCompatible){
		return $provider;
	}
		
	$Provider = Get-AiCurrentProvider -ContextProvider -FilterContext {
		return $_.IsOpenaiCompatible;
	}
	
	if(!$Provider){
		$Provider = Get-AiProvider openai
	}
	
	return $Provider;
}

<#
	Esta função é usada como base para invocar a a API da OpenAI!
#>
function Invoke-OpenaiApi {
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method 			= 'POST'
		,$StreamCallback 	= $null
		,$Token 			= $null
	)

	$MaxTries = @(Get-AiProviders).count
	
	$Provider = GetNearestOpenaiProvider


	verbose "InvokeOpenAI, current provider = $($Provider.name)"
	$Token = GetCurrentOpenaiToken $Token
	
	. Enter-AiProvider $Provider.name {
		$headers = @{}
		
		if($Token){
			 $headers["Authorization"] = "Bearer $token"
		}

		if($endpoint -match '^https?://'){
			$url = $endpoint
		} else {
			$BaseUrl = GetCurrentProviderData BaseUrl
			$url = "$BaseUrl/$endpoint"
		}

		$JsonParams = @{Depth = 10}
		
		verbose "InvokeOpenai: Converting body to json (depth: $($JsonParams.Depth))..."
		$ReqBodyPrint = $body | ConvertTo-Json @JsonParams
		verbose "ReqBody:`n$($ReqBodyPrint|out-string)"
		
		$ReqBody = $body | ConvertTo-Json @JsonParams -Compress
		

		$ReqParams = @{
			data            = $ReqBody
			url             = $url
			method          = $method
			Headers         = $headers
			SseCallback 	= $StreamCallback
		}

		
		
		# Give chance to underline provider change request params if necessary!
		$ReqChanger = GetCurrentProviderData ReqChanger;
		
		# ReqParams is parameters of Invoke-Http function, implement ib lib/http.ps1
		# Providers developers must know how it works and know how openai provider will habndle that answer!
		if($ReqChanger){
			$MyParams 	= GetMyParams
			$null 		= & $ReqChanger $ReqParams $MyParams
		}

		verbose "ReqParams:`n$($ReqParams|out-string)"
		$RawResp 	= InvokeHttp @ReqParams
		verbose "RawResp: `n$($RawResp|out-string)"
	}
	
	if($RawResp.stream){
		return $RawResp;
	}
	

    return $RawResp.text | ConvertFrom-Json
}
Set-Alias InvokeOpenai Invoke-OpenaiApi

function GetCurrentOpenaiToken {
	param($OverrideToken)
	
	if($OverrideToken){
		return $OverrideToken;
	}

	
	$Credential = Get-AiDefaultCredential -MigrateScript {
		$Token = GetCurrentProviderData Token;
		
		$NewCred = NewAiCredential
		$NewCred.name = "default"
		$NewCred.credential = $Token;
		
		SetCurrentProviderData Token $null;
		
		return $NewCred;
	}
	
	if($Credential){
		return $Credential.credential.credential;
	} else {
		write-warning "No default credential was found. Failback to deprecated method. Check if you have multiple creds and set a default credentials!"
	}
	
	$Token = GetCurrentProviderData Token;
	
	if($Token){
		write-warning "Using deprecated powershai tokens! To remove this warning message, set credential using Set-AiCredential. You can migrate using Convert-OpenaiToken2Credential"
		return $token;
	}

	
	$TokenRequired = GetCurrentProviderData RequireToken;
	if($TokenRequired){
		$Provider = Get-AiCurrentProvider
		throw "POWERSHAI_OPENAI_NOTOKEN: No token was defined and is required! Provider = $($Provider.name)";
	}
}

# Função interna e base para definir o token da Openai!
function SetOpenaiTokenBase {
	param(
		# alternative title 
		$title = $null
		
		,#Nome da key no provider data em que deve ser salvo o token 
			$SetData = "Token"
			
		,#Script to be invoke as test. IF test fails, must throw some esception!
		 #Will receive token
			$TestScript = $null
	)
	
	$ErrorActionPreference = "Stop";

	# Elimina a chamada atual que é openai, para considerar apenas os callers, que pode ser sido a propria openai ou outros providers!
	$CurrentStack,$PrevStack = Get-PSCallStack
	
	$Provider = Get-AiCurrentProvider -Context -CallStack $PrevStack
	$ProviderName = $Provider.name.toUpper();
	
	if(!$Title){
		$Title = "$ProviderName API TOKEN"
	}
	
	$creds = Get-Credential $Title;
	
	$TempToken = $creds.GetNetworkCredential().Password;
	
	$BackupToken = $TempToken;
	
	IF(!$TestScript){
		$TestScript = {
			param($token)
			
			try {
				InvokeOpenai 'models' -m 'GET' -token $Token
			} catch [System.Net.WebException] {
				$resp = $_.exception.Response;
				
				if($resp.StatusCode -eq 401){
					throw "POWERSHAI_OPENAI_TOKENTEST_FAILED: Token is invalid";
				}
				
				throw;
			}
		}
	}
	
	
	try {
		$null = & $TestScript $TempToken $BackupToken
	} catch {
		throw "INVALID_TOKEN";
	}
	
	if($SetData -is [scriptblock]){
		$null = & $SetData $TempToken
	} else {
		SetCurrentProviderData Token $TempToken;
	}
}

# Define o token a ser usado nas chamadas da OpenAI!
# Faz um testes antes para certificar de que é acessível!
function Set-OpenaiToken {
	<#
		.SYNOPSIS 
			DEPRECIADO. Disponível apenas para compatibilidade e transição. Use Set-AiCredential. 
			
		.DESCRIPTION
			Configura a api key para conectar com a openai. 
			Para gerar uma API KEY, você deve ir no site da OpenAI, fazer o cadastro e gerar o token.  
			É importante lembrar que a OpenAI é paga, e, portanto, você deverá inserir créditos para conseguir usar a API aqui pelo powershai.
	#>
	[CmdletBinding()]
	param()
	
	write-warning "Set-OpenaiToken is deprecated. Use Set-AiCredential";
	
	Set-AiCredential "OpenaiToken" -Force;
	Set-AiDefaultCredential "OpenaiToken";
}


<#
	.DESCRIPTION 
		Define a API Token.  
		Você deve informar uma API Token gerada no plataforma da OpenAI, em https://platform.openai.com
		Antes de efetiar, o token será testado.
#>
function openai_SetCredential {
	param(
		$AiCredential
	)
	
	SetOpenaiTokenBase -SetData {
			param($token)
			
			$AiCredential.credential = $Token;
		}
}
Set-Alias Set-OpenaiToken openai_SetCredential


# Configura a Url base a ser usada!
function Set-OpenaiBaseUrl {
	[CmdletBinding()]
	param($url)
	
	SetCurrentProviderData BaseUrl $url
}

function Reset-OpenaiBaseUrl {
	SetCurrentProviderData BaseUrl (GetCurrentProviderData ResetUrl)
}



# Get all models!
function Get-OpenaiModels(){
	return (InvokeOpenai 'models' -m 'GET').data
}

function openai_GetModels(){
	param()
	
	$Provider = Get-AiCurrentProvider
	
	. WithAiProvider $Provider {
	
		$Models = Get-OpenaiModels
		$Models | Add-Member -Type noteproperty -Name name -Value $null 
		$Models | %{ $_.name = $_.id }
		return $models;
	
	}
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
	
	write-warning "LEGACY! This endpoint is legacy. Use Chat Get-OpenaiChat"

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
		
		,#Overwrite endpoint url!
			$endpoint = "chat/completions"
    )
	
   
	$Provider = GetNearestOpenaiProvider
	
	# Lock current provider!
	. WithAiProvider $Provider {
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
				$Body.response_format = $ResponseFormat
			}
			
			if($Functions){
				$Body.tools = $Functions
				$Body.tool_choice = "auto";
			}
			
			if($StreamCallback){
				$body.stream = $true;
				$body.stream_options = @{include_usage = $true};
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
				
				FullAnswer = $null
			}
			
			# modo stream!
			$StreamScript = $null
			if($StreamCallback){
				# #https://platform.openai.com/docs/api-reference/chat/create#chat-create-stream
				$StreamScript = {
					param($data)
					
					$line 				= $data.line;
					$StreamData.lines 	+= $line;
					
					# Ignore no json data receive events...
					if(!$line -or $line -NotLike 'data: {*'){
						return;
					}
					
					$RawJson = $line.replace("data: ","");
					$Answer = $RawJson | ConvertFrom-Json;
					
					if(!$Answer){
						return;
					}
					
					if(!$Answer.object){
						return;
					}
					
					$Tools 	= $Answer.choices[0].delta.tool_calls;
					
					if($StreamData.FullAnswer){
						$StreamData.FullAnswer.choices[0].delta.content += $Answer.choices[0].delta.content;
						
					} else {
						$StreamData.FullAnswer = $Answer
						if($Tools){
							$StreamData.CurrentCall = $Tools[-1]
						}
						
						$Tools = @() # dont need process again, already added!
					}
					
					if($Answer.choices[0].finish_reason){
						$StreamData.FullAnswer.choices[0].finish_reason = $Answer.choices[0].finish_reason
					}
						
					
					$FinalMessage 	= $StreamData.FullAnswer.choices[0].delta;
					
					
					## PRocess tools!
					# If model sent tool call, but tool_calls property dont exists yet , add it!
					if($Tools -and $FinalMessage.tool_calls -eq $null){
						$FinalMessage | Add-Member -force Noteproperty tool_calls @()
					}
					
					
					foreach($ToolCall in $Tools){
						$CallId 		= $ToolCall.id;
						$CallType 		= $ToolCall.type;
						#verbose "Processing tool`n$($ToolCall|out-string)"
						
						# Openai sent each tool in chunks, so, next tool will be sent without id.
						# THen, weed need way to get "current" sending tool arguments chunk data...
						# Whenever a call id is sent, then model sents a new tool call. Next chunks will be related to that...
						if($CallId){
							$FinalMessage.tool_calls 	+= $ToolCall;
							$StreamData.CurrentCall 	= $ToolCall;
							continue; # tool call contains all messagem including arguments. Dont need add more nothing. Must go next!
						}
						
						# If have function property, model sent something!
						$CurrentCall = $StreamData.CurrentCall;
						if($CurrentCall.type -eq 'function' -and $ToolCall.function){
							$CurrentCall.function.arguments += $ToolCall.function.arguments;
						}
					}
						
						
					$StreamData.answers += $Answer
					& $StreamCallback $Answer
				}.GetNewClosure()
			}
			
			verbose "Body:$($body|out-string)"
			$Resp = InvokeOpenai -endpoint $endpoint -body $Body -StreamCallback $StreamScript
			
			
			
			if($Resp.stream){
				$OpenaiAnswer = $StreamData.FullAnswer;
				
				$OpenaiAnswer.choices | %{
					$_ | Add-Member -force noteproperty message $_.delta;
					$_.psobject.properties.remove("delta");
				}
				
				$OpenaiAnswer | Add-Member -force noteproperty stream @{
					RawResp = $Resp
				}
			} else {
				$OpenaiAnswer = $resp;
			}
			
			return $OpenaiAnswer;	
	}
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
	
	$LastUserMessage = $null;
	
	#Base on https://gist.github.com/jdmallen/82c4be9cf0f6c86cd8911a4af13848d9
	# Thanks!
	function GetFileBase64 {
		param($file)
		
		$FileBytes = Get-Content -Raw -Encoding Byte $file.FullName;
		
		[Convert]::ToBase64String($FileBytes)
	}
	
	function GetFileMime {
		param($file)
		
		return @{
			".png" = "image/png"
			".jpg" = "image/jpeg"
			".jpeg" = "image/jpeg"
			".gif" = "image/gif"
			".webp" = "image/webp"
			".svg" = "image/svg+xml"
		}[$file.Extension]
		
	}
	
	foreach($m in $InputMessages){
		$ChatMessage =  $null;
		
		#Se não for uma string, assume que é um objeto message contendo as props necessarias
		if($m -is [IO.FileInfo] -or $m -like "file: *"){
			$ChatMessage = $LastUserMessage;
			
			
			if($m -match 'file: (.+)'){
				$file = Get-Item $matches[1];
			} else {
				$file = $m;
			}
			
			$File64 = GetFileBase64 $file;
			$FileMime = GetFileMime $file;
			
			if(!$FileMime){
				write-warning "Cannot determine MimeType of file: $($m.FullName). This can raise errors!";
			}
			
			$ChatMessage.content += @{
						type = "image_url"
						image_url = @{ url = "data:$FileMime;base64,$File64" }
					}
					
			
				
			continue;
		} 
		elseif($m -isnot [string]){	
			verbose "Adding chat message directly:`n$($m|out-string)"
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
			
			$ChatMessage = @{
					role = $RoleName
					content = @(
						@{type="text";"text"=$Content}
					)
				};
		}

		if($ChatMessage.role -eq "user"){
			$LastUserMessage = $ChatMessage;
		}
			
		verbose "	ChatMessage: $($ChatMessage|out-string)"

		$Messages += $ChatMessage
	}
	
	return $Messages;
}


<#	
	Cmdlets Get-OpenaiTool*  
	Comandos com este prefixo transformam um objeto de entrada em um OpenaiTool.  
	Um OpenaiTools é um objeto que pode ser usado com Invoke-AiChatFunctions, parametro -Functions.  
	Com eles, você adiciona a capacidade do modelo decidir executar código, e o PowershAI é a propria engine usada para rodar esse codigo e responder ao modelo.  
	A doc desse comando esclarece melhor como ele utiliza esses objetos! 
#>

<#

	.DESCRIPTION
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
function Get-OpenaiToolFromScript {
	[CmdLetBinding()]
	param(
		$ScriptPath
	)
	
	verbose "Converting script $ScriptPath to OpenaAI toools...";
	
	#Defs is : @{ FuncName = @{}, FuncName2 ..., FuncName3... }
	$FunctionDefs = @{};
	
	$ResolvedPath 	= Resolve-Path $ScriptPath -EA SilentlyContinue;
	
	if(!$ResolvedPath){
		throw "POWERSHAI_OPENAI_sCRIPT2OPENAI_NOTFOUND: File not found $ScriptPath";
	}
	

	# func é um file?
	# existing path!
	$IsPs1 			= $ScriptPath -match '\.ps1$';
	
	if(!$IsPs1 -or !$ResolvedPath){
		throw "POWERSHAI_OPENAI_SCRIPT2OPENAI_ISNOTSCRIPT: $ScriptPath"
	}
	
	[string]$FilePath = $ResolvedPath
	verbose "Loading function from file $FilePath"
	
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
		$PSModuleAutoLoadingPreference = "None"
		
		verbose "Running $FilePath"
		. $FilePath
		
		verbose "	Done!"
		
		$AllFunctions = @{}
		
		#Obtem todas as funcoes definidas no arquivo.
		#For each function get a object 
		
		Get-Command | ? {$_.scriptblock.file -eq $FilePath} | %{
			verbose "Function: $($_.name)"
			
			$help = get-help $_.name;
			
			$AllFunctions[$_.name] = @{
					func = $_
					help = get-help $_.Name
				}
		}
		
		verbose "done!";
		return $AllFunctions;
	}

	$FunctionDefs = & $GetFunctionsScript
	
	[object[]]$AllTools = @();
	
	
	
	#for each function!
	foreach($KeyName in @($FunctionDefs.keys) ){
		$Def = $FunctionDefs[$KeyName];

		$FuncName 	= $KeyName
		$FuncDef 	= $Def
		$FuncHelp 	= $Def.help;
		$FuncCmd 	= $Def.func;
		
		verbose "Creating Tool for Function $FuncName"
		
		$OpenAiFunction = @{
					name = $null 
					description = $null
				}
		
		$OpenAiTool = @{
			type 		= "function"
			'function' 	= $OpenAiFunction
		}
		
		$AllTools += $OpenAiTool;
		
		
		$OpenAiFunction.name 		= $FuncHelp.name;
		$description 				= ( @($FuncHelp.Synopsis) + @($FuncHelp.description|%{$_.text})) -join "`n"
		
		if($description.length -gt 1024){
			$description = $description.substring(1,1024);
		}
		
		$OpenaiFunction.description = $description;
		
		# get all parameters!
		$FuncParams = $FuncHelp.parameters.parameter;
		
		$FuncParamSchema = @{}

		
		if($FuncParams){
			$OpenaiFunction.parameters = @{
				type 		= "object"
				properties 	= $FuncParamSchema
				required 	= @()
			}
		} else {
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
		src 		= $ScriptPath
		type 		= "script"
		tools 		= $AllTools
		functions 	= $FunctionDefs
		
		#mapeia um comando para um script!
		map = {
			param($ToolName, $me)
			return $me.functions[$ToolName]
		}
	}
}

<#
	.DESCRIPTION 
		Gerar um novo id para openai tool call!
#>
function New-OpenaiToolCallId {
	param()
	
	$RandomId = (@(
		([char]'A')..([char]'Z')
		([char]'a')..([char]'z')
		([char]'0')..([char]'9')
	) | Get-Random -Count 24 | %{ [char]$_ }) -Join ""
	
	return "call_$RandomId"
}

<#
	.DESCRIPTION 
		Converte comandos do powershell para OpenaiTool.
#>
function Get-OpenaiToolFromCommand {
	[CmdletBinding()]
	param(
		$functions
		,$parameters = "*"
		,$UserDescription = $null
	)
	
	$ToolList = @();
	$ConvertErrors = @()
	$Applications = @{};
	
	$ToolData = @{}
	
	
	foreach($function in $functions){
	
	
		$Command = Get-Command -EA SilentlyContinue $function;
		
	
		if($Command.CommandType -eq "Application"){
			
			$AppFriendName = $function.replace(".exe","");
			$Applications[$AppFriendName] = $Command;
			$CommandHelp = @{
				name = $AppFriendName
				Synopsis = @(
					"Executable application"
					"FullPath: $($Command.source)"
					($Command.FileVersionInfo | select ProductVersion,ProductName,FileVersion,CompanyName  |out-string)
				) -Join "`n"			
			}
		} else {
			$CommandHelp = Get-Help $function;
		}
		
		$ErrorSlot = @()

		$OpenAiFunction = @{
					name = $null 
					description = $nul 
					parameters = @{}
				}
			
		$OpenAiTool = @{
			type 		= "function"
			'function' 	= $OpenAiFunction
		}
		
		$ToolList += $OpenAiTool;

		$OpenAiFunction.name 		= $CommandHelp.name;
		$description 				= ( @($CommandHelp.Synopsis) + @($CommandHelp.description|%{$_.text})) -join "`n"
		
		if($description.length -gt 1024){
			$description = $description.substring(1,1024);
		}
		
		$OpenaiFunction.description = $description
		
		if($UserDescription){
			$OpenAiFunction.description += "`n" + $UserDescription
		}
			
		# get all parameters!
		$FuncParams = $CommandHelp.parameters.parameter;
			
		$FuncParamSchema = @{}
		$OpenaiFunction.parameters = @{
			type 		= "object"
			properties 	= $FuncParamSchema
			required 	= @()
		}
		
		if(!$FuncParams){
			continue;
		}
		
		$ParametersMeta = $Command.Parameters
		
		foreach($param in $FuncParams){
			$ParamHelp = $param; 
			$ParamName = $ParamHelp.name;
			

			verbose "Processing parameter $ParamName";
			
			if($parameters -ne "*" -and $ParamName -notin @($parameters)){
				continue;
			}
			
			
			$ParamType = $ParamHelp.type;
			$ParamDesc = @($ParamHelp.description|%{$_.text}) -Join "`n"
			
			#Obtem o metadatado do parametro!
			if($ParametersMeta){
				$ParamMeta  = $ParametersMeta[$ParamName]
			} else {
				$ParamMeta = $null
			}
			
			
			verbose "	Type = $ParamType"
			
			$ParamSchema = @{
					type 		= "string"
					description = $ParamDesc
			}
			
			$FuncParamSchema[$ParamName] = $ParamSchema
			
			#Get the typename!
			try {
				$ParamRealType = [type]$ParamType.name
				
				if($ParamRealType -eq [int]){
					$ParamSchema.type = "number"
				}
				
				if($ParamRealType -eq [System.Management.Automation.SwitchParameter]){
					$ParamSchema.type = "boolean"
				}
				
				# Enum {}
				$EnumList = @();
				
				if($ParamRealType.IsEnum){
					$PossibleValues = $ParamRealType.GetEnumNames();
					$EnumList += $PossibleValues
				}
				
				if($ParamMeta){
					$AttrValidateSet = $ParamMeta.Attributes | ? { $_ -is [ValidateSet] }
					
					if($AttrValidateSet){
						$EnumList += $AttrValidateSet.ValidValues
					}
				}
				
				if($EnumList){
					$ParamSchema.enum = $EnumList
				}
				
			} catch{
				write-warning "Cannot determined type of param $ParamName! TypeName = $($ParamType.name)"
			}
		}
				
	}

	return @{
		#Lista de tools que pode ser enviando na OpenAI
		tools 	= $ToolList
		apps 	= $Applications
		type 	= "commands"
		src 	= "commands"
		
		map = {
			param($ToolName, $me)
			
			$FuncName = $ToolName;
			$App = $me.apps[$ToolName];
			
			if($App){
				$FuncName = $App.Name;
			}
			
			return @{ func = $FuncName }
		}
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



# Invoca a api para obter os embeddings
function Get-OpenaiEmbeddings {
	[CmdletBinding()]
	param(
		$text
		,$model
		,$dimensions = $null
	)
	
	if(!$model){
		$model = 'text-embedding-3-small'
	}
	
	$body = @{
		input = $text 
		model = $model 
	}
	
	if($dimensions){
		$body['dimensions'] = $dimensions;
	}
	
	InvokeOpenai -endpoint 'embeddings' -body $Body
}

function openai_GetEmbeddings {
	param(
		$text 
		,[switch]$IncludeText
		,$model
		,$dimensions = $null
	)
	
	$text = @($text);
	
	if(!$dimensions){
		$dimensions  = 768
	}
	
	$resp = Get-OpenaiEmbeddings $text -dimensions $dimensions
	

	
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


#quebra o texto em tokens...
function SplitOpenAiString {
	write-host "TODO..."
}


 # providers que querem reaproveitar a openai, devem ajustar essas keys!
return @{
	# If true and no token available, throws error!
	RequireToken 	= $true
	
	# url base. nao obrigatorio (preisará de um ReqChanger)
	BaseUrl 		= "https://api.openai.com/v1"
	

	#Nome da variável de ambiente que contém o token. Deprecated
	TokenEnvName 	= "OPENAI_API_KEY"
	
	
	# Função, comando, script que deve ser invocado para alterar a requisção.
	# Será invocada antes de enviar a requisi~~aohttp
	# Irá receber no primeiro parametro a requisicao e no segundo os parametros originais da InvokeOpenai
	ReqChanger = $null
	
	
	
	# defaults
	DefaultModel 	= "gpt-4o-mini"
	DefultEmbeddingsModel = "text-embedding-3-small"
	info = @{
		desc	= "OpenAI"
		url 	= "https://openai.com/"
	}

	ToolsModels = @(
		"gpt-*"
		"o1-*"
	)
	
	EmbeddingsModels = @(
		"text-embedding-*"
	)
	
	CredentialEnvName = "OPENAI_API_KEY"
	
	
}

