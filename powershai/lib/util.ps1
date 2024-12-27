
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
	return $Obj.psobject.TypeNames -contains "PowershaiType:$name" `
	-or $Obj.psobject.TypeNames -contains "Deserialized.PowershaiType:$name"
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
		#Unique erro identification 
			$Name
			
		,#A mensagem da exception!
			$Message
		
		,#Propriedades personazalidas 
			$Props  = @{}
			
		,#Tipo adicional!
			$Type = $null
			
		,#Exception pai!
			$Parent = $null

		
	)
	
	if($message){
		$message = $message -Join "`n"
	}
	
	$Ex = New-Object System.Exception("$($Name):$Message",$Parent)
	
	foreach($PropName in @($Props.keys)){
		$Ex | Add-Member -force Noteproperty $PropName $Props[$PropName]
	}
	
	$Ex | Add-Member -force Noteproperty ErrorName $Name;
	
	if($Type){
		SetType $Ex $Type
	}
	
	return $ex;
}

<#
	.SYNOPSIS
		Mescla hashtables em uma hashtable de destino
		
	.DESCRIPTION  
		A hashtable de destino irá conter o valor atualizado das hashtables de origem. 
		Pode se especificar várias hashtables de origem, basta informar.
		Uma nova hashtable é retornada, sem alterar as existentes!
