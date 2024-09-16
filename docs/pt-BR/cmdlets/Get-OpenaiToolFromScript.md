---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Função auxiliar para converter um script .ps1 em um formato de schema esperado pela OpenAI.
Basicamente, o que essa fução faz é ler um arquivo .ps1 (ou string) juntamente com sua help doc.  
Então, ele retorna um objeto no formato especifiado pela OpenAI para que o modelo possa invocar!

Retorna um hashtable contendo as seguintes keys:
	functions - A lista de funções, com seu codigo lido do arquivo.  
				Quando o modelo invocar, você pode executar diretamente daqui.
				
	tools - Lista de tools, para ser enviando na chamada da OpenAI.
	
Você pode documentar suas funções e parâmetros seguindo o Comment Based Help do PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```