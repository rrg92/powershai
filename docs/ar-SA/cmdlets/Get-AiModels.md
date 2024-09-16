---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
يسرد النماذج المتاحة في موفر الخدمة الحالي

## DESCRIPTION <!--!= @#Desc !-->
يُدرج هذا الأمر جميع نماذج LLM التي يمكن استخدامها مع موفر الخدمة الحالي لاستخدامها في PowershaiChat.
تعتمد هذه الدالة على تنفيذ موفر الخدمة للدالة GetModels.

يختلف الكائن المُرجع وفقًا لموفر الخدمة ، ولكن يجب على جميع موفري الخدمة إرجاع مصفوفة من الكائنات ، ويجب أن يحتوي كل منها على الأقل على الخاصية id ، والتي يجب أن تكون سلسلة تُستخدم لتحديد النموذج في أوامر أخرى تعتمد على نموذج.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
