# Sample Tool Test File


function TestTool1 {
	<#
		.SYNOPSIS 
			The Test Tool 1. No arg!
	#>
	param()
	
	
	# essa funcao será criada pelo pester durante os testes!
	__PowershaiToolTest  @{
		name 	= $MyInvocation.MyCommand.name
		args 	= $Args 
		bounds 	= $PsBoundParameters
	}
	
}


function TestTool2 {
	<#
		.SYNOPSIS 
			The Test Tool 2
	#>
	param(
		#Arg Option 1
		[string]$opt1
		
		,#Arg Option 2
		[int]$opt2 
	)
	
	
	# essa funcao será criada pelo pester durante os testes!
	__PowershaiToolTest  @{
		name 	= $MyInvocation.MyCommand.name
		args 	= $Args 
		bounds 	= $PsBoundParameters
	}
	
}