---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
מעדכן את התוצאה של קריאה שנוצרה כ-Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
ה-Cmdlet הזה פועל באותו עיקרון כמו המקבילים שלו ב-Send-GradioApi ו-Update-GradioApiResult.
עם זאת, הוא פועל רק עבור האירועים שנוצרו בסשן ספציפי.
מחזיר את האירוע עצמו כך שניתן יהיה להשתמש בו עם Cmdlets אחרים שתלויים באירוע המעודכן!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
מזהה של האירוע, מוחזר על ידי Invoke-GradioSessionApi או האובייקט עצמו שהוחזר.

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
לא להחזיר את התוצאה חזרה לפלט!

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
מקסימום פעימות לב רצופות.

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
מזהה של הסשן

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
מוסיף את האירועים להיסטוריית האירועים של אובייקט GradioApiEvent שנמסר ב--Id

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
