---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiCommand

## SYNOPSIS <!--!= @#Synop !-->
מאפשר להפעיל את רוב הפונקציות בצורה קומפקטית

## DESCRIPTION <!--!= @#Desc !-->
זהו כלי פשוט שמאפשר להפעיל פונקציות שונות בצורה מצומצמת יותר בשורת הפקודה.  
שימו לב שעדיין לא כל הפקודות נתמכות.

מומלץ להשתמש בו יחד עם pshai.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiCommand [[-CommandName] <Object>] [[-RemArgs] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
pshai tools # מפרט את הכלים
```


## PARAMETERS <!--!= @#Params !-->

### -CommandName
שם הפקודה

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

### -RemArgs

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



<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
