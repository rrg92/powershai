<#
	POWERSHAI - Powershell + Inteligência Artificial 
	Autor: Rodrigo Ribeiro Gomes
	https://powertuning.com.br/
	https://iatalk.ing
	
	
	LICENÇA DE USO 
		
		Este projeto tomou várias horas minhas, da minha família e até com minha filha recém nascida.
		Dia, tarde, madrugada. Vários conhecimentos embutidos aqui da PowerShell que acumulei em uma vida...
		
		Mas, mesmo assim, eu resolvi manter ele aberto e free, e o objetivo é mantê-lo FREE para sempre!
		É uma forma também de retribuir a comunidade técnica por tudo que já aprendi com ela!
		
		Isto é, você pode baixar, usar no seu computador, na sua empresa, vender embutido com algum produto, etc.
		Em suma, você é livre para usá-lo de forma comercial e não-comercial.
		
		Meu único pedido é que sempre mantenha a menção ao projeto original: https://github.com/rr92/powershai
		Deixe os créditos para o autor Rodrigo Ribeiro Gomes, da empresa Power Tuning, o qual também permitiu que eu usasse horas do meu trabalho para mexer com este código.
		Se o PowershAI te ajuda em algum projeto, eu ficarei muito orgulhoso em saber disso e essa menção certamente ajudará minha carreira de algum forma!
		Esta menção pode ser feita em qualquer lugar do seu projeto, como:
			- créditos 
			- help 
			- documentações públicas
			- Git do seu projeto 
			- menu de help
		
	
		Um OBRIGADO ESPECIAL à Power Tuning que sempre me deu a liberdade para conduzir esses projetos, mesmo usando horas da empresa!
		https://powertuning.com.br/
	
	
	USAGE LICENSE (English)

		This project took several hours of my time, my family’s time, and even time with my newborn daughter.  
		Day, afternoon, and late night. Several pieces of PowerShell knowledge accumulated over a lifetime are embedded here...

		But even so, I decided to keep it open and free, and the goal is to keep it FREE forever!  
		It's also a way of giving back to the technical community for everything I've learned from it!

		That means you can download it, use it on your computer, in your company, sell it embedded with a product, etc.  
		In short, you are free to use it commercially and non-commercially.

		My only request is that you always keep the mention of the original project: https://github.com/rr92/powershai  
		Give credit to the author, Rodrigo Ribeiro Gomes, from Power Tuning, who also allowed me to use work hours to deal with this code.  
		If PowershAI helps you in any project, I would be very proud to know that, and this mention will certainly help my career in some way!  
		This mention can be made anywhere in your project, such as:  
		  - credits  
		  - help  
		  - public documentation  
		  - your project’s Git  
		  - help menu

		A SPECIAL THANK YOU to Power Tuning, who has always given me the freedom to lead these projects, even using company hours!  
		https://powertuning.com.br/  
#>
$ErrorActionPreference = "Stop";

$PowershaiRoot = $PSScriptRoot

if(!$Global:POWERSHAI_SETTINGS){
	$Global:POWERSHAI_SETTINGS = @{
		provider = $null #ollama, huggingface
		baseUrl  = $null
		
		#providers settings!
		providers = @{}
		
		# commands 
		# Lista de comandos adicionados pelo usuario!
		UserTools = @{}
	}
}

$PROVIDERS = @{}
$POWERSHAI_USER_TOOLBOX = $null;
$POWERSHAI_PROVIDERS_DIR = Join-Path $PsScriptRoot "providers"

if(!$Global:POWERSHAI_SETTINGS.chats){
	$Global:POWERSHAI_SETTINGS.chats = @{}
}

if(!$Global:POWERSHAI_SETTINGS.OriginalPrompt){
	$Global:POWERSHAI_SETTINGS.OriginalPrompt = $Function:prompt
}

if(!$Global:POWERSHAI_SETTINGS.UserTools){
	$Global:POWERSHAI_SETTINGS.UserTools = @{}
}


 
###
###  Aux/helper/misc functions!
###		
###	As funções a seguir são de caráter auxiliar, isto é, usadas apenas internamente para facilitar algo no PowershAI.
### A maioria são de uso apenas interno pelo módulo!
###
###

# Simple verbose logging function
Function verbose {
	$ParentName = (Get-Variable MyInvocation -Scope 1).Value.MyCommand.Name;
	write-verbose ( $ParentName +':'+ ($Args -Join ' '))
}

# Aux function to set check custom types
function IsType($obj, $name){
	return $($Obj.psobject.TypeNames -contains "PowershaiType:$name");
}

# Aux function to set custom types
function SetType($obj, $name){
	
	if(-not(IsType $obj $name)){
		$Obj.psobject.TypeNames.insert(0,"PowershaiType:$name")
	}
}

# retorna a lista de parametros do caller!
# Return caller function param list
function GetMyParams(){

	$cmd = Get-PSCallStack
	$Caller = $cmd[1];
	
	$CmdParams = @($Caller.InvocationInfo.MyCommand.Parameters.values)
	
	$ParamList = @{};
	
	function GetCommonParams
	{
		[CmdletBinding()]
		param()
		$MyInvocation.MyCommand.Parameters.Keys
	}
	
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


function Get-PowershaiErrorDetails {
	<#
		.SYNOPSIS 
			Obtém mais detalhes sobre exceptions e ErrorRecords disparaods pelo Powershai!
	#>
	param(
		#O erro a ser analisado. Se null, utiliza o ultimo error!
		$ErrorObject = $error[0]
	)
	
	write-host $ErrorObject.GetType().FullName;
	write-host ([string]$ErrorObject);
	
	
	write-host "=== STACK === "
	if($ErrorObject.ScriptStackTrace){
		write-host $ErrorObject.ScriptStackTrace
	}
	
	
	
}

<#
	Obtém uma string codificada com um encoding específico. 
	Internamente, o Powershell (.NET) armazena tudo como unicode utf16 (https://learn.microsoft.com/en-us/dotnet/standard/base-types/character-encoding-introduction)
	Mas, podemos usar as classes de Text.Encoding para obter strings formadas por oturas sequências.  
	Isso é útil para enviar via protocolos (como HTTP), etc.  
	Se você tentar printar o resultado dessa função, pode não ser legível, devido a sequência de bytes diferentes.  
	Esta função é um auxiliar usada para testes somentes
#>
function GetPowershaiAuxEncodedString {
	param(
		$SourceStr
		,$TargetEncoding = "UTF-8"
		,#Se especifciado retorna apenas os bytes 
			[switch]$Bytes
	)
	
	#Aqui obtemos os bytes no encoding desejado.  
	#Internamente, o Powershell armazena os caraceres como UTF-16. As classes Text.Encoding convertem de UTF-16 para a sequencia de bytes no encoding desejado.  
	#FOr exemplo, innternamente, a string "á" é armazenada como um array contendo apenas 1 elemento: [char]225 (225 é o codepoint do á no Unicode).
	#Quando  usamos UTF8.Getbytes("á"), estamos pedindo que o powershel retorne o UTF-8 equiuvalente de "á", que é um array cim 2 posicoes: 195,196 (é assim que o "á" é representando no UTF-8)
	[byte[]]$TargetEncBytes = [Text.Encoding]::GetEncoding($TargetEncoding).GetBytes($SourceStr)
	
	if($Bytes){
		return $TargetEncBytes
	}
	
	#Uma vez que temos um array de bytes, podemos construir um tipo string de volta. 
	#Assi,podemos concatenar essa string em lugares que aceitam string, como concatenção.
	#Aqui, usamos uma "gambi": O encoding iso-8859-1 não faz nenhuma conversão de bytes. Por isso, podemos usar ele para ober a string a partir do byte.  
	#Assim, considerando o exemplo, anterior, será retornada uma string, formada peçla sequencia 195,196. Ao printar ela, vai parecer uma string completamente difernete (pos o Powershell exibe em outra codificação).
	return [Text.Encoding]::GetEncoding("iso-8859-1").GetString($TargetEncBytes)
}

#
# funcoes usadas para auxiliar alguma operacao ou encasuplar logica complexa!
function JoinPath {
	$Args -Join [IO.Path]::DirectorySeparatorChar
}


<#
	.SYNOPSIS
		Obtém uma referência para variável que define os default parameters 
		
	.DESCRIPTION  
		No Powershell, módulos tem seu próprio escopo de variáveis.  
		Portanto, ao tentar definir essa variável fora do escopo correto, não afetará os comandos dos módulos.  
		Este comando permite que o usuário tenha acesso a variável que controla o default parameter dos comandos do módulo.  
		Na maior parte, isso vai ser usado para debug, mas, eventualmente, um usuário pode querer definir parâmetros default.
		
	.EXAMPLE
		O exemplo abaixo mostra como definir a variável de ebug default do comanod Invoke-Http.
		$HttpDebug = @{}
		$ModDefaults = Get-PowershaiDefaultParams
		$ModDefaults['Invoke-Http:DebugVarName'] = 'HttpDebug';
		Note que o parãmetro -DebugVarName é um parâmetro existente no comando Invoke-Http.	
#>
function Get-PowershaiDefaultParams {
	return $PSDefaultParameterValues
}


<#
	.SYNOPSIS
		Cria um nova Exception cusotmizada para o PowershaAI
		
	.DESCRIPTION  
		FAciltia a criação de exceptions customizadas!
		É usada internamente pelos providers para criar exceptions com propriedades e tipos que podem ser restados posteriormente.
#>
function New-PowershaiError {
	param(
		#A mensagem da exception!
			$Message
		
		,#Propriedades personazalidas 
			$Props  = @{}
			
		,#Tipo adicional!
			$Type = $null
			
		,#Exception pai!
			$Parent = $null
	)
	
	$Ex = New-Object System.Exception($Message,$Parent)
	
	foreach($PropName in @($Props.keys)){
		$Ex | Add-Member -force Noteproperty $PropName $Props[$PropName]
	}
	
	if($Type){
		SetType $Ex $Type
	}
	
	return $ex;
}

	
# LOW LEVEL HTTP Functions
. (JoinPath $PSSCriptRoot "lib" "http.ps1")

<#
	.SYNOPSIS
		Mescla hashtables em uma hashtable de destino
		
	.DESCRIPTION  
		A hashtable de destino irá conter o valor atualizado das hashtables de origem. 
		Pode se especificar várias hashtables de origem, basta informar.
		Uma nova hashtable é retornada, sem alterar as existentes!
#>
function HashTableMerge {
	[CmdletBinding()]
	param(
		$Target
		
		,[parameter(ValueFromRemainingArguments)]
			$SourceTables
	)
	
	$Me = $MyInvocation.MyCommand;
	
	$NewTable = @{}
	
	if(!$Target){
		$Target = @{}
	}
	
	if(!$SourceTables){
		$SourceTables = @{}
	}
	
	$TableList = @($Target)
	$TableList += $SourceTables;
	
	foreach($SrcTable in $TableList){
		
		if($SrcTable -isnot [hashtable]){
			throw "POWERSHAI_MERGEHASH_ISNOT_HASHTABLE";
		}
		
		foreach($key in @($SrcTable.keys) ){
			
			#New table
			if(!$NewTable.Contains($key)){
				$NewTable[$key] = $SrcTable[$key];
				continue;
			}
			
			#Se as duas são com tipos diferentes, então sobrescreve
			$SrcValue = $SrcTable[$key]
			$NewValue = $NewTable[$key];
			
			# Se for um hashtable, recursivamente atualiza!
			if($SrcValue -is [hashtable] -and $NewValue -is [hashtable]){
				$SrcValue = & $Me $SrcValue $NewValue 
			}
			
			#Em todos o caso, src substitui o valor!
			$NewTable[$key] = $SrcValue;
		}
	}
	
	return $NewTable;
}


function RegArgCompletion {
	param(
		$Command
		,$Parameter
		,$Script
	)
	
	if(Get-Command -EA SilentlyContinue Register-ArgumentCompleter){
		@($Command) | %{
			Register-ArgumentCompleter -CommandName $_ -ParameterName $Parameter -ScriptBlock $Script
		}
	}
}

#Thanks from: https://www.powershellgallery.com/packages/DRTools/4.0.2.3/Content/Functions%5CInvoke-AESEncryption.ps1
function Invoke-AESEncryption {
    [CmdletBinding()]
    [OutputType([string])]
    Param
    ( 
        [Parameter(Mandatory = $true)]
        [ValidateSet('Encrypt', 'Decrypt')]
        [String]$Mode,

        [Parameter(Mandatory = $true)]
        [String]$Key,

        [Parameter(Mandatory = $true, ParameterSetName = "CryptText")]
        [String]$Text,

        [Parameter(Mandatory = $true, ParameterSetName = "CryptFile")]
        [String]$Path
    )

    Begin {
        $shaManaged = New-Object System.Security.Cryptography.SHA256Managed
        $aesManaged = New-Object System.Security.Cryptography.AesManaged
        $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::CBC
        $aesManaged.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
        $aesManaged.BlockSize = 128
        $aesManaged.KeySize = 256
    }

    Process {
        $aesManaged.Key = $shaManaged.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Key))

        switch ($Mode) {
            'Encrypt' {
                if ($Text) {$plainBytes = [System.Text.Encoding]::UTF8.GetBytes($Text)}
                
                if ($Path) {
                    $File = Get-Item -Path $Path -ErrorAction SilentlyContinue
                    if (!$File.FullName) {
                        Write-Error -Message "File not found!"
                        break
                    }
                    $plainBytes = [System.IO.File]::ReadAllBytes($File.FullName)
                    $outPath = $File.FullName + ".aes"
                }

                $encryptor = $aesManaged.CreateEncryptor()
                $encryptedBytes = $encryptor.TransformFinalBlock($plainBytes, 0, $plainBytes.Length)
                $encryptedBytes = $aesManaged.IV + $encryptedBytes
                $aesManaged.Dispose()

                if ($Text) {return [System.Convert]::ToBase64String($encryptedBytes)}
                
                if ($Path) {
                    [System.IO.File]::WriteAllBytes($outPath, $encryptedBytes)
                    (Get-Item $outPath).LastWriteTime = $File.LastWriteTime
                    return "File encrypted to $outPath"
                }
            }

            'Decrypt' {
                if ($Text) {$cipherBytes = [System.Convert]::FromBase64String($Text)}
                
                if ($Path) {
                    $File = Get-Item -Path $Path -ErrorAction SilentlyContinue
                    if (!$File.FullName) {
                        Write-Error -Message "File not found!"
                        break
                    }
                    $cipherBytes = [System.IO.File]::ReadAllBytes($File.FullName)
                    $outPath = $File.FullName -replace ".aes"
                }

                $aesManaged.IV = $cipherBytes[0..15]
                $decryptor = $aesManaged.CreateDecryptor()
                $decryptedBytes = $decryptor.TransformFinalBlock($cipherBytes, 16, $cipherBytes.Length - 16)
                $aesManaged.Dispose()

                if ($Text) {return [System.Text.Encoding]::UTF8.GetString($decryptedBytes).Trim([char]0)}
                
                if ($Path) {
                    [System.IO.File]::WriteAllBytes($outPath, $decryptedBytes)
                    (Get-Item $outPath).LastWriteTime = $File.LastWriteTime
                    return "File decrypted to $outPath"
                }
            }
        }
    }

    End {
        $shaManaged.Dispose()
        $aesManaged.Dispose()
    }
}

function PowerShaiEncrypt {
	param($str, $password)
	
	Invoke-AESEncryption -Mode Encrypt -text $str -key $password
}

function PowerShaiDecrypt {
	param($str, $password)
	
	Invoke-AESEncryption -Mode Decrypt -text $str -key $password
}

function PowershaiHash {
	param($str)
	
	$shaManaged = New-Object System.Security.Cryptography.SHA256Managed
	[System.Convert]::ToBase64String($shaManaged.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($str)))
}

# misc functions...

<#
	.SYNOPSIS
		Cria um quadro virtual de texto, e escreve caracteres dentro dos limites desse quadro
	
	.DESCRIPTION 
		Cria um quadro de desenho no console, que é atualizado em somente uma região específica!
		Você pode enviar várias linhas de texto e afuncao cuidará de manter o desenho no mesmo quadro, dando a impressão que apenas uma região está sendo atualizada.
		Para o efeito desejado, esta funcao deve ser invocada repetidamente, sem outros writes entre as invocacoes!
		
		Esta função só deve ser usada no modo interativo do powershell, rodando em uma janela de console.
		Ela é útil para usar em situações em que você quer ver o progresso de um resultado em string exatamente na mesma área, podendo comparar melhor variações.
		É apenas uma função auxiliar.
		
	.EXAMPLE
		O seguinte exemplo escreve 3 string de texto a cada 2 segundos.
		Você vai perceber que as strings serão escritas exatamente na mesm alinha, substuindo a anterior!
	
		"ISso",@("é","um teste"),"de escrita","com`nvarias`nlinhas!!" | Invoke-PowerhsaiConsoleDraw -w 60x10 {  $_; start-sleep -s 1 };
		
