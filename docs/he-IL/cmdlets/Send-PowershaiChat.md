---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
שולח הודעה בצ'אט של Powershai

## DESCRIPTION <!--!= @#Desc !-->
קמנד זה מאפשר לך לשלוח הודעה חדשה ל-LLM של הספק הנוכחי.  
ברירת המחדל היא לשלוח בצ'אט הפעיל. אתה יכול לדרוס את הצ'אט באמצעות הפרמטר -Chat. אם אין צ'אט פעיל, הוא ישתמש בברירת המחדל.  

מספר פרמטרים של הצ'אט משפיעים על אופן פעולתו של פקודה זו. ראה את הפקודה Get-PowershaiChatParameter למידע נוסף על פרמטרי הצ'אט.  
בנוסף לפרמטרי הצ'אט, פרמטרי הפקודה עצמם יכולים לדרוס התנהגות. למידע נוסף, עיין בתיעוד של כל פרמטר בקמנד זה באמצעות get-help.  

לצורך פשטות, ולשמירה על שורת הפקודה נקייה, כך שהמשתמש יכול להתמקד יותר בהנחיות ובנתונים, מספר כינויים זמינים.  
כינויים אלה יכולים להפעיל פרמטרים מסוימים.
הם:
	ia|ai
		קיצור של "בינה מלאכותית" בעברית. זהו כינוי פשוט ואינו משנה אף פרמטר. הוא מסייע לצמצם בצורה משמעותית את שורת הפקודה.
	
	iat|ait
		אותו הדבר כמו Send-PowershaAIChat -Temporary
		
	io|ao
		אותו הדבר כמו Send-PowershaAIChat -Object
		
	iam|aim 
		אותו הדבר כמו Send-PowershaaiChat -Screenshot 

המשתמש יכול ליצור כינויים משלו. לדוגמה:
	Set-Alias ki ia # מגדיר את הכינוי עבור הגרמנית!
	Set-Alias kit iat # מגדיר את הכינוי kit עבור iat, כך שהתנהגות תהיה זהה ל-iat (צ'אט זמני) כאשר משתמשים ב-kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] 
[-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] 
[-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
הנחיה שתישלח למודל

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

### -SystemMessages
הודעת מערכת שתיכלל

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
ההקשר 
פרמטר זה מיועד לשימוש מועדף על ידי צינור הקלט.
הוא יגרום לפקודה לשים את הנתונים בתגיות <contexto></contexto> ולהזריק אותם יחד עם ההנחיה.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
מכריח את הקמנד לפעול עבור כל אובייקט בצינור הקלט
ברירת המחדל היא לאסוף את כל האובייקטים במערך, להמיר את המערך למחרוזת אחת ולשלוח אותה בבת אחת ל-LLM.

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

### -Json
מפעיל את מצב JSON 
במצב זה התוצאות המוחזרות תמיד יהיו JSON.
המודל הנוכחי חייב לתמוך בזה!

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

### -Object
מצב אובייקט!
במצב זה מצב JSON יופעל אוטומטית!
הפקודה לא תכתוב דבר על המסך, ותשיב את התוצאות כאובייקט!
שיתווספו חזרה לצינור הקלט!

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

### -PrintContext
מציג את נתוני ההקשר שנשלחו ל-LLM לפני התגובה!
זה שימושי לדיבוג מה מוזרק לנתונים בהנחיה.

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

### -Forget
לא לשלוח את השיחות הקודמות (ההיסטוריה של ההקשר), אבל לכלול את ההנחיה ואת התגובה בהיסטוריה של ההקשר.

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

### -Snub
מתעלם מהתגובה של ה-LLM, ולא כולל את ההנחיה בהיסטוריה של ההקשר

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

### -Temporary
לא שולח את ההיסטוריה ולא כולל את התגובה וההנחיה.  
זה כמו לעבור על -Forget ו- -Snub יחד.

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

### -DisableTools
כבה את קריאת הפונקציה עבור ביצוע זה בלבד!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
שנה את פורמט ההקשר לזה
למידע נוסף ראה ב-Format-PowershaiContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterParams
פרמטרים של פורמט ההקשר ששונו.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PassThru
מחזיר את ההודעות חזרה לצינור הקלט, מבלי לכתוב ישירות על המסך!
אפשרות זו מניחה שהמשתמש יהיה אחראי על מתן היעד הנכון להודעה!
האובייקט שנשלח לצינור הקלט יהיה לו את התכונות הבאות:
	text 			- הטקסט (או קטע) של הטקסט המוחזר מהמודל 
	formatted		- הטקסט המעוצב, כולל את ההנחיה, כאילו נכתב ישירות על המסך (בלי צבעים)
	event			- האירוע. מציין את האירוע שגרם לכך. אלו הם אותם אירועים המתועדים ב-Invoke-AiChatTools
	interaction 	- האובייקט אינטראקציה שנוצר על ידי Invoke-AiChatTools

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

### -Lines
מחזיר מערך של שורות 
אם מצב הזרימה פעיל, יחזור שורה אחת בכל פעם!

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

### -ChatParamsOverride
לדרוס פרמטרים של הצ'אט!
ציין כל אפשרות בהאשטבלס!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
מפרט ישירות את ערך פרמטר הצ'אט RawParams!
אם מצוין גם ב-ChatParamOverride, מתבצע מיזוג, כאשר הפרמטרים המצוינים כאן מקבלים עדיפות.
ה- RawParams הוא פרמטר צ'אט המגדיר פרמטרים שיישלחו ישירות ל-API של המודל!
פרמטרים אלה ידרסו את הערכים ברירת המחדל המחושבים על ידי powershai!
כך, למשתמש יש שליטה מלאה על הפרמטרים, אך עליו להכיר כל ספק!
גם, כל ספק אחראי לספק את היישום הזה ולהשתמש בפרמטרים אלה ב-API שלו.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
לוכד צילום מסך של המסך שמאחורי חלון ה-Powershell ושולח אותו יחד עם ההנחיה. 
שימו לב שהמצב הנוכחי חייב לתמוך בתמונות (מודלים בשפת חזון).

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
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
