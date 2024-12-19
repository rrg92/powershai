BeforeAll {
	import-module ./powershai -force;
}
	
Describe "Get-AiChat" -Tags "get-aichat" {
	
	BeforeAll {
		Set-AiProvider openai;
		
		$Control = @{
			num = 0;
		}
		
		$CustomMessaege = @{
			model 	= "pester-test"
			choices	= @(
				@{
					message = @{
							content = "test123";
						}
				}
			)
		}
		
		# Control output!
		Mock -module powershai openai_Chat {
			
			return $CustomMessaege
		}
		
		Mock -module powershai Get-AiModel {
			return @{ tools = $false }
		}
		
	}
	
	
	It "Returning test message" {
		$resp = Get-AiChat;
		
		$resp.choices[0].message.content | Should -be "test123"
	}
	
	
	It "Returning, content only" {
		$resp = Get-AiChat -ContentOnly;
		
		$resp | Should -be "test123"
	}
	
	It "Retry Logic retries" {
		$MaxTries = Get-Random -Min 2 -Max 5;
		{ Get-AiChat -Check "test456" -Retries $MaxTries} | Should -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times $MaxTries;
	}
	
	It "Retry Logic retries" {
		$MaxTries = Get-Random -Min 2 -Max 5;
		{ Get-AiChat -Check "test456" -Retries $MaxTries} | Should -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times $MaxTries;
	}
	
	It "Retry Logic, check like" {
		$CustomMessaege.choices[0].message.content = "Powershai Test 123";
		
		{$resp = Get-AiChat -CheckLike "*Test*" -Retries 2} | Should -Not -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times 1;
		
		{$resp = Get-AiChat -CheckLike "*NotTest*" -Retries 2} | Should -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times 2;
	}
	
	It "Retry Logic, check regex" {
		$CustomMessaege.choices[0].message.content = "Powershai Test 123";
		
		{$resp = Get-AiChat -CheckRegex 'Test \d+' -Retries 2} | Should -Not -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times 1;
		
		{$resp = Get-AiChat -CheckRegex 'Test$' -Retries 2} | Should -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times 2;
	}
	
	It "Retry Logic, check json" {
		$CustomMessaege.choices[0].message.content = @{
			a = 1
			b = "String"
			c = @{
					c1 = "c.c1"
					c2 = "c.c2"
				}
			d = @(
					@{ id = 0 }
					@{ id = 1 }
				)
		} | ConvertTo-Json
		
		
		$schema = @{
			a = [int]
			b = [string]
			c = @{
					c1 = [string]
					c2 = [string]
				}
			d = @{
					'$schema' = [array]
					id = [int]
				}
		}
		
		{$resp = Get-AiChat -CheckJson $schema  -Retries 2} | Should -Not -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times 1;
		
		$schema.a = [string];
		
		{$resp = Get-AiChat -CheckJson $schema  -Retries 5} | Should -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times 5;
	}
	
	
	It "Retry Logic, custom script" { 
		$CustomMessaege.choices[0].message.content = "Test123";
		
		$CheckScript  = {
			$_.choices[0].message.content -eq "Test123";
		}
		
		{$resp = Get-AiChat -CheckJson $CheckScript -Retries 2} | Should -Not -Throw
		
		
		$CheckScript  = {
			$_.model -ne $CustomMessaege.model
		}
		{$resp = Get-AiChat -CheckJson $CheckScript -Retries 5} | Should -Throw
		Assert-MockCalled -ModuleName powershai openai_Chat -Times 5;
		
		
	}
	
	
}
		
		
		
