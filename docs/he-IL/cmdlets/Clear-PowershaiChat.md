---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Clear-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
מחק אלמנטים מצ'אט!

## DESCRIPTION <!--!= @#Desc !-->
מחק אלמנטים ספציפיים מצ'אט.  
שימושי כדי לשחרר משאבים, או להסיר את ההתמכרות של llm עקב ההיסטוריה.

## SYNTAX <!--!= @#Syntax !-->

```
Clear-PowershaiChat [-History] [-Context] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -History
מחק את כל ההיסטוריה

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

### -Context
מחק את ההקשר 
מזהה של צ'אט. ברירת מחדל: פעיל.

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
