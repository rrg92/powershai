---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
מגדיר איזו פונקציה תשמש לעיצוב אובייקטים שמועברים לפאראמטר Send-PowershaiChat -Context

## DESCRIPTION <!--!= @#Desc !-->
בעת שימוש ב-Send-PowershaiChat בצינור, או בעת העברת פאראמטר -Context ישירות, הוא יזריק אובייקט זה לשורת הפקודה של ה-LLM.  
לפני ההזרקה, עליו להמיר את האובייקט הזה למחרוזת.  
המרה זו נקראת "Context Formatter" כאן ב-Powershai.  
ה-Context Formatter היא פונקציה שתיקח כל אובייקט שעובר ותמיר אותו למחרוזת שתוזרק לשורת הפקודה.
הפונקציה שתשמש צריכה לקבל כפאראמטר הראשון את האובייקט שיש להמיר.  

פאראמטרים נוספים הם לפי שיקול דעת. ניתן לציין את הערכים שלהם באמצעות פאראמטר -Params של פונקציה זו!

powershai מציע Context Formatters מקומיים.  
השתמש ב-Get-Command ConvertTo-PowershaiContext* או ב-Get-PowershaiContextFormatters כדי לקבל את הרשימה!

בהתחשב בכך ש-Context Formatters מקומיים הם רק פונקציות powershell, ניתן להשתמש ב-Get-Help שם, כדי לקבל מידע נוסף.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

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

### -Func
שם הפונקציה powershell
השתמש בפקודה Get-PowershaiContextFormatters כדי לראות את הרשימה

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Str
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
