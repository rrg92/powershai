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
אתה יכול להפעיל את הפקודות הן בתוך סקריפטים והן בשורת הפקודה.

ישנן פקודות רבות המאפשרות שיחה עם LLMs, הפעלת שטחים של Hugging Face, Gradio וכו'.
אתה יכול לשוחח עם GPT-4o-mini, gemini flash, llama 3.1 וכו', באמצעות טוקנים משלך משירותים אלו.
כלומר, אינך משלם דבר עבור השימוש ב-PowershAI, בנוסף לעלויות שכבר היית משלם עבור השימוש בשירותים אלו.

מודול זה מושלם עבור שילוב פקודות powershell עם LLMs האהובים עליך, בדיקת שיחות, pocs וכו'.
הוא אידיאלי עבור מי שכבר מכיר את PowerShell ורוצה להביא בינה מלאכותית לסקריפטים שלו בצורה פשוטה וקלה יותר!

הדוגמאות הבאות מראות כיצד ניתן להשתמש ב-Powershai במצבים נפוצים:

## ניתוח יומני Windows
```powershell
import-module powershai

Set-OpenaiToken # קביעת טוקן עבור OpenAI (יש לבצע זאת רק פעם אחת)
Set-AiProvider openai

Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "האם יש אירוע משמעותי?"
```

## תיאור שירותים
```powershell
import-module powershai

Set-GoogleApiKey # קביעת טוקן עבור Google Gemini (יש לבצע זאת רק פעם אחת)
Set-AiProvider google

Get-Service | ia "ערוך סיכום של שירותים שאינם ילידי Windows ויכולים להוות סיכון"
```

## הסבר התחייבויות Git
```powershell
import-module powershai

Set-MaritalkToken # קביעת טוקן עבור Maritaca.AI (LLM בברזיל)
Set-AiProvider maritalk

git log --oneline | ia "ערוך סיכום של התחייבויות אלו"
```


הדוגמאות לעיל הן רק דוגמה קטנה לכמה קל להתחיל להשתמש ב-AI ב-Powershell שלך ולשלב אותו עם כמעט כל פקודה!
[חקור עוד בתיעוד המלא](/docs/he-IL)

## התקנה

כל הפונקציונליות נמצאת במיקום `powershai`, שהינו מודול PowerShell.
אפשרות ההתקנה הפשוטה ביותר היא באמצעות הפקודה `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

לאחר ההתקנה, פשוט ייבא אותו לסשן שלך:

```powershell
import-module powershai

# הצגת הפקודות הזמינות
Get-Command -mo powershai
```

אתה יכול גם לשכפל פרויקט זה ישירות ולייבא את התיקיה powershai:

```powershell
cd CAMINHO

# שכפל
git clone ...

#יבוא מתוך הנתיב הספציפי!
Import-Module .\powershai
```

## חקור ותרום

עדיין יש הרבה מה לתעד ולשפר ב-PowershAI!
ככל שאני עושה שיפורים, אני משאיר הערות בקוד כדי לעזור לאלו שרוצים ללמוד איך עשיתי זאת!
אל תהסס לחקור ולשתף פעולה עם הצעות לשיפור.

## פרויקטים אחרים עם PowerShell

להלן כמה פרויקטים מעניינים אחרים המשלבים PowerShell עם AI:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

חקור, למד ותרום!




<!--PowershaiAiDocBlockStart-->
_לא סיפקת לי טקסט לתרגם. אנא ספק לי את הטקסט שברצונך לתרגם לעברית. 
_
<!--PowershaiAiDocBlockEnd-->
