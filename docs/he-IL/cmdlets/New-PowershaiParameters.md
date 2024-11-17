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
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] 
<Boolean>] [[-ShowTokenStats] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] 
[[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] 
[[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
כאשר true, משתמש במצב זרימה, כלומר, ההודעות מוצגות כפי שהמודל מייצר אותן

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
מפעיל את מצב JSON. במצב זה, המודל מחויב להחזיר תשובה בפורמט JSON.  
כאשר מופעל, ההודעות המיוצרות באמצעות זרימה אינן מוצגות כפי שהן מיוצרות, ורק התוצאה הסופית מוחזרת.

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
שם המודל שיש להשתמש בו  
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
המספר המרבי של טוקנים להחזיר מהמודל

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
מדפיס את כל הפקודה שנשלחת ל-LLM

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
בסיומה של כל הודעה, מציג את הסטטיסטיקות של השימוש, בטוקנים, שהוחזרו על ידי ה-API

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
המספר המרבי של אינטראקציות שניתן לבצע בבת אחת 
כל פעם שנשלחת הודעה, המודל מבצע 1 אינטראקציה (שולח את ההודעה ומקבל תשובה).  
אם המודל מבקש קריאת פונקציה, התגובה המיוצרת תישלח שוב למודל. זה נחשב כאינטראקציה נוספת.  
פרמטר זה שולט על המספר המרבי של אינטראקציות שיכולות להתקיים בכל קריאה.
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
המספר המרבי של שגיאות ברצף שנוצרו על ידי Tool Calling.  
בעת שימוש ב-tool calling, פרמטר זה מגביל כמה כלים ברצף שגרמו לשגיאה יכולים להיקרא.  
השגיאה המתחשבת היא החריגה שהושלכה על ידי הסקריפט או הפקודה המוגדרת.

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
הגודל המרבי של ההקשר, בתווים 
בעתיד, יהיה בטוקנים 
שולט על כמות ההודעות בהקשר הנוכחי של הצ'אט. כאשר מספר זה חורג, Powershai מנקה אוטומטית את ההודעות הישנות ביותר.

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
פונקציה המשמשת לעיצוב האובייקטים המועברים באמצעות צינור

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
ארגומנטים שיש להעביר ל-ContextFormatterFunc

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
אם true, מציג את הארגומנטים של הפונקציות כאשר Tool Calling מופעל כדי לבצע פונקציה כלשהי

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
מציג את התוצאות של הכלים כאשר הם מבוצעים על ידי PowershAI בתגובה לקריאת הכלים של המודל

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
הודעת מערכת המובטחת להישלח תמיד, ללא קשר להיסטוריה ולניקוי הצ'אט!

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
פרמטרים שיש להעביר ישירות ל-API שמזמן את המודל.  
הספק חייב ליישם את התמיכה בזה.  
כדי להשתמש בו, עליך לדעת את פרטי היישום של הספק וכיצד ה-API שלו פועל!

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
שולט על התבנית המשמשת בעת הזרקת נתוני הקשר!
פרמטר זה הוא scriptblock שצריך להחזיר מיתר עם ההקשר שצריך להיות מוזרק לפקודה!
הפרמטרים של ה-scriptblock הם:
	FormattedObject 	- האובייקט המייצג את הצ'אט הפעיל, שכבר מעוצב עם ה-Formatter שהוגדר
	CmdParams 			- הפרמטרים המועברים ל-Send-PowershaAIChat. זה אותו אובייקט המוחזר על ידי GetMyParams
	Chat 				- הצ'אט שבו הנתונים נשלחים.
אם null, ייצור ברירת מחדל. בדוק את הפקודה Send-PowershaiChat לפרטים

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
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
