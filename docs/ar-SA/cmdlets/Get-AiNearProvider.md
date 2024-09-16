---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
يحصل على مزود أقرب إلى النص البرمجي الحالي

## DESCRIPTION <!--!= @#Desc !-->
عادة ما يتم استخدام هذا cmdlet بشكل غير مباشر بواسطة المزودين من خلال Get-AiCurrentProvider.  
يقوم بالبحث في callstack في powershell ويحدد ما إذا كان المتصل (الوظيفة التي تم تنفيذها) جزءًا من نص برمجي لمزود.  
إذا كان الأمر كذلك ، فسيقوم بإرجاع هذا المزود.

إذا تم إجراء المكالمة من عدة مزودين ، فسيتم إرجاع أحدثها. على سبيل المثال ، تخيل هذا السيناريو:

	المستخدم -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
لاحظ أن هناك مكالمتين للمزودين.  
في هذه الحالة ، ستعيد وظيفة Get-AiNearProvider المزود y ، لأنه هو أحدثها في call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
