---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-AiNearProvider

## SYNOPSIS
Obtém o provider mais recente do script atual

## SYNTAX

```
Get-AiNearProvider
```

## DESCRIPTION
Este cmdlet é comumente uado pelos providers de forma indireta através de Get-AiCurrentProvider.
 
Ele olha na callstack do powershell e identifica se o caller (a função que executou) faz parte de um script de um provider.
 
Se for, ele retorna esse provider.

Se a chamada foi feia em múltiplos providers, o mais recente é retornaod.
Por exemplo, imagine esse cenário:

	Usuario -\> Get-aiChat -\> ProviderX_Function -\> ProviderY_Function -\> Get-AiNearProvider
	
Neste caso, note que existem 2 calls de providers envolvidas.
 
Neste caso, a funcao Get-AiNearProvider retornará o provider y, pois ele é o mais recente da call stack.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
