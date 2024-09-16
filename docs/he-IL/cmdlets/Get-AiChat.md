---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
שולח הודעות ל-LLM ומחזיר את התשובה

## DESCRIPTION <!--!= @#Desc !-->
זוהי הדרך הבסיסית ביותר ל-Chat שמוצע על ידי PowershAI.  
בעזרת פונקציה זו, תוכל לשלוח הודעה ל-LLM של ספק השירות הנוכחי.  

פונקציה זו היא ברמת נמוכה יותר, בצורה סטנדרטית, לגישה ל-LLM ש-powershai מספק.  
היא לא מנהלת היסטוריה או הקשר. היא שימושית להפעלת בקשות פשוטות, שלא דורשות אינטראקציות מרובות כמו בצ'אט. 
למרות שתומכת ב-Function Calling, היא לא מבצעת קוד כלשהו, והיא פשוט מחזירה את תגובת הדגם.



** מידע לספקים
	הספק חייב ליישם את פונקציית Chat כדי שפונקציונליות זו תהיה זמינה. 
	פונקציית chat חייבת להחזיר אובייקט עם התשובה באותה מפרט כמו OpenAI, פונקציית Chat Completion.
	הקישורים הבאים משמשים כבסיס:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (החזרה ללא זרם)
	הספק חייב ליישם את הפרמטרים של פונקציה זו. 
	ראה את התיעוד של כל פרמטר לפרטים וכיצד למפות לספק;
	
	כאשר הדגם לא תומך באחד מהפרמטרים שצוינו (כלומר, אין פונקציונליות שווה ערך, או שניתן ליישם בצורה שווה ערך) יש להחזיר שגיאה.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
הבקשה שיש לשלוח. צריך להיות בפורמט שמתואר על ידי פונקציית ConvertTo-OpenaiMessage

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
טמפרטורה של הדגם

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
שם הדגם. אם לא צוינה, משתמשת ברירת המחדל של הספק.

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
מספר מקסימלי של טוקנים שיש להחזיר

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
הפורמטים שמתקבלים, והתנהגות, צריכים להיות זהים ל-OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
קיצורי דרך:
	"json", שווה ערך ל-{"type": "json_object"}

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
רשימת כלים שיש להפעיל!
אתה יכול להשתמש בפקודות כמו Get-OpenaiTool*, כדי להמיר פונקציות powershell בקלות לפורמט הצפוי!
אם הדגם מפעיל את הפונקציה, התגובה, גם בזרימה, וגם רגילה, צריכה גם לעקוב אחר מודל קריאה של כלים של OpenAI.
פרמטר זה צריך לעקוב אחר אותה תכנית כמו Function Calling של OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
זה יהרוס את הערכים שחושבו ונוצרו על בסיס הפרמטרים האחרים.

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
מאפשר זרם דגם
עליך לציין ScriptBlock שיופעל עבור כל טקסט שנוצר על ידי LLM.
הסקריפט צריך לקבל פרמטר שייצג כל קטע, באותו פורמט זרימה שמוחזר
	פרמטר זה הוא אובייקט שיכיל את המהות choices, שהיא באותה תכנית שמוחזרת על ידי זרימת OpenAI:
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
הכלל את תגובת ה-API בשדה שנקרא IncludeRawResp

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
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
