<#
###
### AI CREDENTIALS
###		
	
	Ai Credentials é uma feature que padroniza a forma como os providers gerenciam e disponibilizam tokens e qualquer oura informação necessária para autenticar nas APIs. 
	Atualmente, cada provider deve fazer sua própria implementação, documentando os comandos que devem ser usados.  
	Com esta feature, os providers apena sprecisam invocar os comandos do Powershai para obter acesos as credencnais.  
	Além disso, eles ainda podem implementar sua propria logica que define quais dados devem ser usados!
#>


function NewAiCredential {
	$o = @{
		name 		= $name 
		description = $description
		credential 	= $null
	}
	
	# helper method to provider standard way to set secure!
	$o | Add-Member ScriptMethod SetSecureCredential {
		param($name, $value)
		
		[securestring]$SecurePassword = ConvertTo-SecureString $value -AsPlainText -Force
		$this.credential = New-Object System.Management.Automation.PSCredential ($name, $SecurePassword)
	}
	
	$o | Add-Member ScriptMethod GetCredential {
		if($this.credential -is [System.Management.Automation.PSCredential]){
			return $this.credential.GetNetworkCredential();
		}
		
		return $this.credential;
	}
	
	
	
	
	return $o;
}


function SetAiCredentialBase {
	<#
		.SYNOPSIS  
			Define credenciais de acesso para o provider atual.
			
		.DESCRIPTION 
			Este comando vai configurar as credenciais de acesso para o provider atual.
			Esse comando é construido dinamicamente sempre que você altera o provider atual.  
			
			Logo, os parâmetros podem ser diferentes, pois cada provider pode implementar um conjunto diferentes de parâmetros.  
			Veja a doc específica de cada parâemtro. Parâmetros comuns para todos os providers são informados como um "base param" na descrição.
			
			Também, alguns providers permitem definir credenciais usando variáveis de ambiente. 
			Quando isso é feito, as credenciais definidas via variáveis de ambiente são sempre retornadas como default por Get-AiDefaultCredential.
			
			Sempre que o comando executa, ele define as credenciais criadas como default.
	#>
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
	param(
		#Identifica unicamente essa credencial no provider atual!
		#Se não fornecido, use o nome "default".
		$Name = "default"
		
		,#Uma breve descrição dessa credencial
		$description
		
		,# forçar sobrescrever a credencial, sem confirmação!
		 # um warning será gerado!
		 [switch]$Force
		
		
		
		# Este parâmetros que começam com _ são usados internamente e não serão expostos para o usuário.
		,$_TargetProvider = $null
		,$_ProviderParams = @{}
	)
	
	
	$InterfaceName = "SetCredential";
	
	$Provider = Get-AiCurrentProvider
	$ProviderName = $Provider.name;
	
	if($_TargetProvider -ne $ProviderName){
		# if this happens,  is pribably some bug or user customzied code.
		# This is because every provider switch, Set-AiCredential will b dynamically updated!
		throw "POWERSHAI_CREDENTIAL_INCORRECTPROVIDER: Current provider is not same of current ai credential! This is likely powershai bug! Target=$_TargetProvider,Current=$ProviderName";
	}
	
	# Get Store!
	$CredStore = GetCurrentProviderData CredStore;
	
	if(!$CredStore){
		$CredStore = @{}
		SetCurrentProviderData CredStore $CredStore;
	}
	
	if(!$Name){
		$Name = "default"
	}
	
	
	# Object representing credential!
	# It is a hahstable to allow free fields by underline provider!
	# Providers are free to mutate credential object!
	# But, credential property must be set to somehting in order to "ack" that a credential was set and validated!
	# For erros, provider must explicit throw eeror with messages to be show to user!
	
	$IsExternal = $false;
	if($Name -is [hashtable]){
		$AiCredential = $Name;
		$IsExternal = $true;
	} else {
		$AiCredential = NewAiCredential
	}
		
	
	
	# Ask user about changing credential...
	$Name = $AiCredential.name;
	if($CredStore.Contains($name)){
		if($Force){
			write-warning "Credential $name will be overwritten";
		}
		elseif(!$PsCmdlet.ShouldProcess("$($provider.name)/$name","Change Credential")){
			return;
		}
		
		$AiCredential.old = $CredStore[$name];
	}
	
	if(!$IsExternal){
		$UseDefault = $false;
		try {
			$Params = @{ AiCredential = $AiCredential } + $_ProviderParams
			$Result = Invoke-PowershaiProviderInterface "SetCredential" -FuncParams $Params
			
			if($AiCredential.credential -eq $null){
				throw "POWERSHAI_SETCREDENTIAL_NOTSET: Provider not set credential correctly. This can be a bug!"
			}
		} catch {
			# If errors is other than interface not found, then throws!
			if($_.Exception.ErrorName -ne "POWERSHAI_PROVIDER_INTERFACE_NOTFOUND"){
				throw;
			}
			
			$UseDefault = $true;
		}
		
		# Default credential get method!
		if($UseDefault){
			$AiCredential.credential = (Get-Credential "$($ProviderName) $Name").GetNetworkCredential().Password;
		}
	}
	
	$AiCredential.remove("old");

	# TODO: Eval how more secure is store using credential object or encrypted string.
	# Storing using PsCredential have limitations on string size and affect exprot and import.
	# Alternative will be encrypt directly, but this would require user managed key.
	# currenyl, assume user running powershai under trusted session.
	# If user runs some malicous script, script can steal the token querying powershai structure that are acessible like environemnt vars are.  
	# So, the level of security is same for using environments or storing in powershell memory without encryption.
	
	# Store the credential!
	$CredStore[$Name] = $AiCredential; 
	
	# Set default!
	Set-AiDefaultCredential $Name;
}

