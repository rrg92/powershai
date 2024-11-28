function PesterGlobalSetup {
	$pass = ConvertTo-SecureString ([guid]::newguid().guid) -AsPlainText -Force
	
	$Global:PESTER_TEST_CREDENTIALS =  New-Object -TypeName PSCredential -ArgumentList "PowershaiTest", $pass
	
	$Global:PesterConfirmBackup = $ConfirmPreference;
	$Global:ConfirmPreference = "None";
	
	Set-Item -Force "Function:Global:Get-Credential" {
		return $PESTER_TEST_CREDENTIALS 	
	}.GetNewClosure()
}

function PesterGlobalClean {
	$Global:ConfirmPreference = $PesterConfirmBackup;
	Remove-Item "Function:Get-Credential";
}