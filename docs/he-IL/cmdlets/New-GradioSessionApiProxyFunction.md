---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
יוצר פונקציות שעוטפות שיחות לנקודת קצה של Gradio (או לכל נקודות הקצה).
הפקודה הזו שימושית מאוד ליצירת פונקציות Powershell שעוטפות נקודת קצה API של Gradio, כאשר פרמטרי ה-API נוצרים כפרמטרים של הפונקציה.
כך, ניתן להשתמש במשאבים טבעיים של Powershell, כמו השלמה אוטומטית, סוג נתונים ותיעוד,  והופך קל מאוד להפעיל כל נקודת קצה ממערכת.

הפקודה קוראת למטא-נתונים של נקודות הקצה ופרמטרים ויוצר את פונקציות Powershell בהיקף הגלובלי.
כך, המשתמש יכול להפעיל את הפונקציות ישירות, כאילו הן פונקציות רגילות.

לדוגמה, נניח שאפליקציית Gradio בכתובת http://mydemo1.hf.space  יש לה נקודת קצה בשם /GenerateImage ליצירת תמונות עם Stable Diffusion.
נניח שאפליקציה זו מקבלת 2 פרמטרים: Prompt (תיאור התמונה שיש ליצור) ו-Steps (מספר הסטפס הכולל).

בדרך כלל, ניתן להשתמש בפקודה Invoke-GradioSessionApi, כך:

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

זה יפעיל את ה-API, וניתן יהיה לקבל את התוצאות באמצעות Update-GradioApiResult:

$ApiEvent | Update-GradioApiResult

עם הפקודה הזו, ניתן לעטוף את השיחות האלו קצת יותר:

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

הפקודה לעיל תיצור פונקציה בשם Invoke-GradioApiGenerateimage.
אז, ניתן להשתמש בה בצורה פשוטה כדי ליצור את התמונה:

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100

בברירת מחדל, הפקודה תתבצע ותקבל את אירועי התוצאות, ותכתוב אותם בצינור כך שתוכל להשתלב עם פקודות אחרות.
אפילו, חיבור כמה חללים הוא פשוט מאוד, ראה למטה על צינור.

מינוח

	שמות הפונקציות שנוצרו עוקבים אחר הפורמט:  <Prefix><NomeOp>
		<Prefix> הוא ערך הפרמטר -Prefix של הפקודה הזו.
		<NomeOp> הוא שם הפעולה, מתוחזק רק אותיות ומספרים

		לדוגמה, אם הפעולה היא /Op1, והקידומת INvoke-GradioApi, הפונקציה הבאה תיווצר: Invoke-GradioApiOp1


פרמטרים
	הפונקציות שנוצרו כוללות את הלוגיקה הדרושה כדי להמיר את הפרמטרים המועברים ולהפעיל את הפקודה Invoke-GradioSessionApi.
	כלומר, אותה החזרה חלה כאילו הפעלת את הפקודה הזו ישירות. (כלומר, אירוע יוחזר וייתווסף לרשימת האירועים של המערכת הנוכחית).

	פרמטרי הפונקציות עשויים להשתנות בהתאם לנקודת הקצה של ה-API, מכיוון שכל נקודת קצה כוללת קבוצה שונה של פרמטרים וסוגי נתונים.
	פרמטרים שהם קבצים (או רשימה של קבצים), כוללים שלב נוסף של העלאה. ניתן להפנות לקובץ מקומית והעלאתו תתבצע לשרת.
	אם תציין כתובת URL, או אובייקט FileData שתקבל מפקודה אחרת, לא תבוצע העלאה נוספת, רק ייווצר אובייקט FileData תואם לשליחה באמצעות API.

	בנוסף לפרמטרי נקודת הקצה, יש קבוצה נוספת של פרמטרים שתתווסף תמיד לפונקציה שנוצרת.
	הם:
		- Manual
		אם משתמשים בו, גורם לפקודה להחזיר את האירוע שנוצר על ידי INvoke-GradioSessionApi.
		במקרה זה יהיה עליך לקבל באופן ידני את התוצאות באמצעות Update-GradioSessionApiResult

		- ApiResultMap
		ממפה את תוצאות הפקודות האחרות לפרמטרים. ראה עוד בסעיף צינור.

		- DebugData
		למטרות ניפוי באגים על ידי המפתחים.


העלאה
	פרמטרים שמקבלים קבצים מטופלים באופן מיוחד.
	לפני הפעלת ה-API, הפקודה Send-GradioSessionFiles משמשת כדי להעלות את הקבצים הללו לאפליקציה Gradio המתאימה.
	זו עוד יתרון גדול בשימוש בפקודה זו, מכיוון שזה הופך להיות שקוף, והמשתמש לא צריך להתמודד עם העלאות.

