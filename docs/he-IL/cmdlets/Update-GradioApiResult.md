---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioApiResult

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
מעדכן אירוע שהוחזר על ידי Send-GradioApi עם תוצאות חדשות מהשרת ובברירת מחדל מחזיר את האירועים ב-pipeline.

תוצאות ה-APIs של Gradio לא נוצרות מיד, כמו ברוב שירותי HTTP REST.  
עזרת הפקודה Send-GradioApi מסבירה בפירוט כיצד התהליך מתנהל.  

הפקודה הזו צריכה להיעשות כדי לעדכן את האובייקט GradioApiEvent, שהוחזר על ידי Send-GradioApi.  
אובייקט זה מייצג את התגובה לכל קריאה שהייתה לך ב-API, הוא מכיל את כל מה שצריך כדי לבדוק את התוצאה, כולל נתונים והיסטוריה.

בעיקרון, cmdlet זה פועל על ידי קריאה ל-endpoint של בדיקת מצב הקריאה של ה-API.  
הפרמטרים הדרושים לבדיקה זמינים באובייקט עצמו שנשלח בפרמטר -ApiEvent (שנוצר והוחזר על ידי cmdlet Send-GradioApi).

בכל פעם שה-cmdlet הזה מתבצע, הוא מתקשר באמצעות חיבור HTTP מתמשך עם השרת וממתין לאירועים.  
כשהשרת שולח את הנתונים, הוא מעדכן את האובייקט שנשלח בפרמטר -ApiEvent, ובברירת מחדל, כותב את האירוע שהוחזר ב-pipeline.

האירוע שהוחזר הוא אובייקט מסוג GradioApiEventResult, ומייצג אירוע שנוצר על ידי התגובה לביצוע ה-API.  

אם הפרמטר -History מוגדר, כל האירועים שנוצרו נשמרים בנכס events של האובייקט שניתן ב- -ApiEvent, כמו גם הנתונים שהוחזרו.

OBJETO GradioApiEventResult
	num 	= מספר סידורי של האירוע. מתחיל ב-1.
	ts 		= תאריך בו נוצר האירוע (תאריך מקומי, לא מהשרת).
	event 	= שם האירוע
	data 	= נתונים שהוחזרו באירוע זה

DADOS (DATA)

	כדי לקבל את הנתונים מ-Gradio, זה בעיקרון לקרוא את האירועים שהוחזרו על ידי cmdlet זה ולהסתכל בנכס data של GradioApiEventResult.  
	באופן כללי, ממשק ה-Gradio כותב מחדש את השדה עם האירוע האחרון שהתקבל.  
	
	אם -History משמש, בנוסף לכתיבה ב-pipeline, ה-cmdlet ישמור את הנתון בשדה data, ולכן, תהיה לך גישה להיסטוריה המלאה של מה שנוצר על ידי השרת.  
	שים לב שזה עשוי לגרום לצריכת זיכרון נוספת, אם יחזרו הרבה נתונים.
	
	יש מקרה "בעייתי" ידוע: לפעמים, ה-Gradio עשוי לשדר את 2 האירועים האחרונים עם אותם נתונים (1 אירוע יהיה בשם "generating", והאחרון יהיה complete).  
	עדיין אין לנו פתרון כדי להפריד זאת בצורה בטוחה, ולכן, המשתמש צריך להחליט על הדרך הטובה ביותר לנהל זאת.  
	אם אתה תמיד משתמש באירוע האחרון שהתקבל, זה לא בעיה.
	אם תצטרך להשתמש בכל האירועים ככל שהם מתוצרים, תצטרך לטפל במקרים הללו.  
	דוגמה פשוטה תהיה להשוות את התוכן, אם הם זהים, לא לחזור עליו. אבל עשויים להיות תרחישים שבהם 2 אירועים עם אותו תוכן, עדיין יהיו אירועים שונים לוגית.
	
	

