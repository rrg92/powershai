# Sample Tool Test File


function ScriptFileTool1 {
	<#
		.SYNOPSIS 
			tool 1
	#>
	param(
		$data
	)
	
	return "FromScript:$data"
}