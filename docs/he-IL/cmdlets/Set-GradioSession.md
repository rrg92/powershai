---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
הגדר אפשרויות מסוימות של session.

## SYNTAX <!--!= @#Syntax !-->

```
Set-GradioSession [[-Session] <Object>] [-Default] [[-MaxCalls] <Object>] [[-MaxCallsPolicy] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Sessão Gradio

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Default
הגדר את session כברירת מחדל

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

### -MaxCalls
הגדר את מספר הקריאות המרבי. למידע נוסף עיין ב-Invoke-GradioSessionApi

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

### -MaxCallsPolicy
הגדר את מדיניות מספר הקריאות המרבי למידע נוסף עיין ב-Invoke-GradioSessionApi

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
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
