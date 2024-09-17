param(
	[switch]$Basic
	,$TestModels = $Env:POWERSHAI_TEST_MODELS # provider/modelname,provider/modelname
	,[switch]$Verbose
)

#
#	Do Basic tests.
#	TODO: Use Pester
#

$ErrorActionPreference = "Stop";

write-host "Starting PowershAI test script...";

try {
	. (Join-Path "$PsScriptRoot" UtilLib.ps1)
	CheckPowershaiRoot
	
	import-module ./powershai -force;
	
	$m = Get-module powershai;
	
	if(!$m){
		throw "MODULE_NOT_IMPORTED: $m";
	}
	
	$TestModelList = $TestModels -split ",";
	write-host "	Models to test: $($TestModelList.count)";
	
	$ChatNum = 1;
	foreach($TestExpr in $TestModelList){
		$ChatNum++;
		$Parts 		= $TestExpr -split "/",2
		$Provider 	= $Parts[0];
		$Model 		= $Parts[1];
		
		write-host "Testing provider: $provider";
		Set-AiProvider $provider;
		
		write-host "Testing model: $model";
		Set-AiDefaultModel $model;

		write-host "Test: Simple temporary default chat";
		iat "Hi, this is a test from powershell ai module called Powershai";
		
		1..5 | iat "write names of that numbers"
		
		ia "gere 5 palavras em pt-BR"
		ia -Lines "traduza os nomes para o inglês" | %{ "English: $_" }
		
		# chat creation test!
		write-host "Test: Creating new chat"
		$Chat = New-PowershaiChat "Test-$ChatNum";
		
		$SecretGuid = [Guid]::NewGuid().Guid;
		write-host "Test: New chat sending data! SecretGuid: $SecretGuid"
		ia (@(
			"This is a secret data: $SecretGuid"
			"I will ask about it later"
		) -Join "`n")
		
		write-host "Test: Getting data from current chat history"
		$ReturnedSecret = @(ia -Lines "What is secret data? Return just secret data in first line");
		if($ReturnedSecret){
			$ReturnedSecret = @($ReturnedSecret)[0].trim();
		}
		
		write-host "	SecretGuidReturned: ~$ReturnedSecret~"
		
		if($ReturnedSecret -ne $SecretGuid){
			throw "HISTORYTEST_POSITIVE_FAIL"
		}
		
		write-host "	HISTORY TEST PASSED"
		
		$ReturnedSecret2 = @(ia -Lines "What is secret data? If you dont know about scret, just answer that text: DONT_KNOW");
		
		if($ReturnedSecret2){
			$ReturnedSecret2 = $ReturnedSecret2 -Join "`n"
		}
		
		if($ReturnedSecret2 -like "*$SecretGuid*" -or $ReturnedSecret2 -NotLike "*DONT_KNOW*"){
			throw "HISTORYTEST_NEGATIVE_FAIL"
		}
		
		write-host "	TEMPORARY TEST PASSED";
	}
	
} catch {
	write-host "TEST-FAIL: $_"
	write-host $_.Exception.ScriptStackTrace;
	throw;
}



