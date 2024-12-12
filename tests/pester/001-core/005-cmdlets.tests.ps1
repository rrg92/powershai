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
		