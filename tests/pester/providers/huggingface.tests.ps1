

describe "HuggingFace Basic Tests" -Skip -Tag "provider:hugginface" {


	describe "Basic Tests" {
		It "Enable provider" {
			Set-AiProvider huggingface;
		}
		
		It "Get spaces" {
			
		}
		
		It "Get models" {
			
		}
	}
	
	
	describe "Gradio Space Tests" -Tag "gradio" {
		
		It "Connect to Space v4" {
			
		}
		
		It "Connect to Space v5" {
			
		}
		
		It "Create Proxy Function" {
			
		}
		
		It "Pipeline using Proxy Function" {
			
		}
	}
	
	describe "Authentication" {
		It "Connect using Hugging Face Api Token" {
			
		}
	}
	
	describe "Inference Api" {
		It "Generate simple text" {
			
		}
	}
	
}