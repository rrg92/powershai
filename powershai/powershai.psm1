<#
	POWERSHAI - Powershell + Inteligência Artificial 
	Autor: Rodrigo Ribeiro Gomes
	https://powertuning.com.br/
	https://iatalk.ing
	
	
	LICENÇA DE USO 
		
		Este projeto tomou várias horas minhas, da minha família e até com minha filha recém nascida.
		Dia, tarde, madrugada. Vários conhecimentos embutidos aqui da PowerShell que acumulei em uma vida...
		
		Mas, mesmo assim, eu resolvi manter ele aberto e free, e o objetivo é mantê-lo FREE para sempre!
		É uma forma também de retribuir a comunidade técnica por tudo que já aprendi com ela!
		
		Isto é, você pode baixar, usar no seu computador, na sua empresa, vender embutido com algum produto, etc.
		Em suma, você é livre para usá-lo de forma comercial e não-comercial.
		
		Meu único pedido é que sempre mantenha a menção ao projeto original: https://github.com/rr92/powershai
		Deixe os créditos para o autor Rodrigo Ribeiro Gomes, da empresa Power Tuning, o qual também permitiu que eu usasse horas do meu trabalho para mexer com este código.
		Se o PowershAI te ajuda em algum projeto, eu ficarei muito orgulhoso em saber disso e essa menção certamente ajudará minha carreira de algum forma!
		Esta menção pode ser feita em qualquer lugar do seu projeto, como:
			- créditos 
			- help 
			- documentações públicas
			- Git do seu projeto 
			- menu de help
		
	
		Um OBRIGADO ESPECIAL à Power Tuning que sempre me deu a liberdade para conduzir esses projetos, mesmo usando horas da empresa!
		https://powertuning.com.br/
	
	
	USAGE LICENSE (English)

		This project took several hours of my time, my family’s time, and even time with my newborn daughter.  
		Day, afternoon, and late night. Several pieces of PowerShell knowledge accumulated over a lifetime are embedded here...

		But even so, I decided to keep it open and free, and the goal is to keep it FREE forever!  
		It's also a way of giving back to the technical community for everything I've learned from it!

		That means you can download it, use it on your computer, in your company, sell it embedded with a product, etc.  
		In short, you are free to use it commercially and non-commercially.

		My only request is that you always keep the mention of the original project: https://github.com/rr92/powershai  
		Give credit to the author, Rodrigo Ribeiro Gomes, from Power Tuning, who also allowed me to use work hours to deal with this code.  
		If PowershAI helps you in any project, I would be very proud to know that, and this mention will certainly help my career in some way!  
		This mention can be made anywhere in your project, such as:  
		  - credits  
		  - help  
		  - public documentation  
		  - your project’s Git  
		  - help menu

		A SPECIAL THANK YOU to Power Tuning, who has always given me the freedom to lead these projects, even using company hours!  
		https://powertuning.com.br/  
#>
param($DebugMode = $Env:POWERSHAI_DEBUG)

$ErrorActionPreference = "Stop";

[string]$POWERSHAI_IMPORT_ID = [Guid]::NewGuid()

. "$PsScriptRoot/lib/util.ps1"
. "$PsScriptRoot/lib/http.ps1"
. "$PsScriptRoot/AiCredentials.ps1"

$PowershaiRoot = $PSScriptRoot

$DEFAULT_SETTINGS_STORE = @{
	version = 2
	
	current = "default"
	
	settings = @{
		default = @{
			# Provider specific!
			providers = @{}

			# User specific!
			user = @{
				provider = $null #ollama, huggingface
				baseUrl  = $null
				
				#providers settings!
				providers = @{}
				
				# commands 
				# Lista de comandos adicionados pelo usuario!
				UserTools = @{}
				
				chats = @{}
				
				OriginalPrompt = $null
			}
		}
	}
	

}

$POWERSHAI_SETTINGS 		= @{}
$PROVIDERS 					= @{}
$DEFAULT_PROVIDERS			= @{}
$POWERSHAI_USER_TOOLBOX 	= $null;
$POWERSHAI_PROVIDERS_DIR 	= Join-Path $PsScriptRoot "providers"

function Get-PowershaiSettingsStore {
	return $Global:POWERSHAI_SETTINGS_V2;
}

function Reset-PowershaiSettingsStore {
	[CmdletBinding()]
	param()
	
	$Global:POWERSHAI_SETTINGS_V2 = $null
}

function UpdatePowershaiSettingsStore {
	param($store)
	
	$Global:POWERSHAI_SETTINGS_V2 = $store;
}

function New-PowershaiSetting {
	return (HashTableMerge @{} $DEFAULT_SETTINGS_STORE.settings.default)
}

function Switch-PowershaiSetting {
	<#
		.SYNOPSIS
			Troca a configuração atual!
	#>
	param(
		$name
		,[switch]$DeleteOld
	)
	
	$SettingsStore = Get-PowershaiSettingsStore

	$OldSetting = $SettingsStore.current;
	$OldUserSetting = GetPowershaiSettingsSlot
	$SettingSlot = $SettingsStore.settings[$name]

	if(!$SettingSlot){
		$SettingSlot = New-PowershaiSetting;
		$SettingsStore.settings[$name] = $SettingSlot;
	}
	
	if(!$SettingSlot.providers -or !$SettingSlot.providers.count){
		$SettingSlot.providers = HashTableMerge @{} $DEFAULT_PROVIDERS
	}
	
	$Script:POWERSHAI_SETTINGS = $SettingSlot.user
	$Script:PROVIDERS = $SettingSlot.providers;
	
	$SettingsStore.current = $name;
	
	$TargetProvider = $POWERSHAI_SETTINGS.provider 
	
	if(!$TargetProvider){
		$TargetProvider = $OldUserSetting.provider;
	}
	
	if($TargetProvider -and (Test-Path "Function:Set-AiProvider") -and $PROVIDERS[$TargetProvider]){
		Set-AiProvider $TargetProvider;
	}
	
	if($DeleteOld -and $OldSetting -ne "default"){
		$SettingsStore.settings.remove($OldSetting);
	}
}

function Get-PowershaiSetting {
	$SettingsStore = Get-PowershaiSettingsStore
	
	if(!$SettingsStore.current){
		$SettingsStore.current = "default";
	}
	
	$SettingsStore.settings[$SettingsStore.current]
}

function GetPowershaiSettingsSlot {
	return $POWERSHAI_SETTINGS
}

function GetPowershaiProviderSlot {
	return $PROVIDERS
}

function UpgradePowershaiSettingsStore {
	<#11
		.SYNOPSIS 
			Atualiza as configurações do powershell com base em uma configuração previamente existente!
	#>
	param(
		$OldSettings
		,[switch]$IgnoreCurrent
		,[switch]$ResetProviders
	)
	
	$NewSettingsStore = HashTableMerge @{} $DEFAULT_SETTINGS_STORE
	$DefaultSettings = $NewSettingsStore.settings.default;
	$CurrentStore = Get-PowershaiSettingsStore
	
	if(!$CurrentStore){
		$CurrentStore = @{}
	}
	
	# First version migration!
	if($OldSettings -and $OldSettings.version -eq $null){
		$DefaultSettings.user = HashTableMerge $DefaultSettings.user $OldSettings
		$OldSettings = @{};
		$NewSettingsStore.settings.default = HashTableMerge $DefaultSettings $OldSettings
	} else {
		$NewSettingsStore = HashTableMerge $NewSettingsStore $OldSettings;
	}
	
	if(!$IgnoreCurrent){
		
		if($CurrentStore.settings -isnot [hashtable]){
			$CurrentStore.settings = @{}
		}
		
		$NewSettingsStore = HashTableMerge $NewSettingsStore $CurrentStore
	}
	
	if(!$NewSettingsStore.current){
		$NewSettingsStore.current = "default";
	}
	
	
	if($ResetProviders){
		
		@($NewSettingsStore.settings.keys)| %{
			$NewSettingsStore.settings[$_].providers = $null;
		}
	}
	
	UpdatePowershaiSettingsStore $NewSettingsStore;
	$Global:POWERSHAI_SETTINGS = $null
	

	Switch-PowershaiSetting $NewSettingsStore.current;
}



