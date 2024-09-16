---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
יצוא הגדרות המושב הנוכחי לקובץ, מוצפן באמצעות סיסמא

## DESCRIPTION <!--!= @#Desc !-->
ה-cmdlet הזה שימושי לשמירת הגדרות, כמו אסימונים, באופן מאובטח.  
הוא מבקש סיסמא ומתשתמש בה כדי ליצור ערך גיבוב ולהצפין את נתוני ההגדרות של המושב ב-AES256.  

ההגדרות שיוצאו הן כל אלה שהוגדרו במשתנה $POWERSHAI_SETTINGS.  
משתנה זה הוא טבלת גיבוב המכילה את כל הנתונים שהוגדרו על ידי ספקי שירות, כולל אסימונים.  

כברירת מחדל, צ'אטים לא יוצאים בגלל כמות הנתונים המעורבת, מה שעלול להוביל לקובץ גדול מאוד!

הקובץ שיוצא נשמר בספריה שנוצרת אוטומטית, כברירת מחדל, בתיקיית הבית של המשתמש ($HOME).  
הפריטים יוצאים באמצעות סריאליזציה, שהיא אותה שיטה שמשתמשת Export-CliXml.  

הנתונים יוצאים בפורמט ייחודי שניתן לייבא רק עם Import-PowershaiSettings תוך ציון אותה סיסמא.  

מאחר ש-PowershAI לא מבצע יצוא אוטומטי, מומלץ להפעיל פקודה זו בכל פעם שיש שינוי בהגדרות, כמו הוספת אסימונים חדשים.  

ספריית היצוא יכולה להיות כל נתיב תקף, כולל כונני ענן כמו OneDrive, Dropbox וכו'.  

פקודה זו נוצרה במטרה להיות אינטראקטיבית, כלומר היא דורשת קלט מהמשתמש במקלדת.

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### יצוא הגדרות ברירת מחדל!
```powershell
Export-PowershaiSettings
```

### יצוא הכל, כולל צ'אטים!
```powershell
Export-PowershaiSettings -Chat
```

### יצוא ל-OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
ספריית יצוא
כברירת מחדל, זו ספריה בשם .powershai בפרופיל המשתמש, אך ניתן לציין את משתנה הסביבה POWERSHAI_EXPORT_DIR כדי לשנות.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -Chats
אם צוין, כולל את הצ'אטים ביצוא
כל הצ'אטים יוצאו

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
