@{
    PowerShellVersion 	= "3.0.0"
    ModuleVersion  		= "0.7.2"
	RootModule 			= 'powershai.psm1'
	Author				= 'Rodrigo Ribeiro Gomes'
	Description 		= "Access AI capabilities directly from PowerShell"
	CompanyName 		= 'IA Talking'
	Copyright 			= '(c) IA Talking. Todos os direitos reservados'
	GUID 				= "c8a0bae0-f6b2-41e6-a5de-c39e929ae0ea"
	FunctionsToExport	= "*"
	CmdletsToExport  	= "*"
	AliasesToExport   	= "*"
	HelpInfoURI 		= "https://github.com/rrg92/powershai"
	FormatsToProcess 	= @(
							"Powershai.format.ps1xml"
						)
	PrivateData 		= @{
							PSData = @{
								Tags = 'ai','openai','google','gemini','ollama','ia'
								LicenseUri = 'https://github.com/rrg92/powershai/blob/main/LICENSE'
								ProjectUri = 'https://github.com/rrg92/powershai'
								IconUri = 'https://iatalk.ing/powershai85.png'
							}
						}

}

