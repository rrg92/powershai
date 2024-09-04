describe "Set-AiProvider HuggingFace" {
	
	it "Changing current provider to Hugging Face, must change in Get-AiCurrentProvider!" {
		
		Set-AiProvider huggingface;
		(Get-AiCurrentProvider).name | Should -Be "huggingface"
	}
	
	
	
	
	
}