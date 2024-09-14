<#
	doc builder Powershai!
	
	Este script deve ser usado para compilar a documentação do PowershAI.  
	Isso irá gerar os help files (.xml) com o formato esperado pelo Powershell.  
	Após isso, os commits devem ser feitos para atualizar!
	
	Este script depende do modulo PlatyPS, que é um modulo oficial do time do Powershell para faciltiar a criação da documentação!
	
	
	ESTRUTURA ESPERADA DE DOCUMENTAÇÃO:
	
		A documentação deve ser feita em markdown, seguindo a sintaxe esperada pelo PlatyPS.  
		Todos os aruqivos devem ficar no diretório docs, da raiz.  
		
		Deve existir um subdirtóerio para cada idioma, e o nome deve seguir a mesma regra de langauge code do Windows. EXemplos:
		
			pt-BR = Diretorio com a documentação em português
			en-US = Diretório com a documentação em inglês
			
			
		Em cada um dos diretórios de linguagme acima, deve haver a seguinte estrutura:
		
			<lang-dir>
				about.md
				about.md
				about.md
				about.md
				
				-dir cmdlets:
					cmdlet.md
				- dir: providers 
					<providername>
						- AboutTopic.md 
						- AboutTopic.md 
						- cmdlets 
							NomeCmdLet.md 
							NomeCmdlet.md
		
		
		Os arquivos *.about.md irão gerar about topics.
		Os arquivos *.cmdlet.md irão gerar o help de cada cmdlet.  
		
		
		O about topic gerado vai seguir uma nomencaltura conforme o diretorio.  
		Todos os abouts topics serão prefixados com about_Powershai.  
		
		O diretorio providers, deve conter um subdiretorio para cada provider.  
		Dentro deles, o arquivo README.md irá gerar o help topic do provider, com a nomencçatura base about_Powershai_Provider. 
		
		Os arquivos *.about.md irão gerar conforme nome.
		Por exemplo,  o arquivo docs/pt-BR/providers/huggingface/UsoBasico.about.md irá gerar o help topic about_Powershai_Hugginface_UsoBasico.

		Os arquvios readme.md em cada direotrio viram o help com o nome do topico base do diretorio. 
		
		Os topicos base de cada diretorio sãi:
		
			Raiz 						- about_Powershai 
			Raiz/cmdlets				- nao deve conter nenhum about topic!
			Raiz/providers 				- about_Powershai_Providers
			Raiaz/providers/<provider> 	- about_Powershai_<provider>
			
			
		Os arquivos MD podem conter expressões especiais, que chamamos de DocExpressions.  
		Essas expressões visam permitri alterar uma linha, ou bloco de linhas, enquanto permite manter a exibição do markdown limpa!  
		Quando for compilado em um help do Powershell, essas expressões serão alteradas!
		
		Sintaxe:
		
			Inline (em qualquer linga de uma linha):
				<!--! Expressao -->
			
			Multiline:
				<!--!
				Expressao
				Expressao
				!-->
	
		Expressao pode ser um dos deguintes:
		
			@Comando 
				Executa um comando que geramlente opera na linha atual!
				Comandos possiveis:
					= - Substitui o conteudo da linha atual.
								= TEXTO
							  Aceita substituição
				
			String qualquer 
				
				Exibe a string, com parse de variávies.
				Variáveis podem ser especificadas usando $Nome.
				As variaveis disponiveis são:
			
			
				
#>
param(
	#Directory where compile 
	$WorkDir
	
	,#Filter files using regex. DebugOnly.
		$FilterRegex = $null
)

$ErrorActionPreference = "Stop";

