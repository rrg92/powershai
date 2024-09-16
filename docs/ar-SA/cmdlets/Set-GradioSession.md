---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
تعيين بعض خيارات الجلسة.

## SYNTAX <!--!= @#Syntax !-->

```
Set-GradioSession [[-Session] <Object>] [-Default] [[-MaxCalls] <Object>] [[-MaxCallsPolicy] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
جلسة Gradio

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
تعيين الجلسة كجلسة افتراضية

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
تعيين الحد الأقصى للاتصالات. لمزيد من المعلومات راجع Invoke-GradioSessionApi

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
تعيين سياسة الحد الأقصى للاتصالات. لمزيد من المعلومات راجع Invoke-GradioSessionApi

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
