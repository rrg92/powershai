<#
	.DESCRIPTION
		Uma pequeno dilema meu: Um produto ou serviço só muito bom, se ele consegue suprir as demandas dos próprios criadores!
		E, baseado nisso, temos o script AI DOC!
		
		Este script usa o próprio PowershAI para gerar docs em outros idiomas
		Ele é um utilitário para facilitar porta a documentação original para outros idiomas, que ainda não possuem uma tradução revisada por alguém expert no idioma de destino.  
		
		Ele pode ser utilizado sempre que qusier gerar novos arquivos de documentação, ou atualizar existentes.  
		Para manter a qualidade, recomendamos o uso com LLM avançados, como GPT-4o-mini, llam 3.1, ou gemini flash.  
		Importante que o modelo suporte longos contextos!
		
		O script causa atualizações de arquivos no projeto, então, é preciso seguir o fluxo normalmente:
			- commit no git 
			- bump de versão 
			- publicar 
			
		Imagine que este script seja seu assistente de tradução do PowershAI!
		Use e abuse!
		
		Como o script funciona:
			Você deve especificar um idioma de origem e de destino.  
			Então, o script vai obter todos os arquivos .md do diretório de origem, traduzir, e escrever a mesma estrutura no diretório do idioma de destino.
			O script irá procurar os diretórios de idioma o diretório docs/, na raiz do projeto.
			Os idiomas suportados são esses cujo existem um subdiretório em docs/.  
			Para adicionar um novo idioma suportado, basta criar o diretório vazio com o seu código.  
			O nome dos idiomas segue o padrão BCP 47. Este link contém uma exemplo usado pelo padrão office que serve: https://learn.microsoft.com/en-us/openspecs/office_standards/ms-oe376/6c085406-a698-4e12-9d4d-c3b0ee3dbc4a
			
			PAra cada arquivo encontrado, o script vai checar o metadado e determinar se ele pode ser traduzido ou não. 
			AS seguintes regras são aplicadas nesta ordem (são checadas nesta ordem):
				- Arquivo de destino existe e foi alterado: Não será traduzido, pois assume que alguém modificou.
				- Arquivo de origem não foi alterado: Não será traduzido, pois assume que não há nada novo.
				- Nos demais caso,a tradução é feita e o arquvio de destino sobrescrito.
				
			O script usa o arquivo AiTranslations.json para guardar os hashs dos arquivos. Ele cria este arquivo no diretório de destino. 
			Com estes hashs, ele consegue detectar as alterações no arquivos e comparar para saber o que foi modificado ou não desde a última execução.  
			Por isso, é de extrema importância que não se altere o arquivo AiTranslations.json.  
			
			A tradução do arquivo é feitas em blocos, para evitar futar o contexto do LLM.  
			O tamanho, em caracteres, de um bloco é controlado pelo parâmetro $MaxTokens.  
			Ele calcula o número de caracteres estimado baseado no máximo de tokens de contexto do LLM.  
			
			E, como mencionado acima, o script apenas gera os arquivos no diretorios de docs/.  
			O ultimo passo é a revisão do responsável e o commit ou reset do git!
		
		Um uso típico do processo seria:
			- Uma doc em uma linguagem é criada e revisada por alguém, ou grupo de pessoas (pt-BR geralmente será a origem)
				- Esta doc deve residir em docs/ 
				- Pode se usar o PlatyPS para gerar os arquivo markdown a partir da documentacao dos cmdlets
			- Um novo diretorio é criado em docs, com o um novo idioma a ser disponibilizado
				- O nome do diretorio deve seguir o lang bcp 47 
			- Entao, o script aidoc.ps1 deve ser executado:
				- Antes de executar, lembrar de cnfigurar o token e o modelo do provider a ser usado (padrao = openai).
				- aidoc.ps1 src-lang tgt-lang (ex.: aidoc.ps1 pt-BR en-US)
			- Os arquivos gerados podem ser revisados 
				- git status docs/destino vai listar o que foi incluido 
			- Seguir o processo de versionamento do modulo normalmente (git commit, version bump, etc)
			- Posteriormente, o autor, ou a comunidade técnica com dominio do idioma pode alterar e corrigir a traducao.
				- ISso vai impedir que os arquivos passem a ser traduzidos automaticamente. A comunidade precisará mantê-los sincronizados.
		
		
		---
		
		A small dilemma of mine: A product or service is only very good if it can meet the demands of its own creators!
		And, based on that, we have the AI DOC script!

		This script uses the PowershAI itself to generate docs in other languages.
		It is a utility to facilitate translating the original documentation into other languages that do not yet have a review by an expert in the target language.

		It can be used whenever you want to generate new documentation files or update existing ones.
		To maintain quality, we recommend using it with advanced LLMs, such as GPT-4o-mini, llam 3.1, or gemini flash.
		It's important that the model supports long contexts!

		The script causes file updates in the project, so it is necessary to follow the normal flow:
			- commit in git
			- bump version
			- publish

		Imagine this script as your translation assistant for PowershAI!
		Use and abuse!
		
		How the script works:
			You must specify a source and target language. Then, the script will obtain all .md files from the source directory, translate them, and write the same structure in the target language directory.

			The script will look for language directories in the `docs/` directory at the root of the project. The supported languages are those for which there is a subdirectory in `docs/`. To add a new supported language, simply create an empty directory with its code. The names of the languages follow the BCP 47 standard. This link contains an example used by the Office standard that serves: https://learn.microsoft.com/en-us/openspecs/office_standards/ms-oe376/6c085406-a698-4e12-9d4d-c3b0ee3dbc4a

			For each file found, the script will check the metadata and determine whether it can be translated or not. The following rules are applied in this order (checked in this order):
			- The target file exists and has been modified: It will not be translated, as it is assumed that someone modified it.
			- The source file has not been modified: It will not be translated, as it is assumed that there is nothing new.
			- In other cases, the translation is performed and the target file is overwritten.

			The script uses the `AiTranslations.json` file to store the hashes of the files. It creates this file in the target directory. With these hashes, it can detect changes in the files and compare to see what has been modified or not since the last execution. Therefore, it is extremely important not to alter the `AiTranslations.json` file.

			The translation of the file is done in blocks to avoid losing the context of the LLM. The size, in characters, of a block is controlled by the $MaxTokens parameter.
			It calculates the estimated number of characters based on the maximum context tokens of the LLM.

			And, as mentioned above, the script only generates files in the `docs/` directories.
			The final step is the review by the responsible person and the commit or reset of the git!
			
		 A typical usage of the process would be:
			- A document in one language is created and reviewed by someone or a group of people (pt-BR will generally be the source).
			  - This document should reside in `docs/`.
			  - You can use PlatyPS to generate the markdown files from the cmdlet documentation.
			- A new directory is created in `docs`, with a new language to be made available.
			  - The name of the directory must follow the BCP 47 standard.
			- Then, the `aidoc.ps1` script should be executed:
			  - Before executing, remember to configure the token and the provider model to be used (default = openai).
			  - Run `aidoc.ps1 src-lang tgt-lang` (e.g., `aidoc.ps1 pt-BR en-US`).
			- The generated files can be reviewed.
			  - Running `git status docs/destination` will list what has been included.
			- Follow the normal versioning process of the module (git commit, version bump, etc.).
			- Subsequently, the author or the technical community proficient in the language can modify and correct the translation.
			  - This will prevent the files from being automatically translated again. The community will need to keep them synchronized.
  
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'High')]
param(
	#Target lang to translate. Valid are on of subdir docs/<name>
		$TargetLang = $null
		
	,#Name of language. One of subdir docs/<name> 
		$SourceLang = 'pt-BR'
		
	
	,#force keep current provider. By efault, script try changes to -Provider 
		[switch]$KeepProvider
		
	,#provider to use 
		$Provider = "google"
		
	,#Force recreate docs that dont have changed!
		[switch]$Force
		
	,#Max tokens returned. Target model must support 
		$MaxTokens = 32000
	
	,#Filter files
		$FileFilter = $null
	
	,#Atualiza o conteudo dos arquios de desitno usando esse script e reclculando o hash!
		[switch]$TargetRehash
		
)

