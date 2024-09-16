function JoinPath {
	[CmdletBinding()]
	param(
		[Parameter(ValueFromRemainingArguments)]
		$PathParts = @()
		
		,[switch]$Resolve
	)

	$Path = ($PathParts -Join [IO.Path]::DirectorySeparatorChar)
	
	if($Resolve){
		$Path = Resolve-Path $Path;
	}
	
	return $Path;
}


function CheckPowershaiRoot {
	# Check if running from project root!
	$proof = get-item (JoinPath powershai powershai.psm1) -EA SilentlyContinue

	if(!$proof){
		throw "CurrentDir must be PowershAI project root";
	}
}

# Replace $VARNAME in strings by variabel found $Vars hashtable!
# \$VARNAME is escapdd as $VarName.
function ReplaceVars($Str,$Vars){
	
	if(!$Vars){
		return $Str;
	}
		
	$ReplaceFunc = {
		param($m)

		[string]$VarName 	= $m.Groups['VarName'];
		[string]$PrevChar 	= $m.Groups['PrevChar'];
		
		if($PrevChar -eq '\'){
			return '$' + $VarName;
		}
		
		$VarValue = $Vars[$VarName]
		return $PrevChar+$Vars[$VarName];
	}
	
	$lines = @();
	foreach($Str in @($Str)){
		$lines += [regex]::Replace($str,'(?<PrevChar>.)\$(?<VarName>\w+)',$ReplaceFunc);
	}
	
	return $lines;
}


# Get HeaderShorts!
# This are codes used by automatic doc scripts to flag sections that contains a header with specific name!
function GetHeaderShorts {
	return @{
		'Short' 	= "SHORT DESCRIPTION"
		'Long' 		= "LONG DESCRIPTION"
		'Ex' 		= "EXAMPLES"
		'Note' 		= "NOTE"
		'Troub' 	= "TROUBLESHOOTING NOTE"
		'Also' 		= "SEE ALSO"
		'Kw' 		= "KEYWORDS"
		'Synop'		= 'SYNOPSIS'
		'Syntax'	= 'SYNTAX'
		'Inputs'	= 'INPUTS'
		'Outputs'	= 'OUTPUTS'
		'Notes'		= 'NOTES'
		'Links'		= 'RELATED LINKS'
		"Desc"		= 'DESCRIPTION'
		"Params"	= 'PARAMETERS'
	}
}

# Write text to utf8bom file!
function WriteFileBom {
	param([string]$Path, $content)
	
	$Content = @($Content) -Join "`n"
	$Utf8Bom = New-Object System.Text.UTF8Encoding $true;
	
	[System.IO.File]::WriteAllText($Path,$Content,$Utf8Bom)
}

function GetCommonParamsNames
{
	[CmdletBinding()]
	param()
	$MyInvocation.MyCommand.Parameters.Keys
}

# retorna a lista de parametros do caller!
# Return caller function param list
function GetMyParams(){

	$cmd = Get-PSCallStack
	$Caller = $cmd[1];
	
	$CmdParams = @($Caller.InvocationInfo.MyCommand.Parameters.values)
	
	$ParamList = @{};
	
	$CommonParams = GetCommonParams
	
	foreach($Param in $CmdParams){
		if($Caller.InvocationInfo.MyCommand.CmdletBinding){
			if($Param.name -in $CommonParams){
				continue;
			}
		}
		
		$ParamList[$Param.name] = Get-Variable -Name $Param.name -Scope 1 -ValueOnly -EA SilentlyContinue
		
	}
	
	
	
	return @{
		bound 	= $ParamList
		args 	= $Caller.InvocationInfo.UnboundArguments
		caller 	= $Caller
	}
}

function HelpSkeleton {
    <#
    .SYNOPSIS
		SkeletonHelp. To be used by ParseCommandHelp.

    .DESCRIPTION
		ParseCommandHelp helper!

    #>
	
	$Cmd = $MyInvocation.MyCommand
	
	if(!$Cmd.MyHelp){
		$Cmd | Add-Member Noteproperty MyHelp (Get-Help -Full $Cmd)
	}
	
	return $Cmd.MyHelp;
}