#>
function Invoke-PowerhsaiConsoleDraw {
	[CmdletBinding()]
	param(
		#Texto a ser escrito. Pode ser um array. Se ultrapassar os limties de W e H, será truncado 
		#Se é um script bloc, invoca o codigo passando o objeto do pipeline!
			$Text
			
		,#Max de caracteres em cada linha 
			$w = 10
			
		,#Max de linhas 
			$h = 10
			
		,#Caractere usado como espaço vazio 
			$BlankChar = " "
			
		,#Objeto do pipeline 
			[Parameter(ValueFromPipeline)]
			$PipeObj
			
		,#Repassa o objeto 
			[switch]$PassThru
	)
	
	begin {
		$CurrentPos = $Host.UI.RawUI.CursorPosition
		$NewXPos = 0
		$NewYPos = $CurrentPos.Y + 1;
		
		if($w -is [string]){
			$Parts = $w -Split "x"
			$w = [int]$Parts[0];
			$h = [int]$Parts[1];
		}
		
	}
	
	process {
		
		$VirtualScreen = @()
		$RawText = $text;

		if($RawText -is [scriptblock]){
			$Result = $PipeObj | % $RawText
			$RawText = $Result
		}
		elseif($RawText -eq $null){
			$RawText = $PipeObj
		}
		
		if($RawText -is [Array]){
			$Lines = $RawText
		} else {
			$Lines = $RawText -split "`r?`n"
		}
		
		$CurrLine = -1;
		while($CurrLine -lt $h){
			$CurrLine++;
			$Line = $Lines[$CurrLine]
			
			if($Line.length -gt $w){
				$Line = $line.substring(0,$w);
			} else {
				$Line += [string]($BlankChar[0])  * ($w - $Line.length)
			}
			
			$VirtualScreen += $line -replace "`t",$BlankChar;
		}
		
		[Console]::SetCursorPosition( $NewXPos, $NewYPos );
		write-host ($VirtualScreen -Join "`n")
		
		if($PassThru){
			write-output $PipeObj
		}
	}
}


<#
	.SYNOPSIS
		Obtém o provider ativo 
		
	.DESCRIPTION 
		Retorna o objeto que representa o provider ativo.  
		Os providers são implementados como objetos e ficam armazenados na memória da sessão, em uma variável global.  
		Esta função retorna o provider ativo, que foi definido com o comando Set-AiProvider.
		
		O objeto retorando é uma hashtable contendo todos os campos do provider.  
		Este comando é comumente usado pelos providers para obter o nome do provider ativo.  
		
		O parâmetro -ContextProvider retorna o provider atual onde o script está rodando.  
		Se estiver rodando em um script de um provider, ele vai retornar aquele provider, ao invés do provider definido com Set-AiProvider.
#>
function Get-AiCurrentProvider {
	param(
		#Se habilitado, usa o provider de contexto, isto é, se o código está rodando em um arquivo no diretorio de um provider, assume este provider.
		#Caso contrario, obtem o provider habilitado atualmente.
		[switch]$ContextProvider
		
		,#Stack alternativa a considerar! Veja mais em Get-AiNearProvider
			$CallStack = $null
	)
	
	if($ContextProvider){
		$Provider = Get-AiNearProvider -CallStack $CallStack
		
		if($Provider){
			return $Provider;
		}
	}
	
	
	$ProviderName = $POWERSHAI_SETTINGS.provider;
	$ProviderSlot = $PROVIDERS[$ProviderName];
	return $ProviderSlot;
}



function Get-AiNearProvider {
<#
	.SYNOPSIS
		Obtém o provider mais recente do script atual
		
	.DESCRIPTION 
		Este cmdlet é comumente uado pelos providers de forma indireta através de Get-AiCurrentProvider.  
		Ele olha na callstack do powershell e identifica se o caller (a função que executou) faz parte de um script de um provider.  
		Se for, ele retorna esse provider.
		
		Se a chamada foi feia em múltiplos providers, o mais recente é retornaod. Por exemplo, imagine esse cenário:
		
			Usuario -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
			
		Neste caso, note que existem 2 calls de providers envolvidas.  
		Neste caso, a funcao Get-AiNearProvider retornará o provider y, pois ele é o mais recente da call stack.  
#>
	param(
		#Usar um call stack específica.
		#Este parâmetro é útil quando uma funcao que invocou quer que se considere a olhar a partir de um ponto específico!
		$callstack
	)
	
	if(!$callstack){
		$CallStack = Get-PSCallStack
	}
	
	$NearProvider = $CallStack | ? { $_.ScriptName -like (JoinPath $POWERSHAI_PROVIDERS_DIR '*.ps1') } | select -first 1;
	
	if(!$NearProvider){
		return;
	}
	

	$RelPath 	= $NearProvider.ScriptName.replace((JoinPath $POWERSHAI_PROVIDERS_DIR ''),'');
	$Parts 		= $RelPath -split '[\\/]',2
	$ProviderName = $Parts[0].replace(".ps1","");
	
	return $PROVIDERS[$ProviderName];
}

<#
	.SYNOPSIS
		Altera o provider atual
		
	.DESCRIPTION 
		Providers são scripts que implementam o acesso à suas respectivas APIs.  
		Cada provider tem sua forma de invocar APIs, formato dos dados, schema da resposta, etc.  
		
		Ao mudar o provider, você afeta certos comandos que operam no provider atual, como `Get-AiChat`, `Get-AiModels`, ou os Chats, como Send-PowershaAIChat.
		Para saber mais detalhes sobre os providers consule o tópico about_Powershai_Providers
#>
function Set-AiProvider {
	[CmdletBinding()]
	param(
		#nome do provider 
		$provider
	)
	
	$ProviderSettings = $PROVIDERS[$provider];
	
	if(!$ProviderSettings){
		throw "POWERSHAI_PROVIDER_INVALID: $provider";
	}
	
	$POWERSHAI_SETTINGS.provider = $provider;
}

RegArgCompletion Set-AiProvider provider {
	param($cmd,$param,$word,$ast,$fake)
	
	@($PROVIDERS.keys) | ? {$_ -like "$word*"} | %{$_}
}

<#
	Invoca funções em um provider!
	O PowershAI espera que certas funções sejam implementandas pelos providers.  
	
	Por exemplo, a função Chat é usada quando invocamos o Get-AiChat.  
	Estas funções devem ser implementadas para prover a funcionalidade de maneira padrão.  
	Essas funções são implementadas usando o nome do provider, por exemplo: openai_Chat.  
	
	O Powershai usa esta função para invocar as funcoes implementadas pelo powershai. Ela atua como um wrapper e facilitado e trata cenários comuns a todas essas invocações.
#>
function PowerShaiProviderFunc {
	param(
		$FuncName
		,$FuncParams
		,[switch]$Ignore
		,[switch]$CheckExists
		,$ProviderName = $null
	)
	
	if($ProviderName){
		$provider = $PROVIDERS[$ProviderName];
	} else {
		$provider = Get-AiCurrentProvider
	}
	
	
	$FuncPrefix 	= $provider.name+"_";
	$FullFuncName 	= $FuncPrefix + $FuncName;
	
	if(!$FuncParams){
		$FuncParams = @{}
	}
	
	if(Get-Command $FullFuncName -EA SilentlyContinue){
		
		if($CheckExists){
			return $true;
		}
		
		# these parameter must be available to providers have access to raw invoked data!
		$ProviderFuncRawData = @{
			params = $FuncParams
		}
		
		& $FullFuncName @FuncParams
	} else {
		
		if($CheckExists){
			return $false;
		}
		
		if(!$Ignore){
			throw "POWERSHAI_PROVIDERFUNC_NOTFOUND: FuncName = $FuncName, FuncPrefix = $FuncPrefix, FullName = $FullFuncName. This erros can be a bug with powershai. Ask help in github or search!"
		}
	}
	
}

<#
	Obtém configuracoes especifcias de um provider especifico, a partir de uma key.
	ProviderData é como se fosse um pequeno banco de dados de configurações no formato de dicionario.  
	Os providers armazenam configurações do usuário ali.  
	
	Todo provider tem 2 slots de configuração: User e Default. 
	O default é o slot com as confniguirações com valores default definido pelo proprio provider.  
	O USer é o slot com a sconfigurações que foram definidas pelo usuário. 
	Ao ser recuperada, o powershai tenta primeiro trazer a versão no slot User. Se não encontra, otbém do default. 
#>
function GetProviderData {
	param($name, $Key)
	
	$UserDefined 	= $POWERSHAI_SETTINGS.providers[$name];
	$provider 		= $PROVIDERS[$name]
	
	if($UserDefined){
		$UserSetting 	= $UserDefined[$Key];
	} else {
		$UserDefined = @{};
	}
	
	if($provider){
		$DefaultSetting	= $Provider[$key];
	}
	
	if($UserDefined.contains($Key)){
		return $UserSetting
	}
	
	return $DefaultSetting
}

# altera configurações de um provider, dado a key e o valor.
function SetProviderData {
	param($name, $Key, $value)
	
	$UserDefined = $POWERSHAI_SETTINGS.providers[$name];
	$UserDefined[$key] = $value;
}

# Obtém configurações do providerr atual, a partir de um akey
function GetCurrentProviderData {
	param($key,[switch]$ContextProvider)
	
	$Provider = Get-AiCurrentProvider -ContextProvider:$ContextProvider
	GetProviderData -name $Provider.name -key $key
}

# Atualiza configurações do provider atual
function SetCurrentProviderData {
	param(
		$key,
		$value
		,[switch]$ContextProvider
	)
	
	$Provider = Get-AiCurrentProvider -ContextProvider:$ContextProvider
	SetProviderData -name $provider.name -key $key -value $value;
}

<#
	.SYNOPSIS
		Retorna os providers disponíveis
	
	.DESCRIPTION
		Este comando lista os providers implementando sno powershai.  
		PAra saber mais sobre providers consulte o tópico about_Powershai_Providers
#>
function Get-AiProviders {
	param()
	
	@($PROVIDERS.keys) | %{
		$Provider = $PROVIDERS[$_];
		

		
		$ProviderInfo = [PSCustomObject](@{name = $_} + $Provider.info )
		
		$ProviderInfo | Add-Member Noteproperty Chat (PowerShaiProviderFunc "Chat" -Provider $Provider.name -CheckExists)
		
		$ProviderInfo
	}
}


# Get all models!
$POWERSHAI_MODEL_CACHE = @{
	Provider = $null
	ModelList = $null
	ByName = @{}
}


function Get-AiModels {
<#
	.SYNOPSIS
		lista os modelos disponíveis no provider atual
	
	.DESCRIPTION
		Este comando lista todos os LLM que podem ser usados com o provider atual para uso no PowershaiChat.  
		Esta função depende que o provider implemente a função GetModels.
		
		O objeto retornado varia conforme o provider, mas, todo provider deve retorna um array de objetos, cada deve conter, pelo menos, a propridade id, que deve ser uma string usada para identificar o modelo em outros comandos que dependam de um modelo.
#>
	[CmdletBinding()]
	param()
	$ModelList 	= PowerShaiProviderFunc "GetModels"
	$Provider 	= Get-AiCurrentProvider;
	$ProviderName = $Provider.name;
	
	$POWERSHAI_MODEL_CACHE.ModelList = $ModelList | %{  
									$POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$($_.name)"] = $_;
									
									if($_.tools -eq $null){
										$ModelInfo = Get-AiModel -ProviderOnly -CheckTools $_.name
										$_ | Add-member -Force noteproperty tools $ModelInfo.tools;
									}
									
									
									
									$_.name;
								} 
	$POWERSHAI_MODEL_CACHE.Provider = (Get-AiCurrentProvider).name
	
	return $ModelList
}


function Get-AiModel {
<#
	.SYNOPSIS
		Retorna as informacoes de um model específico do cache!
	
	.DESCRIPTION
		Se o model existe em cache, usa os dados em cache!
		Se não existe, tenta consultar, caso não tenha sido tentado ainda.
#>	
	param(
		#Nome do model 
			$ModelName
			
		,#Se informado, verifica se o modelo está na lista de supported tools do provider!
		#Se sim, evita ir ao cache ou enviar requisição!
			[switch]$CheckTools
			
		,#Checa somente no provider!
			[switch]$ProviderOnly
	)
	
	$provider = Get-AiCurrentProvider
	$ProviderName = $provider.name;
	
	$SupportedTools = GetCurrentProviderData ToolsModels
	
	$FakeModel = @{tools = $true}
	if($SupportedTools){
		if($SupportedTools -eq "*"){
			return $FakeModel;
		}
		
		if($SupportedTools -eq "*none*"){
			$FakeModel.tools = $false;
			return $FakeModel;
		}
		
		foreach($ToolReg in @($SupportedTools)){
			
			if($ToolReg -like 'reg:*'){
				$RegExpr = $ToolReg -replace '^reg:','';
				
				if($ModelName -match $RegExpr){
					return $FakeModel;
				}
			}
			elseif($ModelName -like $ToolReg){
				return $FakeModel;
			}
		}
		
		$FakeModel.tools = $False;
		return $FakeModel;		
	}
	elseif($ProviderOnly){
		$FakeModel.tools = $false;
		return $FakeModel;
	}
	
	
	$i = 2;
	$CachedModel = $POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$ModelName"]
	
	if($CachedModel){
		
		if($CachedModel.NotFound){
			return;
		}
		
		return $CachedModel;
	}
	
	# check in cache...
	$null = Get-AiModels
	
	# If not found, update to avoid repetitive calls!
	$CachedModel = $POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$ModelName"]
	if(!$CachedModel){
		$POWERSHAI_MODEL_CACHE.ByName["$ProviderName/$ModelName"] = @{NotFound = $true};
	}
}


function Set-AiDefaultModel {
<#
	.SYNOPSIS
		Configurar o LLM default do provider atual
	
	.DESCRIPTION
		Usuários podem configurar o LLM default, que será usado quando um LLM for necessário.  
		Comandos como Send-PowershaAIChat, Get-AiChat, esperam um modelo, e se não for informado, ele usa o que foi definido com esse comando.  
#>
	[CmdletBinding()]
	param(
		#Id do modelo, conforme retornado por Get-AiModels
		#Você pode usar tab para completar a linha de comando.
			$model
			
		,#Força definir o modelo, mesmo que não seja retornaod por Get-AiModels 
			[switch]$Force
	)
	
	$ElegibleModels = @(Get-AiModels | ? { $_.name -like $model+"*" })
	$ExactModel 	= $ElegibleModels | ?{ $_.name -eq $model }
	
	if($ExactModel){
		verbose "Using exact model!";
		SetCurrentProviderData DefaultModel $model;
		return;
	}
	
	verbose "ElegibleModels: $($ElegibleModels|out-string)"
	
	if(!$ElegibleModels){
		if($Force){
			write-warning "Model not found with that name. Forcing usage...";
			SetCurrentProviderData DefaultModel $model;
			return;
		} else {
			throw "POWERSHAI_INVALID_MODEL: $model. Use -force to for usage!";
		}
	}
	
	if($ElegibleModels.count -ge 2 -and !$ExactModel){
		throw "POWERSHAI_DEFAULTMODEL_AMBIGUOUS: Existem vários modelos com o mesmo nome $model e nenhum com este nome exato. Seja mais específico."
	}
	
	$model = $ElegibleModels[0].name
	
	if($ElegibleModels.count -eq 1 -and !$ExactModel){
		write-warning "Modelo exato $model nao encontrado. Usando o único mais próximo: $model"
	}
	
	SetCurrentProviderData DefaultModel $model;
}


# Lista os ids de models para o arg completion!
function GetModelsId {
	
	$CurrentProvider = Get-AiCurrentProvider
	
	
	if(!$POWERSHAI_MODEL_CACHE.ModelList){
		$null = Get-AiModels
	}
	
	if($CurrentProvider.name -ne $POWERSHAI_MODEL_CACHE.Provider){
		$null = Get-AiModels
	}

	$POWERSHAI_MODEL_CACHE.ModelList
}


RegArgCompletion Set-AiDefaultModel model {
	param($cmd,$param,$word,$ast,$fake)
	
	GetModelsId | ? {$_ -like "$word*"} | %{$_}
}


