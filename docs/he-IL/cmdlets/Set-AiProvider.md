---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
משנה את הספק הנוכחי

## DESCRIPTION <!--!= @#Desc !-->
ספקים הם סקריפטים המיישמים גישה ל-APIs שלהם.
לכל ספק יש את הדרך שלו להפעלת APIs, תבנית נתונים, סכימה של תשובה וכו'.

כשאתה משנה את הספק, אתה משפיע על פקודות מסוימות הפועלות בספק הנוכחי, כמו `Get-AiChat`, `Get-AiModels`, או הצ'אטים, כמו Send-PowershaAIChat.
לפרטים נוספים על הספקים עיין בנושא about_Powershai_Providers

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
שם הספק

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