$ErrorActionPreference = "Stop";
. (Join-Path "$PsScriptRoot" UtilLib.ps1)
CheckPowershaiRoot

write-host "Loading local powershai module";
import-module .\powershai -force;

if(!$SourceLang){
	throw "Must specifuy -SourceLang"
}

if(!$TargetLang){
	throw "Must specifuy -TargetLang"
}

if($TargetLang -eq $SourceLang){
	write-warning "Target and Source = $TargetLang. Ignoring";
	return;
}

$SourcePath = Resolve-Path (JoinPath docs $SourceLang)
$TargetPath = Resolve-Path (JoinPath docs $TargetLang)

if(-not(Test-Path $SourcePath)){
	throw "Invalid Lang: $SourceLang, PathNotfound = $SourcePath";
}

if(-not(Test-Path $TargetPath)){
	throw "Invalid Lang: $TargetLang, PathNotfound = $TargetPath";
}


$TranslationMapFile = JoinPath $TargetPath AiTranslations.json

if(Test-Path $TranslationMapFile){
	$TranslationMap = Get-Content -Raw $TranslationMapFile | ConvertFrom-Json;
} else {
	$TranslationMap = @{}
}

# List all source files!
$SourceFiles = gci -rec (JoinPath $sourcePath *.md)



if(!$KeepProvider){
	write-host "Enforcing provider $Provider";
	Set-AiProvider $provider;
}

