---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
מחק קריאות מה רשימה פנימית של הסשן

## DESCRIPTION <!--!= @#Desc !-->
פקודה זו מסייעת במחיקת אירועים שנוצרו על ידי Invoke-GradioSessionApi מה רשימה פנימית של קריאות. 
בדרך כלל, תרצה למחוק את האירועים שכבר עיבדת, על ידי העברת ה-id ישירות.  
אבל, פקודה זו מאפשרת לבצע סוגים שונים של מחיקות, כולל אירועים שלא עובדו.  
השתמש בזה בזהירות, כי לאחר שאירוע נמחק מה רשימה, הנתונים הקשורים אליו גם נמחקים.  
אלא אם כן יצרת עותק של האירוע (או של הנתונים המתקבלים) למשתנה אחר, לא תוכל יותר לשחזר את המידע הזה.  

מחיקת אירועים גם מועילה כדי לעזור לשחרר את הזיכרון שנצרך, אשר, בהתאם לכמות האירועים והנתונים, יכולה להיות גבוהה.

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
מפרט את האירוע, או האירועים, שיש למחוק
Id יכול להיות גם אחד מהערכים המיוחדים הללו:
	clean 	- מוחק רק את הקריאות שכבר הושלמו!
  all 	- מוחק הכל, כולל את אלו שלא הושלמו!

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

### -Force
ברירת מחדל, רק האירועים שהועברו עם מצב "הושלם" נמחקים!
השתמש ב -Force כדי למחוק ללא תלות במצב!

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

### -Elegible
לא מבצע שום מחיקה, אבל מחזיר את המועמדים!

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

### -session
Id של הסשן

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -WhatIf

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: wi
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Confirm

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: cf
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
