---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
מעדכן את התוצאה של שיחה שנוצרה כ-Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
cmdlet זה פועל על אותו עיקרון כמו המקבילים שלו ב-Send-GradioApi ו-Update-GradioApiResult.
עם זאת, הוא פועל רק עבור האירועים שנוצרו בסשן ספציפי.
מחזיר את האירוע עצמו כך שניתן יהיה להשתמש בו עם cmdlet אחרים הדורשים את האירוע המעודכן!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
מזהה האירוע, שהוחזר על ידי Invoke-GradioSessionApi או עצם האירוע שהוחזר.

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

### -NoOutput
לא להוציא את התוצאה אל הפלט!

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

### -MaxHeartBeats
הכמות המקסימלית של פעימות לב רצופות.

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

### -session
מזהה הסשן

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

### -History
מוסיף את האירוע להיסטוריית האירועים של עצם GradioApiEvent שהוזן ב-Id

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
