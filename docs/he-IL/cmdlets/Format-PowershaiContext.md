---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
מעצב אובייקט כדי להזריק אותו להקשר של הודעה שנשלחה בצ'אט של Powershai

## DESCRIPTION <!--!= @#Desc !-->
בהתחשב בכך ש-LLM מעבדים רק מחרוזות, אובייקטים שעוברים בהקשר צריכים להיות מומרים לפורמט מחרוזות, לפני שהם מוזרקים להנחיה.
וכיוון שיש ייצוגים מרובים של אובייקט במחרוזות, Powershai מאפשר למשתמשים שליטה מלאה על כך.

בכל פעם שאובייקט צריך להיות מוזרק להנחיה, כאשר קוראים לו באמצעות Send-PowershaAIChat, דרך ppipeline או פרמטר הקשר, cmdlet זה ייקרא.
cmdlet זה אחראי להפיכת אובייקט זה למחרוזת, ללא קשר לאובייקט, בין אם זה מערך, טבלת האש, מותאם אישית, וכו'.

הוא עושה זאת על ידי קריאה לפונקציית המאלץ שהוגדרה באמצעות Set-PowershaiChatContextFormatter
בדרך כלל, לא תצטרך לקרוא לפונקציה זו ישירות, אך יתכן שתצטרך לקרוא לה כשתרצה לבצע בדיקות!

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
אובייקט כלשהו שיש להזריק

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

### -params
פרמטר שיש להעביר לפונקציית המאלץ

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

### -func
לכתוב מעל לפונקציה שתיקרא. אם לא מוגדר משתמש ברירת המחדל של הצ'אט.

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

### -ChatId
הצ'אט בו לפעול

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
