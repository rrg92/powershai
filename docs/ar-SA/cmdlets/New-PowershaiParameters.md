---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
ينشئ كائنًا جديدًا يمثل معلمات PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
ينشئ كائنًا قياسيًا يحتوي على جميع المعلمات الممكنة التي يمكن استخدامها في الدردشة!
يمكن للمستخدم استخدام الأمر get-help New-PowershaiParameters للحصول على وثائق المعلمات.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] 
<Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
عند تعيين هذه القيمة إلى true، يتم استخدام وضع التدفق، بمعنى أن الرسائل تُعرض أثناء قيام النموذج بإنتاجها

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
يُمكن هذا الخيار وضع JSON. في هذا الوضع، يُجبر النموذج على إرجاع استجابة تحتوي على JSON.  
عند تنشيطه، لن تُعرض الرسائل المُنشأة عبر التدفق أثناء إنشائها، وسيتم إرجاع النتيجة النهائية فقط.

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
اسم النموذج الذي سيتم استخدامه  
إذا كان فارغًا، يتم استخدام النموذج المُحدد باستخدام Set-AiDefaultModel

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
الحد الأقصى لعدد الرموز التي سيعود بها النموذج

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
يطبع الموجه الكامل الذي يتم إرساله إلى LLM

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
في نهاية كل رسالة، تُعرض إحصائيات استهلاك الرموز التي تُرجعها الواجهة البرمجية

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
الحد الأقصى لعدد التفاعلات التي سيتم إجراؤها في وقت واحد 
في كل مرة يتم فيها إرسال رسالة، يُنفذ النموذج 1 تكرار (يرسل الرسالة ويتلقى ردًا).  
إذا طلب النموذج إجراء مكالمة دالة، سيتم إعادة إرسال الاستجابة المُنشأة إلى النموذج. يُعد ذلك تكرارًا آخر.  
تُحدد هذه المعلمة الحد الأقصى لعدد التفاعلات التي يمكن أن تحدث في كل مكالمة.
يساعد ذلك في منع الدورات اللانهائية غير المتوقعة.

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
الحد الأقصى لعدد الأخطاء المتتالية التي تم إنشاؤها بواسطة Tool Calling.  
عند استخدام Tool Calling، تحد هذه المعلمة عدد الأدوات المتتالية التي تُركّب نتيجة أخطاء.  
يُعتبر الخطأ هو الاستثناء المُثار بواسطة البرنامج النصي أو الأمر المُنشأ.

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
أقصى حجم للسياق، مُقاسًا بالرموز 
في المستقبل، سيتم حسابه بالرموز 
تُحدد هذه المعلمة عدد الرسائل في سياق الدردشة الحالي. عند تجاوز هذا الرقم، سيقوم Powershai بمسح الرسائل القديمة تلقائيًا.

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
الوظيفة المستخدمة لتنسيق الكائنات المُمررة عبر خط الأنابيب

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
الحجج التي سيتم تمريرها إلى ContextFormatterFunc

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
إذا تم تعيين هذه القيمة إلى true، يتم عرض حجج الوظائف عندما يتم تنشيط Tool Calling لتنفيذ أي وظيفة

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
يعرض نتائج الأدوات عند تنفيذها بواسطة PowershAI استجابةً لـ Tool Calling من النموذج

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
رسالة النظام التي تُضمن إرسالها دائمًا، بغض النظر عن سجل الدردشة ونظافته!

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
معلمات سيتم تمريرها مباشرةً إلى الواجهة البرمجية التي تستدعي النموذج.  
يجب على مقدم الخدمة تنفيذ الدعم لهذا.  
للاستخدام، يجب أن تكون على دراية بتفاصيل تنفيذ مقدم الخدمة وكيفية عمل واجهة برمجية مقدم الخدمة!

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
تُحدد القالب المستخدم عند حقن بيانات السياق!
تُمثل هذه المعلمة كتلة برنامج نصي يجب أن تُرجع سلسلة تحتوي على السياق الذي سيتم حقنه في الموجه!
معلمات كتلة البرنامج النصي هي:
	FormattedObject 	- الكائن الذي يمثل الدردشة النشطة، مُنشأ بالفعل باستخدام المنسق المُنشأ
	CmdParams 			- المعلمات المُمررة إلى Send-PowershaAIChat. تُمثل نفس الكائن الذي تُرجعه GetMyParams
	Chat 				- الدردشة التي تُرسل إليها البيانات.
إذا كان فارغًا، سيتم إنشاء قيمة افتراضية. راجع الأمر Send-PowershaiChat للحصول على التفاصيل

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
