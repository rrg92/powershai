---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
המרת מערך של מחרוזות ואובייקטים לתבנית הודעות סטנדרטית של OpenAI!

## DESCRIPTION <!--!= @#Desc !-->
אתה יכול להעביר מערך מעורב שבו כל פריט יכול להיות מחרוזת או אובייקט.
אם מדובר במחרוזת, היא יכולה להתחיל עם הקידומת s, u או a, שפירושה, בהתאמה, system, user או assistant.
אם זה אובייקט, הוא יתווסף ישירות למערך התוצאה.

ראה: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "זה טקסט",@{role:"assistant";content="תשובה של assistant"}, "s:הודעה של system"
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
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
