---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
יוצר מסגרת טקסט וירטואלית, וכותב תווים בתוך גבולות המסגרת

## DESCRIPTION <!--!= @#Desc !-->
יוצר מסגרת ציור בקונסולה, שעוברת עדכון רק באזור מסוים!
ניתן לשלוח מספר שורות טקסט והפונקציה תדאג לשמור על הציור באותה מסגרת, ותיתן תחושה שרק אזור מסוים מתעדכן.
עבור האפקט הרצוי, פונקציה זו צריכה להיקרא שוב ושוב, ללא כתיבות נוספות בין הקריאות!

פונקציה זו צריכה לשמש רק במצב אינטראקטיבי של PowerShell, הפועל בחלון קונסולה.
היא שימושית לשימוש במצבים שבהם אתה רוצה לראות את התקדמות התוצאה כמחרוזת בדיוק באותו אזור, ואתה יכול להשוות טוב יותר וריאציות.
זו רק פונקציה עזר.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
הדוגמה הבאה כותבת 3 מחרוזות טקסט כל 2 שניות.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
הטקסט שייכתב. יכול להיות מערך. אם יעבור את גבולות W ו-H, ייחתך. 
אם זה קוד בלוק, מפעיל את הקוד בהעברת אובייקט צינור!

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

### -w
הערך המקסימלי של תווים בכל שורה

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
הערך המקסימלי של שורות

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
תו שמשמש כריק

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PipeObj
אובייקט צינור

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
מעביר את האובייקט

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
