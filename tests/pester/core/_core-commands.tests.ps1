Describe "Provider Commands" -Tag "basic","core:providers"  {
	BeforeAll {
		
		function GetOtherProvider {
			$CurrentProvider = Get-AiCurrentProvider
			$NewProvider = @(Get-AiProviders | ? {$_.name -ne $CurrentProvider.name} | Get-Random)[0]
			
			return @{
				current = $CurrentProvider.name
				other = $NewProvider.name
			}
		}
		
	}
	
	It "Change current provider" {
		$TestData = GetOtherProvider;
		Set-AiProvider $TestData.other
		$CurrentProvider = Get-AiCurrentProvider
		$CurrentProvider.name | Should -not -be $TestData.current
	}
	
	It "Enter Provider" {
		$TestData = GetOtherProvider
		
		Enter-AiProvider $TestData.other {
			
			$Current = Get-AiCurrentProvider
			
			$Current.name | Should -Be $TestData.other
		}
		
		$Current = Get-AiCurrentProvider
		$Current.name | Should -Be $TestData.current;
	}
	
	
	# Enter-AiProvider $provider.name
	
	
}