#This makes a new credential Set-AiCredentialProviderName function!
function MakeAiCredFunction {
	param(
		$ProviderName
	)
	
	if(!$ProviderName){
		throw "POWERSHAI_CREDENTIAL_MAKEFUNCTION: No provider name. This can be a bug in powershai!"
	}
	
	
	$ProviderInterface 		= $ProviderName+"_SetCredential";
	

	
	$BaseParams 			= @(GetParams "SetAiCredentialBase") | ?{$_.name -NotLike "_*"}
	$ProviderParams			= @()
	
	$ProviderHelp = $null
	if(get-item "Function:\$ProviderInterface" -EA SilentlyContinue){
		$ProviderParams = @(GetParams $ProviderInterface) | ?{$_.name -notin @("AiCredential")}
		$ProviderHelp = Get-help -full $ProviderInterface
	}
	
	$BaseParamsNames = $BaseParams | %{$_.name};
	$ProviderParamsNames = $ProviderParams | %{$_.name};
	
	$ParamsList = $ProviderParams + $BaseParams;

	
	
	$ParamBlock = @($ParamsList | %{
		$Help = ""
		if($_.help){
			$Help = @()
			
			if($_.name -in $BaseParamsNames){
				$Help += "# Base Param"
			}
			
			$Help += @( $_.help | %{"# $_"} )
			
			$Help = ($Help -Join "`n") + "`n"
		}
		
		$ParamDef = $_.definition;
		"$Help$ParamDef"
	}) -Join "`n,"



	$Cmd = (Get-Command SetAiCredentialBase);
	$BaseHelp = Get-Help -Full SetAiCredentialBase;
	$Script = {
		[CmdletBinding()]
		param($FuncData)
		
		
		
		$BoundBase = @{}
		$BoundProvider = @{}
		
		@($FuncData.BoundParams.keys) | %{
			$ParamName = $_;
			$ParamValue = $FuncData.BoundParams[$ParamName];
			
			if($ParamName -in $BaseParamsNames){
				$BoundBase[$ParamName] = $ParamValue
			}
			
			if($ParamName -in $ProviderParamsNames){
				$BoundProvider[$ParamName] = $ParamValue
			}
			
			
		}
		
		
		& $Cmd @BoundBase -_TargetProvider $ProviderName -_ProviderParams $BoundProvider -Verbose:$FuncData.IsVerbose
	}.GetNewClosure()
	
	$Synop = $BaseHelp.Synopsis
	
	$DescriptionBase = @($BaseHelp.description | %{$_.text}) -Join "`n";
	$Description = @($ProviderHelp.description | %{$_.text}) -Join "`n";
	
	if(!$Description){
		$Description = $BaseHelp.description
	}
	
	
	$EnvNames = @(GetCurrentProviderData -Context CredentialEnvName) -Join ","
	
	if($EnvNames){
		$EnvNames = "Environment: $EnvNames"
	}
	
	$FunctionCreateScript = "
		function ProviderSetCredential {
			<#
				.SYNOPSIS 
					$Synop
					
				.DESCRIPTION
					$description
					$EnvNames
					---
					
					$DescriptionBase
			#>
			[CmdletBinding()]
			param(
				$ParamBlock
			)
			
			[bool]`$IsVerbosePresent = [bool](`$PsBoundParameters.Verbose)
			
			. `$Script @{
					BoundParams = `$PsBoundParameters
					IsVerbose = `$IsVerbosePresent
				}
		}
	"
	
	$FunctionName = "Set-AiCredential $ProviderName"
	$ModScript = {
		param($data)
		
		$ErrorActionPreference = "Stop";
		
		$FunctionName 	= $data.FunctionName;
		$Script 		= $data.script
		
		Invoke-Expression $data.CreateScript
		Rename-Item "Function:\ProviderSetCredential" -NewName "Global:$FunctionName" -force;
		
		Export-ModuleMember -Function $FunctionName
	}
	
	$ModData = @{
		CreateScript 	= $FunctionCreateScript
		script 			= $Script
		FunctionName 	= $FunctionName
	}
	
	verbose "Creating dummy module... FunctionScript:`n$FunctionCreateScript"
	$DummyMod = New-Module -Name "powershai/$ProviderName" -ScriptBlock $ModScript  -ArgumentList $ModData
	verbose "	Importing dummy module"
	
	
	import-module -force $DummyMod 
	
	return (Get-Command $FunctionName)
}



