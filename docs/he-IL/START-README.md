![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [english](/docs/en-US/START-README.md)
* [Français](/docs/fr-FR/START-README.md)
* [日本語](/docs/ja-JP/START-README.md)
* [العربية](/docs/ar-SA/START-README.md)
* [Deutsch](/docs/de-DE/START-README.md)
* [español](/docs/es-ES/START-README.md)
* [עברית](/docs/he-IL/START-README.md)
* [italiano](/docs/it-IT/START-README.md)

PowershAI (PowerShell + AI) הוא מודול שמשלב שירותי אינטליגנציה מלאכותית ישירות ב-PowerShell.  
אתה יכול להזמין את הפקודות גם בסקריפטים וגם בשורת הפקודה.  

ישנם מספר פקודות שמאפשרות שיחות עם LLMs, להזמין spaces של Hugging Face, Gradio, וכו'.  
אתה יכול לשוחח עם GPT-4o-mini, gemini flash, llama 3.1, וכו', באמצעות הטוקנים האישיים שלך משירותים אלו.  
כלומר, אתה לא משלם שום דבר על השימוש ב-PowershAI, מלבד העלויות שכבר היית משלם בדרך כלל על השימוש בשירותים אלו.  

מודול זה הוא אידיאלי לשילוב פקודות PowerShell עם LLM המועדפים עליך, לבדוק קריאות, pocs, וכו'.  
זה אידיאלי למי שכבר רגיל ל-PowerShell ורוצה להביא את ה-AI לסקריפטים שלו בצורה פשוטה וקלילה יותר!

> [!IMPORTANT]
> זה לא מודול רשמי של OpenAI, Google, Microsoft או כל ספק אחר המוזכר כאן!
> פרויקט זה הוא יוזמה אישית, במטרה להיות מתוחזק על ידי הקהילה הפתוחה עצמה.


הדוגמאות הבאות מראות כיצד אתה יכול להשתמש ב-Powershai במצבים נפוצים:

## ניתוח יומני Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # מגדיר טוקן עבור OpenAI (צריך לעשות זאת רק פעם אחת)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "האם יש אירוע חשוב?"
```

## תיאור שירותים 
```powershell 
import-module powershai 

Set-GoogleApiKey # מגדיר טוקן עבור Google Gemini (צריך לעשות זאת רק פעם אחת)
Set-AiProvider google

Get-Service | ia "עשה סיכום של אילו שירותים אינם ילידים של Windows ויכולים להוות סיכון"
```

## הסבר על התחייבויות של git 
```powershell 
import-module powershai 

Set-MaritalkToken # מגדיר טוקן עבור Maritaca.AI (LLM ברזילאי)
Set-AiProvider maritalk

git log --oneline | ia "עשה סיכום של התחייבויות אלו"
```


הדוגמאות למעלה הן רק הדגמה קטנה של כמה קל להתחיל להשתמש ב-AI ב-PowerShell שלך ולשלב עם practically כל פקודה!
[חקור עוד בתיעוד המלא](/docs/he-IL)

## התקנה

כל הפונקציות נמצאות בתיקיית `powershai`, שהיא מודול PowerShell.  
האופציה הפשוטה ביותר להתקנה היא עם הפקודה `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

לאחר ההתקנה, פשוט ייבא את המודול בש session שלך:

```powershell
import-module powershai

# ראה את הפקודות הזמינות
Get-Command -mo powershai
```

אתה יכול גם לשכפל את הפרויקט הזה ישירות ולייבא את תיקיית powershai:

```powershell
cd CAMINHO

# שכפל
git clone ...

#ייבא מהנתיב הספציפי!
Import-Module .\powershai
```

## חקור ותורם

עדיין יש הרבה לתעד ולפתח ב-PowershAI!  
כשהאני עושה שיפורים, אני משאיר הערות בקוד כדי לעזור לאלה שרוצים ללמוד איך עשיתי את זה!  
אל תהסס לחקור ולתרום עם הצעות לשיפורים.

## פרויקטים אחרים עם PowerShell

הנה כמה פרויקטים מעניינים אחרים שמשלבים PowerShell עם AI:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

חקור, למד ותרום!


<!--PowershaiAiDocBlockStart-->
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
