---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
פונקציית עזר להמרת קובץ .ps1 לפורמט סכימה צפוי על ידי OpenAI.
בפשטות, מה שהפונקציה הזו עושה הוא לקרוא קובץ .ps1 (או מחרוזת) יחד עם תיעוד העזרה שלו.  
לאחר מכן, היא מחזירה אובייקט בפורמט שצוין על ידי OpenAI כדי שהמודל יוכל לקרוא אותו!

מחזירה hashtable המכילה את המפתחות הבאים:
	functions - רשימת פונקציות, עם הקוד שלהן שנלקח מהקובץ.  
				כאשר המודל יקרא, תוכלו להריץ ישירות מכאן.
				
	tools - רשימת כלים, לשליחה בקריאת OpenAI.
	
ניתן לתעד את הפונקציות ואת הפרמטרים שלהן באמצעות עזרה מבוססת הערות של PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

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




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
