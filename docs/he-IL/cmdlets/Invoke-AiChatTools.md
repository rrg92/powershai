---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
שולח הודעה ל-LLM, עם תמיכה בקריאת כלים, ומפעיל את הכלים שביקש המודל כפקודות Powershell.

## DESCRIPTION <!--!= @#Desc !-->
זוהי פונקציה עזר כדי לעזור להפוך את עיבוד הכלים לקל יותר עם Powershell.
היא מטפלת בעיבוד של "כלים", ומפעילה אותם כאשר המודל מבקש!

עליך להעביר את הכלים בפורמט ספציפי, שתועד ב-about_Powershai_Chats
פורמט זה ממפה כראוי פונקציות ופועלי Powershell לסכימה הניתנת לקבלה על ידי OpenAI (סכימת OpenAI).  

פקודה זו מקיפה את כל הלוגיקה המזהה מתי המודל רוצה להפעיל את הפונקציה, את ההפעלה של הפונקציות האלו, ושליחת התגובה הזו חזרה למודל.  
היא נמצאת בלולאה זו עד שהמודל יפסיק להחליט להפעיל עוד פונקציות, או שגבול האינטראקציות (כן, כאן אנו קוראים לזה אינטראקציות, ולא איטרציות) עם המודל יסתיים.

המושג של אינטראקציה הוא פשוט: בכל פעם שהפונקציה שולחת בקשה למודל, זה נספר כאינטראקציה.  
להלן זרימה אופיינית שיכולה להתרחש:
	

ניתן לקבל פרטים נוספים על אופן הפעולה על ידי התייעצות עם about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] 
[[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
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
מערך של כלים, כפי שהוסבר במסמכים של פקודה זו
השתמש בתוצאות של Get-OpenaiTool* כדי ליצור את הערכים האפשריים.  
אתה יכול להעביר מערך של אובייקטים מסוג OpenaiTool.
אם אותה פונקציה מוגדרת ביותר מכלל, הפונקציה הראשונה שנתגלתה בסדר שנקבע תנוצל!

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
בסך הכל, לאפשר מקסימום 5 איטרציות!

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
כמות מקסימלית של שגיאות רצופות שהפונקציה שלך יכולה לייצר לפני שהיא תסתיים.

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
מתאם אירועים
כל מפתח הוא אירוע שיישלח בזמן מסוים על ידי פקודה זו!
אירועים:
answer: נשלח לאחר קבלת התגובה מהמודל (או כאשר תגובה הופכת לזמינה בעת שימוש בזרם).
func: נשלח לפני תחילת ההפעלה של כלי שביקש המודל.
	exec: נשלח לאחר שהמודל ביצע את הפונקציה.
	error: נשלח כאשר הפונקציה שהופעלה יוצרת שגיאה
	stream: נשלח כאשר תגובה נשלחה (על ידי זרם) ו-DifferentStreamEvent
	beforeAnswer: נשלח לאחר כל התגובות. שימושי כאשר משתמשים בזרם!
	afterAnswer: נשלח לפני תחילת התגובות. שימושי כאשר משתמשים בזרם!

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
שולח response_format = "json", ומאלץ את המודל להחזיר JSON.

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
הוסף פרמטרים מותאמים אישית ישירות לשיחה (יישלחו מעל הפרמטרים שהוגדרו באופן אוטומטי).

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
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
