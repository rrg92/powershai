---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
يحصل على مزود نشط

## DESCRIPTION <!--!= @#Desc !-->
يرجع كائن يمثل مزود نشط.  
تم تنفيذ مقدمي الخدمة ككائنات وتخزينها في ذاكرة الجلسة، في متغير عالمي.  
ترجع هذه الوظيفة مزود الخدمة النشط، الذي تم تعريفه باستخدام الأمر Set-AiProvider.

الكائن الذي تم إرجاعه هو جدول هاش يحتوي على جميع حقول مزود الخدمة.  
يستخدم هذا الأمر بشكل شائع من قبل مقدمي الخدمة للحصول على اسم مزود الخدمة النشط.  

معامل -ContextProvider يرجع مزود الخدمة الحالي الذي يعمل فيه البرنامج النصي.  
إذا كان يعمل في برنامج نصي لمزود خدمة، فسيقوم بإرجاع ذلك المزود، بدلاً من مزود الخدمة المعين باستخدام Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
إذا تم تمكينه، فسيستخدم مزود سياق، أي، إذا كان الكود قيد التشغيل في ملف في دليل مزود خدمة، فافترض هذا المزود.
في حالة أخرى، يحصل على مزود الخدمة الممكن حاليًا.

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