Describe "Invoke-AiChatTools" -Tags "invoke-chattools","chattools" {

	BeforeAll {
		Set-AiProvider openai;
		
		[Collections.ArrayList]$Tools = @()
		$CustomMessage = @{
			model 	= "pester-test"
			choices	= @(
				@{
					message 		= @{
							content 		= "test123"
							tool_calls 		= $Tools 
							role 			= "assistant"
						}
					finish_reason 	= "tool_calls"	
				}
			)
		}
		
		# Control output!
		Mock -module powershai openai_Chat {
			return $CustomMessage
		}
		
		Mock -module powershai Get-AiModel {
			return @{ tools = $true }
		}
		
	}
	
	Context "Get-OpenaiToolFromScript, ScriptBlock" {
		BeforeAll {
			[string]$CallToken = [guid]::NewGuid();
			
			$ToolsScript = {
				param($data)
				
				function Test1 {
					<#
						.SYNOPSIS 
							Test 1
					#>
					param()		

					$CustomMessage.choices[0].finish_reason 	= "stop";
					$CustomMessage.choices[0].message.content 	= $CallToken;
					
					return "ToolResult:$CallToken";
				}
				
				function Test2 {
					<#
						.SYNOPSIS 
							Test 2
					#>
					param(
						#Param1
						$obj 
						
						
						,#Param2 
						[string]$Param2
						
						,#Param3 
						[int]$Param3
					)
					
					$CustomMessage.choices[0].finish_reason 	= "stop";
					$CustomMessage.choices[0].message.content 	= $CallToken;
					
					return $obj,$Param2,$Param3;
				}
				
			}
			
			
			$OpenaiTools 	= Get-OpenaiToolFromScript $ToolsScript -Vars @{
					CallToken 		= $CallToken
					CustomMessage 	= $CustomMessage
				}
			
		
			
		}
		
		Describe "No Args" {
			BeforeAll {
				$Tools.Clear();
				$null = $Tools.Add(@{
					id = "call_pestertest"
					type = "function"
					function = @{
						name = "Test1"
						arguments = '{}'
					}
				})
				
				$resp 	= Invoke-AiChatTools "teste" -tools $OpenaiTools
			}
			
			It "Max 2 interactions: user prompt and tool call result" {
				$resp.interactions.count | Should -Be 2
			}
			
			It "Last interaction: last sent must be the function call result" {
				$resp.interactions[-1].sent.prompt[-1].content | Should -be "ToolResult:$CallToken"
			}
			
			It "Must return the final model answer" {
				$resp.answer.choices[0].message.content | Should -Be $CallToken;
			}
		}
		
		Describe "Check Args" {
			BeforeAll {
				$Tools.Clear();
				$ToolArgs = @{
					obj 	= [guid]::NewGuid().Guid
					Param2 	= [guid]::NewGuid().Guid 
					Param3 	= (Get-Random -Min 1 -Max 100)
				}
				
				$null = $Tools.Add(@{
					id = "call_pestertest"
					type = "function"
					function = @{
						name 		= "Test2"
						arguments 	= $ToolArgs | ConvertTo-Json -Compress
					} 
				})
				

				$CustomMessage.choices[0].finish_reason 	= "tool_calls";
				$CustomMessage.choices[0].message.content 	= "";
				
				$resp 	= Invoke-AiChatTools "teste" -tools $OpenaiTools
			}
			
			It "Functions OpenAPI name and description" {
				 $FirstMessage = $resp.interactions[0]
				 $Functions = $FirstMessage.sent.Functions
				 
				 $Functions | %{ $_.function.name } | Should -Be "Test1","Test2"
				 $Functions | %{ $_.function.description.trim() } | Should -Be "Test 1","Test 2"
			}
			
			It "Functions OpenAPI args" {
				 $FirstMessage 	= $resp.interactions[0]
				 $Function 	= $FirstMessage.sent.Functions[-1].function
				 
				 $Function.parameters.type | Should -Be "object"
				 
				 $Function.parameters.properties.obj.type | Should -Be "string"
				 $Function.parameters.properties.obj.description | Should -Be "Param1"
				 
				 $Function.parameters.properties.Param2.type | Should -Be "string"
				 $Function.parameters.properties.Param2.description | Should -Be "Param2"
				 
				 $Function.parameters.properties.Param3.type | Should -Be "number"
				 $Function.parameters.properties.Param3.description | Should -Be "Param3"
			}
			
		}
		

	}
	

	
	
	Context "Get-OpenaiToolFromCommand" {
		BeforeAll {
			$Tools.Clear();
			$CustomMessage.choices[0].finish_reason 	= "tool_calls";
			$CustomMessage.choices[0].message.content 	= "";
			$null = $Tools.Add(@{
				id = "call_pestertest"
				type = "function"
				function = @{
					name = "PesterTestTool1"
					arguments = '{}'
				}
			})
			
			[string]$CallToken = [guid]::NewGuid();
			
			function Global:PesterTestTool1 {
					<#
						.SYNOPSIS 
							Test 1
					#>
					param()	
					

					$CustomMessage.choices[0].finish_reason 	= "stop";
					$CustomMessage.choices[0].message.content 	= $CallToken;
					
					return "ToolResult:$CallToken";
				}
			
			
			$t 	= Get-OpenaiToolFromCommand PesterTestTool1
			$resp 	= Invoke-AiChatTools "teste" -tools $t
			
			# Control output!
			Mock -module powershai openai_Chat {
				return $CustomMessage
			}
			
			Mock -module powershai Get-AiModel {
				return @{ tools = $true }
			}
		}
		
		AfterAll {
			Remove-Item "Function:Global:PesterTestTool1"
		}
		
		It "Max 2 interactions: user prompt and tool call result" {
			$resp.interactions.count | Should -Be 2
		}
		
		It "Last interaction: last sent must be the function call result" {
			$resp.interactions[-1].sent.prompt[-1].content | Should -be "ToolResult:$CallToken"
		}
		
		It "Must return the final model answer" {
			$resp.answer.choices[0].message.content | Should -Be $CallToken;
		}
	}
	
}