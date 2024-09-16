---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
מחזיר את רשימת הפרמטרים הזמינים בצ'אט

## DESCRIPTION <!--!= @#Desc !-->
פקודה זו מחזירה אובייקט המכיל את רשימת המאפיינים.  
האובייקט הוא למעשה מערך, כאשר כל רכיב מייצג מאפיין.  

המערך המוחזר כולל כמה שינויים כדי להקל על הגישה לפרמטרים. 
ניתן לגשת לפרמטרים באמצעות האובייקט המוחזר ישירות, ללא צורך לסנן את רשימת הפרמטרים.
זה שימושי כאשר רוצים לגשת לפרמטר ספציפי מהרשימה.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatParameter [[-ChatId] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
$MyParams = Get-PowershaiChatParameter
```


## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
