---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
יוצר קריאה חדשה לנקודת קצה במושב הנוכחי.

## DESCRIPTION <!--!= @#Desc !-->
מבצע קריאה באמצעות ה-API של Gradio, בנקודת קצה ספציפית ומעביר את הפרמטרים הרצויים.  
קריאה זו תיצור GradioApiEvent (ראה Send-GradioApi), שתישמר פנימית בהגדרות המושב.  
אובייקט זה מכיל את כל מה שדרוש כדי לקבל את התוצאה מה-API.  

הפקודה תחזיר אובייקט מסוג SessionApiEvent המכיל את התכונות הבאות:
	id - מזהה פנימי של האירוע שנוצר.
	event - האירוע הפנימי שנוצר. ניתן להשתמש בו ישירות עם הפקודות המניפולטיביות על אירועים.
	
למושבים יש מגבלה על מספר הקריאות המוגדרות.
המטרה היא למנוע יצירת קריאות אינסופיות כך שלא יאבדו את השליטה.

ישנן שתי אפשרויות למושב שמשפיעות על הקריאה (ניתן לשנות עם Set-GradioSession):
	- MaxCalls 
	שולטים על המספר המקסימלי של קריאות שניתן ליצור
	
	- MaxCallsPolicy 
	שולטים מה לעשות כאשר המקסימום מושג.
	ערכים אפשריים:
		- Error 	= מביא לשגיאה!
		- Remove 	= מסיר את הישנה ביותר 
		- Warning 	= מציג אזהרה, אך מאפשר לעבור את הגבול.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
שם נקודת הקצה (בלי סלש התחלה)

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

### -Params
רשימת פרמטרים 
אם זה מערך, מעביר ישירות ל-API של Gradio 
אם זו hashtable, בונה את המערך בהתבסס על מיקום הפרמטרים שהוחזרו על ידי /info

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

### -EventId
אם מצוין, יוצר עם מזהה אירוע קיים (יכול להיות שנוצר מחוץ למודול).

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

### -session
מושב

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
כופה שימוש בטוקן חדש. אם "ציבורי", אז לא משתמש בטוקן כלשהו!

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


<!--PowershaiAiDocBlockStart-->
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
