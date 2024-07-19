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

if(!$Global:POWERSHAI_SETTINGS){
	$Global:POWERSHAI_SETTINGS = @{
		provider = 'openai' #ollama, huggingface
		baseUrl  = $null
		providers = @{
			openai 	= @{
				RequireToken 	= $true
				DefaultUrl 		= "https://api.openai.com/v1"
				DefaultModel 	= "gpt-4o-mini"
			}
			
			ollama	= @{
				RequireToken 	= $false
				DefaultUrl 		= "http://localhost:11434/v1"
				ApiUrl 			= "http://localhost:11434/api"
				DefaultModel	=  $null
			}
		}
	}
}

if(!$Global:POWERSHAI_SETTINGS.chats){
	$Global:POWERSHAI_SETTINGS.chats = @{}
}

if(!$Global:POWERSHAI_SETTINGS.OriginalPrompt){
	$Global:POWERSHAI_SETTINGS.OriginalPrompt = $Function:prompt
}



function Get-AiCurrentProvider {
	$ProviderName = $POWERSHAI_SETTINGS.provider;
	$ProviderSlot = $POWERSHAI_SETTINGS.providers[$ProviderName];
	return $ProviderSlot;
}


# Função genérica para invocar HTTP e com um minimo de suporte a SSE (Server Sent Events)
Function InvokeHttp {
	[CmdLetBinding()]
	param(
		$url 			= $null
		,[object]$data 	= $null
		,$method 		= "GET"
		,$contentType 	= "application/json; charset=utf-8"
		,$headers 		= @{}
		,$SseCallBack 	= $null
	)
	$ErrorActionPreference = "Stop";
	

	
	#Converts a hashtable to a URLENCODED format to be send over HTTP requests.
	Function verbose {
		$ParentName = (Get-Variable MyInvocation -Scope 1).Value.MyCommand.Name;
		write-verbose ( $ParentName +':'+ ($Args -Join ' '))
	}
		
		
	#Troca caracteres não-unicode por um \u + codigo!
	#Solucao adapatada da resposta do Douglas em: http://stackoverflow.com/a/25349901/4100116
	Function EscapeNonUnicodeJson {
		param([string]$Json)
		
		$Replacer = {
			param($m)
			
			return [string]::format('\u{0:x4}', [int]$m.Value[0] )
		}
		
		$RegEx = [regex]'[^\x00-\x7F]';
		verbose "  Original Json: $Json";
		$ReplacedJSon = $RegEx.replace( $Json, $Replacer)
		verbose "  NonUnicode Json: $ReplacedJson";
		return $ReplacedJSon;
	}
		
	#Converts objets to JSON and vice versa,
	Function ConvertTojson2($o) {
		
		if(Get-Command ConvertTo-Json -EA "SilentlyContinue"){
			verbose " Using ConvertTo-Json"
			return EscapeNonUnicodeJson(ConvertTo-Json $o -Depth 10);
		} else {
			verbose " Using javascriptSerializer"
			Movidesk_LoadJsonEngine
			$jo=new-object system.web.script.serialization.javascriptSerializer
			$jo.maxJsonLength=[int32]::maxvalue;
			return EscapeNonUnicodeJson ($jo.Serialize($o))
		}
	}
		
	Function Hash2Qs {
		param($Data)
		
		
		$FinalString = @();
		$Data.GetEnumerator() | %{
			write-verbose "$($MyInvocation.InvocationName): Converting $($_.Key)..."
			$ParamName = MoviDesk_UrlEncode $_.Key; 
			$ParamValue = Movidesk_UrlEncode $_.Value; 
		
			$FinalString += "$ParamName=$ParamValue";
		}

		$FinalString = $FinalString -Join "&";
		return $FinalString;
	}


	try {
	
		#building the request parameters
		if($method -eq 'GET' -and $data){
			if($data -is [hashtable]){
					$QueryString = Hash2Qs $data;
			} else {
					$QueryString = $data;
			}
			
			if($url -like '*?*'){
				$url += '&' + $QueryString
			} else {
				$url += '?' + $QueryString;
			}
		}
	
		verbose "  Creating WebRequest method... Url: $url. Method: $Method ContentType: $ContentType";
		$Web = [System.Net.WebRequest]::Create($url);
		$Web.Method = $method;
		$Web.ContentType = $contentType
		
		#Faz o close do connection group!
		#$AllSp = [Net.ServicePointManager]::FindServicePoint($url)
		#if($AllSp){
		#	
		#}
		
		
		@($headers.keys) | %{
			$Web.Headers.add($_, $headers[$_]);
		}

		
		#building the body..
		if($data -and 'POST','PATCH','PUT' -Contains $method){
			if($data -is [hashtable]){
				verbose "Converting input object to json string..."
				$data = $data | ConvertTo-Json;
			}
			
			verbose "Data to be send:`n$data"

			# Transforma a string json em bytes...
			[Byte[]]$bytes = [system.Text.Encoding]::UTF8.GetBytes($data);
			
			#Escrevendo os dados
			$Web.ContentLength = $bytes.Length;
			verbose "  Bytes lengths: $($Web.ContentLength)"
			
			
			verbose "  Getting request stream...."
			$RequestStream = $Web.GetRequestStream();
			
			
			try {
				verbose "  Writing bytes to the request stream...";
				$RequestStream.Write($bytes, 0, $bytes.length);
			} finally {
				verbose "  Disposing the request stream!"
				$RequestStream.Dispose() #This must be called after writing!
			}
		}
		
		
		$UrlUri = [uri]$Url;
		$Unescaped  = $UrlUri.Query.split("&") | %{ [uri]::UnescapeDataString($_) }
		verbose "Query String:`r`n$($Unescaped | out-string)"
		


		
		verbose "  Making http request... Waiting for the response..."
		try {
			$HttpResp = $Web.GetResponse();
		} catch [System.Net.WebException] {
			verbose "ResponseError: $_... Processing..."
			$ErrorResp = $_.Exception.Response;
			
			if($ErrorResp.StatusCode -ne "BadRequest"){
				throw;
			}
			
			verbose "Processing response error..."
			$ErrorResponseStream = $ErrorResp.GetResponseStream();
			verbose "Creating error response reader..."
			$ErrorIO = New-Object System.IO.StreamReader($ErrorResponseStream);
			verbose "Reading error response..."
			$ErrorText = $ErrorIO.ReadToEnd();
			throw $ErrorText;
		}
		
		verbose "Request done..."
		
		$Result  = @{};
		
		if($HttpResp){
			verbose "  charset: $($HttpResp.CharacterSet) encoding: $($HttpResp.ContentEncoding). ContentType: $($HttpResp.ContentType)"
			verbose "  Getting response stream..."
			$ResponseStream  = $HttpResp.GetResponseStream();
			
			verbose "  Response streamwq1 size: $($ResponseStream.Length) bytes"
			
			$IO = New-Object System.IO.StreamReader($ResponseStream);
			
			$LineNum = 0;
			
			if($SseCallBack){
				verbose "  Reading SSE..."
				$LineNum++;
				$SseResult = $null;

				$Lines = @();
				
				while($SseResult -ne $false){
					verbose "  Reading next line..."
					$line = $IO.ReadLine()
					
					verbose "	Content: $line";
					
					$Lines += $line;
					
					verbose "	Invoking callback..."
					$SseResult = & $SseCallBack @{ line = $line; num = $LineNum; req = $Web; res = $HttpResp; stream = $IO }
				}
				
				$Result.text = $Lines;
				$Result.stream = $true;
			} else {
				verbose "  Reading response stream...."
				$Result.text = $IO.ReadToEnd();
			}
			
			verbose "  response json is: $responseString"
		}
		
		verbose " HttpResult:`n$($Result|out-string)"
		return $Result
	} finally {
		$BackupErrorAction = $ErrorActionPreference
		$ErrorActionPreference = "Continue";
		
		if($IO){
			$IO.close()
		}

		if($HttpResp){
			write-verbose "Ending http stream..."
			$HttpResp.Close();
		}
		
		
		if($ResponseStream){
			write-verbose "Ending response stream..."
			$ResponseStream.Close()
		}

		if($RequestStream){
			write-verbose "Ending request stream..."
			$RequestStream.Close()
		}
		
		$ErrorActionPreference = $BackupErrorAction;
	}


}


