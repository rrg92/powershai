---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
يمسح ذاكرة التخزين المؤقت لأدوات الذكاء الاصطناعي.

## DESCRIPTION <!--!= @#Desc !-->
يحفظ PowershAI ذاكرة تخزين مؤقت مع الأدوات "المجمعة".
عندما يرسل PowershAI قائمة الأدوات إلى LLM ، يحتاج إلى إرسال وصف الأدوات ، وقائمة المعلمات ، والوصف ، وما إلى ذلك.  
قد يستغرق إنشاء هذه القائمة وقتًا كبيرًا ، حيث سيتم مسح قائمة الأدوات والوظائف ، وللكل ، سيتم مسح المساعدة (والمساعدة لكل معلمة).

عند إضافة وسيط مثل Add-AiTool ، لن يتم جمعه في تلك اللحظة.
سيترك الأمر ليتم ذلك عندما يحتاج إلى استدعاء LLM ، في وظيفة Send-PowershaiChat.  
إذا لم تكن ذاكرة التخزين المؤقت موجودة ، فسيتم تجميعها في تلك اللحظة ، مما قد يؤدي إلى جعل إرسال هذه الرسالة الأولى إلى LLM ، يستغرق بضعة مللي ثوان أو ثوانٍ أكثر من المعتاد.  

يكون هذا التأثير متناسبًا مع عدد الوظائف والمعلمات المرسلة.  

كلما استخدمت Add-AiTool أو Add-AiScriptTool ، فإنه يبطل ذاكرة التخزين المؤقت ، مما يجعله عند التنفيذ التالي ، يتم إنشاؤه.  
يسمح ذلك بإضافة العديد من الوظائف دفعة واحدة ، دون أن يتم تجميعها في كل مرة تضيفها فيها.

ومع ذلك ، إذا قمت بتغيير وظيفتك ، فلن يتم إعادة حساب ذاكرة التخزين المؤقت.  
لذلك ، يجب أن تستخدم هذا الوسيط لكي يحتوي التنفيذ التالي على البيانات المُحدّثة لأدواتك بعد إجراء تغييرات على الكود أو البرنامج النصي.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```



<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
