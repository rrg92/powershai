---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
يخلق كائنًا جديدًا يمثل معلمات PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
يخلق كائنًا افتراضيًا يحتوي على جميع المعلمات الممكنة التي يمكن استخدامها في الدردشة!
يمكن للمستخدم استخدام get-help New-PowershaiParameters للحصول على وثائق المعلمات.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] 
<Boolean>] [[-ShowTokenStats] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] 
[[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] 
[[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
عند التفعيل، يستخدم وضع البث، أي أن الرسائل تظهر أثناء إنتاج النموذج لها

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
يُمكّن وضع JSON. في هذا الوضع، يُجبر النموذج على إرجاع استجابة بتنسيق JSON.  
عند التفعيل، لا تُعرض الرسائل المولدة عبر البث أثناء إنتاجها، ويُعاد فقط النتيجة النهائية.

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
اسم النموذج المراد استخدامه  
إذا كان فارغًا، يتم استخدام النموذج المحدد بواسطة Set-AiDefaultModel

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
الحد الأقصى لعدد الرموز التي سيتم إرجاعها بواسطة النموذج

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 2048
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowFullSend
يطبع النص الكامل الذي يتم إرساله إلى LLM

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowTokenStats
في نهاية كل رسالة، يعرض إحصائيات الاستهلاك، بالرموز، التي تم إرجاعها بواسطة API

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
الحد الأقصى لعدد التفاعلات التي يمكن إجراؤها دفعة واحدة  
كلما تم إرسال رسالة، ينفذ النموذج تكرارًا واحدًا (يرسل الرسالة ويتلقى ردًا).  
إذا طلب النموذج استدعاء دالة، فسيتم إرسال الاستجابة الناتجة مرة أخرى إلى النموذج. هذا يُحتسب كتفاعل آخر.  
تتحكم هذه المعلمة في الحد الأقصى لعدد التفاعلات التي يمكن أن تحدث في كل استدعاء.
يساعد ذلك في منع الحلقات اللانهائية غير المتوقعة.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 50
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
الحد الأقصى من الأخطاء المتتالية الناتجة عن استدعاء الأدوات.  
عند استخدام استدعاء الأدوات، تحدد هذه المعلمة عدد الأدوات المتتالية التي نتجت عن أخطاء يمكن استدعاؤها.  
يعتبر الخطأ هو الاستثناء الذي تم إطلاقه بواسطة السكربت أو الأمر المكون.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 5
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxContextSize
الحد الأقصى لحجم السياق، بالرموز  
في المستقبل، سيكون بالرموز  
يتحكم في عدد الرسائل في السياق الحالي للدردشة. عندما يتجاوز هذا الرقم، يقوم Powershai تلقائيًا بتنظيف الرسائل الأقدم.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: 8192
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterFunc
الدالة المستخدمة لتنسيق الكائنات المرسلة عبر الأنابيب

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: ConvertTo-PowershaiContextOutString
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterParams
المعلمات التي سيتم تمريرها إلى ContextFormatterFunc

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowArgs
إذا كانت صحيحة، تعرض المعلمات الخاصة بالدوال عند تفعيل استدعاء الأدوات لتنفيذ وظيفة ما

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolsResults
يعرض نتائج الأدوات عند تنفيذها بواسطة PowershAI استجابة لاستدعاء الأدوات من النموذج

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 13
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -SystemMessageFixed
رسالة النظام التي يتم ضمان إرسالها دائمًا، بغض النظر عن السجل والتنظيف للدردشة!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 14
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
المعلمات التي سيتم تمريرها مباشرة إلى API التي تستدعي النموذج.  
يجب على المزود تنفيذ الدعم لذلك.  
للاستخدام، يجب أن تعرف تفاصيل تنفيذ المزود وكيفية عمل API الخاصة به!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormat
يتحكم في القالب المستخدم عند حقن بيانات السياق!
تكون هذه المعلمة عبارة عن كتلة سكربت يجب أن تعيد سلسلة تحتوي على السياق الذي سيتم حقنه في النص!
المعلمات الخاصة بكتلة السكربت هي:
	FormattedObject 	- الكائن الذي يمثل الدردشة النشطة، والذي تم تنسيقه بالفعل باستخدام التنسيق المحدد
	CmdParams 			- المعلمات المرسلة إلى Send-PowershaAIChat. إنه نفس الكائن المرتجع بواسطة GetMyParams
	Chat 				- الدردشة التي يتم إرسال البيانات إليها.
إذا كانت فارغة، سيتم إنشاء افتراضية. تحقق من cmdlet Send-PowershaiChat للحصول على التفاصيل

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 16
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_تمت الترجمة تلقائيًا باستخدام PowershAI والذكاء الاصطناعي._
<!--PowershaiAiDocBlockEnd-->