function Get-AiChat {
<#
	.SYNOPSIS
		Envia mensagens para um LLM e retorna a resposta 
		
	.DESCRIPTION 
		Esta é a forma mais básica de Chat promovida pelo PowershAI.  
		Com esta função, você pode enviar uma mensagem para um LLM do provider atual.  
		
		Esta função é mais baixo nível, de maneria padronizada, de acesso a um LLM que o powershai disponibiliza.  
		Ela não gerencia histórico ou contexto. Ela é útil para invocar promps simples, que não requerem várias interações como em um Chat. 
		Apesar de suportar o Functon Calling, ela não executa qualquer código, e apenas devolve a resposta do modelo.
		
		
		
		** INFORMACOES PARA PROVIDERS
			O provider deve implementar a função Chat para que esta funcionalidad esteja disponíveil. 
			A função chat deve retornar um objeto com a resposta com a mesma especificação da OpenAI, função Chat Completion.
			Os links a seguir servem de base:
				https://platform.openai.com/docs/guides/chat-completions
				https://platform.openai.com/docs/api-reference/chat/object (retorno sem streaming)
			O provider deve implementar os parâmetros dessa função. 
			Veja a documentação de cada parãmetro para detalhes e como mapear para um provider;
			
			Quando o modelo não suportar um dos parâmetros informados (isto pé, não houver funcionalidade equivalente,ou que possa ser implementanda de maneira equivalente) um erro deverá ser retornado.
#>
	[CmdletBinding()]
	param(
         #O prompt a ser enviado. Deve ser no formato descrito pela função ConvertTo-OpenaiMessage
			$prompt
        
		,#Temperatuta do modelo 
			$temperature   = 0.6
			
        ,#Nome do modelo. Se não especificado, usa o default do provider.
			$model         = $null
			
        ,#Máximo de tokens a ser retornado 
			$MaxTokens     = 1024
			
		,#Formato da resposta 
		 #Os formatos aceitáveis, e comportamento, devem seguir o mesmo da OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
		 #Atalhos:
		 #	"json"|"json_object", equivale a {"type": "json_object"}
		 #	objeto deve especificar um esquema como se fosse passado direatamente a API da Openai, no campo response_format.json_schema
			$ResponseFormat = $null
		
		,#Lista de tools que devem ser invocadas!
		 #Você pode usar o comandos como Get-OpenaiTool*, para transformar funcões powershell facilmente no formato esperado!
		 #Se o modelo invocar a função, a resposta, tanto em stream, quanto normal, deve também seguir o modelo de tool caling da OpenAI.
		 #Este parâmetro deve seguir o mesmo esquema do Function Calling da OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools
			$Functions 	= @()	
			

		,#Especifique parâmetros diretos da API do provider.
		 #Isso irá sobrescrever os valores que foram calculados e gerados com base nos outros parâmetros.
			$RawParams	= @{}
		
		,#Habilita o modelo Stream 
		 #Você deve especificar um ScriptBlock que será invocado para cada texto gerado pelo LLM.
		 #O script deve receber um parâmetro que representa cada trecho, no mesmo formato de streaming retornado
		 #	Este parâmetro é um objeto que conterá a propridade choices, que é nom mesmo esquema retornado pelo streaming da OpenAI:
		 #		https://platform.openai.com/docs/api-reference/chat/streaming		 
			$StreamCallback = $null
			
		,#Incluir a resposta da API em um campo chamado IncludeRawResp
			[switch]$IncludeRawResp	
	)
	
	$Provider = Get-AiCurrentProvider
	$FuncParams = $PsBoundParameters;
	
	if($ResponseFormat -in "json","json_object"){
		$FuncParams.ResponseFormat = @{type = "json_object"}
	} elseif($ResponseFormat) {
		$FuncParams.ResponseFormat = @{
				type = "json_schema"
				json_schema = $FuncParams.ResponseFormat
			}
	}

	$ModelName = $model;
	if(!$ModelName){
		$ModelName = GetCurrentProviderData DefaultModel
	}
	
	
	$model = Get-AiModel $ModelName -CheckTools;
	
	if(!$model.tools){
		verbose "Turning off functions due to unsuportted tool calling in model $ModelName";
		# Remove function call!
		# TODO: Add Chat parameter to control what do!
		$FuncParams.Functions = $null
		
	}
	
	$FuncParams['model'] = $ModelName
	PowerShaiProviderFunc "Chat" -FuncParams $FuncParams;
}

# Representa cada interação feita com o modelo!
function NewAiInteraction {
	return @{
			req  		= $null	# the current req count!
			sent 		= $null # Sent data!
			rawAnswer  	= $null # the raw answer returned by api!
			stopReason 	= $null	# The reason stopped!
			error 		= $null # If apply, the error ocurred when processing the answer!
			seqError 	= $null # current sequence error
			toolResults	= @() # lot of about running functino!
		}
}



<#
	.SYNOPSIS
		Envia mensagem para um LLM, com suporte a Tool Calling, e executa as tools solicitadas pelo modelo como comandos powershell.
		
	.DESCRIPTION
		Esta é uma função auxiliar para ajudar a fazer o processamento de tools mais fácil com powershell.
		Ele lida com o processamento das "Tools", executando quando o modelo solicita!
		
		Você deve passar as tools em um formato específico, documentando no tópico about_Powershai_Chats
		Esse formato mapeia corretamente funções e comandos powershell pra o esquema aceitável pela OpenAI (OpenAPI Schema).  
		
		Este comando encapsula toda a lógica que identifica quando o modelo quer invocar a função, a execução dessas funções,e o envio dessa resposta de volta ao modelo.  
		Ele fica nesse loop até que o modelo pare de decidir invocar mais funções, ou que o limite de interações (sim, aqui chamamos de interações mesmo, e não iterações) com o modelo tenha finalizado.
		
		O conceito de interação é simples: Cada vez que a função envia um prompt para o modelo, conta como uma integração.  
		Abaixo está um fluxo típico que pode acontecer:
			

		Você pode obter mais detalhes do funcionamento consultando o tópico about_Powershai_Chats
#>
function Invoke-AiChatTools {
	[CmdletBinding()]
	param(
		$prompt
		
		,# Array de tools, conforme explicado na doc deste comando
		 # Use os resultado de Get-OpenaiTool* para gerar os valores possíveis.  
		 # Você pode passar um array de objetos do tipo OpenaiTool.
		 # Se uma mesma funcoes estiver definida em mais de 1 tool, a primeira encontrada na ordem definida será usada!
			$Tools		= $null
			
		,$PrevContext		= $null
		,# máx output!
			$MaxTokens			= 500	
		,# No total, permitir no max 5 iteracoes!
			$MaxInteractions  		= 10	
			
		,# Quantidade maximo de erros consecutivos que sua funcao pode gerar antes que ele encerre.
			$MaxSeqErrors 		= 2	

			
		,$temperature		= 0.6	
		,$model 			= $null
		
		,# Event handler
		# Cada key é um evento que será disparado em algum momento por esse comando!
		# eventos:
		#	answer: disparado após obter a resposta do modelo (ou quando uma resposta fica disponivel ao usar stream).
		#	func: disparado antes de iniciar a execução de uma tool solicitada pelo modelo.
		# 	exec: disparado após o modelo executar a funcao.
		# 	error: disparado quando a funcao executada gera um erro
		# 	stream: disparado quando uma resposta foi enviada (pelo stream) e -DifferentStreamEvent
		# 	beforeAnswer: Disparado após todas as respostas. Util quando usado em stream!
		# 	afterAnswer: Disparado antes de iniciar as respostas. Util quando usado em stream!
			$on				= @{} 	
									
		,# Envia o response_format = "json", forçando o modelo a devolver um json.
			[switch]$Json				
		
		,#Adicionar parâmetros customizados diretamente na chamada (irá sobrescrever os parâmetros definidos automaticamente).
			$RawParams			= $null
			
		,[switch]$Stream
	)
	
	$ErrorActionPreference = "Stop";
	
	# Converts the function list user passed to format acceptable by openai!
	$OpenaiTools = @()

	#toolbox = conjutno de várias tools que foi gerada a partir de um script file, grupo de funcoes, etc.
	# é cada item passado em Tools (Chamamos de toolbox para desambiguar com o cocneito original de tool da openai)
	$FunctionMap = @{}
	foreach($Toolbox in @($Tools)){
		foreach($Tool in $Toolbox.tools){
			$OpenaiTools += $Tool ;
			$FunctionName 	= $Tool.function.name;
			
			if($FunctionMap[$FunctionName]){
				write-warning "Tool $ToolName duplicate..."
			} else {
				$FunctionMap[$FunctionName] = @{
					SrcBox = $Toolbox
				}
			}
		}
	}
	
	# initliza message!
	$Message 	= New-Object System.Collections.ArrayList
	$Message.AddRange($prompt);
	
	$TotalPromptTokens 	= 0;
	$TotalOutputTokens 	= 0;
	
	$AllInteractions = @();
	
	$emit = {
		param($evtName, $interaction)
		
		$evtScript = $on[$evtName];
		
		if(!$evtScript){
			return;
		}
		
		try {
			$null = & $evtScript $interaction @{event=$evtName}
		} catch {
			write-warning "EventCallBackError: $evtName";
			write-warning $_
			write-warning $_.ScriptStackTrace
		}
	}
			
	
	# Vamos iterar em um loop chamando o model toda vez.
	# Sempre que o model retornar pedindo uma funcao, vamos iterar novamente, executar a funcao, e entregar o resultado pro model!
	$ReqsCount = 0;
	$FuncSeqErrors = 0; #Indicates how many consecutive errors happens!
	:Main while($true){
		#Vamos avançr o numero de requests totais que ja fizemos!!
		$ReqsCount++;
		
		#This object is created every request and will store all data bout interaction!
		$AiInteraction = NewAiInteraction
		$AiInteraction.req = $ReqsCount;
		
		# Parametros que vamos enviar a openai usando a funcao openai!
		$Params = @{
			prompt 			= @($Message)
			temperature   	= $temperature
			MaxTokens     	= $MaxTokens
			Functions 		= $OpenaiTools
			model 			= $model
			RawParams		= $RawParams
		}
		
		$StreamProcessingData = @{
			num = 1
		}
		$ProcessStream = {
			param($Answer)
			
			$AiInteraction.stream = @{
				answer 	= $Answer
				emiNum 	= 0
				num 	= $StreamProcessingData.num++
			}
			
			
			
			& $emit "stream" $AiInteraction
		}
	
		
		if($Stream){
			$Params['StreamCallback'] = $ProcessStream
		}
		
		if($Json){
			#https://platform.openai.com/docs/guides/text-generation/json-mode
			$Params.ResponseFormat = "json_object";
			$Params.prompt += "s: Response in JSON";
		}
		
		$AiInteraction.sent = $Params;
		$AiInteraction.message = @($Message);
		
		# Se chegamos no limite, então naos vamos enviar mais nada!
		if($ReqsCount -gt $MaxInteractions){
			$AiInteraction.stopReason = "MaxReached";
			break;
		}
		
		
		write-verbose "Sending Request $ReqsCount";
		# manda o bla bla pro gpt...
		& $emit "send" $AiInteraction
		$Answer = Get-AiChat @Params;
		$AiInteraction.rawAnswer = $Answer;
		$AllInteractions += $AiInteraction;
		
		& $emit "answer" $AiInteraction
		
		if($Answer.stream){
			$ModelResponse = $Answer
		} else {
			$ModelResponse = $Answer.choices[0];
		}
		
		verbose "FinishReason: $($ModelResponse.finish_reason)"
		
		$WarningReasons = 'length','content_filter';
		
		if($ModelResponse.finish_reason -in $WarningReasons){
			write-warning "model finished answering due to $($ModelResponse.finish_reason)";
		}
	
		# Model asked to call a tool!
		if($ModelResponse.finish_reason -eq "tool_calls"){
			
			# A primeira opcao de resposta...
			$AnswerMessage = $ModelResponse.message;
			$ToolCallMsg = $AnswerMessage
		
			$ToolCalls = $AnswerMessage.tool_calls
			
			verbose "TotalToolsCals: $($ToolCalls.count)"
			foreach($ToolCall in $ToolCalls){
				$CallType = $ToolCall.type;
				$ToolCallId = $ToolCall.id;
				
				#Build the response message that will sent back!
				$FuncResp = @{
					role 			= "tool"
					tool_call_id 	= $ToolCallId
					
					#Set to a default message!
					content	= "ERROR: Tools was not executed due some unknown problem!";
				}
					
				verbose "Processing tool call $ToolCallId"
				
				try {
					if($CallType -ne 'function'){
						throw "POWERSHAI_CHATTOOLS_INVALID_LLM_CALLTYPE: Tool type $CallType not supported"
					}
					
					$FuncCall = $ToolCall.function
					
					#Get the called function name!
					$FuncName = $FuncCall.name
					verbose "	FuncName: $FuncName"

					# acha a tool na lista!
					$FunctionInfo = $FunctionMap[$FuncName]
					
					if(!$FunctionInfo){
						throw "POWERSHAI_CHATTOOLS_NOFUNCTIONMAP: Function $FuncName was invoked, but no function map found. This can be PowershAI bug or LLM incorrect call!"
					}
					
					$SrcToolbox = $FunctionInfo.SrcBox;
					$NoSplatArgs = $false;
					if($SrcToolbox.map){
						try {
							$MapResult = (& $SrcToolbox.map $FuncName $SrcToolbox)
							$TheFunc = $MapResult.Func
							$NoSplatArgs = $MapResult.NoSplatArgs;
						} catch {
							write-warning "POWERSHAI_CHATTOOLS_PSMAP_ERROR: ChatTools failed get command name for tool $FuncName"
							throw
						}
					} else {
						$TheFunc = $FuncName
					}
					
					if(!$TheFunc){
						throw "POWERSHAI_CHATTOOLS_NOFUNCTION: No function name was returned by map of $FuncName. This can be a bug of Powershai or LLM wrong call."
					}
					
					#Here wil have all that we need1
					$FuncArgsRaw =  $FuncCall.arguments
					verbose "	Arguments: $FuncArgsRaw";
					
					#We assuming model sending something that can be converted...
					$funcArgs = $FuncArgsRaw | ConvertFrom-Json;
					
					
					#Then, we can call the function!
					$ArgsHash = @{};
					$funcArgs.psobject.properties | %{ $ArgsHash[$_.Name] = $_.Value  };
					
					$CurrentToolResult = @{ 
						hash 	= $ArgsHash
						obj 	= $funcArgs 
						name 	= $FuncName
						id 		= $ToolCallId
						resp 	= $FuncResp
					}
					
					$AiInteraction.toolResults += $CurrentToolResult
					
					& $emit "func" $AiInteraction $CurrentToolResult
					
					verbose "Calling function $FuncName ($FuncInfo)"
					
					if($NoSplatArgs){
						$ArgsHash = @($ArgsHash)
					}
					
					$FuncResult = & $TheFunc @ArgsHash 
					
					if($FuncResult -eq $null){
						$FuncResult = @{};
					}
					
					$FuncResp.content = (Format-PowershaiContext $FuncResult)
					& $emit "funcresult" $AiInteraction $CurrentToolResult $FuncResult
					
					
					
					# TODO: Add formatter!
					
					
					$FuncSeqErrors = 0;
				} catch {
					$err = $_;
					
					& $emit "error" $AiInteraction
					
					#Add curent error to this object to caller debug...
					$AiInteraction.error = $_;
					
					#just log in screen to caller know about these errors!
					write-warning "Processing answer of model resulted in error. Id = $ToolCallId";
					write-warning "FuncName:$FuncName, Request:$ReqsCount"
					write-warning ("ERROR:")
					write-warning $err
					write-warning $err.ScriptStackTrace
					
					$FuncResp.content = "ERROR:"+$err;
					
					#Resets the seq errorS!
					$FuncSeqErrors++;
					$AiInteraction.seqError = $FuncSeqErrors;
					if($FuncSeqErrors -ge $MaxSeqErrors){
						$AiInteraction.stopReason = "MaxSeqErrorsReached";
						write-warning "Stopping due to max consecutive errors";
						break Main;
					}
				}
				
				& $emit "exec" $AiInteraction
				
				# Add tool and its answer!
				# Add current message to original message to provided previous context!
				$Message.AddRange(@(
					$ToolCallMsg
					$FuncResp
				))
				
			}
			
			#Start sending again...
			continue;
		}
		
		# se chegou aqui é pq o gpt processou tudo e nao precisou invocar uma funcao!
		#entao, podemos encerrar a bagaça!
		break;
	}
	
	$AllAnswers = $AllInteractions | %{ $_.rawAnswer };
	$AnswerCost = Get-OpenAiAnswerCost $AllAnswers
	
	return @{
		answer 			= $Answer 			# last answer					
		interactions	= $AllInteractions
		tools 			= $OpenAiTools
		costs 			= $AnswerCost
	}
}

