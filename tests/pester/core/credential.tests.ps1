BeforeAll {
	import-module ./powershai -force;
	PesterGlobalSetup
	Switch-PowershaiSetting _pester	
	
	$BackupEnvs = @{}
	
	# Clean environemnt credential vars!
	Get-AiProviders | % {
		Enter-AiProvider $_ {
			Get-AiCredentialEnvironmentVars | %{
				$EnvName = $_.name;
				$BackupEnvs[$_.name] = $_.value;
				Set-Item "Env:$EnvName" -Value $null
			}
		}
	}
}

AfterAll {
	PesterGlobalClean
	Switch-PowershaiSetting default
	
	# Restore env!
	@($BackupEnvs.keys) | %{
		Set-Item "Env:$_" -Value $BackupEnvs[$_];
	}
}

BeforeDiscovery {
	$Provider = Get-AiProviders | %{ 
			@{name = $_.name} 
		}
}
	
Describe "AiCredential" -Tag "credential","basic" {
	
	Context "Provider Change, Reflect Set-AiCredential" {
		
		Describe "Set-AiCredential <Name>" -ForEach $Provider {
			It "Correct alias" {
				$ProviderName = $_.name;
				$ExpectedName = "Set-AiCredential $($ProviderName)"
				Set-AiProvider $name;
				$Cmd = Get-Command Set-AiCredential;
				
				$Cmd.ResolvedCommand.name | Should -be $ExpectedName;
			}
		}
	
	}
	
	Context "Credential Operations" {
		BeforeAll {
			
			# The remaining of tests will use openai!
			Set-AiProvider openai;

			# mock to avoid http calls while testing...
			Mock -module powershai InvokeOpenai {
				return;
			}
			
			
		}
		
		It "Clean Credentials" {
			Get-AiCredentials | Remove-AiCredential;
			@(Get-AiCredentials) | Should -HaveCount 0
		}
		
		It "Create default credential" {
			
			Set-AiCredential
			
			$Creds = Get-AiCredentials
			$Creds | Should -HaveCount 1
			$Creds[0].name | Should -Be "default";
		}
		
		It "Create named credential and use as default" {
			$CredName = "PesterCredTest"
			Set-AiCredential $CredName;
			
			$Cred = Get-AiDefaultCredential
			$Cred.source | Should -Be "set:$CredName";
		}
		
		It "Multiple creds, no default: error" {
			Get-AiCredentials | Remove-AiCredential;
			Set-AiCredential Cred1
			Set-AiCredential Cred2
			Set-AiCredential Cred3
			
			Remove-AiCredential Cred3;
			
			{ Get-AiDefaultCredential } | Should -Throw
			
			Remove-AiCredential Cred2;
			
			{ Get-AiDefaultCredential } | Should -Not -Throw
			
		}
		

	}
	
}