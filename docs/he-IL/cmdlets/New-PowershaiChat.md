---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
יוצר צ'אט PowershaAI חדש.

## DESCRIPTION <!--!= @#Desc !-->
PowershaAI  מביא איתו מושג של "צ'אטים", דומים לצ'אטים שאתם רואים ב-OpenAI, או ל-"threads" של ה-API של Assistants.  
כל צ'אט שנוצר מקבל סט פרמטרים, הקשר והיסטוריה משלו.  
כאשר אתם משתמשים ב-cmdlet Send-PowershaiChat (כינוי ia), הוא שולח הודעות למודל, וההיסטוריה של השיחה הזו עם המודל נשמרת בצ'אט שנוצר כאן על ידי PowershAI.  
כלומר, כל ההיסטוריה של השיחה שלכם עם המודל נשמרת כאן בסשן של PowershAI, ולא שם במודל או ב-API.  
כך PowershAI שומר על כל השליטה במה לשלוח ל-LLM ולא תלוי במנגנונים שונים של APIs שונים מספקים כדי לנהל את ההיסטוריה. 


כל צ'אט כולל סט פרמטרים שבשינוי שלהם ישפיעו רק על אותו צ'אט.  
פרמטרים מסוימים של PowershAI הם גלובליים, כמו למשל, הספק המשמש. שינוי הספק גורם לצ'אט להתחיל להשתמש בספק החדש, אך שומר על אותה היסטוריה.  
זה מאפשר לכם לנהל שיחות עם מודלים שונים, תוך כדי שמירה על אותה היסטוריה.  

בנוסף לפרמטרים אלו, כל צ'אט כולל היסטוריה.  
ההיסטוריה כוללת את כל השיחות והאינטראקציות שנעשו עם המודלים, ושומרת על התגובות שהוחזרו על ידי APIs.

לצ'אט גם יש הקשר, שהוא לא יותר מכל ההודעות ששלחתם.  
בכל פעם ששולחים הודעה חדשה בצ'אט, Powershai מוסיף את ההודעה הזו להקשר.  
עם קבלת התגובה מהמודל, התגובה הזו מתווספת להקשר.  
בהודעה הבאה ששלחתם, כל היסטוריית ההודעות מההקשר נשלחת, גורמת למודל, ללא תלות בספק, להחזיק זיכרון של השיחה.  

העובדה שההקשר נשמר כאן בסשן של Powershell מאפשרת תכונות כמו שמירת ההיסטוריה שלכם בדיסק, יישום ספק ייחודי לשמירת ההיסטוריה שלכם בענן, שמירה רק ב-Pc שלכם, וכו'. תכונות עתידיות יכולות ליהנות מזה.

כל הפקודות *-PowershaiChat  מתמקדות בצ'אט הפעיל או בצ'אט שאתם מציינים במפורש בפרמטר (בדרך כלל עם השם -ChatId).  
הצ'אט הפעיל הוא הצ'אט אליו יישלחו ההודעות, אם לא צוין ChatId  (או אם הפקודה אינה מאפשרת לציין צ'אט במפורש).  

קיים צ'אט מיוחד בשם "default" שהוא הצ'אט שנוצר בכל פעם שאתם משתמשים ב-Send-PowershaiChat ללא ציון צ'אט וללא צ'אט פעיל מוגדר.  

אם אתם סוגרים את הסשן של Powershell, כל היסטוריית הצ'אטים הזו אובדת.  
אתם יכולים לשמור בדיסק, באמצעות הפקודה Export-PowershaiSettings. התוכן נשמר מוצפן באמצעות סיסמה שאתם מציינים.

בעת שליחת הודעות, PowershaAI  שומר על מנגנון פנימי שמוחק את הקשר של הצ'אט, כדי למנוע שליחה של יותר מדי מידע.
גודל ההקשר המקומי (כאן בסשן של Powershai, ולא ב-LLM), נשלט על ידי פרמטר (השתמשו ב-Get-PowershaiChatParameter כדי לראות את רשימת הפרמטרים)

שים לב, בשל אופן הפעולה של Powershai, תלוי בכמות המידע שנשלחת וחוזרת, בתוספת ההגדרות של הפרמטרים, אתם עלולים לגרום ל-Powershell שלכם לצרוך זיכרון רב. אתם יכולים לנקות את הקשר וההיסטוריה באופן ידני מהצ'אט באמצעות Reset-PowershaiCurrentChat

לפרטים נוספים עיינו בנושא about_Powershai_Chats,

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
מזהה של הצ'אט. אם לא צוין, ייוצר מזהה לפי ברירת מחדל 
כמה דפוסים של מזהים שמורים לשימוש פנימי. אם אתם משתמשים בהם אתם עלולים לגרום לחוסר יציבות ב-PowershAI.
הערכים הבאים שמורים:
 default 
 _pwshai_*

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

### -IfNotExists
יוצר רק אם לא קיים צ'אט באותו שם

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

### -Recreate
אילוץ יצירת צ'אט מחדש אם כבר נוצר!

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

### -Tools
יוצר צ'אט וכולל את הכלים האלה!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
