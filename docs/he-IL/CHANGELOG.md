# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: נוספו בדיקות אוטומטיות עבור groq

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: תוקן באג בספק groq, שקשור להודעות מערכת
- **COHERE PROVIDER**: תוקן באג שקשור להודעות המודל כאשר היו תשובות של קריאות כלים.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: צ'אטים נוצרו מחדש בכל פעם, מה שמנע שמירה נכונה של ההיסטוריה בעת שימוש בצ'אטים מרובים!
- **OPENAI PROVIDER**: תוקנה תוצאת `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תוקנו באגים בספק Hugging Face עקב ניתובים מחדש.
- תוקנה התקנת מודולים לבדיקות באמצעות Docker Compose.
- תוקנו בעיות ביצועים בהמרת כלים עקב מספר רב של פקודות בפגישה. כעת משתמש במודולים דינמיים. ראה `ConvertTo-OpenaiTool`.
- תוקנו בעיות אי תאימות בין ממשק ה-API של GROQ ל-OpenAI. `message.refusal` אינו מקובל יותר.
- תוקנו באגים קטנים ב-PowerShell Core עבור לינוקס.
- **OPENAI PROVIDER**: נפתר קוד חריגה שנגרם עקב היעדר מודל ברירת מחדל.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **ספק חדש**: ברוך הבא Azure 🎉
- **ספק חדש**: ברוך הבא Cohere 🎉
- נוספה התכונה `AI Credentials` - דרך חדשה וסטנדרטית למשתמשים להגדיר אישורים, המאפשרת לספקים לבקש נתוני אישורים ממשתמשים.
- ספקים הועברו לשימוש ב-`AI Credentials`, תוך שמירה על תאימות לפקודות ישנות יותר.
- Cmdlet חדש `Confirm-PowershaiObjectSchema`, לאימות סכמות באמצעות OpenAPI עם תחביר "PowerShell" יותר.
- נוספה תמיכה בניתובים מחדש של HTTP בספריית HTTP.
- נוספו מספר בדיקות חדשות עם Pester, החל מבדיקות יחידה בסיסיות ועד למקרים מורכבים יותר, כמו קריאות כלים LLM אמיתיות.
- Cmdlet חדש `Switch-PowershaiSettings` מאפשר להחליף הגדרות וליצור צ'אטים, ספקים, מודלים וכו', כאילו היו פרופילים נפרדים.
- **Retry Logic**: נוספה `Enter-PowershaiRetry` להפעלה חוזרת של סקריפטים על סמך תנאים.
- **Retry Logic**: נוספה לוגיקת ניסיון חוזר ב-`Get-AiChat` כדי להפעיל בקלות את הפקודה ל-LLM שוב במקרה שהתשובה הקודמת אינה תואמת את הרצוי.
- Cmdlet חדש `Enter-AiProvider` מאפשר כעת להפעיל קוד תחת ספק ספציפי.
- ערימת ספקים (Push/Pop): בדומה ל-`Push-Location` ו-`Pop-Location`, כעת ניתן להוסיף ולהסיר ספקים לשינויים מהירים יותר בעת הפעלת קוד בספק אחר.
- Cmdlet חדש `Get-AiEmbeddings`: נוספו cmdlets סטנדרטיים להשגת הטמעות של טקסט, המאפשרים לספקים לחשוף את יצירת ההטמעות ולמשתמשים מנגנון סטנדרטי ליצירתן.
- Cmdlet חדש `Reset-AiDefaultModel` כדי לבטל את סימון מודל ברירת המחדל.
- נוספו הפרמטרים `ProviderRawParams` ל-`Get-AiChat` ו-`Invoke-AiChat` כדי לדרוס את הפרמטרים הספציפיים ב-API, לפי ספק.
- **HUGGINGFACE PROVIDER**: נוספו בדיקות חדשות המשתמשות בסביבת Hugging Face אמיתית המתוחזקת כתת-מודול של פרויקט זה. זה מאפשר לבדוק היבטים שונים בו זמנית: הפעלות Gradio ושילוב Hugging Face.
- **HUGGINGFACE PROVIDER**: Cmdlet חדש: Find-HuggingFaceModel, לחיפוש מודלים ב-hub על סמך מסננים!
- **OPENAI PROVIDER**: נוספה cmdlet חדשה ליצירת קריאות כלים: `ConvertTo-OpenaiTool`, התומכת בכלים המוגדרים בבלוקים של סקריפט.
- **OLLAMA PROVIDER**: Cmdlet חדש `Get-OllamaEmbeddings` להחזרת הטמעות באמצעות Ollama.
- **OLLAMA PROVIDER**: Cmdlet חדש `Update-OllamaModel` להורדת מודלי ollama (pull) ישירות מה-powershell
- **OLLAMA PROVIDER**: זיהוי אוטומטי של כלים באמצעות המטא-נתונים של ollama
- **OLLAMA PROVIDER**: מטמון של מטא-נתונים של מודלים ו-cmdlet חדש `Reset-OllamaPowershaiCache` לניקוי המטמון, המאפשר שאילתה של פרטים רבים של מודלי ollama, תוך שמירה על ביצועים לשימוש חוזר בפקודה

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **שינוי שובר**: הפרמטר של הצ'אט `ContextFormatter` שונה ל-`PromptBuilder`.
- שונתה התצוגה הסטנדרטית (formats.ps1xml) של כמה cmdlets כמו `Get-AiModels`.
- שיפור ביומן המפורט בעת הסרת היסטוריה ישנה עקב `MaxContextSize` בצ'אטים.
- דרך חדשה לאחסון הגדרות PowershAI, המציגה את המושג "אחסון הגדרות", המאפשר החלפת הגדרות (לדוגמה, לבדיקות).
- עודכנו האימוג'ים המוצגים יחד עם שם המודל בעת שימוש בפקודה Send-PowershaiChat
- שיפורים בהצפנה של ייצוא/ייבוא הגדרות (Export=-PowershaiSettings). כעת משתמש ב-key derivation ו-salt.
- שיפור בהחזרת הממשק *_Chat, כדי שיהיה נאמן יותר לתקן של OpenAI.
- נוספה האפשרות `IsOpenaiCompatible` לספקים. ספקים המעוניינים לעשות שימוש חוזר ב-cmdlets של OpenAI צריכים להגדיר דגל זה כ-`true` כדי לפעול כראוי.
- שיפור בטיפול בשגיאות של `Invoke-AiChatTools` בעיבוד קריאות כלים.
- **GOOGLE PROVIDER**: נוספה cmdlet `Invoke-GoogleApi` כדי לאפשר קריאות API ישירות על ידי משתמשים.
- **HUGGING FACE PROVIDER**: הת ajustes קלים באופן הכנסת האסימון לבקשות API.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` ו-`Get-OpenaiToolFromScript` כעת משתמשים ב-`ConvertTo-OpenaiTool` כדי למרכז את המרת הפקודה לכלי OpenAI.
- **GROQ PROVIDER**: עודכן מודל ברירת המחדל מ-`llama-3.1-70b-versatile` ל-`llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels כעת כולל מודלים התומכים בכלים, מכיוון שהספק משתמש בנקודת הקצה /api/show כדי לקבל פרטים נוספים על המודלים, מה שמאפשר לבדוק תמיכה בכלים

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תוקן באג בפונקציה `New-GradioSessionApiProxyFunction`, שקשור לכמה פונקציות פנימיות.
- נוספה תמיכה ב-Gradio 5, הנדרשת עקב שינויים בנקודות הקצה של ה-API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- תמיכה בתמונות ב-`Send-PowershaiChat` עבור ספקי OpenAI ו-Google.
- פקודה ניסיונית, `Invoke-AiScreenshots`, שמוסיפה תמיכה בצילום צילומי מסך וניתוחם!
- תמיכה בקריאות כלים בספק Google.
- יומן שינויים התחיל.
- תמיכה ב-TAB עבור Set-AiProvider.
- נוספה תמיכה בסיסית בפלט מובנה לפרמטר `ResponseFormat` של ה-cmdlet `Get-AiChat`. זה מאפשר להעביר hashtable המתאר את סכמת OpenAPI של התוצאה.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **שינוי שובר**: המאפיין `content` של הודעות OpenAI נשלח כעת כמערך כדי להתיישר למפרטים עבור סוגי מדיה אחרים. זה דורש עדכון של סקריפטים התלויים בתבנית המחרוזת היחידה הקודמת ובגרסאות ישנות של ספקים שאינם תומכים בתחביר זה.
- הפרמטר `RawParams` של `Get-AiChat` תוקן. כעת ניתן להעביר פרמטרים של API לספק הרלוונטי כדי לקבל שליטה מדויקת על התוצאה
- עדכוני DOC: מסמכים חדשים שתורגמו עם AiDoc ועדכונים. תיקון קטן ב-AiDoc.ps1 כדי לא לתרגם פקודות תחביר מסוימות של markdown.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תקן #13. הגדרות האבטחה שונו וטיפול באותיות גדולות וקטנות שופר. זה לא אומת, מה שהביא לשגיאה.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2



<!--PowershaiAiDocBlockStart-->
_מתורגם אוטומטית באמצעות PowershAI ובינה מלאכותית_
<!--PowershaiAiDocBlockEnd-->
