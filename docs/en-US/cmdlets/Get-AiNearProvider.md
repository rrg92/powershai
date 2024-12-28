---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Gets the most recent provider from the current script

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet is commonly used by providers indirectly through Get-AiCurrentProvider.  
It looks at the powershell callstack and identifies if the caller (the function that executed) is part of a provider script.  
If so, it returns that provider.

If the call was made in multiple providers, the most recent one is returned. For example, imagine this scenario:







Usuario -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider

In this case, note that there are 2 provider calls involved.  
In this case, the Get-AiNearProvider function will return provider y, as it is the most recent in the call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [[-callstack] <Object>] [[-filter] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -callstack
Use a specific call stack.
This parameter is useful when a function that invoked wants to consider looking from a specific point!

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

### -filter
ScriptBlock with the filter. $_ points to the provider found!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