# misc functions...

<#
	.SYNOPSIS
		Cria um quadro virtual de texto, e escreve caracteres dentro dos limites desse quadro
	
	.DESCRIPTION 
		Cria um quadro de desenho no console, que é atualizado em somente uma região específica!
		Você pode enviar várias linhas de texto e afuncao cuidará de manter o desenho no mesmo quadro, dando a impressão que apenas uma região está sendo atualizada.
		Para o efeito desejado, esta funcao deve ser invocada repetidamente, sem outros writes entre as invocacoes!
		
		Esta função só deve ser usada no modo interativo do powershell, rodando em uma janela de console.
		Ela é útil para usar em situações em que você quer ver o progresso de um resultado em string exatamente na mesma área, podendo comparar melhor variações.
		É apenas uma função auxiliar.
		
	.EXAMPLE
		O seguinte exemplo escreve 3 string de texto a cada 2 segundos.
		Você vai perceber que as strings serão escritas exatamente na mesm alinha, substuindo a anterior!
	
		"ISso",@("é","um teste"),"de escrita","com`nvarias`nlinhas!!" | Invoke-PowerhsaiConsoleDraw -w 60x10 {  $_; start-sleep -s 1 };
		
#>
function Invoke-PowerhsaiConsoleDraw {
	[CmdletBinding()]
	param(
		#Texto a ser escrito. Pode ser um array. Se ultrapassar os limties de W e H, será truncado 
		#Se é um script bloc, invoca o codigo passando o objeto do pipeline!
			$Text
			
		,#Max de caracteres em cada linha 
			$w = 10
			
		,#Max de linhas 
			$h = 10
			
		,#Caractere usado como espaço vazio 
			$BlankChar = " "
			
		,#Objeto do pipeline 
			[Parameter(ValueFromPipeline)]
			$PipeObj
			
		,#Repassa o objeto 
			[switch]$PassThru
	)
	
	begin {
		$CurrentPos = $Host.UI.RawUI.CursorPosition
		$NewXPos = 0
		$NewYPos = $CurrentPos.Y + 1;
		
		if($w -is [string]){
			$Parts = $w -Split "x"
			$w = [int]$Parts[0];
			$h = [int]$Parts[1];
		}
		
	}
	
	process {
		
		$VirtualScreen = @()
		$RawText = $text;

		if($RawText -is [scriptblock]){
			$Result = $PipeObj | % $RawText
			$RawText = $Result
		}
		elseif($RawText -eq $null){
			$RawText = $PipeObj
		}
		
		if($RawText -is [Array]){
			$Lines = $RawText
		} else {
			$Lines = $RawText -split "`r?`n"
		}
		
		$CurrLine = -1;
		while($CurrLine -lt $h){
			$CurrLine++;
			$Line = $Lines[$CurrLine]
			
			if($Line.length -gt $w){
				$Line = $line.substring(0,$w);
			} else {
				$Line += [string]($BlankChar[0])  * ($w - $Line.length)
			}
			
			$VirtualScreen += $line -replace "`t",$BlankChar;
		}
		
		[Console]::SetCursorPosition( $NewXPos, $NewYPos );
		write-host ($VirtualScreen -Join "`n")
		
		if($PassThru){
			write-output $PipeObj
		}
	}
}




$PROVIDER_CONTEXT = New-Object Collections.Stack;
function Get-AiNearProvider {
<#
	.SYNOPSIS
		Obtém o provider mais recente do script atual
		
	.DESCRIPTION 
		Este cmdlet é comumente uado pelos providers de forma indireta através de Get-AiCurrentProvider.  
		Ele olha na callstack do powershell e identifica se o caller (a função que executou) faz parte de um script de um provider.  
		Se for, ele retorna esse provider.
		
		Se a chamada foi feia em múltiplos providers, o mais recente é retornaod. Por exemplo, imagine esse cenário:
		
			Usuario -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
			
		Neste caso, note que existem 2 calls de providers envolvidas.  
		Neste caso, a funcao Get-AiNearProvider retornará o provider y, pois ele é o mais recente da call stack.  
#>
	param(
		#Usar um call stack específica.
		#Este parâmetro é útil quando uma funcao que invocou quer que se considere a olhar a partir de um ponto específico!
		$callstack
		
		,#ScriptBlock com o filtro. $_ aponta para o provider encontrado!
		$filter = $null
	)
	
	if(!$callstack){
		$CallStack = Get-PSCallStack
	}
	
	if($PROVIDER_CONTEXT.count){
		return $PROVIDER_CONTEXT.Peek();
	}
	
	verbose "Getting next provider..."
	foreach($Frame in $CallStack){ 
		
		verbose "Frame: $($Frame.ScriptName)"
		$IsProvider = $Frame.ScriptName -like (JoinPath $POWERSHAI_PROVIDERS_DIR '*.ps1') 
		
		verbose "IsProvider: $IsProvider";
		if(!$IsProvider){
			continue;
		}
		
		$RelPath 		= $Frame.ScriptName.replace((JoinPath $POWERSHAI_PROVIDERS_DIR ''),'');
		$Parts 			= $RelPath -split '[\\/]',2
		$ProviderName 	= $Parts[0].replace(".ps1","");
		$Provider 		= $PROVIDERS[$ProviderName]
		
		verbose "ProviderName: $ProviderName";
		
		
		if($filter -is [scriptblock]){
			$Provider = $PROVIDERS[$ProviderName]
			
			verbose "RunningFilter"
			[bool]$Result = $Provider | ? $filter | %{} {} {$true}
			verbose "	Result: $Result";
			if(!$Result){
				continue;
			}
		}
		
		return $Provider
	}
}

<#
	.SYNOPSIS
		Obtém o provider ativo 
		
	.DESCRIPTION 
		Retorna o objeto que representa o provider ativo.  
		Os providers são implementados como objetos e ficam armazenados na memória da sessão, em uma variável global.  
		Esta função retorna o provider ativo, que foi definido com o comando Set-AiProvider.
		
		O objeto retorando é uma hashtable contendo todos os campos do provider.  
		Este comando é comumente usado pelos providers para obter o nome do provider ativo.  
		
		O parâmetro -ContextProvider retorna o provider atual onde o script está rodando.  
		Se estiver rodando em um script de um provider, ele vai retornar aquele provider, ao invés do provider definido com Set-AiProvider.
