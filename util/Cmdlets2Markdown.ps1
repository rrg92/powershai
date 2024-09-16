#
#	Converts comments docs incmdlets to markdown!
#
#		Depends of module PlatyPS
param(
	$lang = "pt-BR"
	
	#Fitlrar comandos!
	,$CommandFilter = $null
	
	,[switch]$UpdateMd
	,[switch]$UpdateFiles
)

$ErrorActionPreference = "Stop";
. (Join-Path "$PsScriptRoot" UtilLib.ps1)
CheckPowershaiRoot

$DebugInfo = @{
	files = @()
	
}

$OutputDir = JoinPath -Resolve docs $lang cmdlets

import-module -force PlatyPs;
$m = import-module .\powershai -force -passthru;




#if($UpdateMd){
#	write-host "Creating cmdlets...";
#	$NewCmdLets = New-MarkdownHelp -Force -Module $m -OutputFolder $OutputDir -Encoding (New-Object Text.UTF8Encoding $true)
#	$DebugInfo.ExportedCmdlets = $NewCmdLets;
#	write-host "	Exported cmdlets: $($NewCmdlets.count)"
#	$UpdateFiles = $true;
#}
#
#$CmdLetsMd = gci (JoinPath $OutputDir *.md)
#$DebugInfo.ListedFiles = $CmdLetsMd;
#
#
#
#$HeadersRegGroup = @()
#@($Headers.keys) | %{
#	$Name = $_;
#	$Header = $HEADERS[$_];
#	$HeadersRegGroup += "(?<Code_$Name>$Header)"
#}
#
#$HeadersOr = $HeadersRegGroup -JOin "|";
#$HeadersRegex = "#+ \b($HeadersOr)\b"



$ModCommands = Get-Command -mo powershai -CommandType Function

$CommonParams = GetCommonParamsNames

		
$ParamYmlMapping = @{
	'ParamSet' 			= 'Parameter Set'
	'ValidValues' 		= 'Accepted Values'
	'Default' 			= 'Default Value'
	'AcceptPipeline' 	= 'Accept pipeline input'
	'AcceptWildCard'	= 'Accept wildcard characters' 
}
		
$HEADERS = GetHeaderShorts
$INVERSE_HEADERS = @{}
@($HEADERS.keys) | %{ 
	$ShortName 	= $_;
	$HeaderText = $HEADERS[$ShortName];
	$INVERSE_HEADERS[$HeaderText] = "## $HeaderText <!--!= @#$ShortName !-->" 
}

function GetHeaderShort {
	param($text)
	
	$text = $text.toUpper();
	
	$NewHeader = $INVERSE_HEADERS[$text];
	
	if(!$NewHeader){
		throw "INVALID_HEADER: $text";
	}
	
	return $NewHeader;
}
		
foreach($Cmd in $ModCommands){
	

	
	$Parsed = ParseCommandHelp $Cmd;
	
	
	$PlatyMd = @(
		"---"
		"external help file: powershai-help.xml"
		"schema: 2.0.0"
		"powershai: true"
		"---"
		""
		"# $($Cmd.name)"
		""
		(GetHeaderShort SYNOPSIS)
		$Parsed.Synopsis
	)
	
	if($Parsed.description){
		$PlatyMd += @(
			""
			(GetHeaderShort DESCRIPTION)
			$Parsed.description
		)
	}


	$PlatyMd += @(
		""
		(GetHeaderShort SYNTAX)
	)
	
	if($Parsed.Syntax.__AllParameterSets){
		$PlatyMd += @(
				''
				'```'
				$Parsed.Syntax.__AllParameterSets
				'```'
			)
	} else {
		@($Parsed.Syntax.keys) | %{
			$PlatyMd += @(
				""
				"### "+$_
				'```'
				$Parsed.Syntax[$_]
				'```'
			)
		}
	}
	
	
	if($Parsed.examples){
		$PlatyMd += @(
			""
			(GetHeaderShort EXAMPLES)
		)
		
		$Parsed.examples | %{
			$PlatyMd += @(
				""
				"### " + $_.title
				'```powershell'
				$_.code
				'```'
				$_.remarks
			)
		}
	}
	
	$PlatyMd += @(
		""
		(GetHeaderShort PARAMETERS)
	)
	
	if($Parsed.parameters){
		foreach($Param in $Parsed.parameters){
			
			$ParamYaml = @()
			
			
			$Param.psobject.properties | %{
				
				if($_.name -in 'name','description' -or $_.name -Like '_*'){
					return;
				}
				
				$ParamMetaName = $ParamYmlMapping[$_.name];
				$ParamValue = $_.value;
				
				if(!$ParamMetaName){
					$ParamMetaName = $_.name;
				}
				
				if($_.name -eq "ParamSet" -and $ParamValue -eq '__AllParameterSets'){
					$ParamValue = '(All)'
				}
				
				if($ParamValue -is [array]){
					$ParamValue = $ParamValue -Join ","
				}

				$ParamYaml += "$($ParamMetaName): $ParamValue"
			}
			
			
			$PlatyMd += @(
				""
				"### -" + $Param.name
				$Param.description
				""
				'```yml'
				$ParamYaml
				'```'
			)
		}
		
	}
	
	
	$OutputFile = JoinPath $OutputDir "$($Cmd.Name).md"
	
	write-host "Writing to $OutputFile";
	WriteFileBom $OutputFile $PlatyMd;
}



#foreach($File in $CmdLetsMd){
#	
#	$FileLines = Get-Content $File;
#	
#	$FileInfo = @{
#		file = $file
#		lines = $FileLines
#		modified = $null
#	}
#	
#	$DebugInfo.files += $FileInfo;
#	
#	
#	$Modified = New-Object Collections.ArrayList;
#	$LineNum = 0;
#	$CurrentSection = ""
#	foreach($Line in $FileLines){
#		$LineNum++;
#		$NewLine = $line;
#		
#		if($Line -match $HeadersRegex){
#			$MatchedKey = $matches.keys | ? { $_ -like "Code_*" };
#			$CodeName 	= $MatchedKey.replace("Code_","");
#			$NewLine 	= $line + " <!--!= @#$CodeName -->";
#		}
#		
#		
#		$null = $Modified.Add($NewLine);
#	}
#	
#	$Modified = @($Modified)
#	$FileInfo.modified = $modified
#	
#	if($UpdateFiles){
#		write-host "Updating file $file";
#		WriteFileBom $file $Modified;
#	}
#}


write-warning "Check local FileData var to details"