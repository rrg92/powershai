---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
ينشئ مكالمة جديدة لنقطة نهاية في الجلسة الحالية.

## DESCRIPTION <!--!= @#Desc !-->
يجري مكالمة باستخدام واجهة برمجة التطبيقات Gradio، في نقطة نهاية محددة ويمرر المعلمات المطلوبة.  
ستولد هذه المكالمة حدث GradioApi (انظر Send-GradioApi)، والذي سيتم حفظه داخليًا في إعدادات الجلسة.  
يحتوي هذا الكائن على كل ما هو ضروري للحصول على نتيجة واجهة برمجة التطبيقات.  

سيرجع cmdlet كائنًا من نوع SessionApiEvent يحتوي على الخصائص التالية:
	id - معرف داخلي للحدث المولد.
	event - الحدث الداخلي المولد. يمكن استخدامه مباشرة مع cmdlets التي تعالج الأحداث.
	
تمتلك الجلسات حدًا من المكالمات المحددة.
الهدف هو منع إنشاء مكالمات غير محدودة بطريقة تفقد السيطرة.

هناك خياران للجلسة يؤثران على المكالمة (يمكن تغييرهما باستخدام Set-GradioSession):
	- MaxCalls 
	يتحكم في الحد الأقصى من المكالمات التي يمكن إنشاؤها
	
	- MaxCallsPolicy 
	يتحكم في ما يجب فعله عند الوصول إلى الحد الأقصى.
	قيم ممكنة:
		- Error 	= يؤدي إلى خطأ!
		- Remove 	= يزيل الأقدم 
		- Warning 	= يعرض تحذيرًا، ولكن يسمح بتجاوز الحد.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
اسم نقطة النهاية (بدون شريط البداية)

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
إذا كانت مصفوفة، تمرر مباشرة إلى واجهة برمجة التطبيقات Gradio 
إذا كانت جدول تجزئة، يتم بناء المصفوفة بناءً على موضع المعلمات التي تم إرجاعها بواسطة /info

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
إذا تم تحديده، ينشئ مع معرف حدث موجود مسبقًا (قد يكون تم توليده خارج الوحدة).

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
الجلسة

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
فرض استخدام رمز جديد. إذا كان "عامًا"، فلا يستخدم أي رمز!

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
_تمت الترجمة تلقائيًا باستخدام PowershAI والذكاء الاصطناعي._
<!--PowershaiAiDocBlockEnd-->
