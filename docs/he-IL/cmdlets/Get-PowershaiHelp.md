---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
משתמש בספק הנוכחי כדי לעזור לך לקבל עזרה לגבי powershai!

## DESCRIPTION <!--!= @#Desc !-->
ה-cmdlet הזה משתמש בפקודות של PowershAI עצמו כדי לעזור למשתמש לקבל עזרה לגביו.  
בפשטות, בהתבסס על שאלת המשתמש, הוא יוצר בקשה עם כמה מידע נפוץ וhelps בסיסיים.  
ואז, זה נשלח ל-LLM בצ'אט.

בגלל נפח הנתונים הגדול שנשלח, מומלץ להשתמש בפקודה הזו רק עם ספקים ו-modeos שמקבלים יותר מ-128k וזולים.  
נכון לעכשיו, פקודה זו היא ניסויית ופועלת רק עם מודלים אלה:
	- Openai gpt-4*
	
בפנים, הוא ייצור Powershai Chat שנקרא "_pwshai_help", שם הוא ישמור את כל ההיסטוריה!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
תאר את טקסט העזרה!

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

### -command
אם אתה רוצה עזרה לגבי פקודה ספציפית, ציין את הפקודה כאן 
לא חייב להיות רק פקודה של PowershaiChat.

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

### -Recreate
יוצר מחדש את הצ'אט!

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
