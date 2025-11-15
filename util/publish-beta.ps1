<#
	Publica na PSGalery!
#>
[CmdletBinding()]
param(
	$ApiKey = $Env:PSGALERY_KEY
)

$ErrorActionPreference = "Stop";
. (Join-Path "$PsScriptRoot" UtilLib.ps1)
CheckPowershaiRoot
$ModuleRoot = Resolve-Path powershai

if(!$Global:POWERSHAI_PUBLISH_DATA){
	$Global:POWERSHAI_PUBLISH_DATA = @{}
}

if(!$POWERSHAI_PUBLISH_DATA.TempDir){
	$TempFile =  [Io.Path]::GetTempFileName()
	$TempDir  = $TempFile+"-powershai";
	$POWERSHAI_PUBLISH_DATA.TempDir = New-Item -Force -ItemType Directory -Path $TempDir;
}

$TempDir = $POWERSHAI_PUBLISH_DATA.TempDir;

# copia o modulo para o diretorio temporario! 
$BetaTempPath =  "$TempDir/powershai-beta"
$BetaSafeDir = Get-Item $TempDir;
remove-item -force -recurse "$BetaSafeDir/*";

$null = New-Item -Path $BetaTempPath -Force -ItemType Directory

gci $ModuleRoot | %{ write-host "copiando $_"; copy-item -recurse -force $_.FullName $BetaTempPath };

# le o psd para gerar um novo!
$ManifestPath = "$BetaTempPath/powershai.psd1"
$ManifestScript = "$BetaTempPath/powershai-manifest.ps1";

Move-Item  $ManifestPath $ManifestScript

write-host "Lendo manifest atual"
$CurrentManifest = & $ManifestScript;


$LastTaggedVersion = git describe --tags --match "beta-*" --abbrev=0;

if(!$LastTaggedVersion){
	throw "NO_BETA_TAGS";
	return;
}

$BetaVersion = [Version]($LastTaggedVersion.replace("beta-",""))
$CurrentManifest.Guid = 'a7e32bd5-be37-4d35-befc-411c81e2bea7'
$CurrentManifest.Description = 'Beta, unstable, unstested version of powershai with latest stuff!'
$CurrentManifest.ModuleVersion = $BetaVersion
$PSData = $CurrentManifest.PrivateData.PSData
$CurrentManifest.PrivateData.Remove("PSData");

New-ModuleManifest @CurrentManifest @PSData -Path "$BetaTempPath/powershai-beta.psd1"



# testa se o modulo foi importado normalmente!
import-module -force $BetaTempPath 


if($Publish){
	$PublishParams = @{
		Path 		= $BetaTempPath
		NuGetApiKey = $ApiKey
		Force 		= $true
		Verbose 	= $true;
	}
	Publish-Module @PublishParams
}