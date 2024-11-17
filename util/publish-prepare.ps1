#
#	To run in GithubActions, to prepare environment to publish!
#
param()

"platyPS","pester" | %{
	$ModName = $_
	
	if(-not(Get-Module -ListAvailable $ModName)){
		write-host "Instaling $ModName module";
		$m = Install-Module $ModName -force -PassThru
		write-host "	Installed: $($m.name) $($m.Version)"
	}	
	
}

& ./util/publish.ps1 @Args