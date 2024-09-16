---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
שולח נתונים ל-Gradio ומחזיר אובייקט שייצג את האירוע!
העבר אובייקט זה ל-cmdlets אחרים כדי לקבל את התוצאות.

כיצד API של Gradio פועלת

	מבוסס על: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	כדי להבין טוב יותר כיצד להשתמש ב-cmdlet זה, חשוב להבין כיצד API של Gradio פועלת.  
	כאשר אנו קוראים נקודת קצה כלשהי של API, היא לא מחזירה את הנתונים באופן מיידי.  
	זאת בשל העובדה הפשוטה כי העיבוד הוא נרחב, בשל אופיו (בינה מלאכותית ולמידת מכונה).  
	
	לכן, במקום להחזיר את התוצאה, או להמתין לנצח, Gradio מחזירה "Event Id".  
	עם אירוע זה, נוכל לקבל באופן תקופתי את התוצאות שהופקו.  
	Gradio ייצור הודעות אירועים עם הנתונים שנוצרו. עלינו להעביר את EventId שנוצר כדי לקבל את החלקים החדשים שנוצרו.
	אירועים אלה נשלחים באמצעות Server Side Events (SSE), ויכולים להיות אחד מהבאים:
		- hearbeat 
		כל 15 שניות, Gradio ישלח אירוע זה כדי לשמור על החיבור פעיל.  
		לכן, בעת שימוש ב-cmdlet Update-GradioApiResult, הוא עשוי להימשך זמן מה עד שיחזור.
		
		- complete 
		היא ההודעה האחרונה שנשלחה על ידי Gradio כאשר הנתונים נוצרו בהצלחה!
		
		- error 
		נשלח כאשר הייתה שגיאה בעיבוד.  
		
		- generating
		נוצר כאשר ל-API כבר יש נתונים זמינים, אך, עדיין עשויים להגיע נתונים נוספים.
	
	כאן, ב-PowershAI, אנו מפרידים זאת לשלושה חלקים גם: 
		- cmdlet זה (Send-GradioApi) מבצע את בקשת ההתחלה ל-Gradio ומחזיר אובייקט שייצג את האירוע (נקרא לו אובייקט GradioApiEvent)
		- אובייקט התוצאה המתקבל, מסוג GradioApiEvent, מכיל את כל מה שצריך כדי לשאול את האירוע והוא גם שומר את הנתונים והשגיאות שהתקבלו.
		- לבסוף, יש לנו את cmdlet Update-GradioApiResult, שבו עליכם להעביר את האירוע שנוצר, והוא ישאל את API של Gradio ויקבל את הנתונים החדשים.  
			בדוק את העזרה של cmdlet זה למידע נוסף על אופן השליטה במנגנון זה לקבלת הנתונים.
			
	
	אז, בזרם רגיל, עליכם לעשות את הדברים הבאים: 
	
		#INvoque נקודת הקצה של graido!
		$MeuEvento = SEnd-GradioApi ... 
	
		# קבל תוצאות עד שתסתיים!
		# בדוק את העזרה של cmdlet זה כדי ללמוד עוד!
		$MeuEvento | Update-GradioApiResult
		
אובייקט GradioApiEvent

	אובייקט GradioApiEvent המתקבל מ-cmdlet זה מכיל את כל מה שצריך כדי ש-PowershAI ישלוט במנגנון ויקבל את הנתונים.  
	חשוב שתכירו את המבנה שלו כדי שתדעו כיצד לאסוף את הנתונים שנוצרו על ידי API.
	מאפיינים:
	
		- Status  
		מציין את מצב האירוע. 
		כאשר מצב זה הוא "complete", פירוש הדבר ש-API סיימה את העיבוד וכל הנתונים האפשריים כבר נוצרו.  
		עד שיהיה שונה מכך, עליכם להפעיל Update-GradioApiResult כדי שיבדוק את המצב ויעדכן את המידע. 
		
		- QueryUrl  
		ערך פנימי המכיל את נקודת הקצה המדויקת לשאילתת התוצאות
		
		- data  
		מערך המכיל את כל נתוני התגובה שנוצרו. בכל פעם שאתה מפעיל Update-GradioApiResult, אם יהיו נתונים, הוא יוסיף למערך זה.  
		
		- events  
		רשימת אירועים שנוצרו על ידי השרת. 
		
		- error  
		אם היו שגיאות בתגובה, שדה זה יכיל אובייקט כלשהו, מחרוזת, וכו ', המתאר פרטים נוספים.
		
		- LastQueryStatus  
		מציין את מצב השאילתה האחרונה ב-API.  
		אם "normal", מציין כי API נשאלה והחזירה עד הסוף כרגיל.
		אם "HeartBeatExpired", מציין שהשאילתה הופסקה בשל זמן קצוב של hearbeat שהוגדר על ידי המשתמש ב-cmdlet Update-GradioApiResult
		
		- req 
		נתוני הבקשה שבוצעה!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] [[-token] <Object>] [<CommonParameters>]
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
אם סופק, לא קורא ל-API, אלא יוצר את האובייקט ומשתמש בערך זה כאילו הוא התשובה

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
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