#Make credential object!
function MkAiCredential {
	param($CredHash)
	
	$o = [PsCustomObject]$CredHash
	SetType $o AiCredential
	
	$FakeAiCred = NewAiCredential
	
	$o | Add-Member -force ScriptMethod GetCredential $FakeAiCred.GetCredential.Script
	
	return $o;
}

function Get-AiCredentials {
	<#
		.SYNOPSIS 
			Lista todas as credenciais para o provider atual!
	#>
	[CmdletBinding()]
	param()
	
	# Get Store!
	$CredStore = GetCurrentProviderData CredStore;
	
	if(!$CredStore){
		return;
	}
	
	$DefaltCred = GetCurrentProviderData DefaultCred;
	
	@($CredStore.values) | %{ 
		$o = $_  + @{default = $DefaltCred -eq $_.name}
		
		MkAiCredential $o;
	}
}

function Set-AiDefaultCredential {
	<#
		.SYNOPSIS
			Define a credential default, que deve ser usada quando o provider precisa autenticar!
	#>
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline)]
		$Credential
	)
	
	# Get Store!
	$CredStore = GetCurrentProviderData CredStore;
	
	$CredObject = $Credential;
	
	# Se é uma string, obtém pelo nome!
	if($CredObject -is [string]){
		$CredObject = $CredStore[$Credential];
	}
	
	
	if(!$CredObject){
		throw  (New-PowershaiError POWERSHAI_CREDENTIAL_DEFAULT -Message "NotFound" -Props @{
				Credential = $Credential
			})
	}
	
	SetCurrentProviderData DefaultCred $CredObject.name;
}

RegArgCompletion Set-AiDefaultCredential Credential {
	param($cmd,$param,$word,$ast,$fake)
	
	$Creds = @(Get-AiCredentials | %{$_.name})
	
	$Creds | ? {$_ -like "$word*"} | %{$_}
}

