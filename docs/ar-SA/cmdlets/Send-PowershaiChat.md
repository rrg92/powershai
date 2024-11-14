---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
يرسل رسالة في دردشة PowerShai

## DESCRIPTION <!--!= @#Desc !-->
هذا الأمر يسمح لك بإرسال رسالة جديدة إلى LLM لمزود الخدمة الحالي.  
بشكل افتراضي، يتم الإرسال في الدردشة النشطة. يمكنك تجاوز الدردشة باستخدام المعامل -Chat. إذا لم تكن هناك دردشة نشطة، فسيستخدم الافتراضي.  

تؤثر معلمات الدردشة المختلفة على كيفية عمل هذا الأمر. راجع الأمر Get-PowershaiChatParameter لمزيد من المعلومات حول معلمات الدردشة.  
بالإضافة إلى معلمات الدردشة، يمكن أن تتجاوز معلمات الأمر نفسها السلوك. لمزيد من التفاصيل، يرجى الرجوع إلى الوثائق الخاصة بكل معلمة من هذا الأمر باستخدام get-help.  

للتبسيط، وللحفاظ على سطر الأوامر نظيفًا، مما يسمح للمستخدم بالتركيز أكثر على الموجه والبيانات، تتوفر بعض الأسماء المستعارة.  
يمكن أن تفعيل هذه الأسماء المستعارة بعض المعلمات.
وهي:
	ia|ai
		اختصار لـ "الذكاء الاصطناعي" باللغة البرتغالية. هذا اسم مستعار بسيط ولا يغير أي معلمة. إنه يساعد بشكل كبير في تقليل سطر الأوامر.
	
	iat|ait
	نفس الشيء مثل Send-PowershaAIChat -Temporary
		
	io|ao
	نفس الشيء مثل Send-PowershaAIChat -Object
		
	iam|aim 
	نفس الشيء مثل Send-PowershaiChat -Screenshot 

يمكن للمستخدم إنشاء أسماء مستعارة خاصة به. على سبيل المثال:
	Set-Alias ki ia # تعريف الاسم المستعار للألمانية!
	Set-Alias kit iat # تعريف الاسم المستعار kit لـ iat، مما يجعل السلوك متساويًا مع iat (دردشة مؤقتة) عند استخدام kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] 
[-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] 
[-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
الموجه الذي سيتم إرساله إلى النموذج

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

### -SystemMessages
رسالة النظام المراد تضمينها

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
السياق 
يجب استخدام هذا المعامل بشكل تفضيلي من خلال أنبوب البيانات.
سوف يجعل الأمر يضع البيانات داخل علامات <contexto></contexto> ويحقنها معًا في الموجه.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
يجبر الأمر على التنفيذ لكل كائن في أنبوب البيانات
بشكل افتراضي، يقوم بتجميع جميع الكائنات في مصفوفة، وتحويل المصفوفة إلى سلسلة واحدة وإرسالها دفعة واحدة إلى LLM.

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

### -Json
يفعل وضع JSON 
في هذا الوضع، ستكون النتائج المرتجعة دائمًا بتنسيق JSON.
يجب أن يدعم النموذج الحالي ذلك!

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

### -Object
وضع الكائن!
في هذا الوضع، سيتم تفعيل وضع JSON تلقائيًا!
لن يكتب الأمر أي شيء على الشاشة، وسيعيد النتائج ككائن!
الذي سيتم إعادته إلى أنبوب البيانات!

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

### -PrintContext
يظهر بيانات السياق المرسلة إلى LLM قبل الاستجابة!
مفيد لتصحيح الأخطاء حول ما يتم حقنه من بيانات في الموجه.

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

### -Forget
لا ترسل المحادثات السابقة (تاريخ السياق)، ولكن تشمل الموجه والاستجابة في السياق التاريخي.

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

### -Snub
تجاهل استجابة LLM، ولا تشمل الموجه في السياق التاريخي

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

### -Temporary
لا ترسل التاريخ ولا تشمل الاستجابة والموجه.  
هذا هو نفس الشيء مثل تمرير -Forget و -Snub معًا.

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

### -DisableTools
يوقف استدعاء الوظائف لهذه التنفيذ فقط!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
تغيير تنسيق السياق إلى هذا
راجع المزيد عن ذلك في Format-PowershaiContext

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

### -FormatterParams
معلمات تنسيق السياق المعدلة.

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

### -PassThru
يعيد الرسائل مرة أخرى إلى أنبوب البيانات، دون الكتابة مباشرة على الشاشة!
تتوقع هذه الخيار أن يكون المستخدم مسؤولاً عن توجيه الرسالة بشكل صحيح!
سوف يحتوي الكائن الممرر إلى أنبوب البيانات على الخصائص التالية:
	text 			- النص (أو جزء) من النص المرتجع من النموذج 
	formatted		- النص المنسق، بما في ذلك الموجه، كما لو كان مكتوبًا مباشرة على الشاشة (بدون الألوان)
	event			- الحدث. يشير إلى الحدث الذي نشأ عنه. هي نفس الأحداث الموثقة في Invoke-AiChatTools
	interaction 	- كائن التفاعل الذي تم إنشاؤه بواسطة Invoke-AiChatTools

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

### -Lines
يعيد مصفوفة من الأسطر 
إذا كان وضع التدفق مفعلًا، سيعيد سطرًا واحدًا في كل مرة!

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

### -ChatParamsOverride
تجاوز معلمات الدردشة!
حدد كل خيار في جداول هاش!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
يحدد مباشرة قيمة معلمة الدردشة RawParams!
إذا تم تحديده أيضًا في ChatParamOverride، يتم دمجها، مع إعطاء الأولوية للمعلمات المحددة هنا.
RawParams هي معلمة دردشة تحدد المعلمات التي سيتم إرسالها مباشرة إلى واجهة برمجة تطبيقات النموذج!
ستتجاوز هذه المعلمات القيم الافتراضية المحسوبة بواسطة PowerShai!
مع ذلك، يمتلك المستخدم تحكمًا كاملاً على المعلمات، ولكن يحتاج إلى معرفة كل مزود!
أيضًا، كل مزود مسؤول عن توفير هذا التنفيذ واستخدام هذه المعلمات في واجهته البرمجية.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
يلتقط لقطة شاشة للشاشة التي وراء نافذة PowerShell ويرسلها مع الموجه. 
لاحظ أن الوضع الحالي يجب أن يدعم الصور (نماذج اللغة البصرية).

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
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
