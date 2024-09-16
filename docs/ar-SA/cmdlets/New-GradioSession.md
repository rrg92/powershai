---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
إنشاء جلسة Gradio جديدة.

## DESCRIPTION <!--!= @#Desc !-->
تُمثل جلسات الاتصال بتطبيق Gradio.
تخيل أن الجلسة عبارة عن علامة تبويب في متصفح مفتوح متصل بتطبيق Gradio معين.
يتم تسجيل جميع الملفات المرسلة والاتصالات وتسجيل الدخول في هذه الجلسة.

يرجع هذا cmdlet كائنًا نسميه "GradioSesison".
يمكن استخدام هذا الكائن في cmdlets أخرى تعتمد على الجلسة (ويمكن تعيين جلسة نشطة يستخدمها جميع cmdlets افتراضيًا إذا لم يتم تحديدها).

تحتوي كل جلسة على اسم يحددها بشكل فريد. إذا لم يتم تحديده من قبل المستخدم ، فسيتم إنشاؤه تلقائيًا بناءً على عنوان URL للتطبيق.
لا يمكن وجود جلستين بنفس الاسم.

عند إنشاء جلسة ، يحفظ هذا cmdlet هذه الجلسة في مستودع داخلي للجلسات.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
عنوان URL للتطبيق

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

### -Name
اسم فريد يحدد هذه الجلسة!

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

### -DownloadPath
المجلد الذي سيتم فيه تنزيل الملفات

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

### -Force
إعادة إنشاء بالقوة

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
