---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
يرسل الرسائل إلى LLM ويعيد الاستجابة

## DESCRIPTION <!--!= @#Desc !-->
هذه هي الطريقة الأساسية للدردشة التي يروج لها PowershAI.  
باستخدام هذه الوظيفة، يمكنك إرسال رسالة إلى LLM من المزود الحالي.  

هذه الوظيفة هي من مستوى أدنى، بطريقة موحدة، للوصول إلى LLM الذي يوفره powershai.  
إنها لا تدير التاريخ أو السياق. إنها مفيدة لاستدعاء مطالبات بسيطة، التي لا تتطلب تفاعلات متعددة كما في الدردشة. 
على الرغم من دعمها لاستدعاء الوظائف، إلا أنها لا تنفذ أي كود، وتعيد فقط استجابة النموذج.

** معلومات لمزودي الخدمة
يجب على المزود تنفيذ وظيفة الدردشة ليكون هذا الوظيفة متاحة. 
يجب أن تعيد وظيفة الدردشة كائنًا يحتوي على الاستجابة بنفس مواصفات OpenAI، وظيفة إكمال الدردشة.
تعمل الروابط التالية كأساس:
https://platform.openai.com/docs/guides/chat-completions
https://platform.openai.com/docs/api-reference/chat/object (العودة بدون تدفق)
يجب على المزود تنفيذ المعلمات لهذه الوظيفة. 
راجع الوثائق لكل معلمة للحصول على التفاصيل وكيفية ربطها بمزود؛

عند عدم دعم النموذج لأحد المعلمات المحددة (أي، عدم وجود وظيفة مكافئة، أو التي يمكن تنفيذها بطريقة مكافئة) يجب إرجاع خطأ.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] 
[[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
المطالبة التي سيتم إرسالها. يجب أن تكون بالشكل الموصوف بواسطة وظيفة ConvertTo-OpenaiMessage

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

### -temperature
درجة حرارة النموذج

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
اسم النموذج. إذا لم يتم تحديده، يستخدم الافتراضي من المزود.

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
الحد الأقصى من الرموز التي سيتم إرجاعها

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
تنسيق الاستجابة 
يجب أن تتبع التنسيقات المقبولة والسلوك نفس ما هو موجود في OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
اختصارات:
"json"|"json_object"، تعادل {"type": "json_object"}
يجب أن يحدد الكائن مخططًا كما لو تم تمريره مباشرة إلى واجهة برمجة التطبيقات الخاصة بـ OpenAI، في حقل response_format.json_schema

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

### -Functions
قائمة بالأدوات التي يجب استدعاؤها!
يمكنك استخدام الأوامر مثل Get-OpenaiTool*، لتحويل وظائف PowerShell بسهولة إلى التنسيق المتوقع!
إذا استدعى النموذج الوظيفة، يجب أن تتبع الاستجابة، سواء في التدفق أو العادية، أيضًا نموذج استدعاء الأدوات من OpenAI.
يجب أن تتبع هذه المعلمة نفس مخطط استدعاء الوظائف من OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
حدد المعلمات المباشرة لواجهة برمجة التطبيقات الخاصة بالمزود.
سيؤدي ذلك إلى تجاوز القيم التي تم حسابها وتوليدها بناءً على المعلمات الأخرى.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback
يتيح نموذج التدفق 
يجب عليك تحديد ScriptBlock سيتم استدعاؤه لكل نص تم إنشاؤه بواسطة LLM.
يجب أن يتلقى البرنامج النصي معلمة تمثل كل جزء، بنفس تنسيق التدفق المعاد
هذه المعلمة هي كائن يحتوي على خاصية choices، التي هي بنفس المخطط المعاد بواسطة تدفق OpenAI:
https://platform.openai.com/docs/api-reference/chat/streaming

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

### -IncludeRawResp
تضمين استجابة واجهة برمجة التطبيقات في حقل يسمى IncludeRawResp

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
_تمت الترجمة تلقائيًا باستخدام PowershAI والذكاء الاصطناعي._
<!--PowershaiAiDocBlockEnd-->
