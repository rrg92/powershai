---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
שולח הודעות ל-LLM ומחזיר את התגובה

## DESCRIPTION <!--!= @#Desc !-->
זוהי הצורה הבסיסית ביותר של צ'אט המוצעת על ידי PowershAI.  
עם הפונקציה הזו, אתה יכול לשלוח הודעה ל-LLM של ספק הנוכחי.  

זוהי פונקציה ברמת נמוכה יותר, בצורה סטנדרטית, לגישה ל-LLM ש-PowershAI מספק.  
היא לא מנהלת היסטוריה או הקשר. היא שימושית להזנת פקודות פשוטות, שאינן דורשות מספר אינטראקציות כמו בצ'אט. 
למרות שהיא תומכת ב-Functon Calling, היא לא מבצעת שום קוד, ומחזירה רק את התגובה של המודל.



** מידע לספקים
	הספק צריך ליישם את הפונקציה Chat כדי שהפונקציה הזו תהיה זמינה. 
	הפונקציה chat צריכה להחזיר אובייקט עם התגובה באותה המפרט של OpenAI, פונקציית Chat Completion.
	הקישורים הבאים משמשים כבסיס:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (תגובה ללא סטרימינג)
	הספק צריך ליישם את הפרמטרים של הפונקציה הזו. 
	ראה את התיעוד של כל פרמטר לפרטים וכיצד למפות לספק;
	
	כאשר המודל לא תומך באחד מהפרמטרים המידע (זאת אומרת, אין פונקציה מקבילה, או שניתן ליישם אותה בצורה מקבילה) יש להחזיר שגיאה.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] 
[[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
ההודעה שתישלח. יש להיות בפורמט המתואר על ידי הפונקציה ConvertTo-OpenaiMessage

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

### -temperature
טמפרטורת המודל

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
שם המודל. אם לא צוין, משתמש במודל ברירת המחדל של הספק.

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

### -MaxTokens
המקסימום של טוקנים להחזרה

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
פורמט התגובה 
הפורמטים המקובלים, והתנהגותם, צריכים לעקוב אחרי אותם פורמטים של OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
קיצורים:
	"json"|"json_object", שווה ל- {"type": "json_object"}
	אובייקט צריך לציין סכימה כאילו הועברה ישירות ל-API של OpenAI, בשדה response_format.json_schema

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Functions
רשימת כלים שצריכים להיות מופעלים!
אתה יכול להשתמש בפקודות כמו Get-OpenaiTool*, כדי להמיר פונקציות PowerShell בקלות לפורמט הצפוי!
אם המודל מפעיל את הפונקציה, התגובה, הן בסטרימינג והן רגילה, צריכה גם לעקוב אחרי המודל של tool calling של OpenAI.
פרמטר זה צריך לעקוב אחרי אותו הסכם של Function Calling של OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
ציין פרמטרים ישירים של API של הספק.
זה יחליף את הערכים שחושבו ונוצרו בהתבסס על שאר הפרמטרים.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback
מאפשר את המודל סטרים 
אתה צריך לציין ScriptBlock שיתקבל עבור כל טקסט שנוצר על ידי ה-LLM.
הסקריפט צריך לקבל פרמטר המייצג כל קטע, באותו פורמט של סטרימינג שהוחזר
	פרמטר זה הוא אובייקט שיכיל את המאפיין choices, שהוא אותו הסכם שהוחזר על ידי הסטרימינג של OpenAI:
		https://platform.openai.com/docs/api-reference/chat/streaming

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -IncludeRawResp
כולל את התגובה של ה-API בשדה הנקרא IncludeRawResp

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
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
