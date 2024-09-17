<#
	Publica na PSGalery!
#>
[CmdletBinding()]
param(
	$ApiKey = $Env:PSGALERY_KEY
	,[switch]$CompileDoc
	,[switch]$Simulate
	,[switch]$BasicTest
	,[switch]$Publish
)

$ErrorActionPreference = "Stop";
. (Join-Path "$PsScriptRoot" UtilLib.ps1)
CheckPowershaiRoot

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
	& $DocsScript $PlatyDir -SupportedLangs * -MaxAboutWidth 150
}

$ModuleRoot = Resolve-Path powershai


# Current version!
$LastTaggedVersion = git describe --tags --match "v*" --abbrev=0;

$TaggedVersion = [Version]($LastTaggedVersion.replace("v",""))

# Module version!
$Mod = import-module $ModuleRoot -force -PassThru;

if($TaggedVersion -ne $Mod.Version){
	throw "POWERSHAI_PUBLISH_INCORRECT_VERSION: Module = $($Mod.Version) Git = $TaggedVersion";
}

if($BasicTest){
	write-host "Starting tests..."
	./util/TestPowershai.ps1 -Basic;
	write-host "	Test run!";
}

$PublishParams = @{
	Path 		= $ModuleRoot
	NuGetApiKey = $ApiKey
	Force 		= $true
	Verbose 	= $true;
}

if($Simulate){
	$PublishParams.WhatIf = $true;
}

if($Publish){
	Publish-Module -Path $ModuleRoot -NuGetApiKey $ApiKey -Force -Verbose
}