# Extrai todas as secoes de um help, ja no formato texto, pronto para ser exportado para outros formatos, como markdonw, platyps, etc.
function ParseCommandHelp {
	param(
		$Command
	)
	
	$Cmd = Get-Command $Command;
	$HelpSkel = HelpSkeleton
	
	
	$CommonParams = GetCommonParamsNames

	#ordena uma lista de parametros de um comando. 
	#Exclui os parametros common,se o comando é cmdletbinding.
	Function SortedParams {
		param($ParamNames, $Cmd)
		
		@($ParamNames | ?{
			if($Cmd.CmdletBinding -and $_  -in $CommonParams){
				return $false;
			}
			
			return $true;
		} | Sort-Object) -Join ","
	}
	
	$CmdHelp = Get-Help -Full $Cmd;
	
	$ParsedCommand = [PsCustomObject]@{
		name 			= $Cmd.Name
		synopsis 		= ""
		syntax 			= @{} 	# per set!
		description		= ""
		parameters 		= @()	
		examples 		= @()	
		SrcCommand 		= $Cmd
		SrcHelp 		= $CmdHelp
	}

	
	$ParsedCommand.synopsis 	= $CmdHelp.synopsis
	$ParsedCommand.description 	= $CmdHelp.description| ?{$_.text -and $_.text.trim()}|%{$_.text.trim()}
	

	# discover parameter sets!
	# syntax depends no parameter sets, but get-help dont expose complete information that links each syntax to parameter set!
	# so, we need manually build parameter list for each set and compare with parameters of each syntax!
	
	#Here, building list of parameters sets and its parameters!
	$ParamSets = @()
	if($Cmd.ParameterSets){
		$Cmd.ParameterSets | %{
			$ParamSets += [PsCustomObject]@{
				name 			= $_.name
				SortedParams	= (SortedParams ($_.parameters|select -exp name) $cmd) # The param list of this set, sorted determinic way to allow find and compare.
				selected		= $false
				params 			= $_.parameters
			}
		}
	} else {
		$ParamSets += @{
				name 			= '__AllParameterSets'
				SortedParams	= (SortedParams @($Cmd.parameters.keys) $cmd) # The param list of this set, sorted determinic way to allow find and compare.
				selected 		= $false
				params 			= $Cmd.parameters
			}
	}

	
	#Lets iterative over each syntaxm and build it!
	$Syntaxes = @();
	$SyntaxItemsBackup = @($CmdHelp.syntax.syntaxItem)
	foreach($Syntax in $SyntaxItemsBackup){
		
		# each syntax is unique for each parametrr set!
		# but get-help dont returns information about which parameter set is...
		# So, we need compare exactly parameters...
		
		# first, let generate sorted param names, like we do in sets..
		$SetName 		= $null
		$SortedParams 	= SortedParams ($Syntax.parameter|select -exp Name) $cmd
		
		# Now, lets find the set that contains exactly this param list.
		# If two sets same same list, we will pickup one of them only. (besides dont see pratical appplication this, powershell still allow that situation).
		$MySet = $ParamSets | ? { $_.SortedParams -eq $SortedParams -and !$_.selected } | select -first 1;
		
		# if dont found a set, this is a erro!
		# We myst always found a set!
		if(!$MySet){
			$ExtraInfo = @{
				ParamSets = $ParamSets
				Command = $Cmd 
				Sorted = $SortedParams
				Syntax = $Syntax
			}
			
			$msg = "POWERSHAI_PARSECOMMANDHELP: ParameterSet not found for Syntax. Command = $($Cmd.Name). Param: $($SortedParams)";
			$Ex = New-Object System.Exception($msg)
			$Ex | Add-Member Noteproperty ExtraInfo $ExtraInfo;
			
			throw $Ex
		}
		
		# Mak as selected. Next syntax will not find that.
		$MySet.selected = $true;
		
		#Little hack. We just reuse powershell way to represenate syntax (the convetino used, using square brackets, types, etc.)
		# WE dont want implementa a new code to that (revinet whell).
		# Ou can use own powershell defaul formatting to generate that.
		# But, because it genrrate for entire syntax prop, lets replace synsItem array with just item we want get format string.
		# We will uyse help ske, because some commands can make syntax different and out-string would return a object, not syntax tex.!
		# HelpSkeleton gueranttee that!
		$HelpSkel.syntax.syntaxItem = $Syntax;
		
		#then, when .syntax is poped to out-string, it format just syntax item that we want!
		#Also, we remove empty lines, to get clean syntax!
		$ParsedCommand.syntax[$MySet.name] = @(($HelpSkel.syntax|out-string) -split "`n") | ?{$_.trim()}
	}
	
	<#
		Now, it time to work with examples!
		For example, we will add a little extension due to limitatinos of EXAMPLE. 
		Powershell comment based help allow just one line of example code in each example section.  
		We will extended that, allowing multiple lines, and title.
		Because MAML support that, we just need parse correctly to allow tools like platyps do hard work for us.
		
		We will extended just intepreting following format:
		
			.EXAMPLE	
				# First line must start with "#". This will be exported as exaple title.
				> All code lines must start with ">"
				> Every line that starts with > will be part of code block.
				
				And, for end, remarks is just the remaining part!
				
		If first line dont starts with #, then we will parse as normal format...
	#>
	
	
	$ExampleNum = 0;
	foreach($Example in $CmdHelp.examples.example){
		$ExampleNum++;
		
		$code 		= $Example.code;
		$title 		= "EXAMPLE "+$ExampleNum
		$remarks	= @($Example.remarks |%{$_.text -split "`n"}|?{$_ -and $_.trim()})
		
		#extended format
		if($code[0] -eq '#'){
			
			$title 	= $code -replace '^#',''
			$code = @()
			$rems = @()
			
			foreach($line in $remarks){
				if($line -match '^>(.*)'){
					$code += $matches[1].trim()
				} else {
					$rems += $line;
				}
			}
		}
		
		if($title){
			$title = $title.trim()
		}
		
		$ParsedCommand.examples += [PsCustomObject]@{
				title 	= $title
				code 	= $code
				remarks = $rems
				num 	= $ExampleNum
			}
	}
	

	foreach($Param in $CmdHelp.parameters.parameter){
		$ParamName = $Param.name;
		$ParamInfo = $Cmd.parameters.$ParamName;
		
		$ParsedCommand.parameters += [PsCustomObject]@{
					name 			= $Param.name
					description		= @($Param.description|%{$_.text -split "`n"}|?{$_ -and $_.trim()})
					ParamSet		= @($ParamInfo.ParameterSets.keys)
					Type 			= $Param.type.name
					Aliases 		= @($ParamInfo.Aliases)
					ValidValues 	= $null
					Required 	 	= $Param.required 
					Position 	 	= $Param.position
					Default		  	= $Param.defaultValue
					AcceptPipeline	= $Param.pipelineInput
					AcceptWildcard	= $Param.globbing
					_src 			= @{
						help = $Param
						cmd = $ParamInfo
					}
			}
	}


	return $ParsedCommand;
	
	# $Parameters = @()
	# 
	# foreach($Parameter in $CmdHelp.parameters.parameter){
	# 		
	# 	$Parameters += @(
	# 		"### $(Parameter.name)"
	# 	)
	# 	
	# }
	
	
	
	
	
	
	
	
}