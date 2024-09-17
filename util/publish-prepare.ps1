#
#	To run in GithubActions, to prepare environment to publish!
#
param()

if(-not(Get-Module -ListAvailable platyPS)){
	write-host "Instaling PLatyPs module";
	$m = Install-Module platyPS -force -PassThru
	write-host "	Installed: $($m.name) $($m.Version)"
}

& ./util/publish.ps1 @Args