<#
	Publica na PSGalery!
#>
[CmdletBinding()]
param(
	$ApiKey = $Env:PSGALERY_KEY
	,[switch]$CompileDoc
	,[switch]$Tests
	,[switch]$Publish
	,[switch]$CheckVersion
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

if($Tests){
	write-host "Starting tests..."
	$Config = New-PesterConfiguration -HashTable @{
		Run = @{
			'Throw' = $true
		}
		
		Path = "./tests/pester"
		
		Output = @{
			CIFormat = "GithubActions"
		}
	}
	Invoke-Pester -Configuration $Config;
	
	write-host "	Test run!";
}

if($CompileDoc){
	$PlatyDir = Join-Path $TempDir "platy"
	$null = New-Item -Force -ItemType Directory -Path $PlatyDir
	write-host "DocCompileWorkDir: $PlatyDir";
	$DocsScript = Join-Path $PsScriptRoot doc.ps1
	& $DocsScript $PlatyDir -SupportedLangs * -MaxAboutWidth 150
}



# Module version!
if($CheckVersion){
	# Current version!
	$LastTaggedVersion = git describe --tags --match "v*" --abbrev=0;

	$TaggedVersion = [Version]($LastTaggedVersion.replace("v",""))


	$Mod = import-module $ModuleRoot -force -PassThru;

	if($TaggedVersion -ne $Mod.Version){
		throw "POWERSHAI_PUBLISH_INCORRECT_VERSION: Module = $($Mod.Version) Git = $TaggedVersion";
	}
}

if($Publish){
	$PublishParams = @{
		Path 		= $ModuleRoot
		NuGetApiKey = $ApiKey
		Force 		= $true
		Verbose 	= $true;
	}
	Publish-Module -Path $ModuleRoot -NuGetApiKey $ApiKey -Force -Verbose
}