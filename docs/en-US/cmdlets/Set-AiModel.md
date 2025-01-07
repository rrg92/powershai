---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiModel

## SYNOPSIS <!--!= @#Synop !-->
Modifies options of a model from the current provider

## DESCRIPTION <!--!= @#Desc !-->
Models have configurations that can be modified and that change some feature or characteristic.
The function parameters document the available options and their effects.
These configurations only take effect in the current session. They are also exported and imported when using Export-PowershaiSettings (or Import).
These defined options take precedence over the default settings!

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiModel [[-ModelName] <Object>] [[-tools] <Object>] [[-embeddings] <Object>] [[-Unset] <String[]>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ModelName
Model name

```yml
Parameter Set: (All)
Type: Object
Aliases: model
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -tools
Enables or disables support for tools

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

### -embeddings
Enables or disables support for embeddings

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

### -Unset
Defines options that will be reset (takes precedence over other options).

```yml
Parameter Set: (All)
Type: String[]
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