#>
function Get-AiCurrentProvider {
	param(
		#Se habilitado, usa o provider de contexto, isto é, se o código está rodando em um arquivo no diretorio de um provider, assume este provider.
		#Caso contrario, obtem o provider habilitado atualmente.
		[switch]$ContextProvider
		
		,#Stack alternativa a considerar! Veja mais em Get-AiNearProvider
			$CallStack = $null
			
		,#Permite escolher  o provider com base em filtros
			$FilterContext = $null
	)
	
	if($ContextProvider){
		verbose "Getting context provider";
		$Provider = Get-AiNearProvider -CallStack $CallStack -filter $FilterContext
		
		if($Provider){
			return $Provider;
		}
	}
	
	if($PROVIDER_CONTEXT.count){
		verbose "Getting locked provider";
		return $PROVIDER_CONTEXT.Peek();
	}
	
	$ProviderName = $POWERSHAI_SETTINGS.provider;
	$ProviderSlot = $PROVIDERS[$ProviderName];
	return $ProviderSlot;
}



function Enter-AiProvider {
	param(
		$Provider
		,$code
	)
	
	$Provider = Get-AiProvider $provider;
	
	$null = $PROVIDER_CONTEXT.push($Provider)
	
	try {
		. $Code;
	} finally {
		$null = $PROVIDER_CONTEXT.pop();
	}
	
	
}
Set-Alias WithAiProvider Enter-AiProvider





function SetCurrentProviderCred {
	param($Provider)
	
	if(!$Provider){
		$Provider = Get-AiCurrentProvider
	}
	
	
	$CredFunction = $Provider.CredFunction;
	
	if($CredFunction.ImportId -ne $POWERSHAI_IMPORT_ID){
		$CredFunction = @{
			func 		= (MakeAiCredFunction $Provider.name)
			ImportId	= $POWERSHAI_IMPORT_ID
		}
		
		$Provider.CredFunction  = $CredFunction;
	}
	
	
	Set-Alias -Scope Global -Force Set-AiCredential $CredFunction.func
}

<#
	.SYNOPSIS
		Obtém um provider específico!
#>
function Get-AiProvider {
	param(
		$provider
	)
	
	if($provider -isnot [string]){
		return $provider;
	}
	
	if(!$PROVIDERS.Contains($provider)){
		throw "POWERSHAI_PROVIDER_NOTFOUND: $provider";
	}
	
	return $PROVIDERS[$provider];
}

<#
	.SYNOPSIS
		Retorna os providers disponíveis
	
	.DESCRIPTION
		Este comando lista os providers implementando sno powershai.  
		PAra saber mais sobre providers consulte o tópico about_Powershai_Providers
#>
function Get-AiProviders {
	param()
	
	@($PROVIDERS.keys) | %{
		$Provider = $PROVIDERS[$_];
		
		$ProviderInfo = [PSCustomObject](@{name = $_} + $Provider.info )
		
		$ProviderInfo | Add-Member Noteproperty Chat (Invoke-PowershaiProviderInterface "Chat" -Provider $Provider.name -CheckExists)
		
		
		SetType $ProviderInfo "AiProvider"
		
		$ProviderInfo
	}
}



<#
	.SYNOPSIS
		Altera o provider atual
		
	.DESCRIPTION 
		Providers são scripts que implementam o acesso à suas respectivas APIs.  
		Cada provider tem sua forma de invocar APIs, formato dos dados, schema da resposta, etc.  
		
		Ao mudar o provider, você afeta certos comandos que operam no provider atual, como `Get-AiChat`, `Get-AiModels`, ou os Chats, como Send-PowershaAIChat.
		Para saber mais detalhes sobre os providers consule o tópico about_Powershai_Providers
#>
function Set-AiProvider {
	[CmdletBinding()]
	param(
		#nome do provider 
		$provider
	)
	
	$ProviderSettings = $PROVIDERS[$provider];
	
	if(!$ProviderSettings){
		throw "POWERSHAI_PROVIDER_INVALID: $provider";
	}
	
	$POWERSHAI_SETTINGS.provider = $provider;
	
	
	# Functions!
	SetCurrentProviderCred
}

RegArgCompletion Set-AiProvider provider {
	param($cmd,$param,$word,$ast,$fake)
	
	@($PROVIDERS.keys) | ? {$_ -like "$word*"} | %{$_}
}




function Invoke-PowershaiProviderInterface {
	<#
		.DESCRIPTION
			Invoca as implementações das interfaces de um provider provider!
			O PowershAI espera que certas funções sejam implementandas pelos providers.  
			
			Por exemplo, a função Chat é usada quando invocamos o Get-AiChat.  
			Estas funções devem ser implementadas para prover a funcionalidade de maneira padrão.  
			Essas funções são implementadas usando o nome do provider, por exemplo: openai_Chat.  
			
			O Powershai usa esta função para invocar as funcoes implementadas pelo powershai. Ela atua como um wrapper e facilitado e trata cenários comuns a todas essas invocações.
	#>
	param(
		$FuncName
		,$FuncParams
		,[switch]$Ignore
		,[switch]$CheckExists
		,$ProviderName = $null
	)
	
	if($ProviderName){
		$provider = $PROVIDERS[$ProviderName];
	} else {
		$provider = Get-AiCurrentProvider
	}
	
	
	$FuncPrefix 	= $provider.name+"_";
	$FullFuncName 	= $FuncPrefix + $FuncName;
	
	if(!$FuncParams){
		$FuncParams = @{}
	}
	
	if(Get-Command $FullFuncName -EA SilentlyContinue){
		
		if($CheckExists){
			return $true;
		}
		
		# these parameter must be available to providers have access to raw invoked data!
		$ProviderFuncRawData = @{
			params = $FuncParams
		}
		
		& $FullFuncName @FuncParams
	} else {
		
		if($CheckExists){
			return $false;
		}
		
		if(!$Ignore){
			$ex = New-PowershaiError POWERSHAI_PROVIDER_INTERFACE_NOTFOUND -Message @(
				"InterfaceName = $FuncName, FuncPrefix = $FuncPrefix, FullName = $FullFuncName, Provider = $($Provider.name)"
				"This erros can be a bug with powershai. Ask help in github or search!"
			) -Props @{ Interface = $FuncName; FuncPrefox = $FuncPrefix; FullName = $FullFuncName; Provider = $Provider }
			
			throw $ex;
		}
	}
	
}

<#
	Obtém configuracoes especifcias de um provider especifico, a partir de uma key.
	ProviderData é como se fosse um pequeno banco de dados de configurações no formato de dicionario.  
	Os providers armazenam configurações do usuário ali.  
	
	Todo provider tem 2 slots de configuração: User e Default. 
	O default é o slot com as confniguirações com valores default definido pelo proprio provider.  
	O USer é o slot com a sconfigurações que foram definidas pelo usuário. 
	Ao ser recuperada, o powershai tenta primeiro trazer a versão no slot User. Se não encontra, otbém do default. 
#>
function GetProviderData {
	param($name, $Key)
	
	$UserDefined 	= $POWERSHAI_SETTINGS.providers[$name];
	$provider 		= $PROVIDERS[$name]
	
	if($UserDefined){
		$UserSetting 	= $UserDefined[$Key];
	} else {
		$UserDefined = @{};
	}
	
	if($provider){
		$DefaultSetting	= $Provider[$key];
	}
	
	if($UserDefined.contains($Key)){
		return $UserSetting
	}
	
	return $DefaultSetting
}

# altera configurações de um provider, dado a key e o valor.
function SetProviderData {
	param($name, $Key, $value)
	
	$UserDefined = $POWERSHAI_SETTINGS.providers[$name];
	
	if(!$UserDefined){
		$UserDefined = @{};
		$POWERSHAI_SETTINGS.providers[$name] = $UserDefined;
	}
	
	$UserDefined[$key] = $value;
}

