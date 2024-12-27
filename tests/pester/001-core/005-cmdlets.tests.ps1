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

	Context "ConvertTo-OpenaiTool " -Tags "ConvertTo-OpenaiTool" {
		BeforeAll {
			function PesterTestTool1 {
				<#
					.SYNOPSIS 
						Test Tool 1
				#>
				param(
					#Param1
					[Parameter(Mandatory)]
						$p1
					
					,#Param2	
						[int]$p2
						
					,#Param3
						$p3
				)
			}
				
			$Cmd 	= Get-Command PesterTestTool1
			$Help 	= Get-Help PesterTestTool1 
			$Tool 	= ConvertTo-OpenaiTool $Cmd -Help $Help
		}
		
		It "Tool basic info: name,description,type" {
			$tool.type | Should -Be "Function"
			$tool.function.description | Should -BeLike "*Test Tool 1*"
			$tool.function.name | Should -BeLike "PesterTestTool1"
			
		}
		
		Context "Tool parameters"  {
			BeforeAll {
				$ParamList = $tool.function.parameters.properties;
			}
			
			It  "Type = Object" {
				$tool.function.parameters.type | Should -Be object
			}
			
			It "Required parameters"  {
				$tool.function.parameters.required | Sort-Object |Should -Be @('p1')
			}
			
			Context "Params Tests" -ForEach @(
				@{ ParamName = "p1"; ParamDescription = "Param1"; ParamType="string" }
				@{ ParamName = "p2"; ParamDescription = "Param2"; ParamType="number" }
				@{ ParamName = "p3"; ParamDescription = "Param3"; ParamType="string" }
			){
				Context "Param $ParamName" {
					It "description" {
						$ParamList[$ParamName].description | Should -be $ParamDescription
						$ParamList[$ParamName].type | Should -be $ParamType
					}
				}	
			}

		}
	
		Context "Custom Schema" {
			
			BeforeAll {
				
				$Cmd 	= Get-Command PesterTestTool1
				$Help 	= Get-Help PesterTestTool1 
				
				
				$Tool 	= ConvertTo-OpenaiTool $Cmd -Help $Help -JsonSchema @{
						parameters = @{
							properties = @{
								p3 = @{
									properties = @{
										a = @{ description = "p3.a" }
									}
								}
							}	
						}
					}
				
			}
			
			It "Param Custom Schema"  {
				$p3 = $Tool.function.parameters.properties.p3;
				
				$p3.properties.a.description | Should -Be "p3.a"
			}
			
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
				} -JsonSchema @{
					Test2 = @{
						obj = @{
							properties = @{
								b1 = @{ type = "int" }
							}
						}
					}
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
				 
				 $Functions | %{ $_.function.name } | Sort-Object | Should -Be "Test1","Test2"
				 $Functions | %{ $_.function.description.trim() } | Sort-Object | Should -Be "Test 1","Test 2"
			}
			
			Context "Functions OpenAPI args" {
				 BeforeAll {
					$FirstMessage 	= $resp.interactions[0]
					$Function 	= ($FirstMessage.sent.Functions | ? { $_.function.name -eq "Test2" } | select -first 1).function
				 }
				 
				 It "Default Basic Schema" {
					 $Function.parameters.type | Should -Be "object"
					 
					 $Function.parameters.properties.obj.type | Should -Be "string"
					 $Function.parameters.properties.obj.description | Should -Be "Param1"
					
					 
					 $Function.parameters.properties.Param2.type | Should -Be "string"
					 $Function.parameters.properties.Param2.description | Should -Be "Param2"
					 
					 $Function.parameters.properties.Param3.type | Should -Be "number"
					 $Function.parameters.properties.Param3.description | Should -Be "Param3"
				 }
				 
				 It "Custom Schema" {
					 $Function.parameters.properties.obj.properties.b1.type | Should -Be "int"
				 }
			}
			
		}
		

		
		Describe "No Args" {
			BeforeAll {
				$CustomMessage.choices[0].finish_reason 	= "tool_calls";
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
			
			It "Inexistent function" {
				$CustomMessage.choices[0].finish_reason 	= "tool_calls";
				$Tools[0].function = @{
					name 		= "InexistenteTool"
					arguments 	= @()
				}
				
				{ Invoke-AiChatTools "teste" -tools $OpenaiTools -MaxInteractions 2 } | Should -Throw
			}
		}
		
		
		Describe "Muliple Scripts" {
			BeforeAll {
				
				$ToolsScriptBlock = {
					param($data)
					
					function Test1 {
						<#
							.SYNOPSIS 
								Test 1
						#>
						param()		

						return "123";
					}
				}
				
				[string]$ToolsScriptFile = Resolve-Path "$PsScriptRoot/TestToolScript.ps1"
				
				
				$ScriptBlockTools 	= Get-OpenaiToolFromScript $ToolsScriptBlock
				$ScriptFileTools	= Get-OpenaiToolFromScript $ToolsScriptFile
				

				
				$Tools.Clear();
				$null = $Tools.Add(@{
					id 			= "call_pestertest"
					type 		= "function"
					function 	= @{
								name = "Test1"
								arguments = '{}'
					}
				})
				
				
			}
			
			It "Invoke ScriptBlock Tool" {
				$CustomMessage.choices[0].finish_reason 	= "tool_calls";
				$Tools[0].function.name = "Test1";
				$resp 	= Invoke-AiChatTools "teste" -tools $ScriptBlockTools,$ScriptFileTools -MaxInteractions 2
				
				
				$CallMsg 	= $resp.interactions[-1].sent.prompt[1]
				$CallResult = $resp.interactions[-1].sent.prompt[2]
				
				$CallMsg.tool_calls.function.name | Should -Be "Test1"
			}
			
			It "Invoke ScriptFile Tool" {
				$CustomMessage.choices[0].finish_reason 	= "tool_calls";
				$Tools[0].function = @{
					name 		= "ScriptFileTool1"
					arguments 	= (@{ data = "teste" } | ConvertTo-Json -Compress)
				}
				
				$resp 	= Invoke-AiChatTools "teste" -tools $ScriptBlockTools,$ScriptFileTools -MaxInteractions 2
				
				
				$CallMsg 	= $resp.interactions[-1].sent.prompt[1]
				$CallResult = $resp.interactions[-1].sent.prompt[2]
				$CallMsg.tool_calls.function.name | Should -Be "ScriptFileTool1"
				$CallResult.content | Should -Be "FromScript:teste"
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