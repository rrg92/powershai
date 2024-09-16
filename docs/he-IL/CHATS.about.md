﻿# צ'אטים 


# מבוא <!--! @#Short --> 

PowershAi מגדיר את המושג של צ'אטים, העוזרים ליצור היסטוריה וקונטקסט של שיחות!  

# פרטים  <!--! @#Long --> 

PowershAi יוצר את המושג של צ'אטים, הדומים מאוד למושג של צ'אטים ברוב שירותי ה-LLM.  

צ'אטים מאפשרים לנהל שיחה עם שירותי LLM באופן סטנדרטי, בלי קשר לספק הנוכחי.  
הם מספקים דרך סטנדרטית לתכונות אלו:

- היסטוריית צ'אטים 
- קונטקסט 
- צינור (שימוש בתוצאה של פקודות אחרות)
- קריאה לכלי (ביצוע פקודות לפי בקשת ה-LLM)

לא כל ספק יממש תמיכה בצ'אטים.  
כדי לדעת אם ספק מסוים תומך בצ'אטים, השתמש ב-cmdlet Get-AiProviders ובדוק את המאפיין "Chat". אם הוא $true, אז צ'אטים נתמכים.  
כמו כן, גם אם צ'אטים נתמכים, ייתכן שחלק מהתכונות לא יהיו נתמכות, בשל מגבלות של הספק.  

## התחלת צ'אט חדש 

הדרך הפשוטה ביותר להתחיל צ'אט חדש היא באמצעות הפקודה Send-PowershaiChat.  
ברור שאתה צריך להשתמש בו לאחר קביעת תצורה של הספק (באמצעות `Set-AiProvider`) והגדרות ראשוניות, כגון אימות, אם נדרש.  

```powershell 
Send-PowershaiChat "שלום, אני מדבר איתך מ-Powershai"
```

לשם פשטות, לפקודה `Send-PowershaiChat` יש שם נרדף בשם `ia` (קיצור של אינטליגנציה מלאכותית).  
איתו, אתה מקצר משמעותית ומתמקד יותר בפקודה:

```powershell 
ia "שלום, אני מדבר איתך מ-Powershai"
```

כל הודעה נשלחת בצ'אט.  אם לא תיצור צ'אט באופן ספציפי, יישתמש בצ'אט מיוחד בשם `default`.  
אתה יכול ליצור צ'אט חדש באמצעות `New-PowershaiChat`.  

לכל צ'אט יש היסטוריה משלו של שיחות והגדרות.  
יצירת צ'אטים נוספים עשויה להיות שימושית אם אתה צריך לשמור על יותר משיחה אחת בלי שהן יתערבבו אחת בשנייה!


## פקודות צ'אט  

פקודות שמתמודדות עם צ'אטים באופן כלשהו הן בפורמט `*-Powershai*Chat*`.  
בדרך כלל, פקודות אלו מקבלות פרמטר -ChatId, המאפשר לך לציין את השם או אובייקט הצ'אט שנוצר עם `New-PowershaiChat`.  
אם לא מצוין, הן משתמשות בצ'אט הפעיל.  

## צ'אט פעיל  

צ'אט פעיל הוא הצ'אט ברירת המחדל המשמש את פקודות PowershaiChat.  
כאשר יש רק צ'אט אחד שנוצר, הוא נחשב לצ'אט פעיל.  
אם יש לך יותר מצ'אט אחד פעיל, אתה יכול להשתמש בפקודה `Set-PowershaiActiveChat` כדי לקבוע מי הוא. אתה יכול להעביר את השם או את האובייקט שהוחזר על ידי `New-PowershaiChat`.


## פרמטרים של צ'אט  

לכל צ'אט יש פרמטרים מסוימים השולטים במגוון היבטים.  
לדוגמה, כמות מקסימלית של tokens להחזרה על ידי LLM.  

פרמטרים חדשים עשויים להתווסף בכל גרסה של PowershAI.  
הדרך הפשוטה ביותר לקבל את הפרמטרים ואת מה שהם עושים היא באמצעות הפקודה `Get-PowershaiChatParameter`;  
פקודה זו תביא את רשימת הפרמטרים שניתן להגדיר, יחד עם הערך הנוכחי ותיאור של אופן השימוש בה.  
אתה יכול לשנות את הפרמטרים באמצעות הפקודה `Set-PowershaiChatParameter`.  

חלק מהפרמטרים המפורטים הם הפרמטרים הישירים של API של הספק.  
הם יגיעו עם תיאור המציין זאת.  

## קונטקסט והיסטוריה  

לכל צ'אט יש קונטקסט והיסטוריה.  
ההיסטוריה היא כל ההיסטוריה של ההודעות שנשלחו ונתקבלו בשיחה.  
גודל הקונטקסט הוא כמה מההיסטוריה הוא ישלח ל-LLM, כך שהוא יזכור את התגובות.  

