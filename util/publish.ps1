<#
	Publica na PSGalery!
#>
[CmdletBinding()]
param(
	$ApiKey = $Env:PSGALERY_KEY
	,[switch]$CompileDoc
)

$ErrorActionPreference = "Stop";

if(!$Global:POWERSHAI_PUBLISH_DATA){
	$Global:POWERSHAI_PUBLISH_DATA = @{}
}

if(!$POWERSHAI_PUBLISH_DATA.TempDir){
	$TempFile =  [Io.Path]::GetTempFileName()
	$TempDir  = $TempFile+"-powershai";
	$POWERSHAI_PUBLISH_DATA.TempDir = New-Item -Force -ItemType Directory -Path $TempDir;
}

$TempDir = $POWERSHAI_PUBLISH_DATA.TempDir;

$PlatyDir = Join-Path $TempDir "platy"
$null = New-Item -Force -ItemType Directory -Path $PlatyDir

if($CompileDoc){
	write-host "DocCompileWorkDir: $PlatyDir";
	$DocsScript = Join-Path $PsScriptRoot doc.ps1
	& $DocsScript $PlatyDir
}

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