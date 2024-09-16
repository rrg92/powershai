---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
يرسل رسالة إلى LLM، مع دعم Tool Calling، وينفذ الأدوات التي يطلبها النموذج كأوامر powershell.

## DESCRIPTION <!--!= @#Desc !-->
هذه وظيفة مساعدة للمساعدة في جعل معالجة الأدوات أسهل مع powershell.
تتعامل مع معالجة "الأدوات" ، وتنفذها عندما يطلب النموذج!

يجب عليك تمرير الأدوات في تنسيق محدد ، موثق في موضوع about_Powershai_Chats
يُرسم هذا التنسيق بشكل صحيح بين الوظائف وأوامر powershell لتصميم قابل للقبول من OpenAI (OpenAPI Schema).  

يقوم هذا الأمر بتغليف كل المنطق الذي يحدد متى يريد النموذج استدعاء الوظيفة ، وتنفيذ هذه الوظائف ، وإرسال هذه الاستجابة مرة أخرى إلى النموذج.  
يبقى في هذه الحلقة حتى يتوقف النموذج عن اتخاذ قرارات أكثر لاستدعاء الوظائف ، أو حتى ينتهي حد التفاعلات (نعم ، نسميها تفاعلات هنا ، وليس تكرارات) مع النموذج.

مفهوم التفاعل بسيط: في كل مرة يرسل فيها الأمر مطالبة إلى النموذج ، يُحسب ذلك كتكامل.  
فيما يلي تدفق نموذجي يمكن أن يحدث:
	

يمكنك الحصول على مزيد من التفاصيل حول كيفية العمل من خلال استشارة موضوع about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] 
[[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt

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

### -Tools
مصفوفة الأدوات ، كما هو موضح في مستند هذا الأمر
استخدم نتيجة Get-OpenaiTool* لإنشاء القيم الممكنة.  
يمكنك تمرير مصفوفة من الكائنات من نوع OpenaiTool.
إذا تم تعريف نفس الوظائف في أكثر من أداة واحدة ، فسيتم استخدام أول أداة تم العثور عليها بالترتيب المحدد!

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

### -PrevContext

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

### -MaxTokens
مخرجات قصوى!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 500
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
في المجموع ، السماح بحد أقصى 5 تكرارات!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
الحد الأقصى لعدد الأخطاء المتتالية التي يمكن أن تولدها وظيفتك قبل إيقافها.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 2
Accept pipeline input: false
Accept wildcard characters: false
```

### -temperature

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -on
معالج الأحداث
كل مفتاح هو حدث سيتم إطلاقه في مرحلة ما بواسطة هذا الأمر!
الأحداث:
answer: يُطلق بعد الحصول على رد من النموذج (أو عند توفر رد باستخدام الدفق).
func: يُطلق قبل بدء تنفيذ أداة يطلبها النموذج.
	exec: يُطلق بعد قيام النموذج بتنفيذ الوظيفة.
	error: يُطلق عند حدوث خطأ في الوظيفة التي تم تنفيذها
	stream: يُطلق عند إرسال رد (بواسطة الدفق) و -DifferentStreamEvent
	beforeAnswer: يُطلق بعد جميع الردود. مفيد عند استخدامه في التدفق!
	afterAnswer: يُطلق قبل بدء الردود. مفيد عند استخدامه في التدفق!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
يرسل response_format = "json" ، مما يجبر النموذج على إرجاع json.

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

### -RawParams
إضافة معلمات مخصصة مباشرة في المكالمة (سوف تفرض على المعلمات المحددة تلقائيًا).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Stream

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