שים לב שגודל הקונטקסט הוא מושג של PowershAI, והוא אינו זהה ל-"Context length"  
גודל הקונטקסט משפיע רק על PowershAI, ובהתאם לערך, הוא עשוי לעבור את Context Length  
חשוב לשמור על גודל הקונטקסט מאוזן בין שמירה על LLM מעודכן עם מה שנאמר כבר לבין  
לא עובר את כמות ה-tokens המרבית של LLM.  

אתה שולט בגודל הקונטקסט באמצעות פרמטר הצ'אט, כלומר, באמצעות `Set-PowershaiChatParameter`.

שים לב שההיסטוריה והקונטקסט מאוחסנים בזיכרון הפעלת הפעולה של Powershell, כלומר,  
אם תסגור את הפעלת הפעולה של Powershell, הם יאבדו.  
בעתיד, אנו עשויים לקבל מנגנונים המאפשרים למשתמש לשמור באופן אוטומטי  

גם חשוב לזכור שמאחר שההיסטוריה נשמרת בזיכרון של Powershell, שיחות ארוכות מאוד  
אתה יכול לאפס את הצ'אטים בכל עת באמצעות הפקודה `Reset-PowershaiCurrentChat`,  
השתמש בזהירות, מכיוון שזה יגרום לאובדן כל ההיסטוריה ו-LLM לא יזכור את המוזרויות  

## צינור  

אחת מהתכונות החזקות ביותר של צ'אטים ב-Powershai היא השילוב עם צינור Powershell.  
במילים אחרות, אתה יכול להעביר את התוצאה של כל פקודה powershell, והיא תישמש כקונטקסט.  

PowershAI עושה זאת על ידי המרת אובייקטים לטקסט ושליחתם בפקודה.  
ואז, הודעת הצ'אט מתווספת בהמשך.  

לדוגמה:

```
Get-Service | ia "הכינו תקציר אודות שירותים שלא נפוצים ב-Windows"
```

בהגדרות ברירת המחדל של PowershAI, הפקודה `ia`  (שם נרדף ל- `Send-PowershaiChat`),  
ואז, מחרוזת זו תוזרק לפקודה של LLM, ויונחו לו להשתמש בתוצאה זו כ"קונטקסט"  

פקודת המשתמש מתווספת מייד לאחר מכן.  

בזכות כך, נוצר אפקט רב עוצמה: אתה יכול לשלב בקלות את הפלט של פקודות עם  
LLM נוטה לשקול זאת היטב.  

