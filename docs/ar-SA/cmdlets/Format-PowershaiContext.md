---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
تنسيق كائن ليتم حقنه في سياق رسالة تم إرسالها في Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
نظرًا لأن LLM تعالج فقط السلاسل، فإن الكائنات المارة في السياق تحتاج إلى تحويلها إلى تنسيق سلسلة، قبل حقنها في المطالبة.
وبما أن هناك العديد من التمثيلات لكائن في سلسلة، فإن Powershai يسمح للمستخدم بالتحكم الكامل في ذلك.  

كلما احتاج كائن إلى حقنه في المطالبة، عند استدعائه باستخدام Send-PowershaAIChat، عبر الأنبوب أو معلمة Contexto، سيتم استدعاء هذا cmdlet.
يُعد هذا cmdlet مسؤولًا عن تحويل هذا الكائن إلى سلسلة، بغض النظر عن الكائن، سواء كان مصفوفة، أو جدول هاش، أو مخصصًا، وما إلى ذلك.  

يقوم بذلك من خلال استدعاء وظيفة المنسق المحددة باستخدام Set-PowershaiChatContextFormatter
بشكل عام، لا تحتاج إلى استدعاء هذه الوظائف مباشرة، ولكن قد ترغب في الاستدعاء عندما تريد إجراء بعض الاختبارات!

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
أي كائن ليتم حقنه

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

### -params
معلمة يتم تمريرها إلى وظيفة المنسق

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

### -func
تجاهل وظيفة يتم استدعاؤها. إذا لم يتم تحديدها، فاستخدم الافتراضي للدردشة.

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

### -ChatId
الدردشة التي تعمل عليها

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