<#
	.SYNOPSIS 
		Exporta as configurações da sessão atual para um arquivo, criptografado por uma senha
		
	.DESCRIPTION
		Este cmdlet é útil para salvar configurações, como os Tokens, de maneira segura.  
		Ele solicia uma senha e usa ela para criar um hash e criptografar os dados de configuração da sessão em AES256.  
		
		As configurações exportadas são todas aquelas definidas na variável $POWERSHAI_SETTINGS.  
		Essa variável é uma hashtable contendo todos os dados configurados pelos providers, o que inclui os tokens.  
		
		Por padrão, os chats não são exportados devido a quantidade de dados envolvidos, o que pode deixar o arquivo muito grande!
		
		O arquivo exportado é salvo em um diretório criado automaticamente, por padrão, na home do usuário ($HOME).  
		Os objetos são exportados via Serialization, que é o mesmo método usado por Export-CliXml.  
		
		Os dados são exportados em um formato próprio que pode ser importado apenas com Import-PowershaiSettings e informando a mesma senha.  
		
		Uma vez que o PowershAI não faz um export automático, é recomendo invocar esse comando comando sempre que houver alteração de configuração, como a inclusão de novos tokens.  
		
		O diretório de export pode ser qualquer caminho válido, incluindo cloud drives como OneDrive,Dropbox, etc.  
	
		Este comando foi criado com o intuito de ser interativo, isto é, precisa da entrada do usuário em teclado.
		
	.EXAMPLE 
		# Exportando as configurações padrões!
		> Export-PowershaiSettings 
		
		
		
	.EXAMPLE 
		# Exporta tudo, incluindo os chats!
		> Export-PowershaiSettings -Chat  
	
	.EXAMPLE
		# Exportando para o OneDrive
		> $Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
		> Export-PowershaiSettings
			
#>
function Export-PowershaiSettings {
	[CmdletBinding()]
	param(
		#Diretório de export 
		#Por Padrão, é um diretorio chamado .powershai no profile do usuário, mas pode especificar a variável de ambiente POWERSHAI_EXPORT_DIR para alterar.
			$ExportDir = $Env:POWERSHAI_EXPORT_DIR
		
		,#Se especificado, inclui os chats no export 
		 #Todos os chats serão exportados
			[switch]$Chats
	)
	
	$Password = Get-Credential "ExportPassword";
	
	$FinalData = @{
		IsRemoved = $true
	}
	
	if(!$ExportDir){
		$ExportDir = JoinPath $Home .powershai 
		$null = New-Item -Force -Itemtype Directory -Path $ExportDir;
	}
	
	write-verbose "ExportDir: $ExportDir";
	$ExportFile = JoinPath $ExportDir "exportedsession.xml"
	
	$Check 		= [Guid]::NewGuid().Guid
	
	write-verbose "Hashing check: $Check";
	$CheckHash 	= PowershaiHash $Check
	
	$ExportData = @{};
	
	foreach($KeyName in @($POWERSHAI_SETTINGS.keys) ){
		$ExportData[$KeyName] = $POWERSHAI_SETTINGS[$KeyName];
	}
	
	if(!$Chats){
		$ExportData.Remove("chats");
	}
	
	write-verbose "Serializaing..."
	$Serialized =  [System.Management.Automation.PSSerializer]::Serialize($ExportData);
	$Decrypted = @(
		"PowerShai:$($Check):$CheckHash"
		$Serialized;
	) -Join "`n"
	
	
	write-verbose "Encrypting... Serialized: $($Serialized.length)"
	$Encrypted = PowerShaiEncrypt -str 	$Decrypted -password $Password.GetNetworkCredential().Password
	
	Set-Content -Path $ExportFile  -Value $Encrypted;
	
	write-host "Exported to: $ExportFile";
	#$POWERSHAI_SETTINGS | Export-CliXml $ExportFile
}

<#
	.SYNOPSIS 
		Importa uma configuração exportada com Export-PowershaiSettings
		
	.DESCRIPTION
		Este cmdlet é o pair do Export-PowershaiSettings, e como o nome indica, ele importa os dados que foram exportados.  
		Você deve garantir que a mesma senha e o mesmo arquivo são passados.  
		
		IMPORTANTE: Este comando sobscreverá todos os dados configurados na sessão. Só execute ele se tiver certeza absoluta que nenhum dado configurado previamente pode ser perdido.
		Por exemplo, alguma API Token nova gerada recentemente.
		
		Se você estivesse especifciado um caminho de export diferente do padrão, usando a variável POWERSHAI_EXPORT_DIR, deve usa ro mesmo aqui.
		
		O processo de import valida alguns headers para garantir que o dado foi descriptografado corretamente.  
		Se a senha informanda estiver incorreta, os hashs não vão ser iguais, e ele irá disparar o erro de senha incorreta.
		
		Se, por outro lado, um erro de formado invalido de arquivo for exibido, significa que houve alguma corrupção no proesso de import ou é um bug deste comando.  
		Neste caso, você pode abrir uma issue no github relatando o problema.
		
		
		
	.EXAMPLE 
		# Import padrão
		> Import-PowershaiSettings
		
		
	
	.EXAMPLE
		# Importando do OneDrive
		> $Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
		> Import-PowershaiSettings
		
		Importa as configurações que foram exportadas para um diretório alternativo (one drive).
#>
function Import-PowershaiSettings {
	[CmdletBinding()]
	param($ExportDir = $Env:POWERSHAI_EXPORT_DIR)
	

	if(!$ExportDir){
		$ExportDir = JoinPath $Home .powershai;
	}
	
	write-verbose "ExportDir: $ExportDir";
	$ExportedFile = JoinPath $ExportDir "exportedsession.xml"
	
	if(-not(Test-Path $ExportedFile)){
		write-warning "Nothing to import at $ExportedFile";
		return;
	}
	
	$Encrypted = Get-Content $ExportedFile;
	write-verbose "	Encrypted content length: $($Encrypted.length)"
	$Password = Get-Credential "file password";
	$DecryptKey = $Password.GetNetworkCredential().Password
	
	try {
		$Decrypted = PowerShaiDecrypt $Encrypted $DecryptKey;
	} catch {
		write-warning "Decrypted process failed. Can be some bug of powershai. Check errors!";
		throw;
	}
	
	$Lines 		= $Decrypted -split "`n",2
	$CheckData 	= $Lines[0]
	$Data 		= $Lines[1];
	
	write-verbose "CheckData: $CheckData";
	$CheckParts = $CheckData -split ":";
	$CheckGuid  = $CheckParts[1]
	$CheckExpected = $CheckParts[2];
	$CurrentCheckGuid = PowershaiHash $CheckGuid
	
	
		
	if($CheckExpected -ne $CurrentCheckGuid){
		write-verbose "Expected: $CheckExpected | Current = $CurrentCheckGuid | SavedGuid = $CheckGuid"
		throw "POWERSHAI_IMPORTSESSION_INVALIDGUID: Failed decrypt. Check if your password is correct!";
	}
	
	$ExportedObject =  [System.Management.Automation.PSSerializer]::Deserialize($Data);
	
	foreach($key in @($ExportedObject.keys)){
		write-verbose "Importing setting key $key";
		$POWERSHAI_SETTINGS[$key] = $ExportedObject[$key]
	}
	write-host "Session settings imported";
}

###
### POWERHSAI CHATS
###		
###	Funcoes relacionadas ao Powershai Chat
###
###


# Cria um objeto que representa um ChatContext
function NewChatContext {
	return @{
		messages = @()
		size = 0
	}
}

<#
	.SYNOPSIS 
		Cria um novo objeto que representa os parâmetros de um PowershaiChat 
		
		
	.DESCRIPTION
		Cria um ojbeto padrao contendo todos o spossveis parametros que podem ser usados no chat!
		O usuário pode usar um get-help New-PowershaiParameters para obter a doc dos parametros.  	
#>
function New-PowershaiParameters {
	[CmdLetBinding()]
	param(
		#Quando true, usa o modo stream, isto é, as mensagens são mostradas a medida que o modelo as produz
			$stream = $true
			
		,# Habilia o modo JSON. Nesse modo, o modelo é forçado a retornar uma resposta com JSON.  
		 # Quandoa ativado, as mensagens geradas via stream não sãoe xibidas a medida que são produzidas, e somente o resultado final é retornado.  
			[bool]$Json = $false
			
		,# Nome do modelo a ser usado  
		 # Se null, usa o modelo definido com Set-AiDefaultModel
			[string]$model = $null
			
		,# Maximo de tokens a ser retornado pelo modelo  
		   [int]$MaxTokens = 2048
		
		,#Printa o prompt inteiro que está sendo enviado ao LLM 
			[bool]$ShowFullSend = $False 
			
		,#Ao final de cada mensagem, exibe as estatísticas de consumo, em tokens, retornadas pela API 
			$ShowTokenStats  = $False 
			
		,#Maximo de interacoes a serem feitas de um só vez 
		 #Cada vez uma mensagem é enviada, o modelo executa 1 iteração (envia a mensagem e recebe uma resposta).  
		 #Se o modelo pedir um function calling, a restpoa gerada será enviada novamente ao modelo. Isso conta como outra interacao.  
		 #Esse parâmetro controla o máximo de interacoes que podem existir em cada chamada.
		 #Isso ajuda a prevenir loops infinitos inesperados. 
			$MaxInteractions = 50
			
		,#MAximo de erros em sequencia gerado por Tool Calling.  
		 #Ao usar tool calling, esse parametro limita quantos tools sem sequencia que resultaram em erro podem ser chamados.  
		 #O erro consideraod é a exception disparada pelo script ou comando configuirado. 
			$MaxSeqErrors = 5
			
		,#Tamanho máximo do contexto, em caracteres 
		 #No futuro, será em tokens 
		 #Controla a quantidade de mensagens no contexto atual do chat. Quando esse número ultrapassar, o Powershai limpa automaticamente as mensagens mais antigas.
			$MaxContextSize = 8192
		
		,#Função usada para formatação dos objetos passados via pipeline 
			$ContextFormatterFunc = "ConvertTo-PowershaiContextOutString"
			
		,#Argumentos para ser passados para a ContextFormatterFunc
			$ContextFormatterParams = $null 
			
		,#Se true, exibe os argumenots das funcoes quando o Tool Calling é ativado para executar alguma funcao 
		 #DEPRECIADO. Será removido em breve. Use -PrintToolCalls
			$ShowArgs = $true 
			
		,#Exibe os resultados das tools quando são executadas pelo PowershAI em resposta ao tool calling do modelo 
			$PrintToolsResults = $false
			
		,#System Message que é garantida ser enviada sempre, independente do histórico e clenaup do chat!
			$SystemMessageFixed = $null
			
		,#Parãmetros a serem passados diretamente para a API que invoca o modelo.  
		 #O provider deve implementar o suporte a esse.  
		 #Para usá-lo você deve saber os detalhes de implementação do provider e como a API dele funciona!
			$RawParams = @{}
			
			
		,# Controla o template usado ao injetar dados de contexto!
		 # Este parâmetro é um scriptblock que deve retornar uma string com o contexto a ser injetado no prompt!
		 # Os parâmetros do scriptblock são:
		 #		FormattedObject 	- O objeto que representa o chat ativo, já formatado com o Formatter configurado
		 #		CmdParams 			- Os parâmetros passados para Send-PowershaAIChat. É o mesmo objeto retorndo por GetMyParams
		 #		Chat 				- O chat no qual os dados estão sendo enviados.
		 # Se nulo, irá gerar um default. Verifique o cmdlet Send-PowershaiChat para detalhes
			$ContextFormat = $null
			
		,#Controla como as Tools Calls são exibidas pelo comando Send-PowershaiChat
		 #Valores possíveis:
		 #	No			- não exibe nada relacionado ao tool calls.
		 #	NameOnly 	- Exibe apenas o nome no formato FunctionaName{...} , em uma linha própria.
		 #	NameArgs	- Exibe o nome e os argumentos!
			[ValidateSet("No","NameOnly","NameArgs")]
			$PrintToolCalls = $null
	)
	
    # Get the command name
    $CommandName = $PSCmdlet.MyInvocation.InvocationName;
    # Get the list of parameters for the command
    $ParameterList = (Get-Command -Name $CommandName).Parameters;
	
	$NewParams = @{}
	
	# compatibility
	if($ShowArgs -and $PrintToolCalls -eq $null){
		$PrintToolCalls = "NameArgs"
	}
	
	
	foreach($ParamName in @($ParameterList.keys) ){
		
		if($ParamName -in [System.Management.Automation.PSCmdlet]::CommonParameters){
			continue;
		}
		
		$ParamValue = Get-Variable $ParamName -ValueOnly -EA SilentlyContinue
		
		$NewParams[$ParamName] = $ParamValue;
	}
	
	return $NewParams;
	
}

<#
	.SYNOPSIS 
		Cria um novo Powershai Chat.
		
	.DESCRIPTION 
		O PowershaAI traz um conceito de "chats", semelhantes aos chats que você vê na OpenAI, ou as "threads" da API de Assistants.  
		Cada chat criado tem seu próprio conjunto de parâmetros, contexto e histórico.  
		Quando você usa o cmdlet Send-PowershaiChat (alias ia), ele está enviando mensagens ao modelo, e o histórico dessa conversa com o modelo fica no chat criado aqui pelo PowershAI.  
		Ou seja, todo o histórico da sua conversa com o modelo é mantido aqui na sua sessão do PowershAI, e não lá no modelo ou na API.  
		Com isso o PowershAI mantém todo o controle do que enviar ao LLM e não depende de mecanismos das diferentes APIs de diferentes providers para gerenciar o histórico. 
		
		
		Cada Chat possui um conjunto de parâmetros que ao serem alterados afetam somente quele chat.  
		Certos parâmetros do PowershAI são globais, como por exemplo, o provider usado. Ao mudar o provider, o Chat passa a usar o novo provider, mas mantém o mesmo histórico.  
		Isso permite conversar com diferentes modelos, enquanto mantém o mesmo histórico.  
		
		Além destes parâmetros, cada Chat possui um histórico.  
		O histórico contém todas as conversas e interações feitas com os modelos, guardando as repostas retornadas pelas APIs.
		
		Um Chat também tem um contexto, que é nada mais do que todas as mensagesn enviadas.  
		Cada vez que uma nova mensagem é enviada em um chat, o Powershai adiciona esta mensage ao contexto.  
		Ao receber a resposta do modelo, esta resposta é adicionada ao contexto.  
		Na próxima mensagem enviada, todo ess ehistórico de mensagem do contexto é enviado, fazendo com que o modelo, independente do provider, tenha a memória da conversa.  
		
		o fato do contexto ser mantido aqui na sua sessão do Powershell permite funcionaldiades como gravar o seu histórico em disco, implementar um provider exclusivo para guardar o seu hitórico na nuvem, manter apenas no seu Pc, etc. Futuras funcionalidades podem se beneficiar disso.
		
		Todos os comandos *-PowershaiChat giram em todos do chat ativo ou do chat que voce explicitamente especifica no parametro (geralmente com o nome -ChatId).  
		O ChatAtivo é o chat em que as mensagens serão enviadas, caso nao seja especificado o ChatId  (ou se o comando não permite especificar um chat explicito).  

		Existe um chat especial chamado "default" que é o chat criado sempre que voce usa o Send-PowershaiChat sem especifciar um chat e se não houver chat ativo definido.  
		
		Se você fechar sua sessão do Powershell, todo esse histoico de Chats é perdido.  
		Você pode salvar em disco, usando o comando Export-PowershaiSettings. O conteudo é salvo criptografado por uma senha que voce especificar.
		
		Ao emviar mensagens, o PowershaAI mantém um mecanismo interno que limpa o contexto do chat, para evitar enviar mais do que o necessário.
		O tamanho do contexto local (aqui na sua sessao do Powershai, e nao do LLM), é controlado por um parametro (use Get-PowershaiChatParameter para ver a lista de parametros)
		
		Note que, devido a essa maneira do Powershai funcionar, dependendo da quantidade de informacoes enviadas e retornadas, mais as configuracoes dos parametros, voce pode fazer seu Powershell consumir bastante memória. Voce pode limpar o contexto e historico manualmente do seu chat usando Reset-PowershaiCurrentChat
		
		Veja mais detalhes sobre no tópico about_Powershai_Chats,
