---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
יוצר אובייקט חדש המייצג את הפרמטרים של PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
יוצר אובייקט ברירת מחדל המכיל את כל הפרמטרים האפשריים שניתן להשתמש בהם בצ'אט!
המשתמש יכול להשתמש ב-get-help New-PowershaiParameters כדי לקבל את התיעוד של הפרמטרים.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] 
<Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
כאשר true, משתמש במצב זרם, כלומר, ההודעות מוצגות ככל שהמודל מייצר אותן

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
מאפשר מצב JSON. במצב זה, המודל נאלץ להחזיר תגובה עם JSON.  
כאשר מופעל, ההודעות שנוצרו דרך זרם לא מוצגות ככל שהן נוצרות, ורק התוצאה הסופית מוחזרת.

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
שם המודל שישמש  
אם null, משתמש במודל שהוגדר עם Set-AiDefaultModel

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
מספר מרבי של טוקנים שיוחזרו על ידי המודל

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 2048
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowFullSend
מדפיס את הפרומפט כולו שנשלח ל-LLM

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowTokenStats
בסוף כל הודעה, מציג את הסטטיסטיקה של צריכת טוקנים, שהוחזרה על ידי ה-API

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
מספר מרבי של אינטראקציות שיבוצעו בפעם אחת 
בכל פעם שהודעה נשלחת, המודל מבצע 1 איטרציה (שולח את ההודעה וקולט תגובה).  
אם המודל מבקש קריאה לפונקציה, התגובה שנוצרה תשלח שוב למודל. זה נחשב כאיטרציה נוספת.  
פרמטר זה שולט במספר המרבי של האינטראקציות שיכולות להתקיים בכל שיחה.
זה עוזר למנוע לולאות אינסופיות בלתי צפויות.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 50
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
מספר מרבי של שגיאות ברצף שנוצרו על ידי קריאה לכלי.  
בעת שימוש בקריאה לכלי, פרמטר זה מגביל כמה כלים ברצף שגרמו לשגיאה ניתן לקרוא.  
השגיאה המשתקפת היא החריגה שגרם הסקריפט או הפקודה שהוגדרו.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 5
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxContextSize
גודל מרבי של הקשר, בתווים 
בעתיד, זה יהיה בטוקנים 
שולט בכמות ההודעות בהקשר הנוכחי של הצ'אט. כאשר מספר זה יעבור, Powershai ינקה אוטומטית את ההודעות הישנות ביותר.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: 8192
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterFunc
פונקציה המשמשת לעיצוב אובייקטים שעוברים דרך צינור

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: ConvertTo-PowershaiContextOutString
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterParams
ארגומנטים להעברה ל-ContextFormatterFunc

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowArgs
אם true, מציג את ארגומנטים הפונקציות כאשר קריאה לכלי מופעלת כדי להפעיל פונקציה כלשהי

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolsResults
מציג את התוצאות של הכלים כאשר הם מבוצעים על ידי PowershAI בתגובה לקריאת כלי של המודל

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 13
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -SystemMessageFixed
הודעת מערכת שמוודאת שנשלחת תמיד, ללא קשר להיסטוריה ולניקוי של הצ'אט!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 14
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
פרמטרים להעברה ישירות ל-API שגורם למודל.  
הספק חייב ליישם תמיכה בזה.  
כדי להשתמש בזה עליך לדעת את פרטי היישום של הספק וכיצד ה-API שלו פועל!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormat
שולט בתבנית המשמשת בעת הזרקת נתוני הקשר!
פרמטר זה הוא scriptblock שצריך להחזיר מחרוזת עם הקשר שיש להזריק לפרומפט!
פרמטרי ה-scriptblock הם:
	FormattedObject 	- האובייקט שמייצג את הצ'אט הפעיל, שכבר מעוצב באמצעות ה-Formatter שהוגדר
	CmdParams 			- הפרמטרים שהועברו ל-Send-PowershaAIChat. זהו אותו אובייקט שמוחזר על ידי GetMyParams
	Chat 				- הצ'אט שבו הנתונים נשלחים.
אם NULL, הוא ייצור ברירת מחדל. בדוק את cmdlet Send-PowershaiChat לפרטים

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 16
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
