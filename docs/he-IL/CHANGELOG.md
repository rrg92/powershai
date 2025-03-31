# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.3]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVIDER**: הוספת פרמטר -DisableRetry ל-Get-GradioInfo
- **HUGGINGFACE PROVIDER**: הוספת פרמטרים GradioServerRoot ל-Get-HuggingFaceSpace ו-ServerRoot ל-Connect-HuggingFaceSpaceGradio
- **HUGGINGFACE PROVIDER**: הוספת לוגיקה לזיהוי אם ה-space של hugging face משתמש ב-Gradio 5 והתאמת שורש השרת
- **HUGGINGFACE PROVIDER**: הוספת spaces פרטיים לבדיקות של ה-provider

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: תוקן בעיית אימות ב-spaces פרטיים


## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: הוספת groq לבדיקות אוטומטיות

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: תוקן שגיאה ב-provider groq, הקשורה להודעות מערכת 
- **COHERE PROVIDER**: תוקן שגיאה הקשורה להודעות מהמודל כאשר היו תגובות מהתקשרויות כלים.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: שיחות נוצרו מחדש כל פעם, מה שהימנע מלהשאיר את ההיסטוריה נכון כאשר משתמשים במספר שיחות! 
- **OPENAI PROVIDER**: תוקן תוצאה של `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תוקנו שגיאות של provider Hugging Face עקב הפניות.
- תוקנה ההתקנה של מודולים לבדיקה באמצעות Docker Compose.
- תוקנו בעיות ביצועים בהמרת כלים עקב מספר גדול אפשרי של פקודות במושב. עכשיו משתמש במודולים דינמיים. ראה `ConvertTo-OpenaiTool`.
- תוקנו בעיות חוסר תאימות בין ה-API GROQ ל-OpenAI. `message.refusal` לא מתקבל יותר.
- תוקנו באגים קטנים ב-PowerShell Core עבור לינוקס.
- **OPENAI PROVIDER**: נפתרה קוד חריגה שנגרם על ידי היעדר מודל ברירת מחדל.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOVO PROVIDER**: ברוך הבא Azure 🎉
- **NOVO PROVIDER**: ברוך הבא Cohere 🎉
- הוספת תכונת `AI Credentials` — דרך חדשה סטנדרטית עבור המשתמשים להגדיר אישורים, המאפשרת לספקים לבקש נתוני אישורים מהמשתמשים.
- ספקים הועברו להשתמש ב-`AI Credentials`, תוך שמירה על תאימות עם פקודות ישנות יותר.
- cmdlet חדש `Confirm-PowershaiObjectSchema`, כדי לאמת סכמות באמצעות OpenAPI עם תחביר "PowerShellי" יותר.
- הוספת תמיכה להפניות HTTP בספריית HTTP
- הוספו מספר בדיקות חדשות עם Pester, הנעות מבדיקות יחידה בסיסיות ועד מקרים מורכבים יותר, כמו קריאות לכלים LLM אמיתיים.
- cmdlet חדש `Switch-PowershaiSettings` מאפשר להחליף הגדרות וליצור שיחות, ספקים ברירת מחדל, מודלים וכו', כאילו היו פרופילים נפרדים.
- **Retry Logic**: הוספת `Enter-PowershaiRetry` כדי להריץ מחדש סקריפטים בהתבסס על תנאים.
- **Retry Logic**: הוספת לוגיקת ניסיון ב-`Get-AiChat` כדי להריץ בקלות את הפקודה ל-LLM שוב במקרה שהתשובה הקודמת לא הייתה בהתאם לרצוי.- cmdlet חדש `Enter-AiProvider` עכשיו מאפשר להריץ קוד תחת ספק ספציפי. Cmdlets התלויים בספק, ישתמשו תמיד בספק שבו "נכנסו" לאחרונה במקום הספק הנוכחי.
- Stack של ספק (Push/Pop): בדיוק כמו ב `Push-Location` ו `Pop-Location`, עכשיו אתה יכול להכניס ולהסיר ספקים לשינויים מהירים יותר בעת הרצת קוד בספק אחר.
- cmdlet חדש `Get-AiEmbeddings`: נוספו cmdlets סטנדרטיים לקבלת embeddings מטקסט, מאפשרים לספקים לחשוף את יצירת ה-embeddings ולמשתמשים שיהיה מנגנון סטנדרטי ליצירתם.
- cmdlet חדש `Reset-AiDefaultModel` כדי לבטל את סימון המודל המוגדר כברירת מחדל.
- נוספו הפרמטרים `ProviderRawParams` ל `Get-AiChat` ו `Invoke-AiChat` כדי לדרוס את הפרמטרים הספציפיים ב-API, לפי ספק.
- **HUGGINGFACE PROVIDER**: נוספו בדיקות חדשות באמצעות מרחב Hugging Face ייחודי אמיתי המוחזק כתת-מודול של פרויקט זה. זה מאפשר לבדוק מספר אספקטים בו זמנית: מפגשי Gradio ושילוב Hugging Face.
- **HUGGINGFACE PROVIDER**: cmdlet חדש: Find-HuggingFaceModel, לחיפוש מודלים במרכז מבוסס על כמה מסננים!
- **OPENAI PROVIDER**: נוספה cmdlet חדשה ליצירת קריאות לכלים: `ConvertTo-OpenaiTool`, תומכת בכלים המוגדרים בחסימות סקריפט.
- **OLLAMA PROVIDER**: cmdlet חדש `Get-OllamaEmbeddings` להחזיר embeddings באמצעות Ollama.
- **OLLAMA PROVIDER**: cmdlet חדש `Update-OllamaModel` להורדת מודלים של ollama (pull) ישירות מהפאוורשאי.
- **OLLAMA PROVIDER**: זיהוי אוטומטי של כלים באמצעות המטא-דאטה של ollama.
- **OLLAMA PROVIDER**: מטמון של מטא-דאטה של מודלים וcmdlet חדש `Reset-OllamaPowershaiCache` כדי לנקות את המטמון, מאפשרת לבדוק הרבה פרטים על מודלים של ollama, תוך שמירה על ביצועים לשימוש חוזר בפקודה.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **שינוי מהותי**: הפרמטר של צ'אט `ContextFormatter` שונה ל `PromptBuilder`.
- שונה התצוגה הסטנדרטית (formats.ps1xml) של כמה cmdlets כמו `Get-AiModels`.
- שיפור ביומן מפורט בעת הסרת ההיסטוריה הישנה בגלל `MaxContextSize` בצ'אטים.
- דרך חדשה שבה מאוחסנות הגדרות ה-PowershAI, תוך הצגת רעיון של "אחסון הגדרות", מאפשרת החלפת הגדרות (לדוגמה, לבדיקה).
- עדכון אימוג'ים המוצגים יחד עם שם המודל כאשר משתמשים בפקודת Send-PowershaiChat.
- שיפורים בהצפנת הייצוא/ייבוא של הגדרות (Export=-PowershaiSettings). עכשיו משתמשת בהפקת מפתח וסלט.
- שיפור בהחזרה של הממשק *_Chat, כך שיהיה נאמן יותר לסטנדרט של OpenAI.
- נוספה אפשרות `IsOpenaiCompatible` לספקים. ספקים שמעוניינים לעשות שימוש חוזר בcmdlets של OpenAI צריכים להגדיר את הדגל הזה כ `true` כדי לפעול כראוי.
- שיפור בטיפול בשגיאות של `Invoke-AiChatTools` בעיבוד קריאות לכלים.- **GOOGLE PROVIDER**: נוסף cmdlet `Invoke-GoogleApi` כדי לאפשר קריאות API ישירות על ידי המשתמשים.
- **HUGGING FACE PROVIDER**: עדכונים קטנים בדרך להכניס את הטוקן בבקשות ה-API.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` ו- `Get-OpenaiToolFromScript` עכשיו משתמשים ב- `ConvertTo-OpenaiTool` כדי למקד את ההמרה מפקודה לכלי OpenAI.
- **GROQ PROVIDER**: עודכן המודל הסטנדרטי מ- `llama-3.1-70b-versatile` ל- `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels עכשיו כולל מודלים התומכים בכלים, מכיוון שהספק משתמש ב-endpoint /api/show כדי לקבל פרטים נוספים על המודלים, מה שמאפשר לבדוק את התמיכה בכלים.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תוקן באג בפונקציה `New-GradioSessionApiProxyFunction`, הקשורה לכמה פונקציות פנימיות.
- נוסף תמיכה ב-Gradio 5, הנדרשת בעקבות שינויים ב-endpoints של ה-API.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- תמיכה לתמונות ב- `Send-PowershaiChat` עבור הספקים OpenAI ו-Google.
- פקודה ניסיונית, `Invoke-AiScreenshots`, המוסיפה תמיכה לצילום מסך ולניתוחם!
- תמיכה לקריאה לכלים בספק Google.
- CHANGELOG הושק.
- תמיכה ב-TAB ל-Set-AiProvider.
- נוסף תמיכה בסיסית לפלט מובנה לפרמטר `ResponseFormat` של cmdlet `Get-AiChat`. זה מאפשר להעביר Hashtable המתאר את הסכימה OpenAPI של התוצאה.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: המאפיין `content` של הודעות OpenAI עכשיו נשלח כמערך כדי להתאים למפרטים עבור סוגי מדיה אחרים. זה דורש עדכון של סקריפטים התלויים בפורמט מחרוזת יחידה הקודם ובגרסאות ישנות של ספקים שאינם תומכים בסינטקס הזה.
- פרמטר `RawParams` של `Get-AiChat` תוקן. עכשיו אתה יכול להעביר פרמטרים מה-API לספק הרלוונטי כדי לקבל שליטה מדויקת על התוצאה.
- עדכוני DOC: מסמכים חדשים שתורגמו עם AiDoc ועדכונים. תיקון קטן ב-AiDoc.ps1 כדי לא לתרגם כמה פקודות סינטקס markdown.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תיקון #13. הגדרות האבטחה שונו וטיפול באותיות גדולות וקטנות שופר. זה לא היה מאומת, מה שגרם לשגיאה.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6  
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5  
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0  
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1  
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2  


<!--PowershaiAiDocBlockStart-->
_אתה מאומן על נתונים עד אוקטובר 2023._
<!--PowershaiAiDocBlockEnd-->
