---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
מרשימת את המודלים הזמינים בספק הנוכחי

## DESCRIPTION <!--!= @#Desc !-->
פקודה זו מפרטת את כל ה-LLM שניתן להשתמש בהם עם ספק השירות הנוכחי לשימוש ב-PowershaiChat.  
פונקציה זו תלויה בכך שהספק ישתמש בפונקציה GetModels.

האובייקט המוחזר משתנה בהתאם לספק, אך, כל ספק צריך להחזיר מערך של אובייקטים, שכל אחד מהם צריך להכיל, לפחות, את המאפיין id, שצריך להיות מחרוזת המשמשת לזיהוי המודל בפקודות אחרות התלויות במודל.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
