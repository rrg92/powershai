---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
إرسال رسالة في محادثة Powershai

## DESCRIPTION <!--!= @#Desc !-->
يتيح لك هذا cmdlet إرسال رسالة جديدة إلى نموذج اللغة الكبير (LLM) لمزود الخدمة الحالي. 
بشكل افتراضي، يتم الإرسال إلى المحادثة النشطة. يمكنك تجاوز المحادثة باستخدام المعلمة -Chat. 
إذا لم تكن هناك محادثة نشطة، فسيتم استخدام المحادثة الافتراضية.

تؤثر العديد من معلمات المحادثة على كيفية عمل هذا الأمر. راجع الأمر Get-PowershaiChatParameter لمزيد من المعلومات حول معلمات المحادثة.
بالإضافة إلى معلمات المحادثة، يمكن لمعلمات الأمر نفسها تجاوز السلوك. لمزيد من التفاصيل، راجع وثائق كل معلمة من معلمات هذا cmdlet باستخدام get-help. 

من أجل البساطة، والحفاظ على سطر الأوامر نظيفاً، مما يسمح للمستخدم بالتركيز أكثر على طلبات النموذج والبيانات، تم توفير بعض الأسماء المستعارة.
يمكن لهذه الأسماء المستعارة تنشيط بعض المعلمات.
وهي:
	ia|ai
		اختصار لـ "الذكاء الاصطناعي". هذا مجرد اسم مستعار ولا يغير أي معلمة. يساعد في اختصار سطر الأوامر بشكل كبير.
	
	iat|ait
		يُعَدّ هو نفسه Send-PowershaAIChat -Temporary
		
	io|ao
		يُعَدّ هو نفسه Send-PowershaAIChat -Object

يمكن للمستخدم إنشاء أسماء مستعارة خاصة به. على سبيل المثال:
	Set-Alias ki ia # حدد اسم مستعار للغة الألمانية!
	Set-Alias kit iat # حدد اسم مستعار "kit" لـ "iat"، مما يجعل السلوك هو نفسه "iat" (محادثة مؤقتة) عند استخدام "kit"!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] 
[-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
طلب النموذج المراد إرساله.

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
رسالة النظام المراد تضمينها.

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
السياق.
يفضل استخدام هذه المعلمة عن طريق الأنبوب.
سيؤدي ذلك إلى جعل الأمر يضع البيانات في علامات `<contexto></contexto>` ويدمجها مع طلب النموذج.

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
يجبر cmdlet على التنفيذ لكل كائن في الأنبوب.
بشكل افتراضي، فإنه يجمع جميع الكائنات في مصفوفة، ويحول المصفوفة إلى سلسلة ثم يرسلها في وقت واحد إلى LLM.

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
يُفعّل وضع JSON.
في هذا الوضع، تكون النتائج المُعادة دائمًا بتنسيق JSON.
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
وضع كائن!
في هذا الوضع، سيتم تفعيل وضع JSON تلقائيًا!
لن يكتب الأمر أي شيء على الشاشة، وسيرجع النتائج ككائن!
سيتم تمريرها مرة أخرى إلى الأنبوب!

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
يعرض بيانات السياق المُرسلة إلى LLM قبل الرد!
مفيد في تصحيح الأخطاء لمعرفة ما يتم حقنه في طلب النموذج من بيانات.

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
لا تُرسل المحادثات السابقة (سجل السياق)، ولكن قم بتضمين طلب النموذج والرد في سجل السياق.

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
تجاهل رد LLM، ولا تقم بتضمين طلب النموذج في سجل السياق.

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
لا تُرسل السجل ولا تقم بتضمين الرد وطلب النموذج. 
يُعَدّ هو نفسه تمرير -Forget و -Snub معًا.

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
يُغلق استدعاء الدالة لهذا التنفيذ فقط!

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
يُغيّر مُنسق السياق لهذا الأمر.
شاهد المزيد في Format-PowershaiContext.

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
معلمات مُنسق السياق المُغيّر.

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
يرجع الرسائل إلى الأنبوب، دون كتابة أي شيء على الشاشة!
يُفترض من هذا الخيار أن يكون المستخدم هو المسؤول عن توجيه الرسالة بشكل صحيح!
سيكون للكائن الذي يتم تمريره إلى الأنبوب الخصائص التالية:
	text 			- نص (أو مقطع) النص المُرجع من النموذج
	formatted		- النص المُنسق، بما في ذلك طلب النموذج، كما لو كان مكتوبًا مباشرة على الشاشة (بدون ألوان)
	event			- الحدث. يشير إلى الحدث الذي نشأ منه. تُعَدّ هي نفس الأحداث التي تم توثيقها في Invoke-AiChatTools
	interaction 	- كائن "interaction" تم إنشاؤه بواسطة Invoke-AiChatTools

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
يرجع مصفوفة من الأسطر.
إذا كان وضع "stream" مُفعلاً، فسيتم إرجاع سطر واحد في كل مرة!

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