#>
function HashTableMerge {
	[CmdletBinding(PositionalBinding=$false)]
	param(
		[parameter(Position=1)]
			$Target
		
		,[parameter(Position=2,ValueFromRemainingArguments)]
			$SourceTables
			
		,$filter = $null
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
		
		if($SrcTable -eq $null){
			continue;
		}
		
		if($SrcTable -is [psobject] -and $SrcTable -isnot [hashtable]){
			$ObjHash = @{}
			$SrcTable.psobject.properties | %{ $ObjHash[$_.name] = $_.Value }
			$SrcTable = $ObjHash;
		}
		
		elseif($SrcTable -isnot [hashtable]){
			$type = "null";
			
			if($SrcTable){
				$type = $SrcTable.getType().FullName;
			}
			
			throw "POWERSHAI_MERGEHASH_ISNOT_HASHTABLE: $type";
		}
		
		foreach($key in @($SrcTable.keys) ){
			$KeyPath = $ParentKeyPath +"/"+ $key
			
			#Se as duas são com tipos diferentes, então sobrescreve
			$SrcValue = $SrcTable[$key]
			$NewValue = $NewTable[$key];
			
			
			if($filter){
				$FilterResult = & $filter @{
						key 		= $key
						new 		= $SrcValue 
						current 	= $NewValue
						path 		= $KeyPath 
					}
					
				if(!$FilterResult){
					continue;
				}
			}
			
			
			# Se for um hashtable, recursivamente atualiza!
			if($SrcValue -is [hashtable] -and $NewValue -is [hashtable]){
				$ParentKeyPath = $KeyPath
				$SrcValue = & $Me $NewValue $SrcValue  
			}
			
			elseif($SrcValue -is [hashtable]){
				# make copy!
				$SrcValue = & $Me @{} $SrcValue
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



function GetParams($FunctionName){
	
	$c = Get-Command $FunctionName;
	$ParamsAst = $Command.ScriptBlock.Ast.Parameters;
	
	if(!$ParamsAst){
		$ParamsAst = $c.ScriptBlock.Ast.Body.ParamBlock.Parameters;
	}
	
	$CommandHelp = get-help $c;
	
	$Global:HelpIndex = @{}
	
	$CommandHelp.parameters.parameter | %{ 
		$AllText = $_.description | %{
			
			$_.text -split '\r?\n' | ?{$_ -and $_.trim()} | %{ $_.trim() }		
		}
	
		$HelpIndex[$_.name] = $AllText 
	
	}
	
	foreach($param in $ParamsAst){
		$ParamName = $param.name.toString() -replace '^\$','';
		[PsCustomObject]@{
			name = $ParamName
			definition = $param.toString()
			help = $HelpIndex[$ParamName]
			source  = $c
		}
		
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
	
	if(!$str){
		$str = "";
	}
	
	$shaManaged = New-Object System.Security.Cryptography.SHA256Managed
	[System.Convert]::ToBase64String($shaManaged.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($str)))
}


function Confirm-PowershaiObjectSchema {
	<#
		.SYNOPSIS 
			Valida se um objeto segue um schema correto
		
		.DESCRIPTION
			Este comando valida se a estrutura deum objeto, ou hashtable, segue um schema.  
			O schema é definindo no parametro scehma, e possui a seguinte sintaxe:
				@{	
					#Definir cada key esperada no objeto!
					Key1 = [string] 		# tipo de dado esperado!
					Key2 = "val1","val2" 	# lista de valores esperados
					
					# Uma key que é um objeto! Cada item deve especificar as props do objeto esperado!
					Key3 = @{
								SubKey1 = [int] # Significa: Key3.SubKey1 deve ser int
							}
							
					# Uma key que é um array!
					Key4 = @{
							'$schema' = "array" # a key especial $schema é uma metadado que define o schema!
							
							SubKey1 = [string] # Entao, cada subkey é tratado como 
						}
				}
				
			'$schema' deve seguir as mesmas especificacoes da OpenaAPI.
			Se $schema for um type, é o meso que especificr $schema.type = "array".
	#>
	param($obj, $schema, $parent)
	
	$Me = $MyInvocation.MyCommand;
	
	$Options = $schema.'$schema';
	
	if($Options -is [type]){
		$Options = @{
			type = $Options
		}
	}
	
	if($parent){
		$Validations 	= $parent.validations
		$ParentPath 	= $parent.path;
	} else {
		$ParentPath 	= ""
		$Validations 	= @{}
	}
	
	$IsValid = $true;
	$errors = @()
	
	$hashvals = @{}
	
	
	
	if($Options.type -eq [array]){
		
		$n = -1;
		
		$ItemSchema = HashTableMerge @{} $schema;
		$ItemSchema.remove('$schema');
		
		if($obj -is [array]){
			
			$obj | %{
				$n++;
				
				$result = & $me $_ $ItemSchema @{
						path = $ParentPath+"[$n]"
						validations = $Validations
					}
					
				if(!$result.valid){
					$IsValid = $false;
				}
			}
		} else {
			$IsValid = $false;
			$IsTypeValid = $false;
			$Validations[$ParentPath] = [pscustomobject]@{
				path 	= $ParentPath
				valid 	= $false;
				errors 	= "NotArray"
			}
		}
		
		$schema = @{};
	}
	elseif($obj -eq $null){
		$hashvals = @{}
	} 
	elseif($obj -isnot [hashtable]){			
		$obj.psobject.properties | %{ $hashvals[$_.name] = $_.value }
	} else {
		$hashvals = $obj
	}
	

	foreach($key in @($schema.keys)){
		$KeyPath = $ParentPath +"/"+ $key;
		
		if($key -eq '$schema'){
			continue;
		}
		
		$KeySchema = @{
			type 	= [object]
			values  = @()
		}
		
		$KeySchemaValue = $schema[$key];
		$KeyValue 		= $hashvals[$key];
		
		if($KeySchemaValue -is [type]){
			$KeySchema.type = $KeySchemaValue
		}
		
		if($KeySchemaValue -is [array]){
			$KeySchema.values = $KeySchemaValue
		}
		
		if($KeySchemaValue -is [hashtable]){
			# recursive validation!
			$result = & $Me $KeyValue $KeySchemaValue @{
						path = $KeyPath
						validations = $Validations
					}
					
			$IsValidSchema = $result.valid;
			$IsContentValid = $IsValidSchema;
			$IsTypeValid	= $true;
		} else {
			$ExpectedType 	= $KeySchema.type;
			$ExpectedTypes 	= @($ExpectedType)
			
			if($ExpectedType -eq [int]){
					$ExpectedTypes += [int64];
			}
			
			[bool]$IsTypeValid = @( $ExpectedTypes | ?{ $KeyValue -is $_ }).count
			
			
			
			if(!$IsTypeValid){
				
				$CurrenType = "NULL";
				if($KeyValue -ne $null){
					$CurrenType = $KeyValue.getType().Name
				}
				
				$errors 	+= @(
								"InvalidType:$CurrenType"
								"Expected:"+(@($ExpectedType|%{$_.name}) -Join ",")
							) -Join ","
			}
			
			$IsContentValid = !$KeySchema.values -or $KeyValue -in @($KeySchema.values);
			if(!$IsContentValid){
				$errors += "InvalidContent:"+$KeyValue;
			}
			
			$IsValidSchema = $IsTypeValid -and $IsContentValid;
		}
		
		if(!$IsValidSchema){
			$IsValid = $false;
		}
		
		$Validations[$KeyPath] = [pscustomobject]@{
				path 		= $KeyPath
				name 		= $key
				valid 		= $IsValidSchema
				IsTypeValid = $IsTypeValid
				ValueValid 	= $IsContentValid
				errors 		= $errors
			}
	}
	
	$result = @{
		valid = $IsValid
	}
	
	if(!$ParentPath){
		$result.validations = @($Validations.values)
	}
	
	return [PsCustomObject]$result;
}



function Enter-PowershaiRetry {
	<#
		.SYNOPSIS
			Gerencia a execução de comandos com base no resultado
			
		.DESCRIPTION
			Este cmdlet ajuda a executar comandos enquanto um determinado resultado não for alcançado.
			Com isso, é possível, por exemplo, solicitar o LLM que gere um resultado novamente caso a resposta não seja a solicitada!
	#>
	[CmdletBinding()]
	param(
		#O scriptblock com o código a ser executado
			$Code 
		
		,#Resultado esperado 
		 #Pode ser uma string co o qual o resultado do código será comparado.
		 #Pode ser um script block que será invocado!
		 #Deve retornar um bool true para ser considerado como válido!
		 #$_ aponta para o resultado atual!
			$Expected 
		
		,#Máximo de retry
			$Retries = 1
			
		,#Exibe o progresso das tentativas 
			[switch]$ShowProgress
			
		,#Inclui exceptions no check!
		 #Se não especifciado, se o codigo em -Code resultar em erro, o erro é disparado de volta para quem chamou.
		 #Ao ser especificado, o erro é enviado como resultado para que o codigo -Expected decida o que fzer!
			[switch]$CheckErrors
			
		,# Permite modificar o vlaor a ser usado no check. $_  apontará para o objeto resultante da execução!
			$ModifyResult = $null
	)
	
	function progress {
		if($ShowProgress){
			write-host @Args;
		} else {
			verbose @Args;
		}
	}
	
	if($Expected -is [ScriptBlock]){
		$CheckScript = $Expected
	} else {
		$CheckScript = {
			return $Expected
		}
	}
	
	$CheckDetails = @{}
	
	$MustRetry 	= $true;
	$CurrentTry = 0;
	while($CurrentTry -lt $Retries){
		$CurrentTry++;
		
		progress "Running code... Try: $($CurrentTry)";
		$IsError = $false;
		try {
			$result = & $code 
		} catch {
			
			if(!$CheckErrors){
				throw;
			}
			
			progress "Resulted in error";
			$IsError = $true;
			$result = $_
		}
		
		progress "	Result:`n$result"
		
		[bool]$CheckResult = & {
				
				
				if($ModifyResult -is [scriptblock]){
					$result = $ModifyResult.InvokeWithContext($null,[psvariable]::new('_', $result)) | %{$_}
				}
			
				$CheckScriptResult = $CheckScript.InvokeWithContext(	$null, [psvariable]::new('_', $result)) | %{$_};
				verbose "CheckScriptResult: $CheckScriptResult";
				
				$CheckDetails.CheckScriptResult = $CheckScriptResult;
				
				if($CheckScriptResult -is [bool]){
					verbose "Result is bool!";
					return $CheckScriptResult;
				}
				
				
				if($CheckScriptResult -is [type]){
					verbose "Validating if is type $CheckScriptResult";
					return $result -is $CheckScriptResult;
				}
				
				if($CheckScriptResult -is [hashtable]){
					verbose "result is hashtable. Validating as schema!";
					
					# Result must be a valid object!
					# If text, assume JSON!
					$ResultObject = $result;
					
					if($ResultObject -is [string]){
						$ResultObject = $ResultObject | ConvertFrom-Json;
					}
					
					$SchemaValidation = Confirm-PowershaiObjectSchema $ResultObject $CheckScriptResult
					
					$CheckDetails.SchemaValidation = $SchemaValidation;
					return $SchemaValidation.valid;
				}
				
				verbose "Performing simple eq comparison...";
				return $result -eq $CheckScriptResult	
			}
		
		progress "	CheckResult: $CheckResult";
		
		if($CheckResult){
			write-output -NoEnumerate $result;
			return;
		}
	}
	
	
	$error = New-PowershaiError POWERSHAI_RETRY_MAXREACHED -Props @{
		details = $CheckDetails
	}
	
	throw $error;
}


function GetParamCallAlias {
	param($ParamName)
	
	$ParentInvocation = Get-Variable -Scope 1 MyInvocation -Value;
	$MyAliases =$ParentInvocation.MyCommand.Parameters[$ParamName].Aliases
	$MyAliasesReg = $MyAliases -Join "|";
		
	$AliasFound = $ParentInvocation.Line -match "-\b($MyAliasesReg)\b"
	
	if($AliasFound){
		return $matches[1];
	}
}
