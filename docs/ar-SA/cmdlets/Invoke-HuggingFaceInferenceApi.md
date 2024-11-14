---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-HuggingFaceInferenceApi

## SYNOPSIS <!--!= @#Synop !-->
استدعاء واجهة برمجة تطبيقات استدلال Hugging Face
https://huggingface.co/docs/hub/en/api

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-HuggingFaceInferenceApi [[-model] <Object>] [[-params] <Object>] [-Public] [-OpenaiChatCompletion] [[-StreamCallback] <Object>] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model

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

### -Public

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

### -OpenaiChatCompletion
فرض استخدام نقطة النهاية لإكمال الدردشة 
يجب التعامل مع Params كـ params نفسه لواجهة برمجة تطبيقات Openai (انظر الأمر Get-OpenaiChat).
مزيد من المعلومات: https://huggingface.co/blog/tgi-messages-api
يعمل فقط مع النماذج التي تحتوي على نموذج دردشة!

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

### -StreamCallback
استدعاء التدفق للاستخدام في حالة StreamS!

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


<!--PowershaiAiDocBlockStart-->
_تمت الترجمة تلقائيًا باستخدام PowershAI والذكاء الاصطناعي._
<!--PowershaiAiDocBlockEnd-->
