BeforeAll {
	Switch-PowershaiSetting pester
	Set-AiProvider google
	
	
}

AfterAll {
	Switch-PowershaiSetting default
}
	
	
Describe "Google Provier Tests" -Tags "google","provider:google" {
	
	Describe "Basic Prompt Commands" {
		
		Context "Openai Message to Google Content Message" {
			It "Simple Text Messages" {
				$GoogleMessage = ConvertTo-GoogleContentMessage "s: SystemPromptTest","UserMessageTest"
				
				$GoogleMessage.SystemMessage | Should -Be "SystemPromptTest"
				$GoogleMessage.content.count | Should -Be 1
				$GoogleMessage.content[0].role | Should -Be "user"
				$GoogleMessage.content[0].parts[0].text | Should -Be "UserMessageTest"
			}
			
		}
		
		
		
	}
	
	
}