$CurrentProvider = Get-AiCurrentProvider

write-host "Generating fixed translations..."
$WaterResult = Get-AiChat -prompt @(
	"s: Traduzir para $TargetLang. Rertornar somente o texto traduzido"	
	"Traduzido automaticamente usando o PowershAI e IA"
)
$WatermarkText = $WaterResult.choices[0].message.content

$WatermarkText = @($WatermarkText) -Join ""

$NewMap = @{}
$TranslationMap.psobject.properties | %{
	$NewMap[$_.name] = $_.Value;
}

$TranslationMap = $NewMap;

$DebugData = @{
	files 			= @()
	translationMap	= $TranslationMap
	SrcLang 		= $SrcLang
	TargetLang 		= $TargetLang
}
$Global:AIDOC_LASTRUN = $DebugData;

function SaveTranslationMap {
	$TranslationMapJson = $TranslationMap | ConvertTo-Json	
	Set-Content -Path $TranslationMapFile -Value $TranslationMapJson
}


$StartReadme = Get-Item ./README.md;

if($SourceLang -eq 'pt-BR'){
	$SourceFiles += $StartReadme;
}


foreach($SrcFile in $SourceFiles){
	
	$SrcFileInfo = @{
		SrcFile 	= $SrcFile 
		status 		= "started"
	}
	
	$DebugData.files += $SrcFileInfo;
	
	
	if($SrcFile -eq $StartReadme){
		$SrcRelPath 				= 'START-README.md'
		$SrcFileInfo.IsStartReadme 	= $true;
	} else {
		$SrcRelPath = $SrcFile.FullName.replace($SourcePath,'')
		
	}
	
	if($SrcRelPath[0] -in '\','/'){
		$SrcRelPath = $SrcRelPath -replace '^.',''
	}
	
	$FileId	 = $SrcRelPath.replace('\','/');
	$SrcFileInfo.RelPath 	= $SrcRelPath
	$SrcFileInfo.Fileid 	= $FileId;
	

	if($FileFilter -and $FileId -NotLike $FileFilter -and $SrcRelPath -NotLike $FileFilter ){
		write-verbose "$SrcRelPath filteredout!"
		$SrcFileInfo.status = "filtered";
		continue;
	}
	
	write-host "File: $SrcRelPath";
	
	
	$TargetFilePath = JoinPath $TargetPath $SrcRelPath;
	$TargetFile = Get-Item $TargetFilePath -EA SilentlyContinue;
	
	$SrcFileInfo.TargetPath = $TargetPath
	$SrcFileInfo.TargetItem = $TargetFile
	$TranslationInfo 		= $TranslationMap[$FileId];
	
	$SrcFileInfo.TranslationInfo = $TranslationInfo;
	
	if($Force){
		write-host "	### Forcing!":
		$TargetFile = $null
		$TranslationInfo = $null;
		$SrcFileInfo.Forced = $true;
	}
	
	$TargetHash = $null
	$FileBackup = $null
	if($TargetFile){
		write-host "	Target exists!"
		$FileBackup = Get-Content $TargetFile;
		
		# check if file is auto updated!
		# aCalculate hash!
		$TargetHash = Get-FileHash $TargetFile

		$SrcFileInfo.TargetHash = $TargetHash;
		
		
		# Checa se o arquivo foi geraod automaticamente!
		if(!$TranslationInfo){
			$SrcFileInfo.status = "NotinMap";
			write-host "	File not generated by AiDoc! Skipping...";
			continue;
		}
		
		# Get hash!
		$AiHash = $TranslationInfo.TargetHash;
		
		if($AiHash -ne $TargetHash.Hash){
			$SrcFileInfo.status = "TargetChanged";

			if($TargetRehash){
				if($PSCmdlet.ShouldProcess($TargetFile.FullName,"Rehash $AiHash->$($TargetHash.Hash)")){
					$SrcFileInfo.status = "TargetRehashed";
					$TranslationInfo.TargetHash = $TargetHash.Hash;
					SaveTranslationMap;
					continue;
				}
			} else {
				write-host "	FileChanged. Will not be updated more...";
				$TranslationMap.remove($FileId);
			}
			
			continue;
		}
		
		# Neste ponto, assume que o arquivo pode ser atualizavel!s
	}
	
	if($TargetRehash){
		write-host "	TargetReash mode. Nothing to do more..."
		continue;
	}
	
	write-host "	Calculating Hash..."
	$SrcHash = Get-FileHash $SrcFile;
	$SrcFileInfo.SrcHash = $SrcHash;
	
	# Checa se mudou!
	if($TranslationInfo.SrcHash -eq $SrcHash.Hash){
		$SrcFileInfo.status = "NotChanged"
		write-host "	Nothing changed... Skipping";
		continue;
	}

	$SrcFileInfo.status = "translating";
	write-host "	Translating file...";
	$FileContent = Get-Content -Raw $SrcFile;
	
	write-host "	Length: $($FileContent.length)";
	
	# Divide o markdown em blocos, para evitar ultrassar o size do modelo!
	$BlockSize 	= $MaxTokens - 1000;
	$FullTranslation = "";
	
	$Control = @{
		buffer 			= @()
		TotalChars 		= 0
		text 			= ""
		blockNum		= 0
		InputTokens 	= 0
		OutputTokens 	= 0
		LastModel 		= $null
		answers 		= @()
	}
	
	Function Translate {
		$BufferText 		= $Control.buffer -Join "`n";
		$Control.buffer 	= @();
		$Control.TotalChars = 0;
		$Control.blockNum++
		
		write-host "	Num: $($Control.blockNum) Buffer:" $BufferText.length;
		
		$Initial = @()

		
		$system = @(
			"Traduza o texto do usuário para a linguagem de código $($TargetLang). Retorne APENAS o texto traduzido."
			"Manter o conteúdo original entre <!--! -->. Traduzir comentários de código, nomes de funções de exemplo. Não traduzir nomes de comandos do PowershAI."
			"Não altere ou complemente partes, foque apenas na tradução do texto."
		)
		
		
		
		
		$system = $system -Join "`n";
		$prompt = @(
			"s: $system"
			$BufferText 
		)
		
		write-host "	Invoking AI..."
		$result 	= Get-AiChat -prompt $prompt -MaxTokens $MaxTokens
		$airesult 	= $result.choices[0]
		$usage 		= $result.usage;
		write-host "	Usage: Input = $($usage.prompt_tokens), Output = $($usage.completion_tokens)"
		if($airesult.finish_reason -ne "stop"){
			throw "STOP_REASON: $($airesult.finish_reason)"
		}
		
		$translated = $result.choices[0].message.content;
		write-host "	Translated: $($translated.length) chars"
		$Control.text 			+= $translated
		$Control.InputTokens 	+= $usage.prompt_tokens
		$Control.OutputTokens 	+= $usage.completion_tokens
		$Control.LastModel 		= $result.model;
		$Control.answers 		+= $result;
	}
	
	try {
		if($FileContent.length -gt $BlockSize){
			$FileLines = $FileContent -split "`r?`n"
			foreach($line in $FileLines){
				$LineLen 	= $Line.length;
				$EstTotal 	= $Control.TotalChars + $LineLen;
				
				if($EstTotal -ge $BlockSize){
					$null = Translate
				}
				
				$Control.buffer += $line;
				$Control.TotalChars += $LineLen;
			}
		} else {
			$Control.buffer = $FileContent;
		}
		
		Translate
	} catch {
		write-host "	FAILED: $_";
		$SrcFileInfo.status 		= "error:translation";
		$SrcFileInfo.translation 	= $Control
		$SrcFileInfo.error 			= $_
		continue;
	}
	
	$Translated 	= $Control.text
	$InputTokens 	= $Control.InputTokens
	$OutputTokens 	= $Control.OutputTokens
	$Model 			= $Control.LastModel
	write-host "	Translated Length: $($Translated.length)";
	
	write-host "	Creating target directories..."
	$Paths = Split-Path $TargetFilePath -Parent;
	$null = New-Item -ItemType Directory -Path $Paths -force;
	
	
	$SrcFileInfo.status = "Updating"
	
	try {
		verbose "Fixing localized links"
		$Translated = $Translated.replace("/docs/"+$SourceLang,"/docs/"+$TargetLang)
		
		write-host "	Updating target content..."
		@(
			$Translated
			''
			''
			'<!--PowershaiAiDocBlockStart-->'
			'_'+$WatermarkText+'_'
			'<!--PowershaiAiDocBlockEnd-->'
		) | Set-Content -Encoding UTF8 -Path $TargetFilePath
	
		# check if file is auto updated!
		# aCalculate hash!
		$TargetNewHash = Get-FileHash $TargetFilePath	
		
		$SrcFileInfo.TargetNewHash = $TargetNewHash;
		
		write-host "	Creating new map..."
		$NewMap[$FileId] = @{
			SrcHash 		= $SrcHash.Hash
			TargetHash		= $TargetNewHash.Hash
			Provider 		= $CurrentProvider.name 
			Model 			= $Model 	
			InputTokens 	= $InputTokens 
			OutputTokens	= $OutputTokens
			SrcLang			= $SourceLang
		}
		
		$SrcFileInfo.NewMap = $NewMap;
		
		$SrcFileInfo.status = "MapUpdate"
		write-host "	Saving $TranslationMapFile";
		SaveTranslationMap
		$SrcFileInfo.status = "translated";	
	} catch {
		$SrcFileInfo.error = $_;
		
		# Restore file backup!
		if($FileBackup){
			$SrcFileInfo.status = "Restoring"
			write-warning "	Restoring file backup due to errors..."
			$FileBackup | Set-Content -Encoding UTF8 -Path $TargetFilePath
		}
		
		$SrcFileInfo.status = "error";
		
		throw;
	}

		
}













