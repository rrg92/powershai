---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
Gets the active provider

## DESCRIPTION <!--!= @#Desc !-->
Returns the object that represents the active provider.  
Providers are implemented as objects and are stored in the session's memory, in a global variable.  
This function returns the active provider, which was defined with the Set-AiProvider command.

The returned object is a hashtable containing all the provider's fields.  
This command is commonly used by providers to get the name of the active provider.  

The -ContextProvider parameter returns the current provider where the script is running.  
If running in a provider's script, it will return that provider, instead of the provider defined with Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [[-CallStack] <Object>] [[-FilterContext] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
If enabled, uses the context provider, that is, if the code is running in a file in a provider's directory, it assumes this provider.
Otherwise, it gets the currently enabled provider.

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -CallStack
Alternative stack to consider! See more in Get-AiNearProvider

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

### -FilterContext
Allows you to choose the provider based on filters

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