#>
function New-PowershaiChat {
	[CmdletBinding()]
	param(
		#Id do chat. Se não especifico, irá gerar um padrão 
		#ALguns padrões de id são reservados para uso interno. Se você us´-alos poderá causar instabilidades no PowershAI.
		#Os seguintes valores são reservados:
		# default 
		# _pwshai_*
			$ChatId
			
		,#Cria somente se não existe um chat com o mesmo nome 
			[switch]$IfNotExists
			
		,#Forçar recriar o chat se ele já estiver criado!
			[switch]$Recreate
			
		,#Cria o chat e inclui essas tools!
			$Tools = @()
	)
	
	if(!$ChatId){
		$ChatId = (Get-Date).toString("yyyyMMddHHmmss")
	}
	
	# Create chat!
	$Chats = $POWERSHAI_SETTINGS.chats;
	
	$ChatSlot = $Chats[$ChatId];
	
	if($ChatSlot){
		if($IfNotExists){
			return $ChatSlot;
		}
		
		if(!$Recreate){
			throw "POWERSHAI_START_CHAT: Chat $ChatId already exists";
		}
		
		verbose "Recreate Enabled";
	}
	
	try {
		$CurrentUser = Get-LocalUser -SID ([System.Security.Principal.WindowsIdentity]::GetCurrent().User)
		$FullName = $CurrentUser.FullName;
		$UserAllNames = $FullName.split(" ");
		$UserFirstName = $UserAllNames[0];
	} catch {
		write-verbose "Cannot get logged username: $_"
	}
	
	$ApiParams = @{					}
	
	$ChatParams = New-PowershaiParameters
	
	$ChatSlot = [PsCustomObject]@{
		#Id unico e interno do chat!
		id 			 	= $ChatId
		
		#Data/hora de criacao do chat!
		CreateDate 		= (Get-Date)
		
		#Numero sequencia da msg atual enviada
		num 			= 0
		
		#Ultimo prompt enviado!
		LastPrompt 		= $null
		
		#Metados de controle do chat!
		metadata 		= @{}
		
		#Historico completo de todas as mensagens enviadas, com os objetos
		history 		= @()
		
		#Parametros configuraveis do chat
		params 			= $ChatParams 
		
		#Contexto dos chats. é onde fica as mensagens que deve ser enviadas
		context  = (NewChatContext)
		
		#Informacoes do usuario atual
		UserInfo = @{
			FullName = $FullName
			AllNames = @($UserAllNames)
		}
		
		#Estatisticas de uso de tokens ao longo de todo o chat!
		stats = @{
			TotalChats 	= 0
			
			TotalCost 	= 0
			TotalInput 	= 0
			TotalOutput = 0
			
			TotalTokensI = 0
			TotalTokensO = 0
		}
		
		#Slot contendo tudo o que é necessario para controlar as tools dos chats!
		Tools = @{
			compiled = $null
			raw = @{}
		}
	}
	
	SetType $ChatSlot "Chat";

	verbose "Updating slot of chatid: $ChatId";
	$Chats[$ChatId] = $ChatSlot;
	
	$null = Get-PowershaiChat -SetActive $ChatId
	
	if($Tools){
		 Add-AiTool -names $Tools -ChatId $ChatId
	}
	
	return $ChatSlot;
}

<#
	.SYNOPSIS
		Remove um chat e retorna o objeto com todo o histórico e contexto
#>
function Remove-PowershaiChat {
	[CmdletBinding()]
	param(
		#Id do chat a ser removido, ou objeto representando o chat!
		[Parameter(ValueFromPipelineByPropertyName=$true)]
		[Alias("id")]
		$ChatId
	)
	
	$CurrentChat = Get-PowershaiChat "."
	$TargetChat = Get-PowershaiChat $ChatId
	
	if($CurrentChat -eq $TargetChat){
		throw "POWERSHAI_REMOVECHAT: Cannot remove active chat!";
	}
	
	#return removed!
	$Chats = $POWERSHAI_SETTINGS.chats;
	$Chats.remove($TargetChat.id);
	
	return $TargetChat;
}

<#
	.SYNOPSIS 
		Retorna um ou mais Chats criados com New-PowershaAIChat
		
	.DESCRIPTION
		Este comando permite retornar o objeto que representa um Powershai Chat.  
		Este objeto é o objeto referenciando internamente pelos comandos que operam no Powershai Chat.  
		Apesar de certos parâmetros você poder alterar diretamente, não é recomendável que faça esta ação.  
		Prefira sempre usar a saída desse comando como entrada para os outros que comandos PowershaiChat.
#>
function Get-PowershaiChat {
	[CmdletBinding()]
	param(
		#Id do chat
		#Nomes especiais:
		#	. - Indica o proprio chat 
		# 	* - Indica todos os chats 
			$ChatId 
		
		,#Define o chat como ativo, quando o id especifciado não é um nome especial.
			[switch]$SetActive
			
		,#Ignora erros zde validação 
			[switch]$NoError
	)
	
	try {
		if(!$ChatId){
			throw "POWERSHAI_GET_CHAT: Must inform -ChatId"
		}
		
		if(IsType $ChatId "Chat"){
			return $ChatId;
		}
		
		if($ChatId -eq '*'){
			@($POWERSHAI_SETTINGS.chats.values) | Sort-Object CreateDate
			return;
		}
		
		# Create chat!
		$Chats 	= $POWERSHAI_SETTINGS.chats;
		
		if(!$Chats){
			 $POWERSHAI_SETTINGS.chats = @();
		}
		
		$OriginalChatId =$ChatId 
		
		if($ChatId -eq "."){
			$ChatId = $POWERSHAI_SETTINGS.ActiveChat;
			
			if(!$ChatId -or $ChatId -isnot [string]){
				throw "POWERSHAI_GET_CHAT: No active ChatId!"
			}
			
		}
		
		$Chat = $Chats[$ChatId];
		
		if(!$Chat){
			throw "POWERSHAI_GET_CHAT: Chat $ChatId not found!";
		}
		
		if($SetActive -and $OriginalChatId -ne "."){
			$POWERSHAI_SETTINGS.ActiveChat = $ChatId;
		}
	
		return $Chat
	} catch {
		if($NoError){
			return;
		}
		
		throw;
	}
	
	
	
}

<#
	.SYNOPSIS 
		Altera o chat ativo
		
	.DESCRIPTION
		O chat ativo é o chat padrão nos quais os comandos do Powershai Chat são enviados.  
		Se existem somente 1 chat, ele é considerado ativo, por padrão.
#>
function Set-PowershaiActiveChat {
	[CmdletBinding()]
	param(
		$ChatId
	)
	
	if(IsType $ChatId "Chat"){
		$ChatId = $ChatId.id;
	}
	
	Get-PowershaiChat -SetActive $ChatId;
}

<#
	.SYNOPSIS
		Atualiza o valor de um parâmetro do chat do Powershai Chat.  
		
	.DESCRIPTION 
		Atualiza o valor de um parâmetro de um Powershai Chat.  
		Se o parâmetro não existe, um erro é retornado.
#>
function Set-PowershaiChatParameter {
	param(
		#Nome do parâmetro 
			$parameter
		,#Valor do parâmetro
			$value
		,# Chat que deseja atualizar. Por padrão atualiza o chat ativo 
			$ChatId = "."
			
		,#Forçar atualização, mesmo se o parâmetro não existe na lista de parâmetros 
			[switch]$Force
	)
	
	$AllParameters = Get-PowershaiChatParameter -ChatId $ChatId
	
	$Param = $AllParameters | ? { $_.name -eq $parameter }
	
	if(!$Param -and $Force){
		throw "POWERSHAI_CHAT_SETPARAM: Parameter $Parameter not found";
	}
	
	
	$Chat = Get-PowershaiChat $ChatId;
	$CurrentValue = $Chat.params[$parameter];
	
	$Chat.params[$parameter] = $value;
	
	return [PsCustomObject]@{ Parameter = $parameter; OldValue = $CurrentValue; Newvalue = $Chat.params[$parameter] }
}

<#
	.SYNOPSIS
		Retorna a lista de parâmetros disoponíveis em um chat
		
	.DESCRIPTION 
		Este comando retorna um objeto contendo a lista de propriedades.  
		O objeto é, na verdade, um array, onde cada elemento representa uma propriedade.  
		
		Esse array retornado possui algumas modificações para faciltiar o acesso aos parametros. 
		Você pode acessar os parâmetros usando o objeto retornado diretamente, sem a necessidade de fitrar sobre a lista de parâmetros.
		Isso é útil quando se desejar acessar um parâmetro específico da lista.  
		
	.EXAMPLE 	
		> $MyParams = Get-PowershaiChatParameter
		> $MyParams.MaxTokens # Acessa o parâmetro max TOKENS
		> $MyParams | %{ write-host Parametro $_.name tem o valor $_.value } # itera sobre os parametros!
		
#>
function Get-PowershaiChatParameter {
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId;
	
	[Collections.ArrayList]$ParamsHelp = @()
	
	SetType $ParamsHelp "ChatParameterList"
	
	$ParamBaseHelp = @(get-help New-PowershaiParameters).parameters.parameter
	
	#Lista tudo para garantir mesmo os chats criados previamente possam exibir novas opcoes que aparecem!
	$AllParams = @($Chat.params.keys) + @($ParamBaseHelp | %{$_.name}) | Sort-object -Unique
	
	# Parametros da funcao!
	$AiChatParams = ((Get-Command Invoke-AiChatTools).Parameters).Keys;
	
	foreach($ParamName in $AllParams){
		$ParamHelp = $ParamBaseHelp | ? {$_.name -eq $ParamName}
		
		$IsDirectParam = $ParamName -in $AiChatParams;
		
		if($ParamHelp){
			$help = @($ParamHelp.description | %{$_.text}) -Join "`n"
		} else {
			$help = "Raw API param. Check model docs"
		}
		
		$ParameterInfo = [PsCustomObject]@{}
		$ParameterInfo | Add-Member Noteproperty name $ParamName
		$ParameterInfo | Add-Member Noteproperty value $Chat.params[$ParamName]
		$ParameterInfo | Add-Member Noteproperty description $help
		
		#Direct informa se o parâmetro é um parâmetro direto da função Invoke-AiChatTools, que é a função base invocada Powershai Chats.
		$ParameterInfo | Add-Member Noteproperty direct $IsDirectParam
		
		$null = $ParamsHelp.add($ParameterInfo)
		Add-Member -InputObject $ParamsHelp -force Noteproperty $ParameterInfo.name $ParameterInfo.value;
	}
	
	
	write-output -NoEnumerate $ParamsHelp;
}


$PARAM_LIST = @();

RegArgCompletion Set-PowershaiChatParameter parameter {
	param($cmd,$param,$word,$ast,$fake)
	 
	Get-PowershaiChatParameter -ChatId . | ? {$_.name -like "$word*"} | %{$_.Name};
}


<#
	.SYNOPSIS
		Permite invocar a maioria das funções de uma maneira compacta
		
	.DESCRIPTION 
		Este é um simples utilizario que permite invocar diversas funcoes de uma forma mais reduzia na linha de comando.  
		Note que nem todos os comandos podem ser suportados ainda.
		
		É melhor usado com o alia pshai.
		
	.EXAMPLE 	
		> pshai tools # lista as tools
		> pshai params MaxTokens 2048 #atualiza um parâmetro
		
#>
function Invoke-PowershaiCommand {
	[CmdletBinding()]
	param(
		#Command name
			[ValidateSet("params","tools")]
			$CommandName
		
		,[Parameter(ValueFromRemainingArguments=$true)]
			$RemArgs
	)
	
	switch($CommandName){
		"params" {
			Set-PowershaiChatParameter @RemArgs
		}
		
		"tools" {
			Get-AiTools
		}
		
		default {
			write-warning "Unkown command";
		}
	}
	
}

Set-Alias pshai Invoke-PowershaiCommand

$POWERSHAI_FORMATTERS_SHORTCUTS = @{}
<#
	.SYNOPSIS
		Define qual será a funcao usada para formatar os objetos passados pro parâmetro Send-PowershaiChat -Context
	
	.DESCRIPTION
		Ao invocar Send-PowershaiChat em um pipe, ou passando diretamente o parâmetro -Context, ele irá injetar esse objeto no prompt do LLM.  
		Antes de injetar, ele deve converter esse objeto para uma string.  
		Essa conversão é chamada de "Context Formatter" aqui no Powershai.  
		O Context Formatter é uma funcao que irá pegar cada objeto passado e convertê-lo para uma string para ser injetada no prompt.
		A função usada deve receber como primeiro parametro o objeto a ser convertido.  
		
		Os demais parametros ficam a criterio. Os valor deles pode ser especicicados usando o parametro -Params dessa funcao!
		
		O powershai disponibiliza context formatters nativos.  
		Utilize Get-Command ConvertTo-PowershaiContext* ou Get-PowershaiContextFormatters para obter a lista!
		
		Uma vez que os context formatters nativos são apenas funções powershell, você pode usar o Get-Help Nome, para obter mais detalhes.  
#>
function Set-PowershaiChatContextFormatter {
	param(
		$ChatId = "."
		,#Nome da funcao powershell
		 #Use o comando Get-PowershaiContextFormatters para ver a lista
			$Func = "Str"
		
		,$Params = $null
	)
	
	$Chat = Get-PowershaiChat -ChatId $ChatId
	$Chat.params.ContextFormatterFunc 	=  $Func 
	$Chat.params.ContextFormatterParams =  $Params
}

<#
	.SYNOPSIS
		Lista todos os Context Formatters compactos disponíveis
	
	.DESCRIPTION
		Certos Context Formatters disponibilizados pelo PowershAI podem ter um nome compacto (ou alias, se preferir), para facilitar sua definição.  
		Este cmdlet retorna todos esses momes que podem ser usados ao uisar Set-PowershaiChatContextFormatter
#>
function  Get-PowershaiContextFormatters {
	param()
	
	@($POWERSHAI_FORMATTERS_SHORTCUTS.keys) |  %{ [PsCustomObject]@{name = $_; func = $POWERSHAI_FORMATTERS_SHORTCUTS[$_]} }
}

<#
	.SYNOPSIS
		Converte o contexto para JSON usando ConverTo-Json
#>
function ConvertTo-PowershaiContextJson {
	param($context)
	
	$context | convertto-json @params
}
$POWERSHAI_FORMATTERS_SHORTCUTS['json'] = 'ConvertTo-PowershaiContextJson'

<#
	.SYNOPSIS
		Converte o contexto para JSON usando ConverTo-Json
#>
function ConvertTo-PowershaiContextOutString {
	param(
		#Objeto a ser injetado no contexto 
		$context
	)
	
	$context | out-string @params
}
$POWERSHAI_FORMATTERS_SHORTCUTS['str'] = 'ConvertTo-PowershaiContextOutString'

<#
	.SYNOPSIS
		Converte o objeto para um formato lista usando Format-List.
#>
function ConvertTo-PowershaiContextList  {
	param(
		#Objeto que será injetado no contexto
			$context
		
		,#Parâmetros do comando Format-List 
			$FlParams = @{}
	)
	
	$context | Format-List @FlParams | out-string
}
$POWERSHAI_FORMATTERS_SHORTCUTS['list'] = 'ConvertTo-PowershaiContextList'

<#
	.SYNOPSIS
		Converte o objeto para um formato Table usando Format-Table
#>
function ConvertTo-PowershaiContextTable {
	param(
		#Objeto que será injetado no contexto
			$context
			,$FlParams = @{}
	)
	
	$context | Format-Table -AutoSize @FlParams | out-string
}
$POWERSHAI_FORMATTERS_SHORTCUTS['table'] = 'ConvertTo-PowershaiContextTable'


<#
	.SYNOPSIS
		Formato um objeto para ser injetado no contexto de uma mensagem envianda em um Powershai Chat
	
	.DESCRIPTION 
		Dado que LLM processam apenas strings, os objetos passados no contexto precisam ser convertidos para um formato em string, antes de serem injetados no prompt.
		E, como existem várias reprsentações de um objeto em string, o Powershai permite que o usuário tenha total controle sobre isso.  
		
		Sempre que um objeto precisar ser injado no prompt, quando invocado com Send-PowershaAIChat, via ppipeline ou parâmetro Contexto, este cmdlet será invocado.
		Este cmdlet é responsavel por transformar este objeto em string, independente do objeto, seja array, hashtable, customizado, etc.  
		
		Ele faz isso invocando a função de formatter configurada usando Set-PowershaiChatContextFormatter
		NO geral, você não precisa invocar essa funções diretamente, mas pode querer invocar quando quiser fazer algum teste!
#>
function Format-PowershaiContext {
	[CmdletBinding()]
	param(
		#Objeto qualquer a ser injetado 
			$obj
			
		,#Parâmetro a ser passado para a função formatter 
			$params
			
		,#Sobrescrever a função ser invocada. Se não especificado usa o defualt do chat.
			$func 
			
		,#Chat em qual operar 
			$ChatId = "."
	)
	
	write-verbose "Getting ChatId..."
	$Chat = Get-PowershaiChat -ChatId $ChatId
	
	if(!$func){
		$func = $Chat.params.ContextFormatterFunc
		
		if(!$func){
			$func = "str"
		}
	}
	
	$ShortCut = $POWERSHAI_FORMATTERS_SHORTCUTS[$Func];
	if($ShortCut){
		$Func = $ShortCut
	}
	
	write-verbose "FormatFunction: $func"
	
	if(!$params){
		$params =  $Chat.params.ContextFormatterParams
	}
	
	
	if($params -eq $null){
		$params = @{}
	}
	
	write-verbose "FormatParams: $($params|out-string)";

	
	write-verbose "Invoking formatter..."
	& $func $obj @params
}


