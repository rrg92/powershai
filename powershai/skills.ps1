function _ParseSimpleYaml {
	param(
		[string]$YamlText
	)

	$Data = @{}
	foreach($Line in @($YamlText -split "`r?`n")){
		$Trimmed = [string]$Line
		if([string]::IsNullOrWhiteSpace($Trimmed)){
			continue
		}

		$Trimmed = $Trimmed.Trim()
		if($Trimmed.StartsWith("#")){
			continue
		}

		if($Trimmed -match '^([A-Za-z0-9_\-]+)\s*:\s*(.*)$'){
			$Key = $Matches[1]
			$Value = $Matches[2].Trim()

			if(($Value.StartsWith('"') -and $Value.EndsWith('"')) -or ($Value.StartsWith("'") -and $Value.EndsWith("'"))){
				$Value = $Value.Substring(1,$Value.Length-2)
			}

			$Data[$Key] = $Value
		}
	}

	return $Data
}

function _ParseAiSkillFile {
	param(
		[Parameter(Mandatory)]
		[string]$SkillFilePath
	)

	$Resolved = Resolve-Path -LiteralPath $SkillFilePath -EA SilentlyContinue
	if(!$Resolved){
		throw "POWERSHAI_AISKILL_FILE_NOTFOUND: $SkillFilePath"
	}

	$SkillFilePath = [string]$Resolved
	$SkillDir = Split-Path -Parent $SkillFilePath
	$Raw = Get-Content -LiteralPath $SkillFilePath -Raw -Encoding UTF8

	$FrontmatterText = $null
	$Body = $Raw
	$Metadata = @{}
	$Diagnostics = @()

	if($Raw -match '(?s)^\s*---\s*\r?\n(.*?)\r?\n---\s*\r?\n?(.*)$'){
		$FrontmatterText = $Matches[1]
		$Body = $Matches[2]

		$YamlCommand = Get-Command -Name ConvertFrom-Yaml -EA SilentlyContinue
		if($YamlCommand){
			try {
				$MetadataObj = ConvertFrom-Yaml -Yaml $FrontmatterText -EA Stop
				$Metadata = HashTableMerge @{} $MetadataObj
			} catch {
				$Diagnostics += "YAML parser failed, fallback parser used: $($_.Exception.Message)"
				$Metadata = _ParseSimpleYaml -YamlText $FrontmatterText
			}
		} else {
			$Metadata = _ParseSimpleYaml -YamlText $FrontmatterText
		}
	} else {
		$Diagnostics += "No YAML frontmatter found in SKILL.md"
	}

	$SkillName = [string]$Metadata.name
	$SkillDescription = [string]$Metadata.description

	if([string]::IsNullOrWhiteSpace($SkillDescription)){
		throw "POWERSHAI_AISKILL_INVALID_DESCRIPTION: Description is required in $SkillFilePath"
	}

	if([string]::IsNullOrWhiteSpace($SkillName)){
		$SkillName = Split-Path -Leaf $SkillDir
		$Diagnostics += "Missing 'name' in frontmatter. Falling back to directory name: $SkillName"
	}

	$DirName = Split-Path -Leaf $SkillDir
	if($DirName -ne $SkillName){
		$Diagnostics += "Skill name does not match directory name. name=$SkillName dir=$DirName"
	}

	$Resources = @()
	$AllFiles = Get-ChildItem -LiteralPath $SkillDir -File -Recurse -EA SilentlyContinue
	foreach($File in @($AllFiles)){
		if($File.Name -ieq "SKILL.md"){
			continue
		}

		$Relative = $File.FullName.Substring($SkillDir.Length).TrimStart([char]92,[char]47)
		$Resources += $Relative
	}

	$Skill = [ordered]@{
		name = $SkillName
		description = $SkillDescription
		location = $SkillFilePath
		skillDir = $SkillDir
		body = [string]$Body.Trim()
		resources = @($Resources | Sort-Object -Unique)
		diagnostics = @($Diagnostics)
		metadata = $Metadata
	}

	SetType $Skill "AiSkill"
	return $Skill
}

function _ResolveAiSkillSelection {
	param(
		$Skill,
		[string]$Name,
		$Skills
	)

	if($Skill){
		return $Skill
	}

	$ByName = @($Skills) | Where-Object { $_ -and $_.name -eq $Name } | Select-Object -First 1
	if(!$ByName){
		throw "POWERSHAI_AISKILL_NOTFOUND: $Name"
	}

	return $ByName
}

