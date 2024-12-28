---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiProviderInterface

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Invokes the implementations of a provider's interfaces!
PowershAI expects certain functions to be implemented by providers.  

For example, the Chat function is used when we invoke Get-AiChat.  
These functions must be implemented to provide functionality in a standard way.  
These functions are implemented using the provider's name, for example: openai_Chat.  

Powershai uses this function to invoke the functions implemented by powershai. It acts as a wrapper and facilitator and handles scenarios common to all these invocations.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiProviderInterface [[-FuncName] <Object>] [[-FuncParams] <Object>] [-Ignore] [-CheckExists] [[-ProviderName] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -FuncName

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

### -FuncParams

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

### -Ignore

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

### -CheckExists

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

### -ProviderName

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
