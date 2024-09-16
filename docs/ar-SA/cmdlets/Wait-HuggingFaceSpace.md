---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Wait-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
ينتظر بدء المساحة. يعيد $true إذا بدأ بنجاح أو $false إذا تم تجاوز المهلة!

## SYNTAX <!--!= @#Syntax !-->

```
Wait-HuggingFaceSpace [[-Space] <Object>] [-timeout <Object>] [-SleepTime <Object>] [-NoStatus] [-NoStart] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
يصفّي حسب مساحة محددة

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
عدد الثواني التي تُنتظر كحد أقصى. إذا كان null، فسيتم الانتظار إلى أجل غير مسمى!

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
وقت الانتظار حتى التحقق التالي، بالمللي ثانية

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
لا تطبع حالة التقدم...

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
لا يبدأ، بل ينتظر فقط!

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