function Send-PowershaiChat {
	<#
		.SYNOPSIS 
			Envia uma mensagem em um Chat do Powershai
		
		.DESCRIPTION 
			Este cmdlet permite que você envie uma nova mensagem para o LLM do provider atual.  
			Por padrão, ele envia no chat ativo. Você pode sobrescrever o chat usando o parâmetro -Chat.  Se não houver um chat ativo, ele irá usar o default.  
			
			Diversos parâmetros do Chat afetam como este comando. Veja o comando Get-PowershaiChatParameter para mais info sobre os parâmetros do chat.  
			Além dos parâmetros do chat, os próprios parâmetros do comando podem sobrescrever comportamento.  Para mais detalhes, consule a documentação de cada parâmetro deste cmdlet usando get-help.  
			
			Para simplicidade, e manter a liNha de comando limmpa, permitindo o usuário focar mais no prompt e nos dados, alguns alias são disponibilizados.  
			Estes alias podem ativar certos parâmetros.
			São eles:
				ia|ai
					Abreviação de "Inteligência Artifical" em português. Este é um alias simples e não muda nenum parâmetro. Ele ajuda a reduzir bastante a linha de comando.
				
				iat|ait
					O mesmo que Send-PowershaAIChat -Temporary
					
				io|ao
					O mesmo que Send-PowershaAIChat -Object
					
				iam|aim 
					O mesmo que Send-PowershaaiChat -Screenshot 
			
			O usuário pode criar seus próprios alias. Por exemplo:
				Set-Alias ki ia # DEfine o alias para o alemao!
				Set-Alias kit iat # DEfine o alias kit para iat, fazendo o comportamento ser igual ao iat (chat temporaria) quando usado o kit!
	#>
	[CmdletBinding(PositionalBinding=$false)]
	param(
		[parameter(mandatory=$false, position=0, ValueFromRemainingArguments)]
		# o prompt a ser enviado ao modelo 
			$prompt
		
		,#System message para ser incluída 
			$SystemMessages = @()
		
		,#O contexto 
		 #Esse parâmetro é pra usado preferencialmente pelo pipeline.
		 #Ele irá fazer com que o comando coloque os dados em tags <contexto></contexto> e injeterá junto no prompt.
		[parameter(mandatory=$false, ValueFromPipeline=$true)]
			$context = $null
			
		,#Força o cmdlet executar para cada objeto do pipeline
		 #Por padrão, ele acumula todos os objetos em um array, converte o array para string só e envia de um só vez pro LLM.
			[switch]$ForEach
			
		,#Habilia o modo json 
		 #nesse modo os resultados retornados sempre será um JSON.
		 #O modelo atual deve suportar!
			[switch]$Json
			
		,#Modo Object!
		 #neste modo o modo JSON será ativado automaticamente!
		 #O comando não vai escrever nada na tela, e vai retornar os resultados como um objeto!
		 #Que serão jogados de volta no pipeline!
			[switch]$Object
			
		,# Mostra os dados de contexto enviados ao LLM antes da resposta!
		 # É útil para debugar o que está senod injetado de dados no prompt.
			[switch]$PrintContext
			
		,#Não enviar as conversas anteriores (o histórico de contexto), mas incluir o prompt e a resposta no contexto histórico.
			[switch]$Forget
			
		,#Ignorar a resposta do LLM, e não incluir o prompt no contexto histórico
			[switch]$Snub
			
		,#Não envia o histórico e nem inclui a resposta e prompt.  
		 #É o mesmo que passar -Forget e -Snub juntos.
			[switch]$Temporary 
			
		,# Desliga o function call para esta execução somente!
			[Alias('NoCalls','NoTools','nt')]
			[switch]$DisableTools
			
		,# Alterar o contexto formatter pra este
		 # Veha mais sobre em Format-PowershaiContext
			$FormatterFunc = $null
			
		,# Parametros do contexto formatter alterado.
			$FormatterParams = $null
			
		,# Retorna as mensagens de volta no pipeline, sem escrever direto na tela!
		 # Esta opção assume que o usuário irá ser o responsável por dar o correto destino da mensagem!
		 # O objeto passado ao pipeline terá as seguintes propriedades:
		 #		text 			- O texto (ou trecho) do texto retornado pelo modelo 
		 #		formatted		- O texto formatado, incluindo o prompt, como se fosse escrito direto na tela (sem as cores)
		 #		event			- O evento. Indica o evento que originou. São os mesmos eventos documentaados em Invoke-AiChatTools
		 #		interaction 	- O objeto interaction gerado por Invoke-AiChatTools
			[switch]$PassThru
		
		,#Retorna um array de linhas 
		 #Se o modo stream estiver ativado, retornará uma linha por vez!
			[switch]$Lines
			
		,#Sobrescrever parâmetros do chat!
		 #Especifique cada opção em umas hastables!
		 $ChatParamsOverride = @{}
		 
		,#Especifica diretamente o valor do chat parameter RawParams!
		 #Se especificado também em ChatParamOverride, um merge é feito, dando prioridade aos parametros especificados aqui.
		 #O RawParams é um chat parameter que define parametros que serão enviados diretamente a api do modelo!
		 #Estes parametros irão sobrescrever os valores padrões calculados pelo powershai!
		 #Com isso, o usuario tem total controle sobre os parâmetros, mas precisa conmhecer cada provider!
		 #Também, cada provider é responsável por prover essa implementaão e usar esses parâmetros na sua api.
			$RawParams = @{}
			
		,#Captura um print screen da tela que está atrás da janela do powershell e envia junto com o prompt. 
		 #Note que o mode atual deve suportar imagens (Vision Language Models).
			[switch]
			[Alias("ss")]
			$Screenshot
	)
	
	
	begin {
		$ErrorActionPreference = "Stop";
		
		
		
		$ProcessedPrompt = @();
		@($prompt) | %{
			if($_ -is [IO.FileInfo]){
				$ProcessedPrompt += "file: $($_.FullName)";
			} else {
				$ProcessedPrompt += $_;
			}
		}
		
		$prompt = $ProcessedPrompt;
		
		$MyInvok 		= $MyInvocation;
		$CallName 		= $MyInvok.InvocationName;
		$MyRealName 	= $MyInvocation.MyCommand.Name;
		$CurrentName 	= $CallName;
		$MyParameters 	= GetMyParams
		
		# resolve até chegar no command!
		$LoopProtection = 50;
		while($CurrentName -ne $MyRealName -and $LoopProtection--){
			$CallName = $CurrentName;
			$CurrentName = (Get-Alias $CurrentName).Definition
		}
		
		if($LoopProtection -lt 0){
			write-warning "Cannot determined alias. This can be a bug!";
		}
		
		
		if($CallName -eq "io"){
			write-verbose "Invoked vias io alias. Setting Object to true!";
			$Object = $true;
		}
		
		if($CallName -eq "iat"){
			write-verbose "Invoked vias iat alias. Setting Temporary to true!";
			$Temporary = $true;
		}
		
		if($CallName -eq "iam"){
			$Screenshot = $true;
		}
		
		if($Temporary){
			write-warning "Temporary Chat enabled";
			$Snub 	= $true;
			$Forget = $true;
		}
		
		$ActiveChat = Get-PowershaiChat "." -NoError
		
		if(!$ActiveChat){
			write-verbose "Creating new default chat..."
			$NewChat = New-PowershaiChat -ChatId "default" -IfNotExists
			
			write-verbose "Setting active...";
			$ActiveChat = Get-PowershaiChat -SetActive $NewChat.id;
		}
		
		if($Screenshot){
			if(-not(Get-Command -EA SilentlyContinue Get-PowershaiPrintSCreen)){
				throw "POWERSHAI_ENABLE_EXPLAIN: Você deve habilitar com Enable-AiScreenshots"
			}
			
			$sspath = Get-PowershaiPrintSCreen;
			
			$prompt += "file: $sspath";
		}
		
		$AllContext = @()
		$IsPipeline = $PSCmdlet.MyInvocation.ExpectingInput   
		
		$MainCmdlet = $PsCmdLet;
		
		$ChatMyParams 		= Get-PowershaiChatParameter  -ChatId $ActiveChat.id 
		$CurrentChatParams 	= @{
			all = @{}
			direct = @{}
		};
		
		#Merge raw params!
		$ChatParamsOverride['RawParams'] = HashTableMerge $ChatParamsOverride['RawParams'] $RawParams;
		
		$ChatMyParams | %{
			
			$ParamValue = $_.value;
			
			if($ChatParamsOverride.Contains($_.name)){
				verbose "ChatParam $($_.name) overrided"
				$ParamValue = $ChatParamsOverride[$_.name];
			}

			if($_.direct){
				verbose "Adding direct param $($_.name)";
				$CurrentChatParams.direct[$_.name] = $ParamValue;
			}
			
			$CurrentChatParams.all[$_.name] = $ParamValue;
		}
		
		
		
		$ContextFormat = $CurrentChatParams.all.ContextFormat;
		
		if(!$ContextFormat){
			$ContextFormat = {
				param($Params)
				
				$ContextObject 	= $Params.FormattedObject;
				$UserPrompt 	= $Params.prompt;
				
				@(
					"Answer user message based on context data inside tag <data-context>"
					"Context data:`n<data-context>`n$($ContextObject)`n</data-context>"
					"Answer in same language of user, or in language explicit asked"
					"User message:"
					$UserPrompt	
				)
			}
		}
		
		
		function ProcessPrompt {
			param($prompt)
			
			
			$WriteData = @{
				BufferedText 	= ""
				LinesBuffer		= @()
				streamed 		= $False;
				premsg 			= $false
			}
			function WriteModelAnswer {
				param(
					$interaction
					,$evt
				)
				
				$Stream = $interaction.stream;
				$str = "";
				$EventName = $evt.event;
				
				if($interaction -eq "FlushLine"){
					if($WriteData.BufferedText){
						$MainCmdlet.WriteObject($WriteData.BufferedText)
					}
					
					return;
				}
				
				if($EventName -eq "answer" -and $WriteData.streamed){
					return;
				}
					
				
				if($Object){
					write-verbose "ObjectMode enabled. No writes...";
					return;
				}
				
				$WriteParams = @{
					NoNewLine = $false
					ForegroundColor = "Cyan"
				}
				

				
				
				function FormatPrompt {
					
					$str = PowerShaiProviderFunc "FormatPrompt" -Ignore -FuncParams @{
						model = $model
					}
					
					if($str -eq $null){
						$str = "🤖 $($model): ";
					}
					
					return $str;
				}
		


				if($Stream){
					$WriteData.streamed 	= $true;
					$PartNum 				= $Stream.num;
					$text 					= $Stream.answer.choices[0].delta.content;
					$WriteParams.NoNewLine 	= $true;
					$model 					= $Stream.answer.model;
					
					if(!$WriteData.premsg){
						$str = FormatPrompt
						$WriteData.premsg = $true;
					}

					if($text){
						$Str += $text
					}
					
					if($EventName -eq "answer"){
						$str = "`n`n";
					}
				} else {
					#So entrará nesse quando o stream estiver desligado!
					$ans 	= $interaction.rawAnswer;
					$text 	= $ans.choices[0].message.content;
					$model 	= $ans.model;
					$prempt = FormatPrompt;
					$str 	= "`$($prempt)$text`n`n" 
				}

				if($PassThru){
					$MessageOutput = @{
						event 		= $EventName
						text 		= $text
						formatted 	= $str
						interaction = $interaction
					}
					
					$MainCmdlet.WriteObject($MessageOutput);
					return;
				}
				
				if($Lines){
					$WriteData.BufferedText += $text;
					
					$Lines 		= $WriteData.BufferedText -split '\r?\n'
					$LastLine 	= $Lines.count - 1;
					
					if($LastLine -gt 0){
						$LastDelivery = $LastLine - 1
						$DeliveryLines = $Lines[0..$LastDelivery];
						$DeliveryLines | %{ $MainCmdlet.WriteObject($_) }
						$WriteData.BufferedText = $Lines[-1];
					}
					
					return;
				}
				

				if($str){
					write-host @WriteParams $Str;
				}
				
				
			}

			#Get active chat!
			$Chat = Get-PowershaiChat "."
			
			if(!$Chat){
				throw "POWERSHAI_SEND: No active chats"
			}
			
			#Parameters 
			$ChatStats 			= $Chat.stats;
			$ChatMetadata 		= $Chat.metadata;
			$UserFirstName		= $Chat.UserInfo.AllNames[0];
			$ChatContext 		= $Chat.context;
			
			write-verbose "Iniciando..."
			
			$ChatUserParams = $CurrentChatParams.all
			$DirectParams 	= $CurrentChatParams.Direct;
			
			$VerboseEnabled = $ChatUserParams.VerboseEnabled;
			$ShowFullSend 	= $ChatUserParams.ShowFullSend
			$ShowTokenStats = $ChatUserParams.ShowTokenStats
			# Vou considerar isso como o número de caracter por uma questão simples...
			 # futuramente, o correto é trabalhar com tokens!
			$MaxContextSize = $ChatUserParams.MaxContextSize 
			
			function AddContext($msg) {

				if($Snub){
					return;
				}
					
				while($ChatContext.size -ge $MaxContextSize -and $ChatContext.messages){
					$removed,$LeftMessages = $ChatContext.messages;
					
					$ChatContext.messages = $LeftMessages;
					
					$RemovedCount = $removed.length;
					if($removed.content){
						$RemovedCount = $removed.content.length;
					}
					
					write-verbose "Removing Length: $removed $RemovedCount"
					$ChatContext.size -= [int]$RemovedCount;
				}
				
				$ChatContext.messages += @($msg);

				if($msg.content){
					$ChatContext.size += $msg.content.length;
				} else {
					$ChatContext.size += $msg.length;
				}
			}
			
			
			$Chat.num++
			$InternalMessages = @();
			try {
				verbose "Verbose habilitado..." 
				
				$Chat.LastPrompt = $prompt
				
				if($Object){
					$Exemplo1Json = @{PowerShaiJsonResult = @{
						prop1 = 123
						prop2 = "text value..."
						someArray = 1,2,3
					}} | ConvertTo-Json -Compress;
					
					$Exemplo2Json = @{PowerShaiJsonResult = "valor 1",123,"valor 3"} | ConvertTo-Json -Compress;
					
					$InternalMessages += @(
						"
							Retornar o resultado como JSON no formato: PowerShaiJsonResult:{JSON}
							EXEMPLO 1: $Exemplo1Json
							EXEMPLO 2: $Exemplo2Json
						"
					)
				}
				
				
				$Msg = @(
					@($SystemMessages|%{ [string]"s: $_"})
					@($InternalMessages|%{ [string]"s: $_"})
					$prompt
				)
				
				if($ShowFullSend){
					write-host -ForegroundColor green "YouSending:`n$($Msg|out-string)"
				}
				
	
				if(!$Snub){
					$Msg | %{ AddContext $_ };
					$FullPrompt = $ChatContext.messages;
				}
				
				if($Forget){
					$FullPrompt = $Msg
				}
				

				
				#Generate functions!
				if($Chat.Tools.compiled -eq $null){
					$Chat.Tools.compiled  = @{
						CachedTime 	= (Get-Date)
						Tools 		= $null
					}
					
					verbose "Updating ParsedTools cached...";
					$Chat.Tools.compiled = CompileChatTools
				}
				
				
				$ToolList = @(
					$Chat.Tools.compiled
				)
				
				if($Chat.params.SystemMessageFixed){
					#Envia essa system message sempre!
					$FullPrompt = @("s: " + $Chat.params.SystemMessageFixed) + @($FullPrompt)
				}
				
				#obtem os parametros que são 

				$ChatParams = $DirectParams +  @{
					prompt 			= $FullPrompt
					Tools 			= $ToolList
					
					
					on 			= @{
								
								send = {
									if($VerboseEnabled){
										write-host -ForegroundColor DarkYellow "-- waiting model... --";
									}
								}
								
								stream = {param($inter,$evt) WriteModelAnswer $inter $evt}
								answer = {param($inter,$evt) WriteModelAnswer $inter $evt}

								
								func = {
									param($interaction)
									
									$ans 		= $interaction.rawAnswer;
									$model 		= $ans.model;
									$funcName 	= $interaction.toolResults[-1].name
									
									
									if($PassThru){
										$MainCmdlet.WriteObject(@{event="func";interaction=$interaction});
										return;
									}
									
									if($Chat.params.PrintToolCalls -like "Name*"){
										write-host -ForegroundColor Blue "$funcName{" -NoNewLine
									
										if($Chat.params.PrintToolCalls -eq "NameArgs"){
												write-host ""
												write-host "Args:"
												$ToolArgs = $interaction.toolResults[-1].obj;
												write-host ($ToolArgs|fl|out-string)
										} else {
												write-host -ForegroundColor Blue -NoNewLine ...
										}
									
									}
								}
								
								funcresult = {
									param($interaction)
									
									$LastResult = $funcName = $interaction.toolResults[-1].resp.content;
									
									if($PassThru){
										$MainCmdlet.WriteObject(@{event="funcresult";interaction=$interaction});
										return;
									}
									
									if($Chat.params.PrintToolsResults){
										write-host "Result:"
										write-host $LastResult
									}
									
								}
						
								exec = {
									param($interaction)
									
									if($PassThru){
										$MainCmdlet.WriteObject(@{event="exec";interaction=$interaction});
										return;
									}
									
									if($Chat.params.PrintToolCalls -like "Name*"){
										write-host -ForegroundColor Blue "}"
										write-host ""
									}

								}
						}
				}
				
				if($Json){
					$ChatParams.Json = $true;
				}
				
				if($Object){
					$ChatParams.Json = $true;
					$ChatParams.Stream = $false;
				}
				
				if($VerboseEnabled){
					$ChatParams.Verbose = $true;
				}
				
				if($DisableTools){
					$ChatParams.Remove('Tools');
				}
				
				write-verbose "Params: $($ChatParams|out-string)"
				
				$Start = (Get-Date);
				$Ret 	= Invoke-AiChatTools @ChatParams;
				$End = Get-Date;
				$Total = $End-$Start;
				
				if($lines){
					WriteModelAnswer "FlushLine";
				}

				foreach($interaction in $Ret.interactions){ 
				
					if($interaction.stream){
						$Msg = $interaction.rawAnswer.message
					} else {
						$Msg = $interaction.rawAnswer.choices[0].message;
					}
				
					AddContext $Msg
					
					$toolsResults = $interaction.toolResults;
					if($toolsResults){
						$toolsResults | %{ AddContext $_.resp }
					}

				}
				
				#Store the history of chats!
				$HistoryEntry = @{
					Ret = $Ret
					Elapsed = $Total
					object = $null
				}
				$Chat.history += $HistoryEntry
						
				if($Object){
					verbose "Object mode! Parsing json..."
					$JsonContent = @($Ret.answer)[0].choices[0].message.content
					verbose "Converting json to object: $JsonContent";
					$JsonObject = $JsonContent | ConvertFrom-Json;
					$ResultObj = $JsonObject;
					
					if($JsonObject.PowerShaiJsonResult){
						$ResultObj = $JsonObject.PowerShaiJsonResult
					}
					
					$HistoryEntry.object = $ResultObj
					write-output $ResultObj
				}
				
				
				$AllAnswers 	= @($Ret.interactions | %{$_.rawAnswer});
				$AnswersCost	= $Ret.costs
				
				

				
				# current chat
				$AnswerCount 	= $AllAnswers.count;
				$TotalCost 		= $AnswersCost.total
				$InputCost 		= $AnswersCost.input
				$OutputCost 	= $AnswersCost.output
				$TotalTokens 	= $AnswersCost.tokensTotal
				$InputTokens 	= $AnswersCost.tokensInput
				$OutputTokens 	= $AnswersCost.tokensOutput
				
				# all chats
				$ChatStats.TotalChats += $Chat.history.count;
				$TotalChats = $ChatStats.TotalChats
				
				## COSTS (total, input,output)
				$ChatStats.TotalCost += $TotalCost 
				$ChatStats.TotalInput += $InputCost
				$ChatStats.TotalOutput += $OutputCost
				
				## TOKENS QTY (total, input, output)
				$ChatStats.TotalTokens += $TotalTokens 
				$ChatStats.TotalTokensI += $InputTokens
				$ChatStats.TotalTokensO += $OutputTokens
				
				
				$AnswerLog = @(
					"Answer: $AnswerCount"
					"Cost: $TotalCost (i:$InputCost/o:$OutputCost)"
					"Tokens: $TotalTokens (i:$InputTokens/o:$OutputTokens)"
					"time: $($Total.totalMilliseconds) ms"
				) -Join " "
				
				$HistoryLog = @(
					"AllChats: $($ChatStats.TotalChats)"
					
					@(
						"Cost: $($ChatStats.TotalCost)"
						"(i:$($ChatStats.TotalInput)"
						"/"
						"o:$($ChatStats.TotalOutput))"
					) -Join ""
					
					@(
						"Tokens: $($ChatStats.TotalTokens)"
						"(i:$($ChatStats.TotalTokensI)"
						"/"
						"o:$($ChatStats.TotalTokensO))"
					) -Join ""
					
				) -Join " "
				
				
				if($ShowTokenStats){
					write-host "** $AnswerLog"
					write-host "** $HistoryLog"
				}
			} catch {
				$StackTrace = $_.ScriptStackTrace;
				$Msg = [string]$_;
				$ex = New-PowershaiError -Message "$Msg`n$StackTrace" -parent $_.Exception
				throw $ex;
			}
		}

		function ProcessContext {
			param($context)
			
			if($PrintContext){
				write-host -ForegroundColor Blue Contexto:
				write-host -ForegroundColor Blue $Context;
			}
			
			
			
			$ContextScriptParams = @{
				FormattedObject = $Context
				CmdParams 		= $MyParameters
				Chat 			= $ActiveChat
				prompt 			= $Prompt #processed prompt!
			}
			
			
			$ContextPrompt = & $ContextFormat $ContextScriptParams
			
			write-verbose "Adding to context: $($Context|out-string)"
			ProcessPrompt $ContextPrompt
		}
	

		$ContextFormatParams = @{
			func = $FormatterFunc
			params = $FormatterParams
			ChatId = $ActiveChat.id
		}
		

	}
	
	process {
		
		

		
		if($ForEach -and $IsPipeline){
			# Convete o contexto para string!
			$StrContext = Format-PowershaiContext -obj $context @ContextFormatParams;
			ProcessContext $StrContext;
		} else {
			$AllContext += $context
		}
	}
	
	
	end {
		if(!$IsPipeline){
			ProcessPrompt $prompt
			return;
		}
		
		if($AllContext.length){
			# Convete o contexto para string!
			$StrContext = Format-PowershaiContext -obj $AllContext @ContextFormatParams;
			ProcessContext $StrContext;
		}

		if($Temporary){
			write-warning "Temporary chat"
		}
	}
	
	
	

}

