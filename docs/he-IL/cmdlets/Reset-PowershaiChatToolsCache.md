---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
מנקה את המטמון של כלים של AI.

## DESCRIPTION <!--!= @#Desc !-->
PowershAI שומר מטמון עם כלים "מהודרים".
כאשר PowershAI שולח רשימת כלים ל-LLM, הוא צריך לשלוח יחד איתו את תיאור הכלים, רשימת פרמטרים, תיאור, וכו'. 
יצירת רשימה זו יכולה לקחת זמן משמעותי, מכיוון שהוא יסרוק את רשימת הכלים, הפונקציות, ולכל אחד, יסרוק את העזרה (ועבור כל פרמטר, יסרוק את העזרה שלו).

כאשר מוסיפים cmdlet כמו Add-AiTool, הוא לא מהודר באותו רגע.
הוא משאיר את זה לעתיד, כאשר הוא צריך להפעיל את ה-LLM, בפונקציה Send-PowershaiChat. 
אם המטמון לא קיים, אז הוא מהודר במקום, מה שיכול לגרום לכך שהשליחה הראשונה ל-LLM תיקח כמה מילישניות או שניות יותר מהרגיל.

ההשפעה הזו היא פרופורציונלית למספר הפונקציות והפרמטרים שנשלחים. 

כל פעם שאתם משתמשים ב-Add-AiTool או Add-AiScriptTool, הוא מבטל את המטמון, כך שבפעם הבאה שהוא יתבצע, הוא ייווצר. 
זה מאפשר להוסיף פונקציות רבות בו זמנית, בלי שהן ימהודרו כל פעם שאתם מוסיפים.

עם זאת, אם תשנו את הפונקציה שלכם, המטמון לא ייחשב מחדש. 
אז, תצטרכו להשתמש ב-cmdlet הזה כדי שהפעלה הבאה תכיל את הנתונים המעודכנים של הכלים שלכם לאחר שינויים בקוד או בסקריפט.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
