---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
מאתר את ספק ה-AI הקרוב ביותר לסקריפט הנוכחי

## DESCRIPTION <!--!= @#Desc !-->
קמדלט זה משמש בדרך כלל על ידי ספקים באופן עקיף באמצעות Get-AiCurrentProvider.  
הוא בודק את callstack של powershell ומזהה אם הקורא (הפונקציה שהפעילה) חלק מסקריפט של ספק.  
אם כן, הוא מחזיר את הספק הזה.

אם הקריאה התבצעה בתוך ספקים מרובים, הספק האחרון ביותר יוחזר. לדוגמה, דמיין את התרחיש הזה:

	משתמש -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
שים לב במקרה זה ישנם 2 שיחות ספקים המעורבות.  
במקרה זה, פונקציית Get-AiNearProvider תחזיר את הספק Y, מכיוון שהוא הספק האחרון ביותר ב-call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