function Get-AiDefaultCredential {
	<#
		.SYNOPSIS
			Obtém a credencial default do provider atual!
		
		.DESCRIPTION 
			Obtém a credencial default. 
			Este cmdlet deve ser usado primordialmente pelos providers, quando precisarem se autenticar. 
			Porém, ele é exporo publicamente para permitir que o usuário pode checar as credenciais ativas e fazer um mínimo de troubleshooting.
			
			O cmdlet vai obter a credential default a partir do que foi definido pelo usuario e também checando umas das variáveis de ambiente, se suportados pelo provider. 
	#>
	[CmdletBinding()]
	param(
		# Se nãoe existir, ignora, ao invés de resultar em erro!!
		[switch]$IgnoreNotExists
		
		,#Script para migrar credenciais existentes.
		 #Usado exclusivamente pelos providers. 
		 #Cada provider pode especificar um script que deve retornar objetos AiCredential criado com NewAiCredential.
			$MigrateScript
	)
	
	
	
	$EnvNames 			= @(GetCurrentProviderData -Context CredentialEnvName)
	$DefaultCredSet		= GetCurrentProviderData -Context DefaultCred
	$CredStore 			= GetCurrentProviderData -Context CredStore
	$AllCredentials 	= @($CredStore.keys)
	$Policy 			= "error" 	#	todo: cmdlet to set this.
									# Warning: just warn!
									
	$TempCred = GetCurrentProviderData -Context TempCredential
	
	if($TempCred){
		return @{ credential = $TempCred; source = "temp"; desc="context temporary" };
	}
	
	$Sources = @()
	
	$EnvCredDefined = $false;
	foreach($VarName in $EnvNames){
		
		if($VarName){
			$EnvValue = @(Get-Item "Env:$VarName"  -EA SilentlyContinue).Value

			if($EnvValue){
				verbose "Found credential in environment variable $VarName";
				$Sources += @{ 
						credential 	= $EnvValue
						source 		= "environment" 
						desc 		= "environment $VarName"
					};
				$EnvCredDefined  = $True;
				break;
			}
			
		}
		
	}
	
	# if just one credential is created... always use it as default!
	$DefaultCred = $DefaultCredSet;
	if($AllCredentials.count -eq 1 -and !$EnvCredDefined){
		$DefaultCred = $AllCredentials[0];
	}
	
	if($DefaultCred -and $CredStore.Contains($DefaultCred)){
		verbose "Found credential $DefaultCred (set by Set-AiCredential)"
		$Sources += @{ 
					credential 	= (MkAiCredential $CredStore[$DefaultCred])
					source 		= "set:$DefaultCred" 
					desc 		= "Credential named $DefaultCred"
				};
		
		
	}
	
	if($Sources.count -eq 0){
		
		if($MigrateScript){
			write-warning "Migrating your current tokens to AiCredentials..."
			
			$NewCredentials = @(& $MigrateScript)
			
			
			foreach($AiCred in $NewCredentials){
				Set-AiCredential $AiCred;
			}
			
			$Last = @($NewCredentials)[0];
			
			$Sources += @{
				credential = $Last
				source = "set:Migrated"
				desc = "Migrated"
			}
			
			write-warning "Migrated. Remeber export again to persist!";
		} else {
			if($IgnoreNotExists){
				return;
			}
			
			throw "POWERSHAI_CREDENTIAL_DETAULT: No default credential set. Use Set-AiDefaultCredential"
		}
	}
	
	
	if($Sources.count -gt 1){
		verbose "Multiple default credentials found! Policy: $Policy";
		
		$Descriptions = @($Sources | %{$_.desc}) -Join "`n"
		
		if($Policy -eq "error"){
			throw "POWERSHAI_CREDENTIAL_DEFAULT_MULTIPLES: Multiple source credentials defined. Must define just one:`n$Descriptions"
		}
		
		if($Policy -eq "warning"){
			write-warning "Multiple credentials set. Using first.`n$Descriptions"
		}
	}
	
	
	
	$elegible = @($Sources)[0];
	
	# force default!
	if(!$DefaultCredSet -and $elegible.source -like "set:*"){
		verbose "Setting default cred to $DefaultCredSet due be unique available!"
		SetCurrentProviderData -Context DefaultCred $elegible.name;
	}
	
	
	return $elegible
}

function Remove-AiCredential {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
	param(
		[Parameter(ValueFromPipeline)]
		$Credential
	)
	
	begin {
		$provider  = Get-AiCurrentProvider
		$CredStore = GetCurrentProviderData CredStore;
	}
	
	process {
		
		if(IsType $Credential "AiCredential"){
			$Credential = $Credential.name;
		}
		
		if(!$PsCmdlet.ShouldProcess("$($provider.name)/$Credential","Remove Credential")){
			return;
		}
		
		$CredStore.remove($Credential);
	}
	
	end {
		
	}
	
}

function Enter-AiCredential {
	<#
		.SYNOPSIS  
			Executa um código e disponibiliza uma credential específica sempre
			
		.DESCRIPTION 
			Este comando permite executar um código que sempre vai usar uma credencial específica.
			Sempre que a fução Get-AiDefaultCredential for invocada, a credential informada será retornada sempre.
	#>
	param(
		$credential
		,$code
	)
	
	
	try {
		SetCurrentProviderData -Context TempCredential $credential
		. $Code;
	} finally {
		SetCurrentProviderData -Context TempCredential $null
	}
	
	
}