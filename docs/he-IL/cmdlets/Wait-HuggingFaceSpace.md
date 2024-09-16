---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Wait-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
מחכה שה-space יתחיל. מחזיר $true אם הוא התחיל בהצלחה או $false אם חלף הזמן!

## SYNTAX <!--!= @#Syntax !-->

```
Wait-HuggingFaceSpace [[-Space] <Object>] [-timeout <Object>] [-SleepTime <Object>] [-NoStatus] [-NoStart] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
מסנן לפי space ספציפי

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -timeout
כמה שניות, לכל היותר, לחכות. אם null, אז מחכה לנצח!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -SleepTime
זמן המתנה עד לבדיקה הבאה, ב-ms

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 5000
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoStatus
לא להדפיס סטטוס התקדמות...

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

### -NoStart
לא להתחיל, רק לחכות!

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
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
