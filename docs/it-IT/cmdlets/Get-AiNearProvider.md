---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Ottiene il provider più recente dello script corrente

## DESCRIPTION <!--!= @#Desc !-->
Questo cmdlet è comunemente utilizzato dai provider in modo indiretto tramite Get-AiCurrentProvider.  
Esamina la callstack di PowerShell e identifica se il chiamante (la funzione che è stata eseguita) fa parte di uno script di un provider.  
Se lo è, restituisce tale provider.

Se la chiamata è stata effettuata da più provider, viene restituito quello più recente. Ad esempio, immagina questo scenario:

	Utente -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
In questo caso, nota che sono coinvolte 2 chiamate di provider.  
In questo caso, la funzione Get-AiNearProvider restituirà il provider y, poiché è il più recente nella call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
