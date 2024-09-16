---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
הסר כלי סופית!

## SYNTAX <!--!= @#Syntax !-->

```
Remove-PowershaiChatTool [[-tool] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
שם הפקודה, התסריט, הפונקציות שהוכנסו בעבר ככלי.
אם זה קובץ .ps1, מתייחס אליו כתסריט, אלא אם כן -Force command נמצא בשימוש.
אתה יכול להשתמש בתוצאה של Get-PowershaiChatTool באמצעות צינור לפקודה זו, שתוכל לזהות אותו
בעת שליחת האובייקט המוחזר, כל שאר הפרמטרים מתעלמים.

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

### -ForceCommand
אילץ להתייחס לכלי כפקודה, כאשר זו מחרוזת

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
צ'אט להסרה ממנו

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -global
הסר מרשימת הכללי, אם הכלי נוסף בעבר ככללי

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