צינור
	
	אחת מתכונות Powershell החזקות ביותר היא צינור, one אפשר לחבר פקודות שונות באמצעות |.
	הפקודה הזו גם שואפת למקסם את השימוש במשאב זה.

	ניתן לחבר את כל הפונקציות שנוצרו עם |.
	בעת ביצוע פעולה זו, כל אירוע שנוצר על ידי הפקודה הקודמת מועבר לבא אחריו.

	שקול שני אפליקציות Gradio, App1 ו-App2.
	App1 כוללת את נקודת הקצה Img, עם פרמטר בשם Text, שיוצר תמונות באמצעות Diffusers, ומציג את התמונות חלקיות ככל שהן נוצרות.
	App2 כוללת נקודת קצה Ascii, עם פרמטר בשם Image, שמשנה תמונה לגרסת ASCII בטקסט.

	ניתן לחבר את שתי הפקודות הללו בצורה פשוטה מאוד עם צינור.
	ראשית, צור את המערכות

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator

	צור את הפונקציות
		$App1 | New-GradioSessionApiProxy -Prefix App # זה ייצור את הפונקציה AppImg
		$App2 | New-GradioSessionApiProxy -Prefix App # זה ייצור את הפונקציה AppAscii

	צור את התמונה וחבר אותה למייצר ASCII:

	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data[0]; write-host $_.pipeline[0].data[0].url }

	עכשיו נפרק את הרצף לעיל.

	לפני צינור הראשון, יש לנו את הפקודה שיוצרת את התמונה: AppImg -Text "A car"
	פונקציה זו קוראת לנקודת הקצה /Img של App1. נקודת קצה זו מייצרת פלט לשלב יצירת התמונות באמצעות ספריית Diffusers של hugging face.
	במקרה זה, כל פלט יהיה תמונה (קצת מטושטשת), עד לפלט האחרון שיהיה התמונה הסופית.
	תוצאה זו נמצאת בנכס data של אובייקט הצינור. היא מערך עם התוצאות.

	מיד אחריו בצינור, יש לנו את הפקודה: AppAscii -Map ImageInput=0
	פקודה זו תקבל כל אובייקט שנוצר על ידי הפקודה AppImg, שבמקרה זה, הן התמונות החלקיות של תהליך הדיפוזיה.

	בגלל העובדה שהפקודות עשויות ליצור מערך של פלטים, יש למפות בדיוק אילו מהתוצאות צריכות להיות משויכות לאילו פרמטרים.
	לכן, אנו משתמשים בפרמטר -Map (-Map הוא כינוי, למעשה, השם הנכון הוא ApiResultMap)
	התחביר פשוט: NomeParam=DataIndex,NomeParam=DataIndex
	בפקודה לעיל, אנו אומרים: AppAscii, השתמש בערך הראשון של נכס data בפרמטר ImageInput.
	לדוגמה, אם AppImg יחזיר 4 ערכים, והתמונה תהיה במיקום האחרון, עליך להשתמש ב-ImageInput=3 (0 הוא הראשון).


	לבסוף, צינור אחרון רק מראה את תוצאת AppAscii, שנמצאת כעת באובייקט הצינור, $_, בנכס .data (בדומה לתוצאת AppImg).
	ולשם השלמה, אובייקט הצינור כולל נכס מיוחד, בשם pipeline. באמצעותו, ניתן לגשת לכל התוצאות של הפקודות שנוצרו.
	לדוגמה, $_.pipeline[0], מכיל את תוצאת הפקודה הראשונה (AppImg).

	בזכות מנגנון זה, הופך הרבה יותר קל לחבר אפליקציות Gradio שונות בצנור יחיד.
	שים לב שרצף זה פועל רק בין פקודות שנוצרו על ידי New-GradioSessionApiProxy. ביצוע צינור של פקודות אחרות, לא ייצור את אותה תוצאה (יהיה צורך להשתמש במשהו כמו For-EachObject ולקשר את הפרמטרים ישירות)


מערכות
	כאשר הפונקציה נוצרת, המערכת של מקור נוצרת יחד עם הפונקציה.
	אם המערכת תוסר, הפקודה תיצור שגיאה. במקרה זה, יש ליצור את הפונקציה על ידי הפעלת הפקודה הזו שוב.


התרשים הבא מסכם את התלותיות המעורבות:

	New-GradioSessionApiProxyFunction(Prefix)
		---> function <Prefix><OpName>
			---> Send-GradioSessionFiles (כאשר יש קבצים)
			---> Invoke-GradioSessionApi | Update-GradioSessionApiResult

מכיוון ש-Invoke-GradioSessionApi הוא זה שמבוצע בסופו של דבר, כל הכללים שלו חלים.
ניתן להשתמש ב-Get-GradioSessionApiProxyFunction כדי לקבל רשימה של מה שנוצר ו-Remove-GradioSessionApiProxyFunction כדי להסיר פונקציה אחת או יותר שנוצרו.
הפונקציות נוצרות באמצעות מודול דינמי.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
ליצור רק עבור נקודת קצה ספציפית זו

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -Prefix
קידומת הפונקציות שנוצרו

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Invoke-GradioApi
Accept pipeline input: false
Accept wildcard characters: false
```

### -Session
מערכת

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
מאלץ  יצירת הפונקציה, גם אם כבר קיימת אחת עם אותו שם!

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
