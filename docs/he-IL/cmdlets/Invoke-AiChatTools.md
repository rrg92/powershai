---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
שולח הודעה ל-LLM, עם תמיכה ב-Tool Calling, ומבצע את הכלים המבוקשים על ידי המודל כפקודות powershell.

## DESCRIPTION <!--!= @#Desc !-->
זו פונקציה עזר כדי לעזור לעבד את הכלים בקלות עם powershell.
היא מטפלת בעיבוד ה-"Tools", מבצעת כאשר המודל מבקש!

עליך להעביר את הכלים בפורמט ספציפי, המתועד בנושא about_Powershai_Chats
פורמט זה ממפה נכון פונקציות ופקודות powershell לסכימה המקובלת על ידי OpenAI (OpenAPI Schema).

פקודה זו encapsulates את כל הלוגיקה שמזהה מתי המודל רוצה לקרוא לפונקציה, את ביצוע הפונקציות הללו, ושליחת התגובה חזרה למודל.
היא נשארת בלולאה הזו עד שהמודל מפסיק להחליט לקרוא לפונקציות נוספות, או שהמגבלה של אינטראקציות (כן, כאן אנו קוראים לזה אינטראקציות ולא איטרציות) עם המודל הסתיימה.

המושג אינטראקציה הוא פשוט: כל פעם שהפונקציה שולחת פנייה למודל, זה נחשב כאינטגרציה.
להלן זרימה טיפוסית שיכולה להתרחש:

אתה יכול לקבל פרטים נוספים על פעולתה על ידי התייעצות בנושא about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] 
<Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] 
[-Stream] [<CommonParameters>]
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

### -Tools
מערך של כלים, כפי שהוסבר במסמך של פקודה זו
השתמש בתוצאות של Get-OpenaiTool* כדי לייצר את הערכים האפשריים.
אתה יכול להעביר מערך של אובייקטים מסוג OpenaiTool.
אם פונקציה אחת מוגדרת ביותר מכלי אחד, הראשונה שנמצאת בסדר המוגדר תישתמש!

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

### -PrevContext

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
מקסימום פלט!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 500
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
בסך הכל, אפשר לא יותר מ-5 אינטראקציות!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
מספר מקסימלי של שגיאות רצופות שהפונקציה שלך יכולה לייצר לפני שהיא תסיים.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 2
Accept pipeline input: false
Accept wildcard characters: false
```

### -temperature

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

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

### -on
מטפל באירועים
כל מפתח הוא אירוע שיתפרץ במוקדם או במאוחר על ידי פקודה זו!
אירועים:
answer: מתפרץ לאחר קבלת התגובה מהמודל (או כאשר תשובה זמינה בשימוש ב-stream).
func: מתפרץ לפני שמתחילים לבצע כלי שנדרש על ידי המודל.
	exec: מתפרץ לאחר שהמודל מבצע את הפונקציה.
	error: מתפרץ כאשר הפונקציה המבוצעת מייצרת שגיאה
	stream: מתפרץ כאשר תגובה נשלחה (על ידי ה-stream) ו- -DifferentStreamEvent
	beforeAnswer: מתפרץ לאחר כל התגובות. משמש כשמשתמשים ב-stream!
	afterAnswer: מתפרץ לפני שמתחילים את התגובות. משמש כשמשתמשים ב-stream!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
שולח את response_format = "json", מכריח את המודל להחזיר json.

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

### -RawParams
להוסיף פרמטרים מותאמים אישית ישירות בשיחה (יש overwrites את הפרמטרים המוגדרים אוטומטית).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Stream

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