למרות שיש לו ערך ברירת מחדל, יש לך שליטה מלאה על אופן שליחת האובייקטים.  
הדרך הראשונה לשלוט היא כיצד האובייקט מומר לטקסט.  
ברירת המחדל היא להמיר לייצוג סטנדרטי של Powershell, בהתאם לסוג (באמצעות  
אתה יכול לשנות זאת באמצעות הפקודה `Set-PowershaiChatContextFormatter`.  

הדרך השנייה לשלוט על אופן שליחת הקונטקסט היא באמצעות פרמטר הצ'אט  
פרמטר זה שולט בכל ההודעה שתוזרק לפקודה.  
אתה צריך להחזיר מערך של מחרוזות, השווה לפקודה שנשלחת.  
סגנון זה מקבל גישה לפרמטרים כמו האובייקט המעוצב שעובר בצנור,  
הערך ברירת המחדל של הסגנון מקודד באופן קשיח, ואתה צריך לבדוק ישירות  

###  כלים

אחת התכונות הגדולות המיושמות היא תמיכה בקריאת פונקציות (או קריאת כלים).  
תכונה זו, זמינה במספר LLMs, מאפשרת ל-AI להחליט להפעיל פונקציות  
במילים אחרות, אתה מתאר פונקציה אחת או יותר ופרמטרים שלהן, והמודל יכול  

**חשוב: תוכל להשתמש בתכונה זו רק בספקים שמציגים קריאת פונקציות  **

לפרטים נוספים, עיין בתיעוד הרשמי של OpenAI אודות קריאת פונקציות:  
[קריאת פונקציות](https://platform.openai.com/docs/guides/function-calling).

המודל רק מחליט אילו פונקציות להפעיל, מתי להפעיל אותן ומה יהיו הפרמטרים שלהן.  
הביצוע של הפעלה זו נעשה על ידי הלקוח, במקרה שלנו, PowershAI.  
המודלים מצפים להגדרת הפונקציות תוך תיאור מה הן עושות,  
במקור, זה נעשה באמצעות משהו כמו OpenAPI Spec  
עם זאת, Powershell כולל מערכת עוצמתית של עזרה באמצעות הערות,  
PowershAI משלב עם מערכת עזרה זו, ותרגם אותה ל-OpenAPI specification.  

כדי להדגים תכונה זו, נעבור למדריך פשוט:  

```powershell
# קובץ MinhasFuncoes.ps1, שמור אותו במיקום  

<#
    .DESCRIPTION
    רשימת הזמן הנוכחי
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    מקבל מספר אקראי!
#>
function NumeroAleatorio {
    param(
        # מספר מינימלי
        $Min = $null,
        
        # מספר מקסימלי
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**שים לב לשימוש בהערות לתיאור פונקציות ופרמטרים**.  
זוהי תחביר נתמך על ידי Powershell, המכונה  
[עזרה מבוססת הערות](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

עכשיו, נוסיף קובץ זה ל-PowershAI:

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #confiogure o token se ainda não configurou.


# Adicione o script como tools!
# Supondo que o script fo salvo em C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Confirme que s tools foram adicionadas 
Get-AiTool
```

נסה לבקש מהמודל מה השעה הנוכחית או לבקש ממנו  
תראה שהוא יפעיל את הפונקציות שלך!  
זה פותח אפשרויות אינסופיות, והיצירתיות שלך היא הגבול!

```powershell
ia "כמה שעות?"
```

בפקודה שלמעלה, המודל יפעיל את הפונקציה.  
אתה יכול להוסיף כל פקודה או סקריפט Powershell ככלי.  
השתמש בפקודה `Get-Help -Full Add-AiTol`  

PowershAI מטפל באופן אוטומטי בהפעלת הפקודות ושליחת  
אם המודל מחליט להפעיל מספר פונקציות במקביל,  
שים לב שעל מנת למנוע לולאה אינסופית של ביצועים, PowershAI  
הפרמטר השולט באינטראקציות אלה עם המודל הוא `MaxInteractions`.  


### Invoke-AiChatTools ו-Get-AiChat 

שתי cmdlet's אלה הן הבסיס לתכונת הצ'אטים ב-PowershAI.  
`Get-AiChat` היא הפקודה המאפשרת לתקשר עם LLM  
היא, בעצם, עטיפה סטנדרטית עבור API המאפשרת לייצר טקסט.  
אתה מציין את הפרמטרים, שהם סטנדרטיים, והיא מחזירה  
בלי קשר לספק, התגובה צריכה לעקוב אחר אותה כלל!

ה-cmdlet `Invoke-AiChatTools` הוא קצת יותר מתוחכם  
היא מאפשרת לציין פונקציות Powershell ככלי.  
היא משתמשת במערכת העזרה של Powershell כדי לקבל  
היא שולחת את הנתונים למודל באמצעות הפקודה `Get-Aichat`.  
היא ממשיכה לעשות את לולאת זו עד שהמודל מסיים את  
אינטראקציה היא קריאת API למודל.  
אך, תוך שימוש ב-Invoke-AiChatTools עם פונקציות,  

הדיאגרמה הבאה מסבירה זרימה זו:

```
	sequenceDiagram
		Invoke-AiChatTools->>modelo:prompt (INTERAÇÃO 1)
		modelo->>Invoke-AiChatTools:(response, 3 function call)
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 1
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 2
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 3
		Invoke-AiChatTools->>modelo:Resultado tool call + prompts anteriores prompt (INTERAÇÃO 2)
		modelo->>Invoke-AiChatTools:resposta final
```


#### כיצד פקודות מומרים ומופעלים

הפקודה `Invoke-AiChatTools` מצפה בפרמטר -Functions  
היא מצפה מאובייקט שקוראים לו OpenaiTool,  
- tools  
מאפיין זה מכיל את סכימת קריאת הפונקציות  

- map  
זהו שיטה המוחזרת על ידי פקודת powershell  
שיטה זו צריכה להחזיר אובייקט עם המאפיין  
היא תקבל בארגומנט הראשון את שם הכלי,  

בנוסף למאפיינים אלו, כל מאפיין אחר חופשי  
זה מאפשר לסגנון הסקריפט לקבל גישה לכל  

כאשר LLM מחזיר את בקשת קריאת הפונקציות,  
זה פותח מגוון אפשרויות, ומאפשר,  

ואז, הפקודה תופעל,  
כלומר, הפקודה או הסקריפט צריכים להיות  

כל זה נעשה בלולאה שתעבור, ברצף,  
אין שום הבטחה לגבי הסדר שבו כלים יבוצעו,  
משמעות הדבר היא שבמימושים עתידיים,  

פנימית, PowershAI יוצר סגנון סקריפט ברירת  

לדוגמה כיצד ליישם פונקציות  

שים לב שפונקציה זו עובדת רק עם  

#### שיקולים חשובים אודות השימוש בכלים

תכונת קריאת פונקציות חזקה מכיוון  
לכן, יש להיות זהירים ביותר עם  
זכור ש-PowershAI יפעיל בהתאם  

כמה עצות בטיחות:

- הימנע מהפעלת הסקריפט עם  
- הימנע ממימוש קוד שמחק  
- בדוק את הפונקציות לפני  
- אל תכלול מודולים או  

המימוש הנוכחי מפעיל את  
משמעות הדבר היא ש, לדוגמה, אם המודל  
לכן, שווה להזהיר:  

ישנם תוכניות להוסיף מנגנונים  
כגון בידוד ברחבי ריצה  
ואפשר למשתמש  




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->