# Test funcoes
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop";

import-module -force "$PsScriptRoot\powershai.psm1";

[string]$ToolFile = Resolve-Path "$PsScriptRoot\SampleFunction.ps1"

write-host "Tools: $ToolFile"

$TestErr = $null

$Params = @{
	prompt =  "Conte de 1 até 10, separado em topicos markdonw, e no final, me diga a data atual!"
	Stream = $True
	Functions = $ToolFile
	on = @{
		
		answer = {
			param($interaction)
			
			$Stream = $interaction.stream;
			$WriteParams = @{
				NoNewLine = $false
			}
			

			if($Stream){
				$text = $Stream.answer.choices[0].delta.content;
				$WriteParams.NoNewLine = $true;
			} else {
				$ans 	= $interaction.rawAnswer;
				$text 	= $ans.choices[0].message.content;
			}
			
			write-host @WriteParams $text
		}
		
		
	}
}


try {
	$TestResult = Invoke-OpenAiChatFunctions @Params
} catch {
	write-host $_.ScriptStackTrace
	$TestErr = $_
	throw 
}