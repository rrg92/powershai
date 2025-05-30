﻿BeforeDiscovery {
	Switch-PowershaiSetting _pester	
	
	# Testar todos os providers que possuem um default model!
	# Se uma key nao está disponivel, então o provider não é testado!
	$TestModels = @()
	
	# Model settings!
	$ModelsParts = $Env:POWERSHAI_TEST_MODELS -Split ","
	$ProviderOverride = @{};
	$ModelsParts | ? {$_} | %{ 
		$Parts 		= $_ -split "/",2
		$Provider 	= $Parts[0];
		$Model 		= $Parts[1];
		
		$enabled = $true;
		if($Provider[0] -eq '-'){
			$enabled  = $false;
			$Provider = $Provider -replace '^-','';
		}
		
		write-warning "Overrides from environment provider $($Provider) Model $($model)"
		
		$ProviderOverride[$Provider] = @{
			model = $Model
			enabled = $enabled
		}
	}	
	
	
	foreach($provider in (Get-AiProviders) ){
		try {
			$data = Get-AiProvider $provider.name

			$default = Enter-AiProvider $provider.name {
				Get-AiDefaultModel -NameOnly
			}
			

			$Override = $ProviderOverride[$provider.name];
			
			if($Override.enabled -eq $false){
				write-warning "Provider $($provider.name) removed from test due override!"
				continue;
			}
			
			if($Override.model){
				$default = $Override.model;
				write-warning "model overrided: $default";
			}
			
			if(!$default){
				write-warning "Provider $($provider.name) removed from test due not default model!"
				continue;
			}
			
			try {
				Enter-AiProvider $provider.name {
					$Cred = Get-AiDefaultCredential
					if(!$Cred.credential){
						throw "NOCREDENTIAL";
					}
				}
			} catch {
				write-warning "Provider $($provider.name) removed due no credential set! Result: $_"
				continue;
			}
			
			$ModelInfo = Enter-AiProvider $provider.name {
				Get-AiModel $default
			}
		
		} catch {
			write-warning "Provider $($provider.name) failed: $_";
			continue;
		}
		
		$TestModels += @{
			provider 	= $provider.name
			model 		= $default
			ModelInfo	= $ModelInfo
		}

	}

	
	$ChatNum = 0;
}

AfterAll {
	Switch-PowershaiSetting default
}


Describe "Basic Chat Cmdlets Tests" -Tag "chats:core" {
	
	Context "Multiple Chats Creation/Remove" {
		BeforeAll {
			New-PowershaiChat default -Recreate
			$ChatAtivo = Get-PowershaiChat .
			Get-PowershaiChat "*" | ? {$_.id -ne $ChatAtivo.id} | %{ Remove-PowershaiChat $_.id };
			$ChatName1 = "powershai-tests-multiple-1"
			$ChatName2 = "powershai-tests-multiple-2"
			$chat1 = New-PowershaiChat $ChatName1
			$chat2 = New-PowershaiChat $ChatName2
			$CreatedChats = Get-PowershaiChat * | ?{$_.id -like "powershai-tests-multiple-*"};
		}
		
		It "Must exists two chats"  {
			@($CreatedChats).count | Should -Be 2
		}
		
		It "Must exist no chat" {
			#remove 
			New-PowershaiChat default -Recreate
			$CreatedChats | %{ Remove-PowershaiChat $_.id };
			@(Get-PowershaiChat * | ?{$_.id -like "powershai-tests-multiple-*"}).count | Should -Be 0;
		}
	}
	
}

