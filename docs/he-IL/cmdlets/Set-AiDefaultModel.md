---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
הגדרת דגם LLM ברירת מחדל עבור ספק שירות זה

## DESCRIPTION <!--!= @#Desc !-->
משתמשים יכולים להגדיר דגם LLM ברירת מחדל, שיישמש כאשר יהיה צורך בדגם LLM.  
פקודות כמו Send-PowershaAIChat, Get-AiChat, מצפות לדגם, ואם לא סיפקתם דגם, הן משתמשות בדגם שהוגדר באמצעות פקודה זו.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
מזהה הדגם, כפי שמופיע ב-Get-AiModels
אתה יכול להשתמש בכרטיסייה כדי להשלים את שורת הפקודה.

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

### -Force
אילוץ הגדרת הדגם, גם אם הוא לא מוחזר ב-Get-AiModels

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
