---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-AiModels

## SYNOPSIS
lista os modelos disponíveis no provider atual

## SYNTAX

```
Get-AiModels [<CommonParameters>]
```

## DESCRIPTION
Este comando lista todos os LLM que podem ser usados com o provider atual para uso no PowershaiChat.
 
Esta função depende que o provider implemente a função GetModels.

O objeto retornado varia conforme o provider, mas, todo provider deve retorna um array de objetos, cada deve conter, pelo menos, a propridade id, que deve ser uma string usada para identificar o modelo em outros comandos que dependam de um modelo.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
