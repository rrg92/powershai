---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->

## DESCRIPTION <!--!= @#Desc !-->
שולח נתונים ל-Gradio ומחזיר אובייקט המייצג את האירוע!  
העבר אובייקט זה לשאר הפקודות כדי לקבל את התוצאות.

פעולתה של API של גרדיו

	מבוסס על: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	כדי להבין טוב יותר כיצד להשתמש בפקודה זו, חשוב להבין כיצד פועלת ה-API של גרדיו.  
	כאשר אנו מפעילים נקודת קצה כלשהי של ה-API, היא לא מחזירה את הנתונים מיד.  
	זה נובע מהעובדה הפשוטה שהעיבוד הוא נרחב, בשל הטבע (בינה מלאכותית ולמידת מכונה).  
	
	אז, במקום להחזיר את התוצאה, או לחכות ללא הגבלה, גרדיו מחזיר "מזהה אירוע".  
	עם האירוע הזה, אנו יכולים באופן תקופתי לקבל את התוצאות שנוצרו.  
	גרדיו יפיק הודעות אירוע עם הנתונים שנוצרו. עלינו להעביר את מזהה האירוע שנוצר כדי לקבל את החלקים החדשים שנוצרו.  
	האירועים הללו נשלחים באמצעות Server Side Events (SSE), ויכולים להיות אחד מהבאים:
		- heartbeat 
		כל 15 שניות, גרדיו ישלח את האירוע הזה כדי לשמור על החיבור פעיל.  
		לכן, כאשר אתה משתמש בפקודה Update-GradioApiResult, זה עשוי לקחת קצת זמן להחזיר.
		
		- complete 
		זו ההודעה האחרונה שנשלחת על ידי גרדיו כאשר הנתונים נוצרו בהצלחה!
		
		- error 
		נשלח כאשר הייתה שגיאה כלשהי בעיבוד.  
		
		- generating
		זה נוצר כאשר ה-API כבר יש נתונים זמינים, אך, עדיין עשויים להגיע נוספים.
	
	כאן ב-PowershAI, אנו מפרידים זאת גם ל-3 חלקים: 
		- פקודה זו (Send-GradioApi) מבצעת את הבקשה הראשונית לגרדיו ומחזירה אובייקט המייצג את האירוע (אנחנו קוראים לו אובייקט GradioApiEvent)
		- האובייקט התוצאה, מסוג GradioApiEvent, מכיל את כל מה שצריך כדי לבדוק את האירוע והוא גם שומר את הנתונים והטעויות שהתקבלו.
		- לבסוף, יש לנו את הפקודה Update-GradioApiResult, שבה עליך להעביר את האירוע שנוצר, והיא תבדוק את ה-API של גרדיו ותקבל את הנתונים החדשים.  
			בדוק את העזרה של פקודה זו למידע נוסף כיצד לשלוט במנגנון זה של קבלת הנתונים.
			
	
	אז, בזרימה רגילה, אתה צריך לעשות את הדברים הבאים: 
	
		#הפעל את נקודת הקצה של גרדיו!
		$MeuEvento = SEnd-GradioApi ... 
	
		# קבל תוצאות עד שהן יסתיימו!
		# בדוק את העזרה של פקודה זו כדי ללמוד עוד!
		$MeuEvento | Update-GradioApiResult
		
אובייקט GradioApiEvent

	האובייקט GradioApiEvent שנוצר על ידי פקודה זו מכיל את כל מה שצריך כדי ש-PowershAI יוכל לשלוט במנגנון ולקבל את הנתונים.  
	חשוב שאתה מכיר את המבנה שלו כדי לדעת כיצד לאסוף את הנתונים שנוצרו על ידי ה-API.
	מאפיינים:
	
		- Status  
		מצביע על מצב האירוע. 
		כאשר מצב זה הוא "complete", זה אומר שה-API כבר סיים את העיבוד וכל הנתונים האפשריים כבר נוצרו.  
		בעוד שזה שונה מזה, עליך להפעיל את Update-GradioApiResult כדי שהוא יבדוק את המצב ויעדכן את המידע. 
		
		- QueryUrl  
		ערך פנימי שמכיל את נקודת הקצה המדויקת לבדיקת התוצאות
		
		- data  
		מערך המכיל את כל נתוני התגובה שנוצרו. כל פעם שאתה מפעיל את Update-GradioApiResult, אם יש נתונים, הוא יוסיף למערך זה.  
		
		- events  
		רשימת אירועים שנוצרו על ידי השרת. 
		
		- error  
		אם היו שגיאות בתגובה, שדה זה יכיל אובייקט כלשהו, מיתר וכו', המתארים פרטים נוספים.
		
		- LastQueryStatus  
		מצביע על מצב הבדיקה האחרונה ב-API.  
		אם "נורמלי", זה מצביע על כך שה-API נבדק והחזיר עד הסוף בצורה רגילה.
		אם "HeartBeatExpired", זה מצביע על כך שהבדיקה הופסקה בגלל זמני ההמתנה של ה-heartbeat שהוגדרו על ידי המשתמש בפקודה Update-GradioApiResult
		
		- req 
		נתוני הבקשה שבוצעה!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] 
[[-token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

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

### -ApiName

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

### -Params

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

### -SessionHash

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -EventId
אם צויין, לא נקראת ה-API, אלא נוצר האובייקט ומשתמשים בערך זה כאילו היה החזרה

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

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
