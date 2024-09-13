---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-OpenaiToolFromScript

## SYNOPSIS

## SYNTAX

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Função auxiliar para converter um script .ps1 em um formato de schema esperado pela OpenAI.
Basicamente, o que essa fução faz é ler um arquivo .ps1 (ou string) juntamente com sua help doc.
 
Então, ele retorna um objeto no formato especifiado pela OpenAI para que o modelo possa invocar!

Retorna um hashtable contendo as seguintes keys:
	functions - A lista de funções, com seu codigo lido do arquivo.
 
				Quando o modelo invocar, você pode executar diretamente daqui.
				
	tools - Lista de tools, para ser enviando na chamada da OpenAI.
	
Você pode documentar suas funções e parâmetros seguindo o Comment Based Help do PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ScriptPath
{{ Fill ScriptPath Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
