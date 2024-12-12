BeforeAll {
	Switch-PowershaiSetting pester
	Set-AiProvider openai
	
	Mock -module powershai InvokeOpenai {
		return;
	}
	
	
	PesterGlobalSetup
	
	$BackupKey = $Env:OPENAI_API_KEY
	$Env:OPENAI_API_KEY = $null
}

AfterAll {
	$Env:OPENAI_API_KEY = $BackupKey
	PesterGlobalClean
	Switch-PowershaiSetting default
}
	

Describe "OPENAI Basic Credentials Tests" -Tag "core:credential","provider:openai","basic"  {
	
	

	It "Correct token set" {
		Set-AiCredential "TestCred2"
		
		InModuleScope powershai {
			$tk = GetCurrentOpenaiToken
			
			$tk | Should -be $PESTER_TEST_CREDENTIALS.GetNetworkCredential().Password
		}
	}
	
	It "Api Key Environment" {
		
		Get-AiCredentials | Remove-AiCredential;
		
		$Env:OPENAI_API_KEY = "TestKey";
		
		InModuleScope powershai {
			$tk = GetCurrentOpenaiToken
			
			$tk | Should -be $Env:OPENAI_API_KEY
		}
	}
	
	It "DuplicateDefaultError" {
		Get-AiCredentials | Remove-AiCredential;
		Set-AiCredential Openai1;
		$Env:OPENAI_API_KEY = "TestKey";
		
		{ Get-AiDefaultCredential } | Should -Throw;
	}	
		
}