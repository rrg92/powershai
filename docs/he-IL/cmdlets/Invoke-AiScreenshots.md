---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
לוקח צילומי מסך מהמסך ושולח למודל הפעיל.
פקודה זו היא ניסיונית ועשויה להשתנות או לא להיות זמינה בגרסאות הבאות!

## DESCRIPTION <!--!= @#Desc !-->
פקודה זו מאפשרת, בלולאה, לקבל צילומי מסך מהמסך!

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
הפנייה הסטנדרטית שיש להשתמש בה עם התמונה שנשלחה!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: הסבר את התמונה הזו
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
נשאר בלולאה לוקח מספר צילומי מסך
כברירת מחדל, מצב ידני בשימוש, שבו אתה צריך ללחוץ על מקש כדי להמשיך.
המפתחות הבאים יש להם פונקציות מיוחדות:
	c - מנקה את המסך 
 ctrl + c - מסיים את הפקודה

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

### -AutoMs
אם מצוין, מפעיל את מצב החזרה האוטומטית, שבו כל מספר של ms מצוין, הוא ישלח למסך.
שימו לב: במצב האוטומטי, ייתכן שתראו את החלון מהבהב באופן קבוע, מה שעשוי להיות רע לקריאה.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: $nulls
Accept pipeline input: false
Accept wildcard characters: false
```

### -RecreateChat
מ recreates את הצ'אט שבו השתמשו!

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
