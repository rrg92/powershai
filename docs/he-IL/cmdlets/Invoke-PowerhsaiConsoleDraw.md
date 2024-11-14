---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
יוצר מסגרת טקסט וכתוב תווים בתוך גבולות המסגרת הזו

## DESCRIPTION <!--!= @#Desc !-->
יוצר מסגרת ציור בקונסול, שמתעדכנת רק באזור ספציפי!
אתה יכול לשלוח מספר שורות טקסט והפונקציה תדאג לשמור על הציור באותה מסגרת, נותנת את הרושם שרק אזור אחד מתעדכן.
להשגת האפקט הרצוי, יש לקרוא לפונקציה זו שוב ושוב, ללא כתיבות אחרות בין הקריאות!

פונקציה זו צריכה לשמש רק במצב אינטראקטיבי של פאוורשל, רצה בחלון קונסול.
היא שימושית במצבים שבהם אתה רוצה לראות את ההתקדמות של תוצאה במחרוזת בדיוק באותו אזור, ובכך להשוות טוב יותר שינויים.
זו רק פונקציה עזר.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
הדוגמה הבאה כותבת 3 מחרוזות טקסט כל 2 שניות.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
טקסט שיכתב. יכול להיות מערך. אם יחרוג מגבולות ה-W וה-H, ייחתך 
אם זו בלוק סקריפט, קורא לקוד מעביר את האובייקט של הפייפליין!

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
מקסימום תווים בכל שורה

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
מקסימום שורות

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
תו שמשמש כחלל ריק

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
אובייקט מהפייפליין

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
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
