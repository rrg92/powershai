<#
	Tags:
		basic			= Basic tests, dont require keys!
		provider:* 		= Provider specific 
		chat 			= Chat components
#>
param(
	[string[]]
	$tags  = @()
	
	,[switch]$only
	,$PesterConfiguration = @{}
)

$ErrorActionPreference = "Stop";

. "$(Get-Location)/util/UtilLib.ps1"
. "./tests/pester/testlib.ps1"


CheckPowershaiRoot
Get-module powershai | Remove-module;
import-module ./powershai -force;

[string[]]$DefaultTags = "basic";
[string[]]$TestTags = @();

if(!$only){
	$TestTags += $DefaultTags;
}

$TestTags += @($tags)

if($tags -eq "PRODUCTION"){
	$TestTags = $null
}





$Config = HashTableMerge @{
	Run = @{
		Path = @("./tests/pester")
	}
	
	Output = @{
		Verbosity = "Detailed"
	}
	
	Filter = @{
		Tag = $TestTags
	}
	
} $PesterConfiguration


$FinalConfig = New-PesterConfiguration -HashTable $Config

Invoke-Pester -Configuration $FinalConfig
