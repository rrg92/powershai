<#
	Publica na PSGalery!
#>
[CmdletBinding()]
param(
	$ApiKey = $Env:PSGALERY_KEY
)

$ErrorActionPreference = "Stop";


$TempDir = [IO.Path]::GetTempFileName()
get-item $TempDir -EA SilentlyContinue | Remove-Item;

$TempModPath = Join-Path $TempDir "powershai";

echo "Creating $TempModPath"
New-Item $TempModPath -ItemType Directory -Force;


copy-item -Path "powershai.psm1" -Destination $TempModPath


$moduleSettings = @{
    PowerShellVersion = "3.0.0"
    ModuleVersion  = "1.2"
	RootModule = 'powershai.psm1'
    Path   = "$TempModPath\powershai.psd1"
	Author = 'Rodrigo Ribeiro Gomes'
	Description = "Permite usar Inteligência Artificial direto do PowerShell"
	CompanyName = 'IA Talking'
	Copyright = '(c) IA Talking. Todos os direitos reservados'
	FunctionsToExport	= "*"
	CmdletsToExport  	= "*"
	AliasesToExport   	= "*"
	HelpInfoURI 		= "https://github.com/rrg92/powershai"
}
New-ModuleManifest @moduleSettings

Publish-Module -Path $TempModPath -NuGetApiKey $ApiKey -Force -Verbose