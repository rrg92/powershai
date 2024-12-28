---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModel

## SYNOPSIS <!--!= @#Synop !-->
Returns information of a specific model from the cache!

## DESCRIPTION <!--!= @#Desc !-->
If the model exists in cache, uses the cached data!
If it does not exist, it tries to query, if it hasn't been tried yet.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModel [[-ModelName] <Object>] [-MetaDataOnly] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ModelName
Model name

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

### -MetaDataOnly
Checks only on the provider!

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


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
