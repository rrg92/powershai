---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
تحويل مصفوفة السلسلة والكائنات إلى تنسيق رسالة OpenAI القياسي!

## DESCRIPTION <!--!= @#Desc !-->
يمكنك تمرير مصفوفة مختلطة حيث يمكن أن يكون كل عنصر سلسلة أو كائن.
إذا كانت سلسلة ، فيمكن أن تبدأ ببادئة s أو u أو a ، مما يعني ، على التوالي ، system أو user أو assistant.
إذا كان كائنًا ، فسيتم إضافته مباشرة إلى المصفوفة الناتجة.

انظر: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "هذا نص",@{role:"assistant";content="رد مساعد"}, "s:Msg system"
```


## PARAMETERS <!--!= @#Params !-->

### -prompt

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
