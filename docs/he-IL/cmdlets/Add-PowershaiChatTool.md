---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
מוסיפה פונקציות, סקריפטים, קבצי ביצוע ככלי שניתן להפעיל על ידי LLM בצ'אט הנוכחי (או כברירת מחדל עבור כולם).

## DESCRIPTION <!--!= @#Desc !-->
מוסיפה פונקציות בסשן הנוכחי לרשימת הכלים המותרים להפעלה!
כאשר מוסיפים פקודה, היא נשלחת למודל הנוכחי כאפשרות להפעלת כלים.
העזרה הזמינה של הפונקציה תשתמש להסביר אותה, כולל פרמטרים.
בכך, ניתן, בזמן ריצה, להוסיף יכולות חדשות ל-AI שניתן להפעיל על ידי LLM ולהריץ על ידי PowershAI.

בעת הוספת סקריפטים, כל הפונקציות בתוך הסקריפט מוספות בבת אחת.

למידע נוסף על כלים, עיין בנושא about_Powershai_Chats

חשוב מאוד:
לעולם אל תוסיף פקודות שאינך מכיר או שיכולות לפגוע במחשב שלך.
POWERSHELL יפעיל אותן לפי בקשת ה-LLM ועם הפרמטרים ש-LLM יפעיל, וגם עם אישורי המשתמש הנוכחי.
אם אתה מחובר עם חשבון מנהלי, שים לב שתוכל להפעיל כל פעולה לפי בקשת שרת מרוחק (ה-LLM).

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
שם הפקודה, נתיב הסקריפט או קובץ ההפעלה
יכול להיות מערך מחרוזות עם אלמנטים אלה מעורבים.
כאשר שם שמסתיים ב- .ps1 עובר, הוא מטופל כסקריפט (כלומר, ייטענו הפונקציות מהסקריפט)
אם ברצונך לטפל בו כפקודה (להריץ את הסקריפט), ספק את הפרמטר -Command, כדי לכפות עליו להיות מטופל כפקודה!

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

### -description
תיאור עבור כלי זה שיישלח ל-LLM.
הפקודה תשתמש בעזרה ותשלח גם את התוכן המתואר
אם פרמטר זה נוסף, הוא נשלח יחד עם העזרה.

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

### -ForceCommand
כופה טיפול כפקודה. שימושי כאשר אתה רוצה שסקריפט יופעל כפקודה.
שימושי רק כאשר אתה מעביר שם קובץ דו-משמעי, שתואם לשם של פקודה כלשהי!

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

### -ChatId
צ'אט שבו ליצור את הכלי

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
יוצר את הכלי באופן גלובלי, כלומר, הוא יהיה זמין בכל הצ'אטים

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
