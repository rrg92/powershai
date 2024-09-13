---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Set-AiDefaultModel

## SYNOPSIS
Configurar o LLM default do provider atual

## SYNTAX

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
Usuários podem configurar o LLM default, que será usado quando um LLM for necessário.
 
Comandos como Send-PowershaAIChat, Get-AiChat, esperam um modelo, e se não for informado, ele usa o que foi definido com esse comando.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -model
Id do modelo, conforme retornado por Get-AiModels
Você pode usar tab para completar a linha de comando.

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

### -Force
Força definir o modelo, mesmo que não seja retornaod por Get-AiModels

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
