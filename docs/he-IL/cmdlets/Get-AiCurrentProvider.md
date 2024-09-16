---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
מקבל את ספק הפעיל

## DESCRIPTION <!--!= @#Desc !-->
מחזיר את האובייקט שמתאר את ספק הפעיל.  
ספקים מיושמים כאובייקטים ומאוחסנים בזיכרון של המושב, במשתנה גלובלי.  
פונקציה זו מחזירה את ספק הפעיל, שהוגדר באמצעות הפקודה Set-AiProvider.

האובייקט המוחזר הוא hashtable המכיל את כל השדות של הספק.  
פקודה זו משמשת בדרך כלל על ידי ספקים לקבלת שם הספק הפעיל.  

הפרמטר -ContextProvider מחזיר את ספק ההקשר הנוכחי שבו פועל התסריט.  
אם פועל בתסריט של ספק, הוא יחזיר את הספק הזה, במקום הספק שהוגדר באמצעות Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
אם מופעל, משתמש בספק ההקשר, כלומר, אם הקוד פועל בקובץ בספריה של ספק, מניח ספק זה.
במקרה אחר, מקבל את הספק שמופעל כרגע.

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
