---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
يُحدّث نتيجة واجهة برمجة التطبيقات لجلسة Gradio التي تم إنشاؤها كـ Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
يتبع هذا cmdlet نفس المبدأ مثل نظرائه في Send-GradioApi و Update-GradioApiResult.
ومع ذلك ، فهو يعمل فقط للأحداث التي تم إنشاؤها في جلسة محددة.
يُرجع الحدث نفسه حتى يمكن استخدامه مع cmdlets أخرى تتطلب الحدث المُحدّث!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
معرف الحدث ، مُرجع من Invoke-GradioSessionApi أو الكائن المُرجع نفسه.

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
لا تُرجع النتيجة إلى الإخراج!

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
أقصى عدد دقات القلب المتتالية.

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
يضيف الأحداث إلى سجل أحداث كائن GradioApiEvent المحدد في -Id

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