<#
	Esta função é usada como base para invocar a a API da OpenAI!
#>
function InvokeOpenai {
	[CmdletBinding()]
    param(
		$endpoint
		,$body
		,$method = 'POST'
		,$token = $Env:OPENAI_API_KEY
		,$StreamCallback = $null
	)

	$Provider = Get-AiCurrentProvider
	
	
    if(!$token -and $Provider.RequireToken){
        throw "OPENAI_NO_KEY";
    }



    $headers = @{
        "Authorization" = "Bearer $token"
    }
	
	if($endpoint -match '^https?://'){
		$url = $endpoint
	} else {
		$BaseUrl = $POWERSHAI_SETTINGS.baseUrl;

		if(!$BaseUrl){
			$BaseUrl = $Provider.DefaultUrl
		}
		
		$url = "$BaseUrl/$endpoint"
	}

	if($StreamCallback){
		$body.stream = $true;
		$body.stream_options = @{include_usage = $true};
	}

	$JsonParams = @{Depth = 10}
	$Global:Dbg_LastBody = $body;
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
	
	$creds = Get-Credential "OPENAI TOKEN";
	
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
	write-host "	Tudo certo!";
	
	$Env:OPENAI_API_KEY = $TempToken
	
	return;
}

# Configura a Url base a ser usada!
function Set-OpenaiBase {
	[CmdletBinding()]
	param($url)
	
	$CurrentBase = $Env:OPENAI_API_BASE;
	$Env:OPENAI_API_BASE = $url
}

