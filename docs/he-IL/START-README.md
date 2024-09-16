![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [english](docs/en-US/START-README.md)
* [Français](docs/fr-FR/START-README.md)
* [日本語](docs/ja-JP/START-README.md)
* [العربية](docs/ar-SA/START-README.md)
* [Deutsch](docs/de-DE/START-README.md)
* [español](docs/es-ES/START-README.md)
* [עברית](docs/he-IL/START-README.md)
* [italiano](docs/it-IT/START-README.md)

PowershAI (PowerShell + AI) הוא מודול המשלב שירותי בינה מלאכותית ישירות ב-PowerShell.  
ניתן להפעיל את הפקודות הן בתוך סקריפטים והן בשורת הפקודה.  

ישנם מספר פקודות המאפשרות שיחה עם LLMs, הפעלת מרחבים של Hugging Face, Gradio, וכו'.  
ניתן לשוחח עם GPT-4o-mini, gemini flash, llama 3.1, וכו', באמצעות אסימונים אישיים משירותים אלו.  
כלומר, אין תשלום עבור שימוש ב-PowershAI, מעבר לעלויות הרגילות של שימוש בשירותים אלו.  

מודול זה אידיאלי לשילוב פקודות PowerShell עם LLMs המועדפים עליך, בדיקת שיחות, POCs, וכו'.  
אידיאלי עבור אלו שכבר מכירים את PowerShell ורוצים להוסיף IA לסנריפטים שלהם בצורה פשוטה וקלה!

הדוגמאות הבאות מראות כיצד ניתן להשתמש ב-Powershai במצבים נפוצים:

## ניתוח יומני Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # קביעת אסימון עבור OpenAI (יש לבצע פעולה זו רק פעם אחת)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "אירוע חשוב כלשהו?"
```

## תיאור שירותים 
```powershell 
import-module powershai 

Set-GoogleApiKey # קביעת אסימון עבור Google Gemini (יש לבצע פעולה זו רק פעם אחת)
Set-AiProvider google

Get-Service | ia "לעשות סיכום של שירותים שאינם ילידי Windows ומהווים סיכון"
```

## הסבר על Commits ב-Git 
```powershell 
import-module powershai 

Set-MaritalkToken # קביעת אסימון עבור Maritaca.AI (LLM ישראלי)
Set-AiProvider maritalk

git log --oneline | ia "לעשות סיכום של Commits אלו"
```


הדוגמאות לעיל הן רק הדגמה קטנה של כמה קל להתחיל להשתמש ב-IA ב-Powershell שלך ולשלב אותו עם כמעט כל פקודה!
[הרחבה בתיעוד](docs/pt-BR)

## התקנה

כל הפונקציונליות נמצאת בתיקיית `powershai`, שהיא מודול PowerShell.  
אפשרות ההתקנה הפשוטה ביותר היא באמצעות הפקודה `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

לאחר ההתקנה, פשוט ייבא את המודול לפעולה:

```powershell
import-module powershai

# הצגת הפקודות הזמינות
Get-Command -mo powershai
```

ניתן גם לשבט את פרויקט זה ישירות ולייבא את תיקיית powershai:

```powershell
cd CAMINHO

# שיבוט
git clone ...

# ייבוא מתוך נתיב ספציפי!
Import-Module .\powershai
```

## חקור ותרום

יש עוד הרבה מה לתעד ולפתח ב-PowershAI!  
ככל שאני משפר את המודול, אני מוסיף הערות בקוד כדי לסייע לאלו שרוצים ללמוד כיצד עשיתי זאת!  
אל תהסס לחקור ולתרום עם הצעות לשיפור.

## פרויקטים אחרים עם PowerShell

להלן מספר פרויקטים מעניינים אחרים המשלבים PowerShell עם IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

חקור, למד ותרום!




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
