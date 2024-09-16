---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Clear-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Clears elements of a chat!

## DESCRIPTION <!--!= @#Desc !-->
Clears specific elements from a chat.  
Useful to free up resources, or to break the llm's addiction to history.

## SYNTAX <!--!= @#Syntax !-->

```
Clear-PowershaiChat [-History] [-Context] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -History
Clears the entire history

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

### -Context
Clears the context 
Chat Id. Default: active.

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

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