HEARTBEAT 

	אחד מהאירועים שנוצרים על ידי ה-API של Gradio הם ה-Heartbeats.  
	כל 15 שניות, ה-Gradio שולח אירוע מסוג "HeartBeat", רק כדי לשמור על החיבור פעיל.  
	זה גורם לכך שה-cmdlet "נחסם", כי, מכיוון שהחיבור HTTP פעיל, הוא מחכה לתגובה כלשהי (שתהיה נתונים, שגיאות או ה-heartbeat).
	
	אם לא יהיה מנגנון לשליטה בזה, ה-cmdlet ירוץ לנצח, בלי אפשרות לבטל אפילו עם CTRL + C.
	כדי לפתור זאת, cmdlet זה מספק את הפרמטר MaxHeartBeats.  
	פרמטר זה מציין כמה אירועי Heartbeat עוקבים יתקבלו לפני שה-cmdlet יפסיק לנסות לבדוק את ה-API.  
	
	לדוגמה, שקול את שני התרחישים של האירועים שנשלחו על ידי השרת:
	
		תרחיש 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		תרחיש 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	בהנחה שהערך ברירת המחדל הוא 2, בתרחיש 1, ה-cmdlet לא יסיים לפני ה-complete, כי פשוט לא היו 2 heartbeats עוקבים.
	
	בתרחיש 2, לאחר קבלת 2 אירועי נתונים (generating), באירוע הרביעי (heartbeat), הוא יסיים, כי 2 heartbeats עוקבים נשלחו.  
	אנחנו אומרים שה-heartbeat פג, במקרה זה.
	במקרה זה, עליך לקרוא שוב ל-Update-GradioApiResult כדי לקבל את השאר.
	
בכל פעם שהפקודה מסתיימת בגלל שה-heartbeat פג, היא תעדכן את ערך הנכס LastQueryStatus ל-HeartBeatExpired.  
כך, תוכל לבדוק ולטפל כראוי מתי עליך לקרוא שוב.
	
	
STREAM  
	
	בגלל העובדה שה-API של Gradio כבר עונה באמצעות SSE (Server Side Events), אפשר להשתמש באפקט דומה ל-"stream" של הרבה APIs.  
	cmdlet זה, Update-GradioApiResult, כבר מעבד את האירועים מהשרת באמצעות ה-SSE.  
	בנוסף, אם אתה גם רוצה לבצע עיבוד כשאירוע זמין, תוכל להשתמש בפרמטר -Script ולציין scriptblock, פונקציות וכו', שיתבצעו ברגע שהאירוע מתקבל.  
	
	בשילוב עם הפרמטר -MaxHeartBeats, תוכל ליצור קריאה שמעבירה משהו בזמן אמת.  
	לדוגמה, אם זו תגובה מצ'אט בוט, היא יכולה להיכתב מיד על המסך.
	
	שים לב שהפרמטר הזה נקרא ברצף עם הקוד שבודק (כלומר, באותה Thread).  
	לכן, סקריפטים שלוקחים הרבה זמן עשויים להפריע לזיהוי אירועים חדשים, ובConsequently, למסירת הנתונים.
	
.

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiEvent
תוצאה של Send-GradioApi

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Script
סקריפט שיתבצע בכל אירוע שנוצר!
מקבל hashtable עם המפתחות הבאים:
 	event - מכיל את האירוע שנוצר. event.event הוא שם האירוע. event.data הם הנתונים שהוחזרו.

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

### -MaxHeartBeats
מספר ה-heartbeats המקסימלי העוקבים עד לעצירה!
גורם לכך שהפקודה תמתין רק למספר זה של heartbeats עוקבים מהשרת.
כאשר השרת שולח כמות זו, ה-cmdlet מסתיים ומגדיר את LastQueryStatus של האירוע ל-HeartBeatExpired

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

### -NoOutput
לא כותב את התוצאה לפלט של ה-cmdlet

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

### -History
שומר את היסטוריית האירועים והנתונים באובייקט ApiEvent
שים לב שזה יגרום לצריכת זיכרון נוספת מה-PowerShell!

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
