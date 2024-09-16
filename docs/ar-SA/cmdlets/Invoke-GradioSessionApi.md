---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
يخلق مكالمة جديدة لنقطة نهاية في الجلسة الحالية.

## DESCRIPTION <!--!= @#Desc !-->
يقوم بإجراء مكالمة باستخدام واجهة برمجة تطبيقات Gradio ، على نقطة نهاية محددة وإرسال المعلمات المطلوبة.  
ستؤدي هذه المكالمة إلى إنشاء GradioApiEvent (انظر Send-GradioApi) ، والذي سيتم حفظه داخليًا في إعدادات الجلسة.  
يحتوي هذا الكائن على كل ما هو ضروري للحصول على نتيجة واجهة برمجة التطبيقات.  

ستعيد الوحدة النمطية كائنًا من نوع SessionApiEvent يحتوي على الخصائص التالية:
	id - معرف داخلي للحدث الذي تم إنشاؤه.
	event - الحدث الداخلي الذي تم إنشاؤه. يمكن استخدامه مباشرةً مع وحدات النمطية التي تتعامل مع الأحداث.
	
تحتوي الجلسات على حد من المكالمات المحددة.
الهدف هو منع إنشاء مكالمات غير محددة بطريقة تفقد السيطرة.

هناك خياران لجلسة تؤثر على المكالمة (يمكن تغييرهما باستخدام Set-GradioSession):
	- MaxCalls 
	يتحكم في الحد الأقصى للمكالمات التي يمكن إنشاؤها
	
	- MaxCallsPolicy 
	يتحكم في ما يجب فعله عند الوصول إلى الحد الأقصى.
	القيم الممكنة:
		- Error 	= ينتج عنه خطأ!
		- Remove 	= إزالة الأقدم
		- Warning 	= يعرض تحذيرًا ، لكنه يسمح بخرق الحد.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
اسم نقطة النهاية (بدون شريط مائل مبدئي)

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

### -Params
قائمة المعلمات
إذا كانت مصفوفة ، فسيتم تمريرها مباشرةً إلى واجهة برمجة تطبيقات Gradio
إذا كانت جدول هاش ، فسيتم إنشاء المصفوفة بناءً على موضع المعلمات التي تم إرجاعها بواسطة /info

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

### -EventId
إذا تم تحديده ، فسيُنشئ بمعرف حدث موجود بالفعل (قد يكون تم إنشاؤه خارج الوحدة النمطية).

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

### -session
جلسة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
فرض استخدام رمز جديد. إذا كانت "عامة" ، فلن يتم استخدام أي رمز!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
