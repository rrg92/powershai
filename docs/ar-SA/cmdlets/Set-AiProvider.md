---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
يُغيّر مُزوّد الخدمة الحالي

## DESCRIPTION <!--!= @#Desc !-->
مُزوّدو الخدمة هم نصوص برمجية تُنفّذ الوصول إلى واجهات برمجة التطبيقات الخاصة بهم.  
لكل مُزوّد خدمة طريقته الخاصة في استدعاء واجهات برمجة التطبيقات، وصيغة البيانات، ومخطط الاستجابة، وما إلى ذلك.  

عند تغيير مُزوّد الخدمة، ستؤثّر على أوامر معيّنة تعمل على مُزوّد الخدمة الحالي، مثل `Get-AiChat`، `Get-AiModels`، أو المحادثات، مثل Send-PowershaAIChat.
لمزيد من التفاصيل حول مُزوّدي الخدمة، راجع الموضوع about_Powershai_Providers

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
اسم مُزوّد الخدمة

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


<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
