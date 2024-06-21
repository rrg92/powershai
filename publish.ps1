<#
	Publica na PSGalery!
#>
[CmdletBinding()]
param(
	$ApiKey = $Env:PSGALERY_KEY
)

$ErrorActionPreference = "Stop";

$ModuleRoot = Join-Path "$PsScriptRoot" powershai


# Current version!
$LastTaggedVersion = git describe --tags --match "v*" --abbrev=0;

$TaggedVersion = [Version]($LastTaggedVersion.replace("v",""))

# Module version!
$Mod = import-module $ModuleRoot -force -PassThru;

if($TaggedVersion -ne $Mod.Version){
	throw "POWERSHAI_PUBLISH_INCORRECT_VERSION: Module = $($Mod.Version) Git = $TaggedVersion";
}



Publish-Module -Path $ModuleRoot -NuGetApiKey $ApiKey -Force -Verbose