function ReplaceVars($Str,$Vars){
	
	if(!$Vars){
		return $Str;
	}
		
	$ReplaceFunc = {
		param($m)

		[string]$VarName 	= $m.Groups['VarName'];
		[string]$PrevChar 	= $m.Groups['PrevChar'];
		
		if($PrevChar -eq '\'){
			return $m.Value;
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
function ParseRun($str,$vars){
	
	$RunMode = $false;
	$RunLines = @();
	$ParsedLines = @();
	
	$Replacer = {
		param($m)
		
		[string]$Expr = $m.Groups['Expr'];
		
		if(!$Expr){
			return;
		}
		
		$Trimmed = $Expr.trim();
		
		if($Trimmed -match '^='){
			return "<@f>$Trimmed</@f>"
		}
		
		if($Trimmed -match '^@'){
			return "<@f>$Trimmed</@f>"
		}
		
		
		return (ReplaceVars @($Expr) $Vars)
	}
	
	return [regex]::Replace($str,'\<\!\-\-\!(?<Expr>.*?)\-\-\>',$Replacer, "Singleline" ); 
	
}

function JoinPath {
	return ($Args -Join [IO.Path]::DirectorySeparatorChar)
}


if(!$WorkDir -or !(Test-Path $WorkDir)){
	throw "Must inform valid directory in -WorkDir: $WorkDir"
}

[string]$DocsDir = JoinPath "$PsScriptRoot" docs;


$TempDir = (JoinPath $WorkDir "platyps")
write-host "Cleaning work dir $TempDir";
if(Test-Path $TempDir){
	Remove-item -force -recurse $TempDir;
}

write-host "Recreating dir $TempDir";
$null =New-Item -ItemType Directory -Path $TempDir

write-host "Creating lang dirs...";
$SupportedLangs = "pt-BR","en-US";
$LangDirs  = $SupportedLangs | %{  
	$DirPath = JoinPath $TempDir $_;
	
	write-host "	Creating $DirPath";
	New-Item -ItemType Directory -Path $DirPath
}

$Utf8Bom = New-Object System.Text.UTF8Encoding $true

Function ParseFile($Source,$Target,$Vars){
	

	$NewContent = ParseRun (Get-Content $Source -Raw) -Vars $Vars
	
	$Lines = $NewContent -split "`r?`n"
	
	$HEADERS = @{
		'Short' 	= "SHORT DESCRIPTION"
		'Long' 		= "LONG DESCRIPTION"
		'Ex' 		= "EXAMPLES"
		'Note' 		= "NOTE"
		'Troub' 	= "TROUBLESHOOTING NOTE"
		'Also' 		= "SEE ALSO"
		'Kw' 		= "KEYWORDS"
	}
	
	$HeaderNum = 0;
	$LineNum = 0;
	$NewLines = @();
	try {
		$BufferDefaults = @{
			active 		= $false;
			buffer 		= @()
			onStop 		= $null
			stop 		= $null
			inclusive 	= $true;
		}
		$LineBuffer = [PsCustomObject]$BufferDefaults
		
		foreach($line in $Lines){
			$LineNum++;
			
			if($LineBuffer.active){
				$MustStop = & $LineBuffer.stop
				
				if(!$MustStop){
					$LineBuffer.buffer += $line;
					continue;
				}
				
				if($LineBuffer.inclusive){
					$LineBuffer.buffer += $line
				}
				
				& $LineBuffer.onStop;
				$LineBuffer = [PsCustomObject]$BufferDefaults
				
				if($LineBuffer.inclusive){
					continue;
				}
			}
			
			# eat aidoc generated content...
			if($line -eq "<!--PowershaiAiDocBlockStart-->"){
				write-host "	Removing AiDoc block..."
				$LineBuffer.active 	= $true;
				$LineBuffer.stop 	= { $line -eq '<!--PowershaiAiDocBlockEnd-->' }
				$LineBuffer.onStop 	= { write-host "	Removed: $($LineBuffer.buffer.length) lines" };
				continue;
			}

			
			#Parse functiomns!
			if($Line -match '<@f>(.*?)</@f>'){
				$Expr = $matches[1];
						
				if($Expr[0] -eq "="){
					$NewLines += $Expr -replace '^=[\s\t]*','';
				}
						
				if($Expr[0] -eq "@"){
					switch -Regex ($Expr){
						"^\@#(.+)" { 
							$HeaderName = $matches[1];
							
							$HeaderValue = $HEADERS[$HeaderName];
							
							if(!$HeaderValue){
								throw "INVALID_HEADER: $HeaderName";
								continue;
							}
							
						
							$NewLines += "# $HeaderValue";
						}				
						
						default {
							throw "FunctionNotRecognized"
						}
					}
				}
				
				continue;
			}
			
			if($Vars.AboutTopic){
				if($LineNum -eq 2){
					$NewLines += "## " + $Vars.AboutTopic
				}	
			}

			$NewLines += $line;
		}
	
	} catch {
		$msg = "Error:$_ | Expr=$Expr, Line:$LineNum,File:$Source";
		$Ex = New-Object Exception($msg, $_.Exception)
		throw $Ex;
	}
	
	[System.IO.File]::WriteAllLines($Target,$NewLines,$Utf8Bom)
	#$NewLines, | Set-Content -Path $Target -Encoding 
}



write-host "Loading file list: $DocsDir";
$SrcLangDirs = $SupportedLangs | %{JoinPath $DocsDir $_ *.md}
write-host "	Dirs: $SrcLangDirs"
$AllMarkDowns = gci -rec $SrcLangDirs;
foreach($MdFile in $AllMarkDowns){
	
	$Vars = @{}
	
	$RelName 	= $MdFile.FullName.replace($DocsDir,"") -replace '^.',''
	$SRelPath 	= $RelName.replace([IO.Path]::DirectorySeparatorChar, '/');
	
	if($FilterRegex -and -not($SRelPath -match $FilterRegex)){
		write-verbose "File $SRelPath Filtered out by FilterRegex";
		continue;
	}
	
	write-host "File:" $SRelPath;
	$Vars.RelPath = $SRelPath
	


	$Topic = "about_Powershai";
	$FileName = $SRelPath;
	$Lang = $null
	
	if($FileName -match '^(.+?)/(.*)'){
		$Lang 		= $matches[1];
		$FileName 	= $matches[2];
	}
	
	if($Lang -notin $SupportedLangs){
		write-host "LangNotsupported: $FileName";
		continue;
	}
	
	$LangDir = JoinPath $TempDir $Lang;
	
	# Is cmdlet help file!
	if($FileName -match '([\w-]+)\.cmdlet\.md$' -or $FileName -match 'cmdlets/([\w-]+).md'){
		$CmdLetName = $matches[1];

		$NewFileName = $matches[1] + '.md';
		
		$Vars.FileName = $MdFile.name;
		$Vars.CmdLetName = $CmdLetName;
		
		
		write-host "	IsCmdlet doc! name: NewFile: $NewFileName";
		$TargetFile = (JoinPath $LangDir $NewFileName);
		ParseFile -Source $MdFile -Target $TargetFile  -Vars $Vars
		continue;
	}

	if($FileName -match '((.*?)/)?(.*?)\.md'){
		if($matches[1]){
			$Topic += "_" + $Matches[2].replace("/","_")
		}
		
		$BaseName = $matches[3];
		
		if($BaseName -like '*.about' -or $BaseName -eq "README"){
			$Topic += "_" + ($BaseName -replace '\.about$','')
		} elseif($BaseName -ne 'README') {
			write-host "	MdFileNotSupported: leftname=$fileName"
			continue;
		}
	}
	elseif($FileName -ne 'README.md'){
		write-host "	File not supported: $($SRelPath), name = $FileName"
		continue;
	}
	
	$Vars.AboutTopic = $Topic;
	
	write-host 	"	Lang: $Lang, Topic:$Topic, file:$SRelPath"
	$NewFileName = $Topic+".md";
	ParseFile -Source $MdFile -Target (JoinPath $LangDir $NewFileName) -Vars $Vars
}

write-host "== Start compilation... =="

[string]$OutDir = New-Item -ItemType Directory (JoinPath $TempDir "_out")

write-host "	Out: $OutDir";

$Progress = @()

foreach($Lang in $LangDirs){
	$LangName = $Lang.name
	write-host "Compiling:" $LangName

	
	try {
		$OutPath = JoinPath $OutDir $LangName;
		$ErrorFile = JoinPath $OutDir "$LangName-Errors.json";
		
		write-host "	Generating help files to $OutPath";
		#$FileList = gci -rec (JoinPath $Lang.FullName *.md)
		$null = New-ExternalHelp -force -Path  $Lang.FullName-OutputPath $OutPath -Encoding $Utf8Bom -ErrorLogFile $ErrorFile -EA Continue;
		
		
		
		$ModuleLangDir = JoinPath "$PsScriptRoot" "powershai" $LangName
		
		if(Test-Path $ModuleLangDir){
			write-host "	Cleaning target dir: $ModuleLangDir";
			gci (JoinPath $ModuleLangDir *) | remove-item -force -recurse;
		}
		
		write-host "	Copying back to docs: $ModuleLangDir"
		gci $OutPath | copy-item -Recurse -Destination $ModuleLangDir;
	} catch {
		write-warning "LANG ERROR: $LangName, Summary = $_";
		$ErrorActionPreference = "Continue";
		write-error -Exception $_.Exception
		write-host $_.ScriptStackTrace
		$ErrorActionPreference = "Stop";
	}
}








