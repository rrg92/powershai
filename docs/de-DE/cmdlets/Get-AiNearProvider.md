---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Ruft den neuesten Provider des aktuellen Skripts ab

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet wird häufig von Providern indirekt über Get-AiCurrentProvider verwendet.  
Es untersucht den Callstack von Powershell und identifiziert, ob der Aufrufer (die Funktion, die ausgeführt wurde) Teil eines Skripts eines Providers ist.  
Wenn dies der Fall ist, wird dieser Provider zurückgegeben.

Wenn der Aufruf von mehreren Providern getätigt wurde, wird der neueste zurückgegeben. Stellen Sie sich beispielsweise folgendes Szenario vor:

	Benutzer -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
Beachten Sie, dass in diesem Fall zwei Provideraufrufe beteiligt sind.  
In diesem Fall gibt die Funktion Get-AiNearProvider den Provider Y zurück, da er der neueste in der Callstack ist.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
