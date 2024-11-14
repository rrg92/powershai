---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
تحديث نتيجة استدعاء تم إنشاؤه كـ Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
تتبع هذه الأداة نفس المبدأ كأدواتها المعادلة في Send-GradioApi و Update-GradioApiResult.
ومع ذلك، فإنها تعمل فقط للأحداث التي تم إنشاؤها في جلسة معينة.
تعيد الحدث نفسه بحيث يمكن استخدامه مع أدوات أخرى تعتمد على الحدث المحدث!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
معرف الحدث، الذي تم إرجاعه بواسطة  Invoke-GradioSessionApi أو الكائن نفسه المعاد.

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

### -NoOutput
عدم إعادة النتيجة إلى المخرجات!

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

### -MaxHeartBeats
أقصى عدد من نبضات القلب المتتالية.

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

### -session
معرف الجلسة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -History
يضيف الأحداث إلى تاريخ الأحداث للكائن GradioApiEvent المحدد في -Id

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
_تمت الترجمة تلقائيًا باستخدام PowershAI والذكاء الاصطناعي._
<!--PowershaiAiDocBlockEnd-->
