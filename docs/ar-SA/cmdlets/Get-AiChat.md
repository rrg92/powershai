---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
يرسل رسائل إلى LLM ويعيد الرد

## DESCRIPTION <!--!= @#Desc !-->
هذه هي الطريقة الأساسية للدردشة التي يقدمها PowershAI.  
باستخدام هذه الوظيفة ، يمكنك إرسال رسالة إلى LLM من موفر الخدمة الحالي.  

هذه الوظيفة هي الأقل مستوى ، بطريقة موحدة ، للوصول إلى LLM الذي يوفره powershai.  
لا تدير السجل أو السياق. إنها مفيدة لاستدعاء مطالبات بسيطة ، لا تتطلب العديد من التفاعلات كما هو الحال في الدردشة. 
على الرغم من دعمها لـ Functon Calling ، إلا أنها لا تنفذ أي رمز ، بل تعيد فقط رد النموذج.



** معلومات لمقدمي الخدمة
	يجب على مقدم الخدمة تنفيذ وظيفة Chat لكي تكون هذه الوظيفة متاحة. 
	يجب على وظيفة chat إعادة كائن مع الرد مع نفس مواصفات OpenAI ، وظيفة Chat Completion.
	تُستخدم الروابط التالية كأساس:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (العودة بدون بث)
	يجب على مقدم الخدمة تنفيذ معلمات هذه الوظيفة. 
	راجع وثائق كل معلمة للحصول على التفاصيل وكيفية تعيينها لمقدم خدمة ؛
	
	عندما لا يدعم النموذج أحد المعلمات المحددة (أي ، لم تكن هناك وظيفة مكافئة ، أو يمكن تنفيذها بطريقة مكافئة) ، يجب إرجاع خطأ.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
المطلب الذي سيتم إرساله. يجب أن يكون في التنسيق الموصوف بواسطة وظيفة ConvertTo-OpenaiMessage

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
اسم النموذج. إذا لم يتم تحديده ، فسيستخدم النموذج الافتراضي لمقدم الخدمة.

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
أقصى عدد من الرموز التي سيتم إرجاعها

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
تنسيق الرد 
يجب أن تتبع التنسيقات المقبولة والسلوك نفس تنسيق OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
اختصارات:
	"json" ، تعادل {"type": "json_object"}

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
قائمة الأدوات التي يجب استدعائها!
يمكنك استخدام الأوامر مثل Get-OpenaiTool * ، لتحويل وظائف powershell بسهولة إلى التنسيق المتوقع!
إذا استدعى النموذج الوظيفة ، يجب أن يتبع الرد ، سواء في البث أو بشكل عادي ، أيضًا نموذج استدعاء الأداة من OpenAI.
يجب أن تتبع هذه المعلمة نفس مخطط استدعاء الوظيفة من OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
حدد معلمات API مباشرة لمقدم الخدمة.
سوف يفرض هذا القيم التي تم حسابها وتوليدها بناءً على المعلمات الأخرى.

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
تفعيل نموذج البث 
يجب أن تحدد ScriptBlock سيتم استدعاءه لكل نص يتم إنشاؤه بواسطة LLM.
يجب أن يتلقى البرنامج النصي معلمة تمثل كل جزء ، بنفس تنسيق البث الذي تم إرجاعه
	هذه المعلمة هي كائن سيحتوي على خاصية choices ، وهي في نفس المخطط الذي تم إرجاعه بواسطة بث OpenAI:
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
تضمين استجابة API في حقل يسمى IncludeRawResp

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