# Send-PowershaaiChat é esperado ser o comando mais utilizado talvez.
# Reduzir o seu nome pode deixar mais confortável para o usuário.
# Os seguintes alias são os alias primários, em que o Send-PowershaiChat pode alterar seu comportamento se um deles for utilizado.
Set-Alias -Name ia -Value Send-PowershaiChat
Set-Alias -Name iat -Value Send-PowershaiChat
Set-Alias -Name io -Value Send-PowershaiChat
Set-Alias -Name iam -Value Send-PowershaiChat

# Estes são alias secundários, que são criados apenas para melhor interface com usuários de outros idiomas.
# Definimos uma alias para o alias primario, pois isso manterá o comportamento do Send-PowershaiChat, que pode alterar conforme o alias primário.
# 	Ele contém toda a lógica necessáro para detecta esse cenário!
Set-Alias -Name ai 	-Value ia
Set-Alias -Name ait -Value iat
Set-Alias -Name ao 	-Value io
Set-Alias -Name aim -Value io



function Clear-PowershaiChat {
	<#
		.SYNOPSIS
			Apaga elementos de um chat!
		.DESCRIPTION
			Apaga elementos específico de um chat.  
			Útil apra liberar recursos, ou tirar o vício do llm devido ao histórico.
	#>
	param(
		
		#Apaga todo o histórico
			[switch]$History
			
		,#Apaga o contexto 
			[switch]$Context
		
		#Id do chat. Padrão: ativo.
		,$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat -ChatId $ChatId;
	
	if($context){
		write-verbose "Clearing context..."
		$Chat.context = NewChatContext
	}
	
	if($history){
		write-verbose "Clearing history"
		$Chat.history = @();
	}
	
}

function Reset-PowershaiCurrentChat {
	<#
		.SYNOPSIS
			Apaga o histórico e o contexto do chat atual.
	#>
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat -ChatId $ChatId
	
    if($PSCmdlet.ShouldProcess("Current chat: $($Chat.id)")) {
        Clear-PowershaiChat -History -Context
    }
}

function Reset-PowershaiChatToolsCache {
	<#
		.SYNOPSIS
			Limpa o cache de AI Tools.
		
		.DESCRIPTION
			O PowershAI mantém um cache com as tools "compiladas".
			Quando o PowershAI envia a lista de tools pro LLM, ele precisa enviar junto a descrição da tools, lista de paraemtros, descrição, etc.  
			Montar essa lista pode consumir um tempo signifciativo, uma vez que ele vai varrer a lista de tools, funcoes, e pra cada um, varrer o help (e o help de cada parametro).
			
			Ao adicionar um cmdlet como Add-AiTool, ele não compila naquele momento.
			Ele deixa para fazer isso quando ele precisa invocar o LLM, na funcao Send-PowershaiChat.  
			Se o cache não existe, então ele compila ali na hora, o que pode fazer com que esse primeiro envio ao LLM, demora alguns millisegundos ou segundos a mais que o normal.  
			
			Esse impacto é proprocional ao numero de funcoes e parâmetros enviados.  
			
			Sempre que você usa o Add-AiTool ou Add-AiScriptTool, ele invalida o cache, fazendo com que na proxima execução, ele seja gerado.  
			ISso permite adicionar muitas funcoes de uma só vez, sem que seja compilado cada vez que você adicona.
			
			Porém, se você alterar sua função, o cache não é recalcuado.  
			Então, você deve usar esse cmdlet para que a proxima execução contenha os dados atualizados das suas tools após alteracoes de código ou de script.
	#>
	[CmdletBinding()]
	param($ChatId = ".")
	
	$Chat = Get-PowershaiChat $ChatId
	
	$ChatTools = $Chat.Tools
	
	if($ChatTools.compiled){
		$ChatTools.compiled = $null
	}
}

#
####
#### CHAT TOOLS
####
#
#


function  Add-PowershaiChatTool {
	<#
		.SYNOPSIS
			Adiciona funcoes, scripts, executáveis como uma tool invocável pelo LLM no chat atual (ou default para todos).
		
		.DESCRIPTION
			Adiciona funcoes na sessao atual para a lista de Tool caling permitidos!
			Quando um comando é adicionado, ele é enviado ao modelo atual como uma opcao para Tool Calling.
			O help dsponivel da função será usado para descrevê-la, iuncluindo os parâmetros.
			Com isso, você pode, em runtime, adicionar novas habilidades na IA que poderão ser invocadas pelo LLM e executadas pelo PowershAI.  
			
			AO adicionar scritps, todas as funcoes dentro do script são adicionadas de uma só vez.
			
			Para mais informações sobre tools consule o topico about_Powershai_Chats
			
			MUITO IMPORTANTE: 
			NUNCA ADICIONEI COMANDOS QUE VOCÊ NÃO CONHEÇA OU QUE POSSAM COMPROMETER SEU COMPUTADOR.  
			O POWERSHELL VAI EXECUTÁ-LO A PEDIDO DO LLM E COM OS PARÂMETROS QUE O LLM INVOCAR, E COM AS CREDENCIAIS DO USUÁRIO ATUAL.  
			SE VOCÊ ESTIVER LOGADO COM UMA CONTA PRIVILEGIADA, COMO O ADMINISTRADOR, NOTE QUE VOCÊ PODERÁ EXECUTAR QUALQUER AÇÃO A PEDIDO DE UM SERVER REMOTO (O LLM).
	#>
	[CmdletBinding()]
	param(
		#Nome do comando, caminho do script ou executável
		#Pode ser um array de string com estes elementos misturados.
		#Quando nome que termina com .ps1 é passado, é tratado como um script (isto é, será carregado as funcoes do script)
		#Caso queria tratar com um comando (executar o script), informe o parâmetor -Command, para forçar ser tratado como um comando!
			$names
			
		,#Descrição para esse tool a ser passada ao LLM.  
		 #O comando vai usar o help e enviar, também o conteúdo descrito
		 #Se este parâmetro for adicionado, ele é enviado junto com o help.
			$description
		
		,#Força tratar como command. Útil quando você quer que um script seja executado como comando.
		 #ùtil somente quando você passa um nome ambíguo de arquivo, que coincide como nome de algum comando!
			[switch]$ForceCommand
			
		,#Chat em qual criar a tool 
			$ChatId = "."
			
		,#Cria a tool globalmente, isto é, será disponível em todos os chats 
			[switch]$Global
	)
	
	$Chat = Get-PowershaiChat $ChatId
	$Tools = $Chat.tools.raw;
	
	$scope = "chat"
	if($Global){
		$Tools = $POWERSHAI_SETTINGS.UserTools
		$scope = "global"
	}
	
	
	foreach($CommandName in $names){
		$ToolIndex = $CommandName;
		$ToolType = "command"
		
		#Se é uma uri vlaida
		$uri = [uri]$CommandName
		$IsScript = $false;
		
		if($CommandName -like "*.ps1" -and !$ForceCommand){
			$IsScript = $true;
		}
		
		$CommandInfo = $null;
		if($IsScript){
			[string]$AbsPath = Resolve-Path $CommandName -EA SilentlyContinue
			
			if(!$AbsPath){
				throw "POWERSHAI_AITOOL_SCRIPT_FILENOTFOUND: $CommandName";
			}
	
			$ToolIndex = "Path:" + $AbsPath;
			$CommandName = $AbsPath;
			$ToolType = "file"
		}
		else {
			$CommandInfo = Get-Command $CommandName;
		}
		
		$ToolInfo = [PsCustomObject]@{
			name 			= $CommandName
			ComamndInfo 	= $CommandInfo
			UserDescription = $description
			type 			= $ToolType 
			formatter 		= $null #deprecated!
			enabled 		= $true
			chats 			= @()
			scope 			= $scope
		}
		
		SetType $ToolInfo AiToolInfo;
		
		$Tools[$ToolIndex] = $ToolInfo;
	}
	
	#Atualiza o cache das tools!
	Reset-PowershaiChatToolsCache -ChatId $ChatId
}
Set-Alias Add-AiTool Add-PowershaiChatTool


function Get-PowershaiChatTool {
	<#
		.SYNOPSIS
			Obtéma a list de tools atuais.
	#>
	[CmdletBinding()]
	param(
		# obter especifico pelo nome ou o proprio objeto!
		# Se terminar como um .ps1, trata como script, a menos que ForceCommand seja usado!
			$tool = "*"
			
		,#listar somente as tools habilitadas 
			[switch]$Enabled
			
		,#Chat de origem 
			$ChatId = "."

		,#Quando obtendo uma tool específica, procurar na lista de tools globais.
			[switch]$global 
		
		,#Trata tool como um command!
			[switch]$ForceCommand
	)
	
	$Chat = Get-PowershaiChat $ChatId
	
	$IsScript = $false;

	function ListTools {
		param($src, $scope)
		
		$Names = @($src.keys)
		foreach($ToolName in $Names){
			$ToolInfo = $src[$ToolName];
			
			
			if($Enabled -and !$ToolInfo.enabled){
				continue
			}
			
			
			$ToolInfo
		}
	}

	if(!$tool){
		throw "POWERSHAI_GETTOOLS_EMPTY: Must inform -tool";
	}
	
	if($tool -eq "*"){
		ListTools $Chat.Tools.raw "chat"
		ListTools $POWERSHAI_SETTINGS.UserTools "global"
	} else {
		
		if($Tool -like "*.ps1" -and !$ForceCommand){
			$IsScript = $true;
		}
		
		if(IsType $tool AiToolInfo){
			return $tool;
		} else {
			$ToolsStore = $Chat.Tools.raw
			if($Global){
				$ToolsStore = $POWERSHAI_SETTINGS.UserTools
			}
			
			[string]$ToolIndex = $tool;
			if($IsScript){
				[string]$AbsPath = Resolve-Path $tool
				$ToolIndex = "Path:" + $AbsPath
			} 
			
			$ToolInfo = $ToolsStore[$ToolIndex];
			
			if(!$ToolInfo){
				throw "POWERSHAI_GETTOOLS_NOTFOUND: Tool not found, name $tool. Global=$([bool]$Global), Script=$([bool]$IsScript)";
			}
			
			return $ToolInfo;
		}
	}
}
Set-Alias Get-AiTools Get-PowershaiChatTool


function Remove-PowershaiChatTool {
	<#
		.SYNOPSIS
			Remove uma tool definitivamente!
	#>
	[CmdletBinding()]
	param(
		#Nome do comando, script, funcoes que foi previamente adicioonado como tool.
		#Se for um arquivo .ps1, trata como um script, a menos que -Force command é usado.
		#Você pode usar o resultado de Get-PowershaiChatTool via pipe para este comando, que ele irá reconhecer
		#Ao enviar o objeto retornado, todos os demais parâmetros são ignorados.
		[parameter(ValueFromPipeline=$true)]
			$tool
			
		,#Força tratar tool como um comando, quando é uma string 
			[switch]$ForceCommand 
			
		,#Chat de onde remover 
			$ChatId = "."
			
		,#Remover da lista global, se a tool foi adicionada previamente como global 
			[switch]$global
	)
	
	begin {
		$Chat = Get-PowershaiChat $ChatId
		$ToolStore = $Chat.Tools.Raw;
		$IsGlobal = [bool]$global;		
	}
	
	process {
		$IsPath = $False;
		
		if(IsType $tool AiToolInfo){
			$IsPath = $tool.type -eq "file"
			$IsGlobal = $tool.scope -eq "global"
			$name = $tool.name
		}
		else {
			$name = [string]$tool
			if($name -like "*.ps1" -and !$ForceCommand){
				$IsPath = $true;
			}
		}
			
		if($IsGlobal){
			verbose "Using global tools store"
			$ToolStore = $POWERSHAI_SETTINGS.UserTools
		}
		
		$ToolIndex = $name;
		if($IsPath){
			[string]$AbsPath = Resolve-Path $name -EA SilentlyContinue
			$ToolIndex = "Path:" + $AbsPath;
		}
		verbose "Tool Index: $ToolIndex";
		
		
		if($ToolStore.contains($ToolIndex)){
			verbose "Removing tool";
			$ToolStore.Remove($ToolIndex);
		}
		
		verbose "Reseting cache";
		#Atualiza o cache das tools!
		Reset-PowershaiChatToolsCache -ChatId $ChatId
	}
}
Set-Alias Remove-AiTool Remove-PowershaiChatTool


function Set-PowershaiChatTool {
	<#
		.SYNOPSIS
			Desabilita um tool (mas não remove). Tool desabiltiada não é enviada ao LLM.
	#>
	[CmdletBinding()]
	param(
		#Nome da tool (mesmo de Add-PowershaiChatTool) ou via pipe o resultado de Get-PowershaiChatTool
			[parameter(ValueFromPipeline=$true)]
			$tool 
		
		,#habilita a tool.
			[Parameter(ParameterSetName="Enable")]
			[switch]$Enable
			
		,#desabilita a tool.
			[Parameter(ParameterSetName="Disable")]
			[switch]$Disable
		
		,#Se informado, e tool é um nome, força o mesmo a ser tratado como script!
			[switch]$ForceCommand
			
		,#Chat em qual a tool está 
			$ChatId = "."
			
		,#Procura a tool na lista global de Tools	
			[switch]$Global
	)
	
	begin {
		$Chat = Get-PowershaiChat $ChatId
	}
	
	process {	
		$Tool = Get-AiTools -ChatId $ChatId -tool $tool -global:$global -ForceCommand:$ForceCommand
		
		if($Tool){
			$OldState = $Tool.enabled
			
			if($Enable){
				$Tool.enabled = $true
			}
			
			if($Disable){
				$Tool.enabled = $false
			}
			
			verbose "	Setting from $OldState to $($Tool.enabled)"
		}
		
	}
	
	end {
		Reset-PowershaiChatToolsCache
	}
	
}
Set-Alias Set-AiTool Set-PowershaiChatTool

RegArgCompletion Set-AiTool,Remove-AiTool tool {
	param($cmd,$param,$word,$ast,$fake)
	
	Get-AiTools | ? { $_.name -like "$word*" } | %{
		if($_.type -eq "file"){
			"path:" + $_.name
		} else {
			$_.name
		}
		
	}
}



<#
	.SYNOPSIS 
		Converte todas as tools adicionadas no formato esperado pela função Invoke-AiChatTools.
		
	.DESCRIPTION  
		Obtém todas as tools cadastradas pelo usuário com New-PowershaiChatTool e compila em um único objeto para ser enviado ao LLM usando Invoke-AiChatTools.  
		Este processo pode ser bem lento, dependendo da quantidade de tools adicionadas.
		
		O cmdlet vai pecorrer todas as tools, obter o help dos comando e dos parâmetros, e converter isso em um formato que possa ser enviado em Invoke-AiChatTools
		Como o PowershAI define que o mecanismo de tools deve seguir o padrão da OpenAI, a função Get-OpenaiTool* do provider OpenAI é usada.  
		Estas funcões contém a lógica necessária para gerar o schema da tool calling seguindo as especificações da OpenAI.  
		
		Este comando, itera em cada tool disponível para o chat atual e cria o que é necessário para ser enviado com Invoke-AiChatTools. 
		Invoke-AiChatTools contém toda a lógica para lidar com o envio, execução e resposta do LLM.  
		
		Basicamente, existem 2 tipos de tools que o Powershai Suporte: Script ou Comando.  
		Comando é qualquer código executável pelo powershell: funções, .exe, cmdlets nativos, etc.
		
		Scripts são simples arquivos .ps1 que definem as funções que podem ser usadas como tools.
		É como se fosse um grupo de comandos.
		
		Este comando invoca tudo o que é necessário para converter essas tools no formato padrão esperado Invoke-AiChatTools.  
		Invoke-AiChatTools não sabe nada sobre chats, tools globais. Ela é uma função genérica que não depende do mecanismo de Chats criado pelo Powershai.  
		
		Por isso, é necessário que esta função faça toda essa "tradução" das facilidades do Powershai Chat para o esperado pelo Invoke-AiChatTools.
#>
function CompilePowershaiChatTools {
	[CmdletBinding()]
	param(
		#Chat do qual serão obtidos as tools 
		#Além do chat, as tools globais serão inclusas
		$ChatId = "."
	)
	
	$Chat = Get-PowershaiChat $ChatId
	$Compiled = @{
		ToolList = @()
	}
	
	function CompileTools {
		param($src, $scope)
		
		$Names = @($src.keys)
		
		
		
		$CmdIndex = @{}
		$CmdTools = @{
			tools = @()
			CmdIndex = $CmdIndex
			src = $scope
			type = "toolbox"
			map = {
				param($ToolName,$Me)
				
				$ToolData = $Me.CmdIndex[$ToolName];
				$Original = $ToolData.original
				
				# obtém a tool!
				$Tool = & $Original.map $ToolName $Original
				
				$Script = {
					param($HashArgs)
					
					$Result = & $Tool.func @HashArgs
					
					if($ToolData.formatter -and $ToolData.formatter -is [scriptblock]){
						return & $ToolData.formatter $Result
					} else {
						return $Result
					}
				}.GetNewClosure()
				
				@{func = $Script; NoSplatArgs = $true}
			}
			
		}
			
		foreach($name in $names){
			$Tool = $src[$name];
			
			if(!$Tool.enabled){
				continue;
			}
			
			if($Tool.type -eq "file"){
				$Compiled.ToolList += Get-OpenaiToolFromScript $Tool.name
			}
			
			if($Tool.type -eq "command"){
				
				$ParamList = "*"
				
				if($Tool.parameter){
					$ParamList = $Tool.parameter 
				}
				
				$OpenaiTools = @(Get-OpenaiToolFromCommand -functions $Tool.name -parameters $ParamList -UserDescription $Tool.UserDescription)
				$OriginalTool = $OpenaiTools[0]
				
				$ToolData = @{
					original 	= $OriginalTool
					formatter 	= $Tool.formatter
				}
				
				$CmdIndex[$Tool.name] = $ToolData
				$CmdTools.tools += $OriginalTool.tools;
			}
		}
		
		$Compiled.ToolList += $CmdTools
	}
	

	CompileTools $Chat.Tools.raw "chat"
	CompileTools $POWERSHAI_SETTINGS.UserTools "global"
	
	
	return $Compiled.ToolList
}
Set-Alias CompileChatTools CompilePowershaiChatTools



function Enable-AiScreenshots {
	<#
		.SYNOPSIS
			Habilita o explain screen!
			
		.DESCRIPTION
			Explain Screen é uma feature que permite obter prints de uma área da tela e enviar ao LLM que suporta vision!
			É um recurso que está sendo testado ainda, e por isso, você deve habilita!
	#>
	[CmdletBinding()]
	param()
	
	$ModScript = {
		. "$PsScriptRoot/lib/screenshotservices.ps1"
	}
			
	$DummyMod = New-Module -Name "PowershaiExplainScreen" -ScriptBlock $ModScript
	verbose "	Importing dummy module"
	import-module -force $DummyMod 
}

function Invoke-AiScreenshots {
	<#
		.SYNOPSIS
			Faz print constantes da tela e envia para o modelo ativo.
			Este comando é EXPERIMENTAL e pode mudar ou não ser disponibilizado nas próximas versões!
			
		.DESCRIPTION
			Este comando permite, em um loop, obter prints da tela!
	#>
	param(
		#Prompt padrão para ser usado com a imagem enviada!
			$prompt = "Explique essa imagem"
		
		,#Fica em loop em tirando vários screenshots
		 #Por padrão, o modo manual é usado, onde você precisa pressionar uma tecla para continuar.
		 #as seguintes teclas possuem funcoes especiais:
		 #	c - limpa a tela 
		 # ctrl + c - encerra o comando
			[switch]$repeat
		
		,#Se especificado, habilita o modo repeat automático, onde a cada número de ms especificados, ele irá enviar para a tela tela.
		 #ATENÇÃO: No modo automatico, você poderá ver a janela piscar constatemente, o que pode ser ruim para a leitura.
			$AutoMs = $nulls
		
			
		,#Recria o chat usado!
			[switch]$RecreateChat
			
		
	)
	
	# Create new chat!
	$CurrentChat = Get-PowershaiChat .
	
	try {
		# Create internal chat!
		$IfNotExists = !$RecreateChat
		$sschat 	= New-PowershaiChat -ChatId "pwshai-screenshots" -IfNotExists:$IfNotExists -Recreate:$RecreateChat;
		$null 		= Set-PowershaiActiveChat $sschat;
		
		
		$jobdata = @{
			ms = $AutoMs
			modpath = $PowershaiRoot
		}
		
		if($AutoMs){
			Get-Job "PowershaiScreenshot" -ea SilentlyContinue | Stop-Job -PassThru | Remove-job;
			
			$PrintJob = Start-Job -Name "PowershaiScreenshot" {
				param($data)
				
				import-module -force $data.modpath;
				Enable-AiScreenshots
				while($true){
					
					write-output $(Get-PowershaiPrintSCreen)
					Start-Sleep -m $data.ms
				}
			} -ArgumentList $jobdata
		}
		
		$PendingPrints = New-Object Collections.ArrayList
		$null = $PendingPrints.Add( (Get-PowershaiPrintSCreen) )
		
		while($true){
			foreach($file in $PendingPrints){
				$WarningPreference = "SilentlyContinue"
				Send-PowershaiChat -Temporary -prompt "$prompt","file: $file";
				$WarningPreference = "Continue";
			}
			
			if(!$repeat){
				break;
			}
			
			$PendingPrints.Clear();
			while(!$PendingPrints){
				if($AutoMs){
					$null = $PrintJob | Receive-Job | %{ $PendingPrints.Add($_) };
					start-sleep -m $AutoMs;
				} else {
					[Console]::TreatControlCAsInput = $true;
					$key = [console]::ReadKey($true)
					[Console]::TreatControlCAsInput = $False;
					
					if($key.Key -eq "C"){
						if($key.Modifiers -eq "Control"){
							return;
						}
						
						clear-host;continue;
					}

					$null = $PendingPrints.Add( (Get-PowershaiPrintSCreen) )
				}
			}
			
			write-host "";
		}
		
	} finally {
		$null = Set-PowershaiActiveChat $CurrentChat;
		$null = Get-Job "PowershaiScreenshot" -ea SilentlyContinue | Stop-Job
	}
}
Set-Alias printai Invoke-AiScreenshots


function Get-PowershaiHelp {
	<#
		.SYNOPSIS
			Usa o provider atual para ajudar a obter ajuda sobre o powershai!
			
		.DESCRIPTION
			Este cmdlet utiliza os próprios comandos do PowershAI para ajudar o usuário a obter ajuda sobre ele mesmo.  
			Basicamente, partindo da pergunta do usuário, ele monta um prompt com algumas informacoes comuns e helps basicos.  
			Então, isso é enviando ao LLM em um chat.
			
			Devido ao grande volume de dados enviandos, é recomendando usar esse comando somente com providers e modeos que aceitam mais de 128k e que sejam baratos.  
			Por enquanto, este comando é experimental e funciona penas com estes modelos:
				- Openai gpt-4*
				
			Internamente, ele irá criar um Powershai Chat chamado "_pwshai_help", onde manterá todo o histórico!
	#>
	[CmdletBinding()]
	param(
		#Descreva o texto de ajuda!
		$helptext
		
		,#Se quiser help de um comando específico, informe o comando aqui 
		 #Não precisa ser somente um comando do PowershaiChat.
			$command
			
		,#Recria o chat!
			[switch]$Recreate
	)
	
	write-warning "This command is in preview! Take caution!"
	
	$CurrentProvider = Get-AiCurrentProvider
	$CurrentProviderName = $CurrentProvider.name;
	[object[]]$SupportedProviders = @("openai")
	if($CurrentProviderName -notin $SupportedProviders){
		throw "POWERSHAI_AIHELP_PROVIDER_NOTSUPPORTED: $CurrentProviderName | Allowed = $SupportedProviders"
	}
	
	$CurrentChat = Get-PowershaiChat .
	
	
	
	$HelpTools = JoinPath $PsScriptRoot "lib" PowershaiHelp.tools.ps1
	
	
	
	try {
		# Create internal chat!
		$IfNotExists = !$Recreate
		$HelpChat 	= New-PowershaiChat -ChatId "_pwshai_help" -IfNotExists:$IfNotExists -Tool $HelpTools -Recreate:$Recreate;
		$null 		= Set-PowershaiActiveChat $HelpChat;
	
		$null = Set-PowershaiChatParameter MaxContextSize 20000
		$null = Set-PowershaiChatParameter MaxInteractions 50
		$null = Set-PowershaiChatParameter MaxTokens 8192
		
		if(!$HelpChat.HelpCache){
			$HelpChat | Add-Member -Force Noteproperty HelpCache @{}
		}
		
		$HelpCache = $HelpChat.HelpCache;
		
		if(!$HelpCache.SystemPrompt){
			
			$Synopsis = @{
				Name = "Descricao"
				Expression = {
					if($_.CommandType -eq "alias"){
						return "Alias para" + $_.Definition;
					}
					
					return (Get-help $_).Synopsis.trim()
				}
			}
			
			$CommandHelp = Get-Command -mo powershai | select name,$Synopsis
			
			$Culture = Get-UICulture;
			$HelpCache.SystemPrompt = @(
					"Você é um assistente que deve ajudar o usuário a responder dúvidas sobre um módulo Powershell chamado Powershai"
					"O Powershai é um módulo que possui vários comandos para trazer ao mundo de IA!"
					"Abaixo está a lista de comandos do powershai, separado por vírgula:"
					@(Get-Command -mo powershai | select CommandType,name | out-string)
					""
					"Abaixo está a lista de help topics disponiveis no powershai:"
					@(get-help about_Powershai*|out-string)
					"Com base na questão responda sobre as perguntas com o máximo de detalhes e clareza possível"
					"Formate a resposta apenas com textos simples, sem qualquer formatçaão visual, pois o texto será exinido em um prompt de comando"
					"Resonda no idioma da pergunta do usuário. Caso não seja possível identificar, responda nesse: $($Culture.DisplayName)"
				)
		}
		
		
		
		ia $helptext -SystemMessages $HelpCache.SystemPrompt
	} finally {
		$null = Set-PowershaiActiveChat $CurrentChat;
	}
	
	
	
	
	
}
set-alias aihelp Get-PowershaiHelp
set-alias aid Get-PowershaiHelp
set-alias ajudai Get-PowershaiHelp
set-alias iajuda Get-PowershaiHelp





# Carrega os providers!
$ProvidersPath = JoinPath $POWERSHAI_PROVIDERS_DIR "*.ps1"

$ProvidersFiles = gci $ProvidersPath

foreach($File in $ProvidersFiles){
	$ProviderName = $File.name.replace(".ps1","");
	write-verbose "Loading provider $ProviderName";
	
	$ProviderData = . $File.FullName;
	
	if(!$ProviderData.info.desc){
		throw "POWERSHAI_PROVIDER_NODESC: Provider $ProviderName must have desc"
	}
	
	if($ProviderData -isnot [hashtable]){
		throw "POWERSHAI_LOADPROVIDER_INVALIDRESULT: Provider script dont returned hashtable. This can be a bug with Powershai";
	}
	
	$ProviderData.name = $ProviderName;
	$UserDefinedSettings = $POWERSHAI_SETTINGS.providers[$ProviderName];

	if(!$UserDefinedSettings){
		$UserDefinedSettings = @{};
	}
	
	$PROVIDERS[$ProviderName] = $ProviderData;
	$POWERSHAI_SETTINGS.providers[$ProviderName] = $UserDefinedSettings;	
}

# Set default provider to openai!
if(!$POWERSHAI_SETTINGS.provider){
	Set-AiProvider openai
}

Export-ModuleMember -Alias * -Cmdlet *-* -Function *-*

