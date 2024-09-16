---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
تعيين نموذج LLM الافتراضي للمزود الحالي

## DESCRIPTION <!--!= @#Desc !-->
يمكن للمستخدمين تعيين نموذج LLM الافتراضي ، والذي سيتم استخدامه عندما يكون LLM ضروريًا.  
الأوامر مثل Send-PowershaAIChat ، Get-AiChat ، تتوقع نموذجًا ، وإذا لم يتم تحديده ، فسوف يستخدم ما تم تعريفه باستخدام هذا الأمر.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
معرف النموذج ، كما تم إرجاعه بواسطة Get-AiModels
يمكنك استخدام علامة التبويب لإكمال سطر الأوامر.

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

### -Force
إجبار تعيين النموذج ، حتى لو لم يتم إرجاعه بواسطة Get-AiModels

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