# Obtém configurações do providerr atual, a partir de um akey
function GetCurrentProviderData {
	param($key,[switch]$ContextProvider)
	
	$Provider = Get-AiCurrentProvider -ContextProvider:$ContextProvider
	GetProviderData -name $Provider.name -key $key
}

# Atualiza configurações do provider atual
function SetCurrentProviderData {
	param(
		$key,
		$value
		,[switch]$ContextProvider
	)
	
	$Provider = Get-AiCurrentProvider -ContextProvider:$ContextProvider
	SetProviderData -name $provider.name -key $key -value $value;
}






# Get all models!
$POWERSHAI_MODEL_CACHE = @{
	Provider = $null
	ModelList = $null
	ByName = @{}
}


function Get-AiModels {
<#
	.SYNOPSIS
		lista os modelos disponíveis no provider atual
	
	.DESCRIPTION
		Este comando lista todos os LLM que podem ser usados com o provider atual para uso no PowershaiChat.  
		Esta função depende que o provider implemente a função GetModels.
		
		O objeto retornado varia conforme o provider, mas, todo provider deve retorna um array de objetos, cada deve conter, pelo menos, a propridade id, que deve ser uma string usada para identificar o modelo em outros comandos que dependam de um modelo.
#>
	[CmdletBinding()]
	param()
	$ModelList 	= Invoke-PowershaiProviderInterface "GetModels"
	$Provider 	= Get-AiCurrentProvider;
	$ProviderName = $Provider.name;
	
	$POWERSHAI_MODEL_CACHE.ModelList = $ModelList | %{  
									
									$POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$($_.name)"] = $_;
									
									if(!$_.cached){
										

										$ModelMeta = Get-AiModel -MetaDataOnly $_.name
										
										$_ | Add-member -Force noteproperty tools $ModelMeta.tools;
										$_ | Add-member -Force noteproperty embeddings $ModelMeta.embeddings;
										$_ | Add-member -Force noteproperty cached $true
									}

									$_.name;
									
									SetType $_ "AiModel"
								} 
	$POWERSHAI_MODEL_CACHE.Provider = (Get-AiCurrentProvider).name
	
	SetType $ModelList "AiModelList"
	
	return $ModelList
}


function Get-AiModel {
<#
	.SYNOPSIS
		Retorna as informacoes de um model específico do cache!
	
	.DESCRIPTION
		Se o model existe em cache, usa os dados em cache!
		Se não existe, tenta consultar, caso não tenha sido tentado ainda.
#>	
	param(
		#Nome do model 
			$ModelName
			
		,#Checa somente no provider!
			[switch]$MetaDataOnly
	)
	
	$provider = Get-AiCurrentProvider
	$ProviderName = $provider.name;
	
	$ToolsExpresion 	= GetCurrentProviderData ToolsModels
	$EmbedExpression 	= GetCurrentProviderData EmbeddingsModels
	
	function IsModelInExpression {
		param($model, $expressions)
		
		if($expressions -eq "*"){
			return $true;
		}
		
		if($expressions -eq "*none*"){
			return $false;
		}
		
		foreach($expression in @($expressions)){
			if($expression -like "reg:*"){
				$RegExpr = $expression -replace '^reg:','';
				
				if($model -match $RegExpr){
					return $true;
				}
				
			}
			elseif($model -like $expression){
				return $true;
			}
		}
		
		return $false;
	}
	
	
	if($MetaDataOnly){
		return @{
			tools 		= (IsModelInExpression $ModelName $ToolsExpresion)
			embeddings 	= (IsModelInExpression $ModelName $EmbedExpression)
		}
	}
	
	$CachedModel = $POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$ModelName"]
	
	if($CachedModel){
		
		if($CachedModel.NotFound){
			return;
		}
		
		return $CachedModel;
	}
	
	# check in cache...
	$null = Get-AiModels
	
	# If not found, update to avoid repetitive calls!
	$CachedModel = $POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$ModelName"]
	if(!$CachedModel){
		$POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$ModelName"] = @{NotFound = $true};
	}
	
	return $CachedModel;
}


function Set-AiDefaultModel {
<#
	.SYNOPSIS
		Configurar o LLM default do provider atual
	
	.DESCRIPTION
		Usuários podem configurar o LLM default, que será usado quando um LLM for necessário.  
		Comandos como Send-PowershaAIChat, Get-AiChat, esperam um modelo, e se não for informado, ele usa o que foi definido com esse comando.  
#>
	[CmdletBinding()]
	param(
		#Id do modelo, conforme retornado por Get-AiModels
		#Você pode usar tab para completar a linha de comando.
			$model
			
		,#Força definir o modelo, mesmo que não seja retornaod por Get-AiModels 
			[switch]$Force
			
		,#Define embedding model!
			[switch]$Embeddings
	)
	
	$ElegibleModels = @(Get-AiModels | ? { $_.name -like $model+"*" })
	$ExactModel 	= $ElegibleModels | ?{ $_.name -eq $model }
	
	if($ExactModel){
		verbose "Using exact model!";
		SetCurrentProviderData DefaultModel $model;
		return;
	}
	
	verbose "ElegibleModels: $($ElegibleModels|out-string)"
	
	if(!$ElegibleModels){
		if($Force){
			write-warning "Model not found with that name. Forcing usage...";
			SetCurrentProviderData DefaultModel $model;
			return;
		} else {
			throw "POWERSHAI_INVALID_MODEL: $model. Use -force to for usage!";
		}
	}
	
	if($ElegibleModels.count -ge 2 -and !$ExactModel){
		throw "POWERSHAI_DEFAULTMODEL_AMBIGUOUS: Existem vários modelos com o mesmo nome $model e nenhum com este nome exato. Seja mais específico."
	}
	
	$model = $ElegibleModels[0].name
	
	if($ElegibleModels.count -eq 1 -and !$ExactModel){
		write-warning "Modelo exato $model nao encontrado. Usando o único mais próximo: $model"
	}
	
	$SetSlot = "DefaultModel"
	
	if($Embeddings){
		$SetSlot = "DefaultEmbeddingsModel"
	}
	
	SetCurrentProviderData $SetSlot $model;
}


# Lista os ids de models para o arg completion!
function GetModelsId {
	
	$CurrentProvider = Get-AiCurrentProvider
	
	
	if(!$POWERSHAI_MODEL_CACHE.ModelList){
		$null = Get-AiModels
	}
	
	if($CurrentProvider.name -ne $POWERSHAI_MODEL_CACHE.Provider){
		$null = Get-AiModels
	}

	$POWERSHAI_MODEL_CACHE.ModelList
}


RegArgCompletion Set-AiDefaultModel model {
	param($cmd,$param,$word,$ast,$fake)
	
	GetModelsId | ? {$_ -like "$word*"} | %{$_}
}


