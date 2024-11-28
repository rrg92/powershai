BeforeAll {
	import-module ./powershai -force;
	Switch-PowershaiSetting pester-hugginface
}

AfterAll {
	Switch-PowershaiSetting default
}

describe "HuggingFace Basic Tests" -Tag "provider:huggingface" {


	describe "Hub API" {
		It "Enable provider" {
			Set-AiProvider huggingface;
		}
		
		it "Remove all sessions" {
			Get-GradioSession | Remove-GradioSession
			
			Get-GradioSession | Should -BeNullOrEmpty 
		}
		
		It "Get spaces" {
			$TestSpace = Get-HfSpace powershai/tests-gradio
			
			$TestSpace.id | Should -be powershai/tests-gradio
			$TestSpace.author | Should -be powershai
			$TestSpace.sdk | Should -be gradio
		}
		
		It "Get models" {
			
		}
	}
	
	
	describe "Gradio Space Tests" -Tag "gradio" {
		BeforeAll {
			$TestSpace = Get-HfSpace powershai/tests-gradio;
		}
		
		It "Connect Space to Gradio Automatically" {
			$GradioSession = $TestSpace | Get-GradioSession;
			$Endpoints = $GradioSession.info.named_endpoints | gm /* | %{$_.name};
			
			$Endpoints | Should -Be '/Op1','/Op2'
		}
		
		It "Create Proxy Function" {
			$Command = $TestSpace | New-GradioSessionApiProxyFunction -Force -Prefix "PowershaiTest"
			
			$command.name | Should -Be "PowershaiTestOp1","PowershaiTestOp2"
		}
		
		It "Test Api Function Call" {
			$RandomVal = Get-Random -Min 1 -Max 1000
			$result = PowershaiTestOp1 -val $RandomVal
			$result.data | Should -BeLike "*PowershaiTest:Ok:$RandomVal**"
		}
		
		It "Test Api Pipeline" {
			$MaxNums 	= 5
			$seq = @{i=-1}
			$Expected	= @(
					"--start--"
					(1..$MaxNums | %{"$_"})
					"--end--"
				)
				
			PowershaiTestOp2 -MaxNums $MaxNums -sleep 50 | %{
				
				if(!$_.data){
					return;
				}
				
				$seq.i++
				$NextExpected = $Expected[$seq.i];
				
				if($NextExpected -eq $null){
					$NextExpected = $Expected[-1]
				}
				
				$_.data | Should -Be $NextExpected;
				$_.ts.getType().Name | Should -Be "DateTime"
			}
		}
		
		It "Test Api Pipeline Connect" {
			$MaxNums 	= 5
			$seq = @{i=-1}
			$Expected	= @(
					"--start--"
					(1..$MaxNums | %{"$_"})
					"--end--"
				)
			PowershaiTestOp2 -MaxNum $MaxNums -sleep 50 | PowershaiTestOp1 -map val=0 | %{
				
				if(!$_.data){
					return;
				}
				
				$seq.i++
				$NextExpected = $Expected[$seq.i];
				
				if($NextExpected -eq $null){
					$NextExpected = $Expected[-1]
				}
				
				$_.data | Should -BeLike "*PowershaiTest:Ok:$NextExpected*"
			}
		}
		
		
	}

	
	
}