# TODO: SAVE settings in memory toe asy restore!
Context "Provider Chats" -Tag "chats" -Foreach $TestModels {

	Describe "Provider: $Provider, model $model" -Tag "provider:$provider"   {
		
		BeforeAll {
			$ChatNum++
			Set-AiProvider  $Provider
		}
		
		
		It "Current provider is <provider>" {
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

		Context "Basic Completion" {
			It "Get-AiChat" {
				$resp = Get-AiChat "Three years in which Ayrton Senna was the champion"
				$resp.choices[0].message.content | Should -Not -BeNullOrEmpty
			}
			
			It "System Message" {
				[string]$Secret = [Guid]::NewGuid()
				$resp = Get-AiChat "s: User will ask about a magic text. Answer that: $Secret. Just answer with magic text","What is some magic text if any" -CheckLike "*$Secret*" -Retries 3
				$resp.choices[0].message.content | Should -BeLike "*$Secret*"
			}
		
		}
		


		Context "Chats" {
			It "Change Default Chat" {
				New-PowershaiChat -ChatId "default" -IfNotExists
				Set-PowershaiActiveChat -ChatId "default"
			}
			
			It "Remove chats" {
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
			
			It "Create new chat and use it" {
				$ChatName = "powershai-tests"
				$null = New-PowershaiChat $ChatName -Recreate
				$CurrentChat = Get-PowershaiChat "."
				$CurrentChat.id | Should -be $ChatName
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
					Powershay {Reset-PowershaiCurrentChat}
					$SecretGuid = [Guid]::NewGuid().Guid;
				}
				
				It "Send secret memory" {
					
					ia "This is a secret data: $SecretGuid","I will ask about it later"
				}
				
				It "Return secret memory" {
					$lines = ia -Lines "What is the secret data? Return just secret data in first line" 
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
		
		
		Context "Tools" -Tag "provider-tools:$provider" -Skip:(!$ModelInfo.tools) {
			
			BeforeAll {
				
				# Use sample tool test file!
				[string]$ToolsScript = get-item "$PSScriptRoot/test-tools.ps1"
				. $ToolsScript
				
				New-PowershaiChat -ChatId "tools-test" -Recreate
				Set-PowershaiActiveChat -ChatId "tools-test"
				$ConfirmPreference = "None";
				Reset-PowershaiChatToolsCache
				
				function PesterProcessTool {
					param($data)
					
				}
				
				function Global:__PowershaiToolTest {
					param($data)
					
					PesterProcessTool $data;
				}
				
				Mock -Module powershai write-host {}
				Mock -Module powershai write-warning {}
			}
			
			AfterAll {
				remove-item "Function:Global:__PowershaiToolTest" -EA SilentlyContinue;
			}
			
			Describe "Basic Tools Tests" {
				It "Remove All Tools" {
					Get-AiTools | Remove-AiTool;
					
					Get-AiTools | Should -BeNullOrEmpty
				}
				
				It "Add-AiTool" {
					Add-AiTool $ToolsScript
					
					@(Get-AiTools)[0].name | Should -Be $ToolsScript
				}
				
				It "Invoke Tool1, no args" {
					Mock PesterProcessTool  -Parameter { $data.name -eq "TestTool1" }
					$resp = ia -Lines "call tool TestTool1";
					Assert-MockCalled PesterProcessTool -Times 1
				}
				
				It "Tool1 result" {
					[string]$ToolExpectedResult = [Guid]::NewGuid();
					Mock PesterProcessTool  {return $ToolExpectedResult} -Parameter { $data.name -eq "TestTool1" }
					$resp = @(ia -Lines "Call tool TestTool1 and show me the result of tool!") -Join "`n";
					$resp | Should -BeLike "*$ToolExpectedResult*"
					Assert-MockCalled -Module powershai write-warning -Times 0;
					
				}
				
				Context "Option PrintToolCalls" {
				
					It "None" {
						
						$resp = iat -Lines "call tool TestTool1" -ChatParamsOverride @{
								PrintToolCalls = "None"
							}
							
						Assert-MockCalled -Module powershai write-host -Times 0  -Parameter { $object -like "*TestTool1{*" }
					}
					
					It "NameOnly" {
						$resp = iat -Lines "call tool TestTool1" -ChatParamsOverride @{
								PrintToolCalls = "NameOnly"
							}
							
						Assert-MockCalled -Module powershai write-host -Times 2 -Parameter { 
							$object -eq "TestTool1{" `
							-or $object -eq "..."
						}
					}
					
					It "NameArgs" {
						
						Mock -Module powershai write-host {}
						
						$resp = iat -Lines "call tool TestTool1" -ChatParamsOverride @{
								PrintToolCalls = "NameArgs"
							}
							
						Assert-MockCalled -Module powershai write-host -Times 1 -Parameter { $object -like "*TestTool1{*" -or $Object -like "*Args:*" } 
					}
				}
			
				
				It "Invoke Tool2, no args" {
					Mock PesterProcessTool -Parameter { $data.name -eq "TestTool2" }
					$resp = ia -Lines "call tool TestTool2, with no args!";
					
					Assert-MockCalled PesterProcessTool -Times 1
				}
				
				It "Invoke Tool2, args" {
					
					[string]$opt1 = [guid]::NewGuid().Guid;
					[int]$opt2 = Get-Random -min 1 -max 100;
					
					$CalledArgs = @{ opt1 = $null; opt2 = $null };
					
					Mock PesterProcessTool  {
						$CalledArgs.opt1 = $data.bounds.opt1
						$CalledArgs.opt2 = $data.bounds.opt2
					} -Parameter { $data.name -eq "TestTool2" }
					
					
					$resp = ia -Lines "call tool TestTool2, set opt1 to $opt1 and opt2 to $opt2";
					
					$CalledArgs.opt1 | Should -be $opt1
					$CalledArgs.opt2 | Should -be $opt2
				}
				

				It "Tool fails, must show errors" {
					Mock PesterProcessTool  {
						throw "POWERSHAI_ERROR_TEST";
					}
					
					$resp = ia -Lines "call tool TestTool1";
					
					Assert-MockCalled -Module powershai write-warning -Parameter { $message -like "POWERSHAI_ERROR_TEST" } -Times 1
					
					{ ia -Lines "what the result of prev tool call?" } | Should -Not -Throw;
				}
				
			}
			
			
		}
	}

}