function Get-AiChat {
<#
	.SYNOPSIS
		Envia mensagens para um LLM e retorna a resposta 
		
	.DESCRIPTION 
		Esta é a forma mais básica de Chat promovida pelo PowershAI.  
		Com esta função, você pode enviar uma mensagem para um LLM do provider atual.  
		
		Esta função é mais baixo nível, de maneria padronizada, de acesso a um LLM que o powershai disponibiliza.  
		Ela não gerencia histórico ou contexto. Ela é útil para invocar promps simples, que não requerem várias interações como em um Chat. 
		Apesar de suportar o Functon Calling, ela não executa qualquer código, e apenas devolve a resposta do modelo.
		
		
		
		** INFORMACOES PARA PROVIDERS
			O provider deve implementar a função Chat para que esta funcionalidad esteja disponíveil. 
			A função chat deve retornar um objeto com a resposta com a mesma especificação da OpenAI, função Chat Completion.
			Os links a seguir servem de base:
				https://platform.openai.com/docs/guides/chat-completions
				https://platform.openai.com/docs/api-reference/chat/object (retorno sem streaming)
			O provider deve implementar os parâmetros dessa função. 
			Veja a documentação de cada parãmetro para detalhes e como mapear para um provider;
			
			Quando o modelo não suportar um dos parâmetros informados (isto pé, não houver funcionalidade equivalente,ou que possa ser implementanda de maneira equivalente) um erro deverá ser retornado.
#>
	[CmdletBinding()]
	param(
         #O prompt a ser enviado. Deve ser no formato descrito pela função ConvertTo-OpenaiMessage
			$prompt
        
		,#Temperatuta do modelo 
			$temperature   = 0.6
			
        ,#Nome do modelo. Se não especificado, usa o default do provider.
			$model         = $null
			
        ,#Máximo de tokens a ser retornado 
			$MaxTokens     = 1024
			
		,#Formato da resposta 
		 #Os formatos aceitáveis, e comportamento, devem seguir o mesmo da OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
		 #Atalhos:
		 #	"json"|"json_object", equivale a {"type": "json_object"}
		 #	objeto deve especificar um esquema como se fosse passado direatamente a API da Openai, no campo response_format.json_schema
			$ResponseFormat = $null
		
		,#Lista de tools que devem ser invocadas!
		 #Você pode usar o comandos como Get-OpenaiTool*, para transformar funcões powershell facilmente no formato esperado!
		 #Se o modelo invocar a função, a resposta, tanto em stream, quanto normal, deve também seguir o modelo de tool caling da OpenAI.
		 #Este parâmetro deve seguir o mesmo esquema do Function Calling da OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools
			$Functions 	= @()	
			

		,#Especifique parâmetros diretos da API do provider.
		 #Isso irá sobrescrever os valores que foram calculados e gerados com base nos outros parâmetros.
			$RawParams	= @{}
		
		,#Habilita o modelo Stream 
		 #Você deve especificar um ScriptBlock que será invocado para cada texto gerado pelo LLM.
		 #O script deve receber um parâmetro que representa cada trecho, no mesmo formato de streaming retornado
		 #	Este parâmetro é um objeto que conterá a propridade choices, que é nom mesmo esquema retornado pelo streaming da OpenAI:
		 #		https://platform.openai.com/docs/api-reference/chat/streaming		 
			$StreamCallback = $null
			
		,#Incluir a resposta da API em um campo chamado IncludeRawResp
			[switch]$IncludeRawResp	
	)
	
	$Provider = Get-AiCurrentProvider
	$FuncParams = $PsBoundParameters;
	
	if($ResponseFormat -in "json","json_object"){
		$FuncParams.ResponseFormat = @{type = "json_object"}
	} elseif($ResponseFormat) {
		$FuncParams.ResponseFormat = @{
				type = "json_schema"
				json_schema = $FuncParams.ResponseFormat
			}
	}

	$ModelName = $model;
	if(!$ModelName){
		$ModelName = GetCurrentProviderData DefaultModel
	}
	
	
	$model = Get-AiModel $ModelName
	
	if(!$model.tools){
		verbose "Turning off functions due to unsuportted tool calling in model $ModelName";
		# Remove function call!
		# TODO: Add Chat parameter to control what do!
		$FuncParams.Functions = $null
		
	}
	
	$FuncParams['model'] = $ModelName
	$resp = Invoke-PowershaiProviderInterface "Chat" -FuncParams $FuncParams;
	
	# Validate answer!
	#$IsValid = Test-AiChatAnswer $resp -throw;
	
	
	return $resp;
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

function Get-AiEmbeddings {
	<#
		.SYNOPSIS
			Obtém embeddings de um ou mais inputs de texto!
			
		.DESCRIPTION 
			Este função obtém embeddings usando um modelo com suporte a embeddings!
			
			## PARA PROVIDERS
				Providers que desejam export essa funcionalidade devem implementar a interface GetEmbeddings
				Resultado esperado:
					um array onde cada iem é um objeto contendo:
						- embeddings: o embedding gerado.
						- texto: o texto de origgem, se o parâmetro include text foi informado.
						
					deve ser gerado o embedding na mesma ordem do texto em que foi informado!
	#>
	param(
		#Array de textos a serem gerados!
		[Parameter(ValueFromPipeline)]
		[string[]]$text
		
		,#Incluir o texto na resposta!
		 [switch]$IncludeText
		 
		 
		,#model 
			$model = $null
			
		,#Max embeddings para processar de uma só veZ!
			$BatchSize = 10
			
		,#Número de dimensoes 
		 #Se null usará o default de cada provider!
		 #Nem todo provider suporta definir. Se não suportado, um erro é disparado!
			$dimensions = $null
	)
	
	begin {
		$AllText = @()
		
		if(!$model){
			$DefaultModel = GetCurrentProviderData DefaultEmbeddingsModel
			$model = $DefaultModel
		}
		
		if(!$model){
			throw "POWERSHAI_EMBEDDINGS_NOMODEL: Could not determine embedding model!";
		}
		
		function ProcessEmbeddings {
			param([switch]$All)
			
			if($AllText.count -gt $BatchSize -or $All){
				$FuncParams = @{
					text 		= $AllText
					IncludeText = $IncludeText
					model 		= $model
					dimensions 	= $dimensions
				}
				
				
				Invoke-PowershaiProviderInterface "GetEmbeddings" -FuncParams $FuncParams;
				
				$Script:AllText = @()
			}
		}
		
	}
	
	process {
		
		$AllText += $text;
		ProcessEmbeddings
	}
	
	end {
		ProcessEmbeddings -All
	}
	
	
}

<#
	.SYNOPSIS
		Envia mensagem para um LLM, com suporte a Tool Calling, e executa as tools solicitadas pelo modelo como comandos powershell.
		
	.DESCRIPTION
		Esta é uma função auxiliar para ajudar a fazer o processamento de tools mais fácil com powershell.
		Ele lida com o processamento das "Tools", executando quando o modelo solicita!
		
		Você deve passar as tools em um formato específico, documentando no tópico about_Powershai_Chats
		Esse formato mapeia corretamente funções e comandos powershell pra o esquema aceitável pela OpenAI (OpenAPI Schema).  
		
		Este comando encapsula toda a lógica que identifica quando o modelo quer invocar a função, a execução dessas funções,e o envio dessa resposta de volta ao modelo.  
		Ele fica nesse loop até que o modelo pare de decidir invocar mais funções, ou que o limite de interações (sim, aqui chamamos de interações mesmo, e não iterações) com o modelo tenha finalizado.
		
		O conceito de interação é simples: Cada vez que a função envia um prompt para o modelo, conta como uma integração.  
		Abaixo está um fluxo típico que pode acontecer:
			

		Você pode obter mais detalhes do funcionamento consultando o tópico about_Powershai_Chats
#>
function Invoke-AiChatTools {
	[CmdletBinding()]
	param(
		$prompt
		
		,# Array de tools, conforme explicado na doc deste comando
		 # Use os resultado de Get-OpenaiTool* para gerar os valores possíveis.  
		 # Você pode passar um array de objetos do tipo OpenaiTool.
		 # Se uma mesma funcoes estiver definida em mais de 1 tool, a primeira encontrada na ordem definida será usada!
			$Tools		= $null
			
		,$PrevContext		= $null
		,# máx output!
			$MaxTokens			= 500	
		,# No total, permitir no max 5 iteracoes!
			$MaxInteractions  		= 10	
			
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
	$OpenaiTools = @()

	#toolbox = conjutno de várias tools que foi gerada a partir de um script file, grupo de funcoes, etc.
	# é cada item passado em Tools (Chamamos de toolbox para desambiguar com o cocneito original de tool da openai)
	$FunctionMap = @{}
	foreach($Toolbox in @($Tools)){
		foreach($Tool in $Toolbox.tools){
			$OpenaiTools += $Tool ;
			$FunctionName 	= $Tool.function.name;
			
			if($FunctionMap[$FunctionName]){
				write-warning "Tool $ToolName duplicate..."
			} else {
				$FunctionMap[$FunctionName] = @{
					SrcBox = $Toolbox
				}
			}
		}
	}
	
	# initliza message!
	$Message 	= New-Object System.Collections.ArrayList
	$Message.AddRange($prompt);
	
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
			prompt 			= @($Message)
			temperature   	= $temperature
			MaxTokens     	= $MaxTokens
			Functions 		= $OpenaiTools
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
		$AiInteraction.message = @($Message);
		
		# Se chegamos no limite, então naos vamos enviar mais nada!
		if($ReqsCount -gt $MaxInteractions){
			$AiInteraction.stopReason = "MaxReached";
			break;
		}
		
		
		write-verbose "Sending Request $ReqsCount";
		# manda o bla bla pro gpt...
		& $emit "send" $AiInteraction
		$Answer = Get-AiChat @Params;
		$AiInteraction.rawAnswer = $Answer;
		$AllInteractions += $AiInteraction;
		
		& $emit "answer" $AiInteraction
		
		$ModelResponse = $Answer.choices[0];
		
		verbose "FinishReason: $($ModelResponse.finish_reason)"
		
		$WarningReasons = 'length','content_filter';
		
		if($ModelResponse.finish_reason -in $WarningReasons){
			write-warning "model finished answering due to $($ModelResponse.finish_reason)";
		}
	
		# Model asked to call a tool!
		if($ModelResponse.finish_reason -eq "tool_calls"){
			
			# A primeira opcao de resposta...
			$AnswerMessage = $ModelResponse.message;
			$ToolCallMsg = $AnswerMessage
		
			$ToolCalls = $AnswerMessage.tool_calls
			
			verbose "TotalToolsCals: $($ToolCalls.count)"
			foreach($ToolCall in $ToolCalls){
				$CallType = $ToolCall.type;
				$ToolCallId = $ToolCall.id;
				
				#Build the response message that will sent back!
				$FuncResp = @{
					role 			= "tool"
					tool_call_id 	= $ToolCallId
					
					#Set to a default message!
					content	= "ERROR: Tools was not executed due some unknown problem!";
				}
					
				verbose "Processing tool call $ToolCallId"
				
				try {
					if($CallType -ne 'function'){
						throw "POWERSHAI_CHATTOOLS_INVALID_LLM_CALLTYPE: Tool type $CallType not supported"
					}
					
					$FuncCall = $ToolCall.function
					
					#Get the called function name!
					$FuncName = $FuncCall.name
					verbose "	FuncName: $FuncName"

					# acha a tool na lista!
					$FunctionInfo = $FunctionMap[$FuncName]
					
					if(!$FunctionInfo){
						throw "POWERSHAI_CHATTOOLS_NOFUNCTIONMAP: Function $FuncName was invoked, but no function map found. This can be PowershAI bug or LLM incorrect call!"
					}
					
					$SrcToolbox = $FunctionInfo.SrcBox;
					$NoSplatArgs = $false;
					if($SrcToolbox.map){
						try {
							$MapResult = (& $SrcToolbox.map $FuncName $SrcToolbox)
							$TheFunc = $MapResult.Func
							$NoSplatArgs = $MapResult.NoSplatArgs;
						} catch {
							write-warning "POWERSHAI_CHATTOOLS_PSMAP_ERROR: ChatTools failed get command name for tool $FuncName"
							throw
						}
					} else {
						$TheFunc = $FuncName
					}
					
					if(!$TheFunc){
						throw "POWERSHAI_CHATTOOLS_NOFUNCTION: No function name was returned by map of $FuncName. This can be a bug of Powershai or LLM wrong call."
					}
					
					#Here wil have all that we need1
					$FuncArgsRaw =  $FuncCall.arguments
					verbose "	Arguments: $FuncArgsRaw";
					
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
					
					verbose "Calling function $FuncName ($FuncInfo)"
					
					if($NoSplatArgs){
						$ArgsHash = @($ArgsHash)
					}
					
					$FuncResult = & $TheFunc @ArgsHash 
					
					if($FuncResult -eq $null){
						$FuncResult = @{};
					}
					
					$FuncResp.content = (Format-PowershaiContext $FuncResult)
					& $emit "funcresult" $AiInteraction $CurrentToolResult $FuncResult
					
					
					
					# TODO: Add formatter!
					
					
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
				
				# Add tool and its answer!
				# Add current message to original message to provided previous context!
				$Message.AddRange(@(
					$ToolCallMsg
					$FuncResp
				))
				
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

<#
	.SYNOPSIS 
		Exporta as configurações da sessão atual para um arquivo, criptografado por uma senha
		
	.DESCRIPTION
		Este cmdlet é útil para salvar configurações, como os Tokens, de maneira segura.  
		Ele solicia uma senha e usa ela para criar um hash e criptografar os dados de configuração da sessão em AES256.  
		
		As configurações exportadas são todas aquelas definidas na variável $POWERSHAI_SETTINGS.  
		Essa variável é uma hashtable contendo todos os dados configurados pelos providers, o que inclui os tokens.  
		
		Por padrão, os chats não são exportados devido a quantidade de dados envolvidos, o que pode deixar o arquivo muito grande!
		
		O arquivo exportado é salvo em um diretório criado automaticamente, por padrão, na home do usuário ($HOME).  
		Os objetos são exportados via Serialization, que é o mesmo método usado por Export-CliXml.  
		
		Os dados são exportados em um formato próprio que pode ser importado apenas com Import-PowershaiSettings e informando a mesma senha.  
		
		Uma vez que o PowershAI não faz um export automático, é recomendo invocar esse comando comando sempre que houver alteração de configuração, como a inclusão de novos tokens.  
		
		O diretório de export pode ser qualquer caminho válido, incluindo cloud drives como OneDrive,Dropbox, etc.  
	
		Este comando foi criado com o intuito de ser interativo, isto é, precisa da entrada do usuário em teclado.
		
	.EXAMPLE 
		# Exportando as configurações padrões!
		> Export-PowershaiSettings 
		
		
		
	.EXAMPLE 
		# Exporta tudo, incluindo os chats!
		> Export-PowershaiSettings -Chat  
	
	.EXAMPLE
		# Exportando para o OneDrive
		> $Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
		> Export-PowershaiSettings
			
#>
function Export-PowershaiSettings {
	[CmdletBinding()]
	param(
		#Diretório de export 
		#Por Padrão, é um diretorio chamado .powershai no profile do usuário, mas pode especificar a variável de ambiente POWERSHAI_EXPORT_DIR para alterar.
			$ExportDir = $Env:POWERSHAI_EXPORT_DIR
		
		,#Se especificado, inclui os chats no export 
		 #Todos os chats serão exportados
			[switch]$Chats
	)
	
	$Password = Get-Credential "ExportPassword";
	
	$FinalData = @{
		IsRemoved = $true
	}
	
	if(!$ExportDir){
		$ExportDir = JoinPath $Home .powershai 
		$null = New-Item -Force -Itemtype Directory -Path $ExportDir;
	}
	
	write-verbose "ExportDir: $ExportDir";
	$ExportFile = JoinPath $ExportDir "exportedsession-v2.xml"
	
	$Check 		= [Guid]::NewGuid().Guid
	
	write-verbose "Hashing check: $Check";
	$CheckHash 	= PowershaiHash $Check
	
	$ExportData = HashTableMerge @{} (Get-PowershaiSettingsStore)
	
	if(!$Chats){
		@($ExportData.settings.values) | %{
			if($_.user -is [hashtable]){
				$_.user.remove("chats");
			}
		}
	}
	
	write-verbose "Serializaing..."
	$Serialized =  [System.Management.Automation.PSSerializer]::Serialize($ExportData);
	$Decrypted = @(
		"PowerShai:$($Check):$CheckHash"
		$Serialized;
	) -Join "`n"
	
	
	write-verbose "Encrypting... Serialized: $($Serialized.length)"
	$Encrypted = PowerShaiEncrypt -str 	$Decrypted -password $Password.GetNetworkCredential().Password
	
	Set-Content -Path $ExportFile  -Value $Encrypted;
	
	write-host "Exported to: $ExportFile";
}

<#
	.SYNOPSIS 
		Importa uma configuração exportada com Export-PowershaiSettings
		
	.DESCRIPTION
		Este cmdlet é o pair do Export-PowershaiSettings, e como o nome indica, ele importa os dados que foram exportados.  
		Você deve garantir que a mesma senha e o mesmo arquivo são passados.  
		
		IMPORTANTE: Este comando sobscreverá todos os dados configurados na sessão. Só execute ele se tiver certeza absoluta que nenhum dado configurado previamente pode ser perdido.
		Por exemplo, alguma API Token nova gerada recentemente.
		
		Se você estivesse especifciado um caminho de export diferente do padrão, usando a variável POWERSHAI_EXPORT_DIR, deve usa ro mesmo aqui.
		
		O processo de import valida alguns headers para garantir que o dado foi descriptografado corretamente.  
		Se a senha informanda estiver incorreta, os hashs não vão ser iguais, e ele irá disparar o erro de senha incorreta.
		
		Se, por outro lado, um erro de formado invalido de arquivo for exibido, significa que houve alguma corrupção no proesso de import ou é um bug deste comando.  
		Neste caso, você pode abrir uma issue no github relatando o problema.
		
		A partir da versão 0.7.0, um novo arquivo será gerado, chamado exportsession-v2.xml.  
		O arquivo antigo será mantido para que o usuário pode recuperar eventuais credenciais, se necessário.
		
	.EXAMPLE 
		# Import padrão
		> Import-PowershaiSettings
		
		
	
	.EXAMPLE
		# Importando do OneDrive
		> $Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
		> Import-PowershaiSettings
		
		Importa as configurações que foram exportadas para um diretório alternativo (one drive).
#>
function Import-PowershaiSettings {
	[CmdletBinding()]
	param(
		$ExportDir = $Env:POWERSHAI_EXPORT_DIR
		
		,#Força a importação da versão 1
			[switch]$v1
	)

	if(!$ExportDir){
		$ExportDir = JoinPath $Home .powershai;
	}
	
	
	
	
	write-verbose "ExportDir: $ExportDir";
	$ExportedFileV1 = JoinPath $ExportDir "exportedsession.xml"
	$ExportedFileV2 = JoinPath $ExportDir "exportedsession-v2.xml"
	
	$ExportedVersion = 2;
	if((Test-Path $ExportedFileV2) -and !$v1){
		$ExportedFile = $ExportedFileV2
	}
	elseif(Test-Path $ExportedFileV1){
		$ExportedVersion = 1;
		$ExportedFile = $ExportedFileV1
	} else {
		write-warning "Nothing to import at $ExportedFile";
		return;
	}
	
	$Encrypted = Get-Content $ExportedFile;
	write-verbose "	Encrypted content length: $($Encrypted.length)"
	$Password = Get-Credential "file password";
	$DecryptKey = $Password.GetNetworkCredential().Password
	
	try {
		$Decrypted = PowerShaiDecrypt $Encrypted $DecryptKey;
	} catch {
		write-warning "Decrypted process failed. Can be some bug of powershai. Check errors!";
		throw;
	}
	
	$Lines 		= $Decrypted -split "`n",2
	$CheckData 	= $Lines[0]
	$Data 		= $Lines[1];
	
	write-verbose "CheckData: $CheckData";
	$CheckParts = $CheckData -split ":";
	$CheckGuid  = $CheckParts[1]
	$CheckExpected = $CheckParts[2];
	$CurrentCheckGuid = PowershaiHash $CheckGuid

	if($CheckExpected -ne $CurrentCheckGuid){
		write-verbose "Expected: $CheckExpected | Current = $CurrentCheckGuid | SavedGuid = $CheckGuid"
		throw "POWERSHAI_IMPORTSESSION_INVALIDGUID: Failed decrypt. Check if your password is correct!";
	}
	
	$ExportedSettings =  [System.Management.Automation.PSSerializer]::Deserialize($Data);
	
	$CurrentProvider = $POWERSHAI_SETTINGS.Provider;
	
	UpgradePowershaiSettingsStore $ExportedSettings -IgnoreCurrent -ResetProviders
	
	write-host "Session settings imported";
	
	# Correct path to change provider!
	Set-AiProvider $POWERSHAI_SETTINGS.provider;
	
	if($CurrentProvider -ne $POWERSHAI_SETTINGS.provider){
		write-warning "Provider was changed from $CurrentProvider to $($POWERSHAI_SETTINGS.provider)";
	}
}


function Enable-AiScreenshots {
	<#
		.SYNOPSIS
			Habilita o explain screen!
			
		.DESCRIPTION
			Explain Screen é uma feature que permite obter prints de uma área da tela e enviar ao LLM que suporta vision!
			É um recurso que está sendo testado ainda, e por isso, você deve habilita!
	#>
	[CmdletBinding()]
	param()
	
	$ModScript = {
		. "$PsScriptRoot/lib/screenshotservices.ps1"
	}
			
	$DummyMod = New-Module -Name "PowershaiExplainScreen" -ScriptBlock $ModScript
	verbose "	Importing dummy module"
	import-module -force $DummyMod 
}

function Invoke-AiScreenshots {
	<#
		.SYNOPSIS
			Faz print constantes da tela e envia para o modelo ativo.
			Este comando é EXPERIMENTAL e pode mudar ou não ser disponibilizado nas próximas versões!
			
		.DESCRIPTION
			Este comando permite, em um loop, obter prints da tela!
	#>
	param(
		#Prompt padrão para ser usado com a imagem enviada!
			$prompt = "Explique essa imagem"
		
		,#Fica em loop em tirando vários screenshots
		 #Por padrão, o modo manual é usado, onde você precisa pressionar uma tecla para continuar.
		 #as seguintes teclas possuem funcoes especiais:
		 #	c - limpa a tela 
		 # ctrl + c - encerra o comando
			[switch]$repeat
		
		,#Se especificado, habilita o modo repeat automático, onde a cada número de ms especificados, ele irá enviar para a tela tela.
		 #ATENÇÃO: No modo automatico, você poderá ver a janela piscar constatemente, o que pode ser ruim para a leitura.
			$AutoMs = $nulls
		
			
		,#Recria o chat usado!
			[switch]$RecreateChat
			
		
	)
	
	# Create new chat!
	$CurrentChat = Get-PowershaiChat .
	
	try {
		# Create internal chat!
		$IfNotExists = !$RecreateChat
		$sschat 	= New-PowershaiChat -ChatId "pwshai-screenshots" -IfNotExists:$IfNotExists -Recreate:$RecreateChat;
		$null 		= Set-PowershaiActiveChat $sschat;
		
		
		$jobdata = @{
			ms = $AutoMs
			modpath = $PowershaiRoot
		}
		
		if($AutoMs){
			Get-Job "PowershaiScreenshot" -ea SilentlyContinue | Stop-Job -PassThru | Remove-job;
			
			$PrintJob = Start-Job -Name "PowershaiScreenshot" {
				param($data)
				
				import-module -force $data.modpath;
				Enable-AiScreenshots
				while($true){
					
					write-output $(Get-PowershaiPrintSCreen)
					Start-Sleep -m $data.ms
				}
			} -ArgumentList $jobdata
		}
		
		$PendingPrints = New-Object Collections.ArrayList
		$null = $PendingPrints.Add( (Get-PowershaiPrintSCreen) )
		
		while($true){
			foreach($file in $PendingPrints){
				$WarningPreference = "SilentlyContinue"
				Send-PowershaiChat -Temporary -prompt "$prompt","file: $file";
				$WarningPreference = "Continue";
			}
			
			if(!$repeat){
				break;
			}
			
			$PendingPrints.Clear();
			while(!$PendingPrints){
				if($AutoMs){
					$null = $PrintJob | Receive-Job | %{ $PendingPrints.Add($_) };
					start-sleep -m $AutoMs;
				} else {
					[Console]::TreatControlCAsInput = $true;
					$key = [console]::ReadKey($true)
					[Console]::TreatControlCAsInput = $False;
					
					if($key.Key -eq "C"){
						if($key.Modifiers -eq "Control"){
							return;
						}
						
						clear-host;continue;
					}

					$null = $PendingPrints.Add( (Get-PowershaiPrintSCreen) )
				}
			}
			
			write-host "";
		}
		
	} finally {
		$null = Set-PowershaiActiveChat $CurrentChat;
		$null = Get-Job "PowershaiScreenshot" -ea SilentlyContinue | Stop-Job
	}
}
Set-Alias printai Invoke-AiScreenshots


function Get-PowershaiHelp {
	<#
		.SYNOPSIS
			Usa o provider atual para ajudar a obter ajuda sobre o powershai!
			
		.DESCRIPTION
			Este cmdlet utiliza os próprios comandos do PowershAI para ajudar o usuário a obter ajuda sobre ele mesmo.  
			Basicamente, partindo da pergunta do usuário, ele monta um prompt com algumas informacoes comuns e helps basicos.  
			Então, isso é enviando ao LLM em um chat.
			
			Devido ao grande volume de dados enviandos, é recomendando usar esse comando somente com providers e modeos que aceitam mais de 128k e que sejam baratos.  
			Por enquanto, este comando é experimental e funciona penas com estes modelos:
				- Openai gpt-4*
				
			Internamente, ele irá criar um Powershai Chat chamado "_pwshai_help", onde manterá todo o histórico!
	#>
	[CmdletBinding()]
	param(
		#Descreva o texto de ajuda!
		$helptext
		
		,#Se quiser help de um comando específico, informe o comando aqui 
		 #Não precisa ser somente um comando do PowershaiChat.
			$command
			
		,#Recria o chat!
			[switch]$Recreate
	)
	
	write-warning "This command is in preview! Take caution!"
	
	$CurrentProvider = Get-AiCurrentProvider
	$CurrentProviderName = $CurrentProvider.name;
	[object[]]$SupportedProviders = @("openai")
	if($CurrentProviderName -notin $SupportedProviders){
		throw "POWERSHAI_AIHELP_PROVIDER_NOTSUPPORTED: $CurrentProviderName | Allowed = $SupportedProviders"
	}
	
	$CurrentChat = Get-PowershaiChat .
	
	
	
	$HelpTools = JoinPath $PsScriptRoot "lib" PowershaiHelp.tools.ps1
	
	
	
	try {
		# Create internal chat!
		$IfNotExists = !$Recreate
		$HelpChat 	= New-PowershaiChat -ChatId "_pwshai_help" -IfNotExists:$IfNotExists -Tool $HelpTools -Recreate:$Recreate;
		$null 		= Set-PowershaiActiveChat $HelpChat;
	
		$null = Set-PowershaiChatParameter MaxContextSize 20000
		$null = Set-PowershaiChatParameter MaxInteractions 50
		$null = Set-PowershaiChatParameter MaxTokens 8192
		
		if(!$HelpChat.HelpCache){
			$HelpChat | Add-Member -Force Noteproperty HelpCache @{}
		}
		
		$HelpCache = $HelpChat.HelpCache;
		
		if(!$HelpCache.SystemPrompt){
			
			$Synopsis = @{
				Name = "Descricao"
				Expression = {
					if($_.CommandType -eq "alias"){
						return "Alias para" + $_.Definition;
					}
					
					return (Get-help $_).Synopsis.trim()
				}
			}
			
			$CommandHelp = Get-Command -mo powershai | select name,$Synopsis
			
			$Culture = Get-UICulture;
			$HelpCache.SystemPrompt = @(
					"Você é um assistente que deve ajudar o usuário a responder dúvidas sobre um módulo Powershell chamado Powershai"
					"O Powershai é um módulo que possui vários comandos para trazer ao mundo de IA!"
					"Abaixo está a lista de comandos do powershai, separado por vírgula:"
					@(Get-Command -mo powershai | select CommandType,name | out-string)
					""
					"Abaixo está a lista de help topics disponiveis no powershai:"
					@(get-help about_Powershai*|out-string)
					"Com base na questão responda sobre as perguntas com o máximo de detalhes e clareza possível"
					"Formate a resposta apenas com textos simples, sem qualquer formatçaão visual, pois o texto será exinido em um prompt de comando"
					"Resonda no idioma da pergunta do usuário. Caso não seja possível identificar, responda nesse: $($Culture.DisplayName)"
				)
		}
		
		
		
		ia $helptext -SystemMessages $HelpCache.SystemPrompt
	} finally {
		$null = Set-PowershaiActiveChat $CurrentChat;
	}
	
	
	
	
	
}
set-alias aihelp Get-PowershaiHelp
set-alias aid Get-PowershaiHelp
set-alias ajudai Get-PowershaiHelp
set-alias iajuda Get-PowershaiHelp


. "$PSScriptRoot/chats.ps1"


UpgradePowershaiSettingsStore $Global:POWERSHAI_SETTINGS;

# Carrega os providers!
. "$PSScriptRoot/lib/LoadProviders.ps1"




if($DebugMode){
	write-warning "POWERSHAI DEBUG MODE ENABLED!!!!!!"
	Export-ModuleMember -Alias * -Cmdlet * -Function *
} else {
	Export-ModuleMember -Alias * -Cmdlet *-* -Function *-*
}