function _FormatAiSkillActivationContent {
	param(
		[Parameter(Mandatory)]
		$Skill
	)

	$ResLines = @()
	foreach($Res in @($Skill.resources)){
		$ResLines += "  <file>$Res</file>"
	}

	$ResourcesBlock = ""
	if($ResLines.Count){
		$ResourcesBlock = @(
			"<skill_resources>"
			$ResLines
			"</skill_resources>"
		) -join "`n"
	}

	$Content = @(
		"<skill_content name=`"$($Skill.name)`">"
		$Skill.body
		""
		"Skill directory: $($Skill.skillDir)"
		"Relative paths in this skill are relative to the skill directory."
		$ResourcesBlock
		"</skill_content>"
	) -join "`n"

	return $Content.Trim()
}

function Test-AiSkillScriptAuthorization {
	param(
		[Parameter(Mandatory)]
		[string]$SkillName,

		[Parameter(Mandatory)]
		[string]$Script,

		[string[]]$AuthorizedSkillsScripts = @()
	)

	if(!$AuthorizedSkillsScripts){
		return $false
	}

	$ScriptNorm = ([string]$Script).Replace('\\','/').TrimStart('/')
	$ScriptLeaf = Split-Path -Leaf $ScriptNorm

	$Candidates = @(
		"$SkillName/$ScriptNorm",
		"$SkillName/$ScriptLeaf"
	)

	foreach($Pattern in @($AuthorizedSkillsScripts)){
		if([string]::IsNullOrWhiteSpace([string]$Pattern)){
			continue
		}

		$PatNorm = ([string]$Pattern).Replace('\\','/')
		foreach($Candidate in $Candidates){
			if($Candidate -like $PatNorm){
				return $true
			}
		}
	}

	return $false
}

function Test-AiPowershellCommandAuthorization {
	param(
		[Parameter(Mandatory)]
		[string]$Command,

		[string[]]$AuthorizedPowershellCommands = @()
	)

	if(!$AuthorizedPowershellCommands){
		return $false
	}

	foreach($Pattern in @($AuthorizedPowershellCommands)){
		if([string]::IsNullOrWhiteSpace([string]$Pattern)){
			continue
		}

		if($Command -like [string]$Pattern){
			return $true
		}
	}

	return $false
}

function Get-AiSkillFileContent {
	[CmdletBinding()]
	param(
		# Objeto de skill retornado por Get-AiSkills.
		$Skill,

		# Nome da skill para resolver com -Skills.
		[string]$Name,

		# Lista de skills retornada por Get-AiSkills.
		$Skills = @(),

		# Caminho relativo de arquivo dentro da skill.
		[Parameter(Mandatory)]
		[string]$Path,

		# Limite maximo de caracteres retornados.
		[int]$MaxChars = 200000
	)

	$ResolvedSkill = _ResolveAiSkillSelection -Skill $Skill -Name $Name -Skills $Skills
	$SkillRoot = [IO.Path]::GetFullPath($ResolvedSkill.skillDir)

	$TargetPath = $Path
	if(-not [IO.Path]::IsPathRooted($TargetPath)){
		$TargetPath = Join-Path $ResolvedSkill.skillDir $TargetPath
	}

	$ResolvedTarget = Resolve-Path -LiteralPath $TargetPath -EA SilentlyContinue
	if(!$ResolvedTarget){
		throw "POWERSHAI_AISKILL_FILE_NOTFOUND: $Path"
	}

	$TargetFullPath = [IO.Path]::GetFullPath([string]$ResolvedTarget)
	if($TargetFullPath -notlike "$SkillRoot*"){
		throw "POWERSHAI_AISKILL_FILE_OUTSIDE_SKILLDIR: $Path"
	}

	$Content = Get-Content -LiteralPath $TargetFullPath -Raw -Encoding UTF8
	$Truncated = $false
	if($MaxChars -gt 0 -and $Content.Length -gt $MaxChars){
		$Content = $Content.Substring(0,$MaxChars)
		$Truncated = $true
	}

	$RelativePath = $TargetFullPath.Substring($SkillRoot.Length).TrimStart([char]92,[char]47).Replace('\\','/')

	$Output = @(
		"<skill_file_content skill=`"$($ResolvedSkill.name)`" path=`"$RelativePath`" truncated=`"$Truncated`">"
		$Content
		"</skill_file_content>"
	) -join "`n"

	return $Output
}

function Invoke-AiPowershellCommand {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
	param(
		# Comando PowerShell a executar.
		[Parameter(Mandatory)]
		[string]$Command,

		# Diretório de execução do comando.
		[string]$WorkingDirectory = $null,

		# Objeto de skill retornado por Get-AiSkills.
		$Skill,

		# Nome da skill para resolver com -Skills.
		[string]$Name,

		# Lista de skills retornada por Get-AiSkills.
		$Skills = @(),

		# Padrões de comandos autorizados automaticamente (wildcards suportados).
		[string[]]$AuthorizedPowershellCommands = @(),

		# Pula confirmação e executa o comando diretamente nesta chamada.
		[switch]$AllowCommandExecution
	)

	$ResolvedSkill = $null
	if($Skill -or $Name){
		$ResolvedSkill = _ResolveAiSkillSelection -Skill $Skill -Name $Name -Skills $Skills
	}

	if(!$WorkingDirectory -and $ResolvedSkill){
		$WorkingDirectory = $ResolvedSkill.skillDir
	}

	$IsAuthorized = Test-AiPowershellCommandAuthorization -Command $Command -AuthorizedPowershellCommands $AuthorizedPowershellCommands
	if(!$AllowCommandExecution -and !$IsAuthorized){
		$Prompt = "Authorize PowerShell command execution '$Command'? [y/N]"
		$Resp = Read-Host $Prompt
		if($Resp -notmatch '^(?i:y|yes)$'){
			throw "POWERSHAI_AISKILL_COMMAND_NOTAUTHORIZED: $Command"
		}
	}

	$OldLocation = Get-Location
	try {
		if($WorkingDirectory){
			$null = Set-Location -LiteralPath $WorkingDirectory
		}

		$Output = & ([scriptblock]::Create($Command)) 2>&1 | Out-String
	} finally {
		$null = Set-Location -LiteralPath $OldLocation.Path
	}

	$SkillName = ""
	if($ResolvedSkill){
		$SkillName = $ResolvedSkill.name
	}

	$Result = @(
		"<powershell_command_result skill=`"$SkillName`">"
		"<command>$Command</command>"
		"<working_directory>$WorkingDirectory</working_directory>"
		"<output>"
		$Output
		"</output>"
		"</powershell_command_result>"
	) -join "`n"

	return $Result
}

function Get-AiSkills {
	<#
		.SYNOPSIS
			Descobre e carrega skills no formato Agent Skills (SKILL.md).

		.DESCRIPTION
			Varre os caminhos informados em -Path e retorna objetos de skill no formato interno do PowershAI.
			Cada skill encontrada precisa conter description valida no frontmatter YAML do arquivo SKILL.md.
			Este cmdlet nao persiste estado global: ele apenas devolve a lista para ser usada diretamente,
			por exemplo no parametro -Skills de Invoke-AiChatTools.

		.EXAMPLE
			$s = Get-AiSkills -Path ./.agents/skills -Recurse
			Carrega skills de uma raiz de projeto.

		.EXAMPLE
			$s = Get-AiSkills -Path ./my-skill
			Carrega uma skill de um diretorio especifico.
	#>
	[CmdletBinding()]
	param(
		# Caminho(s) para descoberta de skills.
		# Pode ser raiz, diretorio de skill ou arquivo SKILL.md.
		[parameter(Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias("FullName")]
		[string[]]$Path = @("."),

		# Varre subdiretorios recursivamente.
		[switch]$Recurse,

		# Limite maximo de skills retornadas.
		[int]$MaxSkills = 2000
	)

	begin {
		$AllSkills = @()
		$KnownFiles = @{}
	}

	process {
		foreach($CurrentPath in @($Path)){
			$ResolvedList = Resolve-Path -Path $CurrentPath -EA SilentlyContinue
			if(!$ResolvedList){
				Write-Warning "POWERSHAI_AISKILL_PATH_NOTFOUND: $CurrentPath"
				continue
			}

			foreach($Resolved in @($ResolvedList)){
				$ResolvedPath = [string]$Resolved
				$Item = Get-Item -LiteralPath $ResolvedPath -EA SilentlyContinue
				if(!$Item){
					continue
				}

				$Candidates = @()
				if(-not $Item.PSIsContainer){
					if($Item.Name -ieq "SKILL.md"){
						$Candidates += $Item.FullName
					}
				} else {
					$DirectSkill = Join-Path $Item.FullName "SKILL.md"
					if(Test-Path -LiteralPath $DirectSkill){
						$Candidates += $DirectSkill
					}

					$SearchDirs = @()
					if($Recurse){
						$SearchDirs = Get-ChildItem -LiteralPath $Item.FullName -Directory -Recurse -EA SilentlyContinue
					} else {
						$SearchDirs = Get-ChildItem -LiteralPath $Item.FullName -Directory -EA SilentlyContinue
					}

					foreach($Dir in @($SearchDirs)){
						if($Dir.Name -in @('.git','node_modules','.venv','dist','bin','obj')){
							continue
						}

						$SkillFile = Join-Path $Dir.FullName "SKILL.md"
						if(Test-Path -LiteralPath $SkillFile){
							$Candidates += $SkillFile
						}
					}
				}

				foreach($SkillFilePath in @($Candidates | Select-Object -Unique)){
					if($AllSkills.Count -ge $MaxSkills){
						Write-Warning "POWERSHAI_AISKILL_MAX_REACHED: MaxSkills=$MaxSkills"
						break
					}

					$CanonPath = [string](Resolve-Path -LiteralPath $SkillFilePath -EA SilentlyContinue)
					if(!$CanonPath -or $KnownFiles[$CanonPath]){
						continue
					}

					$KnownFiles[$CanonPath] = $true

					try {
						$SkillObj = _ParseAiSkillFile -SkillFilePath $CanonPath
						$AllSkills += $SkillObj
					} catch {
						Write-Warning $_
					}
				}
			}
		}
	}

	end {
		return @($AllSkills)
	}
}

function Invoke-AiSkill {
	<#
		.SYNOPSIS
			Ativa uma skill carregada e retorna seu conteudo formatado para contexto.

		.DESCRIPTION
			Resolve uma skill por objeto (-Skill) ou por nome (-Name + -Skills) e retorna o conteudo
			em formato estruturado (<skill_content ...>) para uso no fluxo de chat.
			Tambem pode executar script de recurso da skill via -Script, com confirmacao por padrao.

		.EXAMPLE
			$s = Get-AiSkills -Path ./.agents/skills -Recurse
			Invoke-AiSkill -Name "pdf-processing" -Skills $s
			Ativa skill por nome e retorna conteudo estruturado.

		.EXAMPLE
			$s = Get-AiSkills -Path ./my-skill
			Invoke-AiSkill -Skill $s[0] -Raw
			Retorna somente o body da skill.

		.EXAMPLE
			$s = Get-AiSkills -Path ./my-skill
			Invoke-AiSkill -Skill $s[0] -Script "scripts/run.ps1" -ScriptArgs @{ Value = "abc" }
			Executa script de recurso da skill com confirmacao por padrao.
	#>
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
	param(
		# Objeto de skill retornado por Get-AiSkills.
		[parameter(ValueFromPipeline)]
		$Skill,

		# Nome da skill para resolver com -Skills.
		[string]$Name,

		# Lista de skills retornada por Get-AiSkills.
		$Skills = @(),

		# Retorna apenas o body da skill, sem wrapper estruturado.
		[switch]$Raw,

		# Script de recurso da skill a executar.
		[string]$Script,

		# Argumentos para o script de recurso.
		[hashtable]$ScriptArgs = @{},

		# Lista de autorizacoes no formato skill/script com suporte a wildcard.
		# Exemplos: myskill/run.ps1, myskill/*, */*
		[string[]]$AuthorizedSkillsScripts = @(),

		# Pula confirmacao e executa o script diretamente nesta chamada.
		[switch]$AllowScriptExecution
	)

	process {
		$ResolvedSkill = _ResolveAiSkillSelection -Skill $Skill -Name $Name -Skills $Skills

		if($Script){
			$ScriptPath = $Script
			$ScriptRelative = $Script
			if(-not [IO.Path]::IsPathRooted($ScriptPath)){
				$ScriptPath = Join-Path $ResolvedSkill.skillDir $ScriptPath
			}

			$ScriptResolved = Resolve-Path -LiteralPath $ScriptPath -EA SilentlyContinue
			if(!$ScriptResolved){
				throw "POWERSHAI_AISKILL_SCRIPT_NOTFOUND: $Script"
			}

			$ScriptResolved = [string]$ScriptResolved
			$SkillRoot = [IO.Path]::GetFullPath($ResolvedSkill.skillDir)
			$ScriptFullPath = [IO.Path]::GetFullPath($ScriptResolved)
			if($ScriptFullPath -notlike "$SkillRoot*"){
				throw "POWERSHAI_AISKILL_SCRIPT_OUTSIDE_SKILLDIR: $Script"
			}

			if([IO.Path]::IsPathRooted($ScriptRelative)){
				$ScriptRelative = $ScriptFullPath.Substring($SkillRoot.Length).TrimStart('\\','/')
			}

			$ScriptRelative = [string]$ScriptRelative
			$ScriptRelative = $ScriptRelative.Replace('\\','/').TrimStart('/')
			$AuthKey = "$($ResolvedSkill.name)/$ScriptRelative"

			$IsAuthorized = Test-AiSkillScriptAuthorization -SkillName $ResolvedSkill.name -Script $ScriptRelative -AuthorizedSkillsScripts $AuthorizedSkillsScripts
			if(!$AllowScriptExecution -and !$IsAuthorized){
				$Prompt = "Authorize skill script execution '$AuthKey'? [y/N]"
				$Resp = Read-Host $Prompt
				if($Resp -notmatch '^(?i:y|yes)$'){
					throw "POWERSHAI_AISKILL_SCRIPT_NOTAUTHORIZED: $AuthKey"
				}
			}

			$ScriptResult = & $ScriptResolved @ScriptArgs

			return @{
				skill = $ResolvedSkill.name
				script = $ScriptResolved
				result = $ScriptResult
			}
		}

		if($Raw){
			return $ResolvedSkill.body
		}

		return _FormatAiSkillActivationContent -Skill $ResolvedSkill
	}
}
