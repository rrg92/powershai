BeforeAll {
	. "$(Get-Location)/util/UtilLib.ps1"
	CheckPowershaiRoot
	
	import-module ./powershai -force;
	
	$PowerShaiModule = Get-module powershai;
	
	if(!$m){
		throw "MODULE_NOT_IMPORTED: $m";
	}
	
	
}

BeforeDiscovery {
	$ModelsParts = $Env:POWERSHAI_TEST_MODELS -Split ","
	$TestModels = $ModelsParts | %{ 
		$Parts 		= $_ -split "/",2
		$Provider 	= $Parts[0];
		$Model 		= $Parts[1];
		@{
			Provider = $Provider
			Model = $Model
		}
	}	
	
	$ChatNum = 0;
}

Describe "Provider: <Provider>, model <model>" -Foreach $TestModels {
	
	BeforeAll {
		$ChatNum++
	}
	
	It "Set current provider to  <provider>" {
		Set-AiProvider $Provider;
		(Get-AiCurrentProvider).name | Should -Be $Provider
	}
	
	It "List all available models and return name property" {
		$Script:AllModels = Get-AiModels
		$AllModels | gm | %{$_.name} | Should -Contain "name"
	}
	
	It "Default model <model> must be returned!" {
		Set-AiDefaultModel $model;
		$AllModels | ? { $_.name -like $model } | Should -Not -BeNullOrEmpty
	}
	
	Context "Chats" {
		It "Garante chat default" -Tag "base" {
			New-PowershaiChat -ChatId "default" -IfNotExists
			Set-PowershaiActiveChat -ChatId "default"
		}
		
		It "Remover todos os demais chats" -Tag "base" {
			$ChatAtivo = Get-PowershaiChat .
			Get-PowershaiChat "*" | ? {$_.id -ne $ChatAtivo.id} | %{ Remove-PowershaiChat $_.id };
		}
		
		It "Chat Screen Output" {
			Mock -ModuleName powershai write-host {}
			Mock -ModuleName powershai write-warning {}
			
			iat "Hi, this is a test from powershell ai module called Powershai";

			Assert-MockCalled -ModuleName powershai write-host
			Assert-MockCalled -ModuleName powershai write-warning
		}

		It "Pipeline context data" {
			Mock -ModuleName powershai write-host {}   -parameter { $Object -like "*two*"  }
			Mock -ModuleName powershai write-warning {}
			
			1..10 | iat "write names of that numbers in english"
			
			Assert-MockCalled -ModuleName powershai write-host 
			Assert-MockCalled -ModuleName powershai write-warning
		}
		
		It "Pipeline context foreach" {
			Mock -ModuleName powershai write-host {} 
			Mock -ModuleName powershai write-warning {}
			
			1..10 | iat -ForEach  "write names of that numbers in english"
			
			Assert-MockCalled -ModuleName powershai write-host -times 10
			Assert-MockCalled -ModuleName powershai write-warning
		}
		
		It "Basic Chat history" {		
			ia "gere 5 palavras em pt-BR"
			$lines = ia -Lines "Gere uma linha para cada nome, com a tradução para en-US" | %{ $_; write-host $_ } 
			$lines.count | Should -BeGreaterOrEqual 5
		}
		
		It "New Chat" -Tag "chatmemo" {		
			$Chat = New-PowershaiChat "Test-$ChatNum";
			
			$null = Set-PowershaiChatParameter MaxTokens 100
			
			@(Get-PowershaiChat .).id |  Should -Be "Test-$ChatNum"
			
		}
		
		Context "Chat Memory" -Tag "chatmemo" {
			
			BeforeAll {
				$SecretGuid = [Guid]::NewGuid().Guid;
			}
			
			It "Send secret memory" {
				ia "This is a secret data: $SecretGuid","I will ask about it later"
			}
			
			It "Return secret memory" {
				$lines = ia -Lines "What is the secret data? Return just secret data in first line" 
				write-host $Lines;
				@($lines -Join "`n") | Should -BeLike  "*$SecretGuid*"
			}

			It "Forget secret" {
				$Lines = ia -Lines -forget "What is the secret data? Return just secret data in first line"
				@($lines -Join "`n") | Should -not -BeLike  "*$SecretGuid*"
			}	
		}
		
		Context "Chat Params" -Tag "chatparams" {
			It "Using MaxTokens from chat parameter" {	
				$null = Set-PowershaiChatParameter MaxTokens 50;
				$null = iat "conte até 100" -lines
				$Chat = Get-PowershaiChat .
				$SentMaxTokens = $Chat.history[-1].Ret.interactions[0].sent.MaxTokens
				$SentMaxTokens | Should -Be 50
			}
			
			It "Using MaxTokens from override" {	
				$null = iat "conte até 100" -lines -ChatParamsOverride @{ MaxTokens = 150 }
				$Chat = Get-PowershaiChat .
				$SentMaxTokens = $Chat.history[-1].Ret.interactions[0].sent.MaxTokens
				$SentMaxTokens | Should -Be 150
			}
			
			It "MaxTokens default keep same" {	
				$null = Set-PowershaiChatParameter MaxTokens 50;
				$null = iat "conte até 100" -lines
				$Chat = Get-PowershaiChat .
				$SentMaxTokens = $Chat.history[-1].Ret.interactions[0].sent.MaxTokens
				$SentMaxTokens | Should -Be 50
			}
		}
		
		
	}
	
	

}