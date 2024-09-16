---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtém o provider mais recente do script atual

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet é comumente uado pelos providers de forma indireta através de Get-AiCurrentProvider.  
Ele olha na callstack do powershell e identifica se o caller (a função que executou) faz parte de um script de um provider.  
Se for, ele retorna esse provider.

Se a chamada foi feia em múltiplos providers, o mais recente é retornaod. Por exemplo, imagine esse cenário:

	Usuario -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
Neste caso, note que existem 2 calls de providers envolvidas.  
Neste caso, a funcao Get-AiNearProvider retornará o provider y, pois ele é o mais recente da call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->