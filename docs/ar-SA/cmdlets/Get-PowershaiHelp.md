---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
يستخدم موفر الملف الحالي للمساعدة في الحصول على مساعدة حول powershai!

## DESCRIPTION <!--!= @#Desc !-->
يستخدم هذا cmdlet أوامر PowershAI نفسها لمساعدة المستخدم على الحصول على مساعدة حوله.  
بشكل أساسي ، انطلاقًا من سؤال المستخدم ، فإنه يصوغ موجهًا مع بعض المعلومات الشائعة والمساعدة الأساسية.  
بعد ذلك ، يتم إرسال ذلك إلى LLM في دردشة.

نظرًا لحجم البيانات الضخم الذي تم إرساله ، يُنصح باستخدام هذا الأمر فقط مع المزودين ونماذج التي تقبل أكثر من 128 كيلوبايت والتي تكون رخيصة.  
في الوقت الحالي ، هذا الأمر تجريبي ويعمل فقط مع هذه النماذج:
	- Openai gpt-4*
	
داخليًا ، سيقوم بإنشاء Powershai Chat يسمى "_pwshai_help" ، حيث سيحتفظ بجميع السجلات!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
صف نص المساعدة!

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

### -command
إذا كنت تريد مساعدة بشأن أمر معين ، فحدد الأمر هنا 
لا داعي لأن يكون أمرًا من PowershaiChat فقط.

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

### -Recreate
إعادة إنشاء الدردشة!

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
