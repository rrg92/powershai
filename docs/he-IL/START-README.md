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

PowershAI (PowerShell + AI) הוא מודול המשלב שירותי בינה מלאכותית ישירות ב-PowerShell.  
ניתן להפעיל את הפקודות הן בסקריפטים והן בשורת הפקודה.  

ישנן פקודות רבות המאפשרות שיחה עם LLMs, הפעלת מרחבים של Hugging Face, Gradio וכו'.  
אתה יכול לשוחח עם GPT-4o-mini, gemini flash, llama 3.1 וכו', תוך שימוש באסימונים משלך משירותים אלה.  
כלומר, אתה לא משלם דבר כדי להשתמש ב-PowershAI, בנוסף לעלויות שהיית נושא בהן בדרך כלל בעת שימוש בשירותים אלה.  

מודול זה אידיאלי לשילוב פקודות PowerShell עם ה-LLM האהובים עליך, לבדיקת קריאות, POC וכו'.  
הוא אידיאלי עבור אלה שכבר מכירים את PowerShell ורוצים להביא את הבינה המלאכותית לסוגי הקוד שלהם בצורה פשוטה ונוחה יותר!

הדוגמאות הבאות מציגות כיצד ניתן להשתמש ב-Powershai במצבים נפוצים:

## ניתוח יומני Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # קביעת אסימון עבור OpenAI (צריך לעשות זאת רק פעם אחת)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "האם יש אירוע חשוב כלשהו?"
```

## תיאור שירותים 
```powershell 
import-module powershai 

Set-GoogleApiKey # קביעת אסימון עבור Google Gemini (צריך לעשות זאת רק פעם אחת)
Set-AiProvider google

Get-Service | ia "ערוך סיכום של השירותים שאינם ילידי Windows ויכולים להוות סיכון"
```

## הסבר ל-commits ב-git 
```powershell 
import-module powershai 

Set-MaritalkToken # קביעת אסימון עבור Maritaca.AI (LLM ברזילאי)
Set-AiProvider maritalk

git log --oneline | ia "ערוך סיכום של ה-commits שנעשו אלה"
```


הדוגמאות לעיל הן רק דוגמה קטנה לכמה קל להתחיל להשתמש בבינה מלאכותית ב-Powershell שלך ולהשתלב כמעט בכל פקודה!
[חקור עוד במסמכים](docs/pt-BR)

## התקנה

כל הפונקציונליות נמצאת בספרייה `powershai`, שהיא מודול PowerShell.  
אפשרות ההתקנה הפשוטה ביותר היא באמצעות הפקודה `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

לאחר ההתקנה, פשוט ייבא את המודול לסשן שלך:

```powershell
import-module powershai

# ראה את הפקודות הזמינות
Get-Command -mo powershai
```

אתה יכול גם לשכפל פרויקט זה ישירות ולייבא את הספרייה powershai:

```powershell
cd CAMINHO

# שיבוט
git clone ...

# ייבוא ​​מהנתיב הספציפי!
Import-Module .\powershai
```

## חקור ותרום

עדיין יש הרבה מה לתעד ולשפר ב-PowershAI!  
ככל שאני משפר את המודול, אני משאיר הערות בקוד כדי לעזור לאלה שרוצים ללמוד איך עשיתי את זה!  
אל תהסס לחקור ולתרום עם הצעות לשיפור.

## פרויקטים אחרים עם PowerShell

להלן כמה פרויקטים מעניינים אחרים המשלבים PowerShell עם בינה מלאכותית:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

חקור, למד ותרום!




<!--PowershaiAiDocBlockStart-->
_נאמר לי שאתה רוצה שאני אעשה משהו, אבל לא נתת לי שום הוראות ספציפיות. בבקשה תן לי הוראות ספציפיות ותוכל לעזור. 
_
<!--PowershaiAiDocBlockEnd-->
