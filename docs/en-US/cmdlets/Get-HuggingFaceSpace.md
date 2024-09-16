---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
Gets information about a specific space!

## SYNTAX <!--!= @#Syntax !-->

### Multiple
```
Get-HuggingFaceSpace [-author <Object>] [-My] [-NoGradioSession] [<CommonParameters>]
```

### Single
```
Get-HuggingFaceSpace [[-Space] <Object>] [-NoGradioSession] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
Filters by a specific space (or array of spaces)

```yml
Parameter Set: Single
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -author
Filter all spaces by author

```yml
Parameter Set: Multiple
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -My
Filter all spaces of the current user!

```yml
Parameter Set: Multiple
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoGradioSession
Does not create an automatic gradio session.
By default, in gradio spaces, it already creates a gradio session!

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
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
