---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Gets the nearest provider from the current script

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet is commonly used by providers indirectly through Get-AiCurrentProvider.  
It looks into the powershell callstack and identifies if the caller (the function that executed it) is part of a provider script.  
If it is, it returns that provider.

If the call was made in multiple providers, the latest one is returned. For example, imagine this scenario:

	User -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
In this case, notice there are 2 provider calls involved.  
In this case, the Get-AiNearProvider function will return provider y, as it is the latest one in the call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
