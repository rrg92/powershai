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
)

$ErrorActionPreference = "Stop";

. "$(Get-Location)/util/UtilLib.ps1"
. "./tests/pester/testlib.ps1"


CheckPowershaiRoot
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



$Params = @{
	tags = $TestTags
}


Invoke-Pester -Output Detailed @Params @Args;
