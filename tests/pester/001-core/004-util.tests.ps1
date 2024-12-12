Describe "Util Commands" -Tag "basic","utils" {
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
	
	Context "HashTableMerge" {
		
		InModuleScope powershai {
			It "Merge two tables" {
				$tab = HashTableMerge @{a = 1} @{b = 2}
				
				$tab.a,$tab.b | Should -Be 1,2;
			}
			
			It "Merge two tables, overwrite" {
				$tab = HashTableMerge @{a = 1} @{a = 3}
				
				$tab.a | Should -Be 3;
			}
			
			It "Merge two tables, filter" {
				$tab = HashTableMerge @{a = 1; c = 5} @{b = 2; c = "mudar"} -filter {
					param($k)
					
					if($k.path -eq "/c"){
						
						if(!$k.current){
							return $true;
						}
						
						return $false;
					}
					
					return $true;
				}
				
				$tab.c | Should -Be 5;
			}
		}
		
	}
	
	
	
	Context "Confirm-PowershaiObjectSchema" {
		

		It "Simple Object, Valid Object" {
			$object =  @{ a = 1; b = "teste" }
			$schema = @{  
				a = [int]  
				b = [string]
			}
			$result = Confirm-PowershaiObjectSchema $object $schema
			$result.valid | Should -Be $true
		}
		
		It "Simple Object, Invalid Object" {
			$object =  @{ a = 1; b = "teste" }
			$schema = @{  
				a = [int]  
				b = [int]
			}
			$result = Confirm-PowershaiObjectSchema $object $schema
			
			
			$ValidationA = $result.validations | ? { $_.path -eq "/a" }
			$ValidationB = $result.validations | ? { $_.path -eq "/b" }
			
			$result.valid | Should -Be $false
			$ValidationA.valid | Should -Be $true
			$ValidationB.valid | Should -Be $false
			$ValidationB.IsTypeValid | Should -Be $false
		}
		
		
		It "Nested Object, Valid Object" {
			$object =  @{ 
				a = 1
				b = @{
					b1 = 123
					b2 = (Get-Date)
				}			
			}
			
			$schema = @{  
				a = [int]  
				b = @{
					b1 = [int]
					b2 = [datetime]
				}
			}
			
			$result = Confirm-PowershaiObjectSchema $object $schema
			$result.valid | Should -Be $true
		}
			
		It "Nested Object, Invalid Object, b.b2 type" {
			$object =  @{ 
				a = 1
				b = @{
					b1 = 123
					b2 = (Get-Date)
				}			
			}
			
			$schema = @{  
				a = [int]  
				b = @{
					b1 = [int]
					b2 = [int]
				}
			}
			
			$result = Confirm-PowershaiObjectSchema $object $schema
			$result.valid | Should -Be $false
		}
			
		It "Nested Object, Invalid Object, b type" {
			$object =  @{ 
				a = 1
				b = @{
					b1 = 123
					b2 = (Get-Date)
				}			
			}
		
			$schema = @{  
				a = [int]  
				b = [int]
			}
			
			$result = Confirm-PowershaiObjectSchema $object $schema
			$result.valid | Should -Be $false
		}
		
		It "Nested Object With Array, valid" {
			$object =  @{ 
				a = 1
				b = @{
					b1 = 123
					b2 = @(
						@{ itemNum = 0; itemName = "obj1" }
						@{ itemNum = 1; itemName = "obj2" }
					)
				}			
			}
		
			$schema = @{  
				a = [int]  
				b = @{
					b1 = [int]
					b2 = @{
						'$schema' 	= [array]
						itemNum 	= [int]
						itemName 	= [string]
					}
				}
			}
			
			$result = Confirm-PowershaiObjectSchema $object $schema
			
			$result.valid | Should -Be $true
			
		}
		
		It "Nested Object With Array, forgot `$schema" {
			$object =  @{ 
				a = 1
				b = @{
					b1 = 123
					b2 = @(
						@{ itemNum = 0; itemName = "obj1" }
						@{ itemNum = 1; itemName = "obj2" }
					)
				}			
			}
		
			$schema = @{  
				a = [int]  
				b = @{
					b1 = [int]
					b2 = @{
						#'$schema' = "array" --> simulating forgot! 
						itemNum 	= [int]
						itemName 	= [string]
					}
				}
			}
			
			$result = Confirm-PowershaiObjectSchema $object $schema
			$result.valid | Should -Be $false
		}
		
	}
}