# Muda o provider!
function Set-AiProvider {
	[CmdletBinding()]
	param($provider, $url)
	
	$ProviderSettings = $POWERSHAI_SETTINGS.providers[$provider];
	
	if(!$ProviderSettings){
		throw "POWERSHAI_PROVIDER_INVALID: $provider";
	}
	
	switch($provider){
		"ollama" {
			if($url){
				$ProviderSettings.DefaultUrl 	= "$url/v1"
				$ProviderSettings.ApiUrl 		= "$url/api"	
			}
		}
		
		default {
			if($url){
				$ProviderSettings.DefaultUrl 	= "$url/v1"
			}
		}
	}
	
	$POWERSHAI_SETTINGS.provider = $provider;
}

# Configura o default model!
function Set-AiDefaultModel {
	[CmdletBinding()]
	param($model)
	
	$SelectedModel = Get-AiModels | ? { $_.name -eq $model }
	
	if(!$SelectedModel){
		throw "POWERSHAI_SET_MODEL: Model NotFound $Model";
	}
	
	$Provider = Get-AiCurrentProvider
	$Provider.DefaultModel = $model;
}

# Get all models!
function Get-OpenaiModels(){
	return (InvokeOpenai 'models' -m 'GET').data
}

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

# Get all models!
function Get-AiModels(){
	[CmdletBinding()]
	param()
	$AiProvider = $POWERSHAI_SETTINGS.provider;
	
	$Models = $null
	
	if($AiProvider -eq 'openai'){
		$Models = (InvokeOpenai 'models' -m 'GET').data
		$Models | Add-Member -Type noteproperty -Name name -Value $null 
		$Models | %{ $_.name = $_.id }
	}
	
	if($AiProvider -eq 'ollama'){
		$Models = Get-OllamaTags
	}
	
	return $Models | select ;
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
		
		,$StreamCallback = $null
		
    )
	
    $Messages = @();

    $ShortRoles = @{
        s = "system"
        u = "user"
        a = "assistant"
    }
	
	if($PrevContext){
		$Messages += $PrevContext;
	}

	$Provider = Get-AiCurrentProvider;
	if(!$model){
		$DefaultModel = $Provider.DefaultModel;
		
		if(!$DefaultModel){
			throw "POWERSHAI_NODEFAULT_MODEL: Must set default model using Set-AiDefaultModel"
		}
		
		$model = $DefaultModel
	}


	[object[]]$InputMessages = @($prompt);
	
	foreach($m in $InputMessages){
		$ChatMessage =  $null;
		
		
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
		#	answer: disparado após obter a resposta do modelo (ou quando uma resposta fica disponivel ao usar stream).
		#	func: disparado antes de iniciar a execução de uma tool solicitada pelo modelo.
		# 	exec: disparado após o modelo executar a funcao.
		# 	error: disparado quando a funcao executada gera um erro
		# 	stream: disparado quando uma resposta foi enviada (pelo stream) e -DifferentStreamEvent
		# 	beforeAnswer: Disparado após todas as respostas. Util quando usado em stream!
		# 	afterAnswer: Disparado antes de iniciar as respostas. Util quando usado em stream!
			$on				= @{} 	
									
		,# Envia o response_format = "json", forçando o modelo a devolver um json.
			[switch]$Json				
		
		,#Adicionar parâmetros customizados diretamente na chamada (irá sobrescrever os parâmetros definidos automaticamente).
			$RawParams			= $null
			
		,[switch]$Stream
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
			$null = & $evtScript $interaction @{event=$evtName}
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
		
		$StreamProcessingData = @{
			num = 1
		}
		$ProcessStream = {
			param($Answer)
			
			$AiInteraction.stream = @{
				answer 	= $Answer
				emiNum 	= 0
				num 	= $StreamProcessingData.num++
			}
			
			
			
			& $emit "stream" $AiInteraction
		}
	
		
		if($Stream){
			$Params['StreamCallback'] = $ProcessStream
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
		
		if($Answer.stream){
			$ModelResponse = $Answer
		} else {
			$ModelResponse = $Answer.choices[0];
		}
		
		write-verbose "FinishReason: $($ModelResponse.finish_reason)"
		
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
				
				write-verbose "ProcessingTooll: $ToolCallId"
				
				try {
					if($CallType -ne 'function'){
						throw "Tool type $CallType not supported"
					}
					
					$FuncCall = $ToolCall.function
					
					#Get the called function name!
					$FuncName = $FuncCall.name
					write-verbose "	FuncName: $FuncName"
					
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
						write-warning "Model asked function $FuncName but the body was not found. This is a bug of PowershIA";
						throw "Function was defined, but code not found. This is a bug of function source."
					}
					
					#Here wil have all that we need1
					$FuncArgsRaw =  $FuncCall.arguments
					write-verbose "	Arguments: $FuncArgsRaw";
					
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
					$FuncResult = & $TheFunc @ArgsHash 
					
					if($FuncResult -eq $null){
						$FuncResult = @{};
					}
					
					$FuncResp.content = $FuncResult | ConvertTo-Json -Depth 10;
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
	
	DEPRECIADO. SErá substuido em beve polos *-PowershaiChat
#>
function Invoke-PowershaiChat {
	[CmdletBinding()]
	param(
		$Functions 		= $Null
		,$MaxTokens 	= 200
		,$MaxRequests	= 10
		,$SystemMessages = @()
		
		,#Desliga o stream 
			[switch]$NoStream
		
		,#Specify a hash table where you want store all results 
			$ChatMetadata 	= @{}
	)
	
	$ErrorActionPreference = "Stop";
	
	function WriteModelAnswer($interaction, $evt){
		$WriteParams = @{
			NoNewLine = $false
			ForegroundColor = "Cyan"
		}
		
		$Stream = $interaction.stream;
		$str = "";
		$EventName = $evt.event;


		if($Stream){
			$PartNum 	= $Stream.num;
			$text 		= $Stream.answer.choices[0].delta.content;
			$WriteParams.NoNewLine = $true;
			
			if($PartNum -eq 1){
				$str = "🤖 $($model):"
			}

			if($text){
				$Str += $text
			}
			
			if($EventName -eq "answer"){
				$str = "`n`n";
			}
		} else {
			#So entrará nesse quando o stream estiver desligado!
			$ans 	= $interaction.rawAnswer;
			$text 	= $ans.choices[0].message.content;
			$model 	= $ans.model;
			$str 	= "`🤖 $($model): $text`n`n" 
		}
		
		if($str){
			write-host @WriteParams $Str;
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
	$MustStream = $true;
	
	if($NoStream){
		$MustStream = $False;
	}
	
	write-host "Carregando lista de modelos..."
	$SupportedModels = Get-AiModels
	
	write-host "Montando estrutura de functions..."
	$Funcs = OpenAuxFunc2Tool $Functions;
	
	try {
		$CurrentUser = Get-LocalUser -SID ([System.Security.Principal.WindowsIdentity]::GetCurrent().User)
		$FullName = $CurrentUser.FullName;
		$UserAllNames = $FullName.split(" ");
		$UserFirstName = $UserAllNames[0];
	} catch {
		write-verbose "Cannot get logged username: $_"
	}
	

	
	write-host "Iniciando..."
	# $Ret = Invoke-OpenAiChatFunctions -temperature 1 -prompt @(
	# 	"Gere uma saudação inicial para o usuário que está conversando com você a partir do módulo powershell chamado PowerShai"
	# )  -on @{
	# 	stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
	# 	answer = {param($inter,$evt) WriteModelAnswer $inter $evt}
	# }  -Stream:$MustStream
	
	
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
		RawParams	= @{
			options = @{
				stop = "|fim|"
			}
		}
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
					write-host $($ElegibleModels|Sort-Object id|out-string)
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
	
	$LoopNum = 0;
	$InternalMessages = @();
	:MainLoop while($true){
		try {
			write-verbose "Verbose habilitado..." -Verbose:$VerboseEnabled;
			$LoopNum++;
			
			if($LoopNum -eq 1){
				$Prompt = @(
					
				)
				
				$InternalMessages += @(
					"Você é um agente que está conversando com o usuário partir do PowershAI, um módulo powershell para interagir com IA"
				)
				

				
				if($UserFirstName){
					$InternalMessages += "O nome do usuário é: "+$UserFirstName;
				}
				
				$Prompt = "Conversa iniciada: Gere uma mensagem inicial:"
				$Prompt = $Prompt -Join "`n";
			} else {
				$InternalMessages = @();
				
				if($UserFirstName){
					$PromptLabel = $UserFirstName
				} else {
					$PromptLabel = "Você"
				}
				
				write-host -NoNewLine "$PromptLabel>>> "
				$prompt = read-host
			}
			
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
			
			$Msg = @(
				@($SystemMessages|%{ [string]"s: $_"})
				@($InternalMessages|%{ [string]"s: $_"})
				[string]"u: $prompt"
			)
			
			
			$Msg | %{ AddContext $_ };
			
			if($ShowFullSend){
				write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
			}
		
	
			$ChatParams = $ChatUserParams + @{
				prompt 		= $ChatContext.messages
				Functions 	= $Funcs 
				Stream		= $MustStream
				on 			= @{
							
							send = {
								if($VerboseEnabled){
									write-host -ForegroundColor DarkYellow "-- waiting model... --";
								}
							}
							
							stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
							answer = {param($inter,$evt) WriteModelAnswer $inter $evt}

							
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
			
				if($interaction.stream){
					$Msg = $interaction.rawAnswer.message
				} else {
					$Msg = $interaction.rawAnswer.choices[0].message;
				}
			
				

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

Set-Alias -Name Chatest -Value Invoke-PowershaiChat
Set-Alias -Name PowerShait -Value Invoke-PowershaiChat


function NewChatContext {
	return @{
		messages = @()
		size = 0
	}
}

<#
	Inicializa o chat, mas sem travar o prompt!
#>
function New-PowershaiChat {
	[CmdletBinding()]
	param(
		$ChatId
		,$Functions 	= $null
		,$model  		= $null
		,$MaxRequests 	= 10
		,$MaxTokens 	= 1024
		,[switch]$Json
		
		,#Desliga o stream 
			[switch]$NoStream
			
		,[switch]$IfNotExists
	)
	
	if(!$ChatId){
		$ChatId = (Get-Date).toString("yyyyMMddHHmmss")
	}
	
	# Create chat!
	$Chats = $POWERSHAI_SETTINGS.chats;
	
	$ChatSlot = $Chats[$ChatId];
	
	if($ChatSlot){
		if($IfNotExists){
			return $ChatSlot;
		}
		
		throw "POWERSHAI_START_CHAT: Chat $ChatId already exists";
	}
	
	write-verbose "Carregando lista de modelos..."
	$SupportedModels = Get-AiModels
	
	
	try {
		$CurrentUser = Get-LocalUser -SID ([System.Security.Principal.WindowsIdentity]::GetCurrent().User)
		$FullName = $CurrentUser.FullName;
		$UserAllNames = $FullName.split(" ");
		$UserFirstName = $UserAllNames[0];
	} catch {
		write-verbose "Cannot get logged username: $_"
	}
	
	$ApiParams = @{					
		#Parametros que vão para a api...
		model 		= $model
		MaxRequest 	= $MaxRequests
		MaxTokens 	= $MaxTokens
		Json 		= ([bool]$Json)
		RawParams	= @{}
		MaxSeqErrors = 5
	}
	
	$ChatSlot = [PsCustomObject]@{
		id 			 	= $ChatId
		CreateDate 		= (Get-Date)
		num 			= 0
		LastPrompt 		= $null
		metadata 		= @{}
		history 		= @()
		ApiParams 		= $ApiParams
		params 			= $ApiParams + @{
				stream 			= !([bool]$NoStream)
				VerboseEnabled 	= $False;
				UseJson 		= $false;
				ShowFullSend 	= $false;
				ShowTokenStats 	= $false;
				MaxContextSize 	= 8192  # Vou considerar isso como o número de caracter por uma questão simples...
										# futuramente, o correto é trabalhar com tokens!
		}
		
		context  = (NewChatContext)
		Functions 		= @{
			src = $Functions
			parsed = $null
		}
		SupportedModels = $SupportedModels
		UserInfo = @{
			FullName = $FullName
			AllNames = @($UserAllNames)
		}
		stats = @{
			TotalChats 	= 0
			
			TotalCost 	= 0
			TotalInput 	= 0
			TotalOutput = 0
			
			TotalTokensI = 0
			TotalTokensO = 0
		}
	}

	$Chats[$ChatId] = $ChatSlot;
	
	$null = Get-PowershaiChat -SetActive $ChatId
	Update-PowershaiChatFunctions -File $Functions
	return $ChatSlot;
}

function Invoke-PowershaiChatStart {
	$InternalMessages = @(
		"Você é um agente que está conversando com o usuário partir do PowershAI, um módulo powershell para interagir com IA"
		"O chat está sendo iniciado agora"
	)

	if($UserFirstName){
		$InternalMessages += "O nome do usuário é: "+$UserFirstName;
	}
	$Prompt = @(
		"Gere uma saudação inicial para o usuário"
	)
	$Prompt = $Prompt -Join "`n";
	Send-PowershaiChat -Prompt $Prompt -SystemMessages $InternalMessages;
}

# Get a chatid!
function Get-PowershaiChat {
	[CmdletBinding()]
	param(
		[string]$ChatId # . active chat
		,[switch]$SetActive
		,[switch]$NoError
	)
	
	try {
		if(!$ChatId){
			throw "POWERSHAI_GET_CHAT: Must inform -ChatId"
		}
		
		if($ChatId -eq '*'){
			@($POWERSHAI_SETTINGS.chats) | Sort-Object CreateDate
			return;
		}
		
		# Create chat!
		$Chats 	= $POWERSHAI_SETTINGS.chats;
		
		if(!$Chats){
			 $POWERSHAI_SETTINGS.chats = @();
		}
		
		$OriginalChatId =$ChatId 
		
		if($ChatId -eq "."){
			$ChatId = $POWERSHAI_SETTINGS.ActiveChat;
			
			if(!$ChatId -or $ChatId -isnot [string]){
				throw "POWERSHAI_GET_CHAT: No active ChatId!"
			}
			
		}
		
		$Chat = $Chats[$ChatId];
		
		if(!$Chat){
			throw "POWERSHAI_GET_CHAT: Chat $ChatId not found!";
		}
		
		if($SetActive -and $OriginalChatId -ne "."){
			$POWERSHAI_SETTINGS.ActiveChat = $ChatId;
		}
	
		return $Chat
	} catch {
		if($NoError){
			return;
		}
		
		throw;
	}
	
	
	
}

function Set-PowershaiActiveChat {
	[CmdletBinding()]
	param($ChatId)
	
	Get-PowershaiChat -SetActive $ChatId;
}

function Set-PowershaiChatParameter {
	param($parameter, $value, $ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId;
	$CurrentValue = $Chat.params[$parameter];
	
	$Chat.params[$parameter] = $value;
	write-host "Changed $parameter from $CurrentValue to $value";
}

function Get-PowershaiChatParameter {
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId;
	$Chat.params
}

function Send-PowershaiChat {
	<#
		.SYNOPSIS 
			Envia uma mensagem para o modelo do provider configurado e escreve a resposta na tela!
	#>
	[CmdletBinding()]
	param(
		[parameter(mandatory=$false, position=1)]
		# o prompt a ser enviado ao modelo 
			$prompt
		
		,#System messages 
			$SystemMessages = @()
		
		,#O contexto 
		 #Esse parâmetro é pra usado preferencialmente pelo pipeline.
		 #Ele irá fazer com que o comando coloque os dados em tags <contexto></contexto> e injeterá junto no prompt.
		[parameter(mandatory=$false, ValueFromPipeline=$true)]
			$context = $null
			
		,#Força o cmdlet executar para cada objeto do pipeline
		 #Por padrão, ele acumula todos os objetos em uma string só e envia de um só vez pro LLM.
			[switch]$ForEach
			
		,#Habilia o modo json 
		 #nesse modo os resultados retornados sempre serão 
			[switch]$Json
			
		,#Modo Object!
		 #neste modo o modo JSON será ativado automaticamente!
		 #O comando não vai escrever nada na tela, e vai retornar os resultados como um objeto!
		 #Que serão jogados de volta no pipeline!
			[switch]$Object
			
		,#Desliga o historico anterior, mas colcoa a resposta atual no historico!
			[switch]$NoContext 
		,#DEsliga o historico e nao inclui o atual no historico!
			[switch]$Temporary 
			
		,# Desliga o function call para esta execução somente!
			[Alias('NoCalls')]
			[switch]$DisableFunctions
	)
	
	
	begin {
		$ErrorActionPreference = "Stop";
		
		$MyInvok = $MyInvocation;
		$CallName = $MyInvok.InvocationName;
		
		if($CallName -eq "io"){
			write-verbose "Invoked vias io alias. Setting Object to true!";
			$Object = $true;
		}
		
		$ActiveChat = Get-PowershaiChat "." -NoError
		
		if(!$ActiveChat){
			write-verbose "Creating new default chat..."
			$NewChat = New-PowershaiChat -ChatId "default" -IfNotExists
			
			write-verbose "Setting active...";
			$null = Get-PowershaiChat -SetActive $NewChat.id;
		}
		
		$AllContext = @()
		$IsPipeline = $PSCmdlet.MyInvocation.ExpectingInput   
		
		function ProcessPrompt {
			param($prompt)
			
			$prompt = $prompt -join " ";
			
			function WriteModelAnswer($interaction, $evt){
				
				if($Object){
					write-verbose "ObjectMode enabled. No writes...";
					return;
				}
				
				$WriteParams = @{
					NoNewLine = $false
					ForegroundColor = "Cyan"
				}
				
				$Stream = $interaction.stream;
				$str = "";
				$EventName = $evt.event;


				if($Stream){
					$PartNum 	= $Stream.num;
					$text 		= $Stream.answer.choices[0].delta.content;
					$WriteParams.NoNewLine = $true;
					
					if($PartNum -eq 1){
						$str = "🤖 $($model):"
					}

					if($text){
						$Str += $text
					}
					
					if($EventName -eq "answer"){
						$str = "`n`n";
					}
				} else {
					#So entrará nesse quando o stream estiver desligado!
					$ans 	= $interaction.rawAnswer;
					$text 	= $ans.choices[0].message.content;
					$model 	= $ans.model;
					$str 	= "`🤖 $($model): $text`n`n" 
				}
				
				if($str){
					write-host @WriteParams $Str;
				}
			}

			#Get active chat!
			$Chat = Get-PowershaiChat "."
			
			if(!$Chat){
				throw "POWERSHAI_SEND: No active chats"
			}
			
			#Parameters 
			$ChatStats 			= $Chat.stats;
			$ChatMetadata 		= $Chat.metadata;
			$SupportedModels 	= $Chat.SupportedModels
			$UserFirstName		= $Chat.UserInfo.AllNames[0];
			$ChatUserParams		= $Chat.params;
			$ApiParamsKeys		= @($Chat.ApiParams.keys);
			$ChatContext 		= $Chat.context;
			
			write-verbose "Iniciando..."
			
			$VerboseEnabled = $ChatUserParams.VerboseEnabled;
			$model 			= $ChatUserParams.model;
			$UseJson 		= $ChatUserParams.UseJson
			$ShowFullSend 	= $ChatUserParams.ShowFullSend
			$ShowTokenStats = $ChatUserParams.ShowTokenStats
			# Vou considerar isso como o número de caracter por uma questão simples...
			 # futuramente, o correto é trabalhar com tokens!
			$MaxContextSize = $ChatUserParams.MaxContextSize 
			
			function ParsePrompt($prompt) {
				$parts 		= $prompt -split ' ',2
				$cmdName	= $parts[0];
				$remain		= $parts[1];
				
				$result = @{
					action = $null
					prompt = $null;
				}
				
				write-verbose "InputPrompt: $cmdName"
				
				$ShortCut = @{
					'/von' 		= "VerboseEnabled true"
					'/voff' 	= "VerboseEnabled false"
					'/json' 	= "UseJson true"
					'/jsoff' 	= "UseJson false"
					'/fullon' 	= "ShowFullSend true"
					'/fulloff' 	= "ShowFullSend false"
					'/tokon' 	= "ShowTokenStats true"
					'/tokoff' 	= "ShowTokenStats false"
					'/reqs' 	= "MaxRequest "+$remain
				}[$cmdName]
				
				if($ShortCut){
					$cmdName = "/p";
					$remain = $ShortCut;
				}
				
				switch($cmdName){
					"/reload" {
						write-host "Reloading function list...";
						
						$FuncFile = $remain;
					
						if(!$FuncFile){
							$FuncFile = $Chat.Functions.src;
						}
						
						$Chat.Functions.parsed = OpenAuxFunc2Tool $FuncFile;
						$Chat.Functions.src = $remain
					}
					
					"/models" {
							write-host $($Chat.SupportedModels|out-string)
					}
					
					{'.cls','/clear','/cls','.c' -contains $_}{
							clear-host
					}
					
					
					"/p" { 
						#Split!
						$paramPair 		= $remain -split ' ',2
						$paramName 		= $paramPair[0]
						$paramValStr 	= $paramPair[1];
						
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
							$ElegibleModels = @( $Chat.SupportedModels | ? { $_.id -like $newModel } );
							
							if($ElegibleModels.length -eq 1){
								$model = $ElegibleModels[0].id;
								break;
							}
							
							write-warning "Refine your search (search:$newModel)";
							write-host $($ElegibleModels|Sort-Object id|out-string)
							$newModel = read-host "Filter model"
						}
						
						$ChatUserParams['model'] = $model
						write-host "	Changed model to: $model"
					}
					
					{'/exit','/end' -contains $_} {
						$result.action = "ExplicitExit";
						$result.prompt = $prompt;
					}
					
					default {
						$result.action = "prompt";
						$result.prompt = $prompt;
					}
				}
				
				return $result;
			}

			function AddContext($msg) {

				if($Temporary){
					return;
				}
					
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
			
			
			$Chat.num++
			$InternalMessages = @();
			try {
				write-verbose "Verbose habilitado..." -Verbose:$VerboseEnabled;
				
				$parsedPrompt = ParsePrompt $Prompt
				$Chat.LastPrompt = $parsedPrompt
				
				switch($parsedPrompt.action){
					"prompt" {
						$prompt = $parsedPrompt.prompt;
					}
					
					default {
						return;
					}
				}
				
				if($Object){
					$Exemplo1Json = @{PowerShaiJsonResult = @{
						prop1 = 123
						prop2 = "text value..."
						someArray = 1,2,3
					}} | ConvertTo-Json -Compress;
					
					$Exemplo2Json = @{PowerShaiJsonResult = "valor 1",123,"valor 3"} | ConvertTo-Json -Compress;
					
					$InternalMessages += @(
						"
							Retornar o resultado como JSON no formato: PowerShaiJsonResult:{JSON}
							EXEMPLO 1: $Exemplo1Json
							EXEMPLO 2: $Exemplo2Json
						"
					)
				}
				
				$Msg = @(
					@($SystemMessages|%{ [string]"s: $_"})
					@($InternalMessages|%{ [string]"s: $_"})
					[string]"u: $prompt"
				)
				
				$Msg | %{ AddContext $_ };
				
				if($ShowFullSend){
					write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
				}
				
				$ApiParams = @{};
				$ApiParamsKeys | %{
					$ApiParams[$_] = $ChatUserParams[$_]
				}
				
				$FullPrompt = $ChatContext.messages;
				
				
				if($NoContext){
					$FullPrompt = $Msg
				}
				
			
				$ChatParams = $ApiParams + @{
					prompt 		= $FullPrompt
					Functions 	= $Chat.Functions.parsed 
					Stream		= $Chat.params.stream
					on 			= @{
								
								send = {
									if($VerboseEnabled){
										write-host -ForegroundColor DarkYellow "-- waiting model... --";
									}
								}
								
								stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
								answer = {param($inter,$evt) WriteModelAnswer $inter $evt}

								
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
				
				if($Json){
					$ChatParams.Json = $true;
				}
				
				if($Object){
					$ChatParams.Json = $true;
					$ChatParams.Stream = $false;
				}
				
				if($VerboseEnabled){
					$ChatParams.Verbose = $true;
				}
				
				if($DisableFunctions){
					$ChatParams.Remove('Functions');
				}
				
				$Start = (Get-Date);
				$Ret 	= Invoke-OpenAiChatFunctions @ChatParams;
				$End = Get-Date;
				$Total = $End-$Start;

				foreach($interaction in $Ret.interactions){ 
				
					if($interaction.stream){
						$Msg = $interaction.rawAnswer.message
					} else {
						$Msg = $interaction.rawAnswer.choices[0].message;
					}
				
					AddContext $Msg
					
					$toolsResults = $interaction.toolResults;
					if($toolsResults){
						$toolsResults | %{ AddContext $_.resp }
					}

				}
				
				#Store the history of chats!
				$HistoryEntry = @{
					Ret = $Ret
					Elapsed = $Total
					object = $null
				}
				$Chat.history += $HistoryEntry
						
				if($Object){
					write-verbose "Object mode! Parsing json..."
					$JsonContent = $Ret.answer[0].choices[0].message.content
					write-verbose "Converting json to object: $JsonContent";
					$JsonObject = $JsonContent | ConvertFrom-Json;
					$ResultObj = $JsonObject;
					
					if($JsonObject.PowerShaiJsonResult){
						$ResultObj = $JsonObject.PowerShaiJsonResult
					}
					
					$HistoryEntry.object = $ResultObj
					write-output $ResultObj
				}
				
				
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
				$ChatStats.TotalChats += $Chat.history.count;
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
				throw;
			}
		}

		function ProcessContext {
			param($context)
			
			$FinalPrompt = @(
				"Responda a mensagem com base nas informacoes de contexto que estao na tag <contexto></contexto>"
				"<contexto>"
				$context
				"</contexto>"
				"Mensagem:"
				$prompt
			)
			
			ProcessPrompt $FinalPrompt
		}
	}
	
	process {
		if($ForEach -and $IsPipeline){
			ProcessContext $context;
		} else {
			$AllContext += $context
		}
	}
	
	
	end {
		if(!$IsPipeline){
			ProcessPrompt $prompt
			return;
		}
		
		if($AllContext.length){
			ProcessContext $AllContext;
		}
	}
	
	
	

}

function Enter-PowershaiChat {
	param(
		$ChatId = "."
		,[switch]$StartMessage
	)
	
	$Chat = Get-PowershaiChat $ChatId -SetActive
	$UserFirstName = $Chat.UserInfo.AllNames[0];
	
	if($UserFirstName){
		$PromptLabel = $UserFirstName
	} else {
		$PromptLabel = "Você"
	}
	
	if($StartMessage){
		Invoke-PowershaiChatStart
	}
		
	while($true){
		$InternalMessages = @();
		write-host -NoNewLine "$PromptLabel>>> "
		$prompt = read-host
		
		try {
			Send-PowershaiChat -prompt $prompt
			
			if($Chat.LastPrompt.action -eq "ExplicitExit"){
				break;
			}
		} catch {
			$ErrorActionPreference = "Continue";
			write-error -ErrorRecord $_
			$ErrorActionPreference = "Stop";
		}
	}
}

function Start-PowershaiChat {
	[CmdletBinding()]
	param(
		$ChatId = "default"
		,$Functions = $null
	)
	
	if(!$NoCreate){
		$NewChat = New-PowershaiChat -ChatId $ChatId -IfNotExists
	}
	
	if($Functions){
		Update-PowershaiChatFunctions -ChatId $NewChat.id -File $Functions;
	}
	
	
	Enter-PowershaiChat -StartMessage
}

function Update-PowershaiChatFunctions {
	[CmdletBinding()]
	param($File, $ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId
	
	if($File){
		$FunctionSrc = $File;
	} else {
		$FunctionSrc = $Chat.src
	}
	
	write-verbose "Loading functions from $FunctionSrc"
	$Chat.Functions.src 	= $FunctionSrc;
	$Chat.Functions.parsed 	= OpenAuxFunc2Tool $FunctionSrc;
}

function Clear-PowershaiChat {
	<#
		.SYNOPSIS
			Apaga elementos de um chat!
	#>
	param(
		
		#Apaga todo o histórico
			[switch]$History
			
		,#Apaga o contexto 
			[switch]$Context
		
		#Id do chat. Padrão: ativo.
		,$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat -ChatId $ChatId;
	
	if($context){
		write-verbose "Clearing context..."
		$Chat.context = NewChatContext
	}
	
	if($history){
		write-verbose "Clearing history"
		$Chat.history = @();
	}
	
}


function prompt {
	$ExistingPrompt = [scriptblock]::create($POWERSHAI_SETTINGS.OriginalPrompt);
	
	try {
		$Chat = Get-PowershaiChat ".";
		$Id = $Chat.id;
	} catch {
		
	}
	
	if($Id){
		$Id = "💬 $Id"
	} else {
		$Id = ""
	}
	
	
	
	$NewPrompt = (& $ExistingPrompt);
	
	if($Id){
		$NewPrompt = "$Id $NewPrompt"
	}
	
	return $NewPrompt
}


Set-Alias -Name PowerShai -Value Start-PowershaiChat
Set-Alias -Name ia -Value Send-PowershaiChat
Set-Alias -Name io -Value Send-PowershaiChat
Set-Alias -Name iaf -Value Update-PowershaiChatFunctions



Export-ModuleMember -Function * -Alias * -Cmdlet *