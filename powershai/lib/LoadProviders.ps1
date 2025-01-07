<#
	PROVIDERS
	
	Saiba mais sobre os providers e sua estrutura no arquivo docs/<lang>/providers/DEVELOPMENT.about.md

#>

function Import-AiProvider {
	param($ProviderName)
	
	$ProviderPath 	= JoinPath $POWERSHAI_PROVIDERS_DIR "$ProviderName.ps1"
	$File 			= Get-Item $ProviderPath
	
	verbose "Loading provider $ProviderName";
	$ProviderData = . $File.FullName;
	
	if(!$ProviderData.info.desc){
		throw "POWERSHAI_PROVIDER_NODESC: Provider $ProviderName must have desc"
	}
	
	if($ProviderData -isnot [hashtable]){
		throw "POWERSHAI_LOADPROVIDER_INVALIDRESULT: Provider script dont returned hashtable. This can be a bug with Powershai";
	}
	
	$ProviderData.name = $ProviderName;
	$UserDefinedSettings = $POWERSHAI_SETTINGS.providers[$ProviderName];

	if(!$UserDefinedSettings){
		$UserDefinedSettings = @{};
	}
	
	$PROVIDERS[$ProviderName] = $ProviderData;
	$POWERSHAI_SETTINGS.providers[$ProviderName] = $UserDefinedSettings;
}

$ProvidersPath = JoinPath $POWERSHAI_PROVIDERS_DIR "*.ps1"
$ProvidersFiles = gci $ProvidersPath
foreach($File in $ProvidersFiles){
	$ProviderName = $File.name.replace(".ps1","");
	. Import-AiProvider $ProviderName;	
}

# Set default provider to openai!
if(!$POWERSHAI_SETTINGS.provider){
	Set-AiProvider openai
}

SetCurrentProviderCred

# Point all provider settings to same!
$PowerShaiSettingsStore = Get-PowershaiSettingsStore

@($PowerShaiSettingsStore.settings.keys) | %{
	$SettingSlot = $PowerShaiSettingsStore.settings[$_]
	
	if($SettingSlot){
		verbose "Updating provider setting for setting $_";
		$SettingSlot.providers = $PROVIDERS;
	}
}



$DEFAULT_PROVIDERS = $PROVIDERS;