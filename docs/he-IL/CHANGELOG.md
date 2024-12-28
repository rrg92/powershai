# יומן שינויים

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תוקנו שגיאות של ספק Hugging Face עקב ניתובים מחדש.
- תוקנה התקנת מודולים לבדיקות באמצעות Docker Compose.
- תוקנו בעיות ביצועים בהמרת כלים עקב מספר גדול אפשרי של פקודות בפעולה. כעת משתמש במודולים דינמיים. ראה `ConvertTo-OpenaiTool`.
- תוקנו בעיות אי-התאמה בין ממשק ה-API של GROQ לבין OpenAI. `message.refusal` כבר לא מתקבל.
- תוקנו באגים קטנים ב-PowerShell Core עבור Linux.
- **ספק OPENAI**: קוד חריג פתור שנגרם עקב היעדר מודל ברירת מחדל.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **ספק חדש**: ברוכים הבאים Azure 🎉
- **ספק חדש**: ברוכים הבאים Cohere 🎉
- נוסף התכונה `AI Credentials` — דרך ברירת מחדל חדשה עבור משתמשים להגדיר אישורים, המאפשרת לספקים לבקש נתוני אישורים ממשתמשים.
- ספקים הועברו לשימוש ב-`AI Credentials`, תוך שמירה על תאימות עם פקודות ישנות יותר.
- cmdlet חדש `Confirm-PowershaiObjectSchema`, לאימות סכמות באמצעות OpenAPI עם תחביר "PowerShell" יותר.
- נוסף תמיכה בניתובים HTTP בספריית HTTP
- נוספו בדיקות חדשות רבות עם Pester, החל מבדיקות יחידה בסיסיות ועד מקרים מורכבים יותר, כמו קריאות לכלי LLM אמיתיים.
- cmdlet חדש `Switch-PowershaiSettings` מאפשר לעבור בין הגדרות וליצור צ'אטים, ספקים ברירת מחדל, מודלים וכו', כאילו היו פרופילים נפרדים.
- **לוגיקת ניסיון חוזר**: נוסף `Enter-PowershaiRetry` להרצת מחדש של סקריפטים בהתבסס על תנאים.
- **לוגיקת ניסיון חוזר**: נוסף לוגיקת ניסיון חוזר ב-`Get-AiChat` כדי להריץ בקלות את ההנחיה ל-LLM שוב אם התשובה הקודמת לא תואמת את הרצוי.
- cmdlet חדש `Enter-AiProvider` מאפשר כעת להריץ קוד תחת ספק ספציפי. Cmdlets שתלויים בספק, ישתמשו תמיד בספק שנכנס אליו לאחרונה במקום בספק הנוכחי.
- מחסנית של ספק (Push/Pop): בדומה ל-`Push-Location` ול-`Pop-Location`, כעת ניתן להוסיף ולהסיר ספקים לשינויים מהירים יותר בעת הרצת קוד בספק אחר.
- cmdlet חדש `Get-AiEmbeddings`: נוספו cmdlets ברירת מחדל לקבלת הטבעות של טקסט, המאפשרים לספקים לחשוף יצירת הטבעות ולמשתמשים מנגנון ברירת מחדל ליצירתן.
- cmdlet חדש `Reset-AiDefaultModel` כדי לבטל את הסימון של מודל ברירת המחדל.
- נוספו הפרמטרים `ProviderRawParams` ל-`Get-AiChat` ול-`Invoke-AiChat` כדי לעקוף את הפרמטרים הספציפיים ב-API, לפי ספק.
- **ספק HUGGINGFACE**: נוספו בדיקות חדשות באמצעות חלל Hugging Face ייחודי אמיתי המתוחזק כמו-מודול משנה של פרויקט זה. זה מאפשר לבדוק היבטים רבים בו זמנית: הפעלות Gradio ואינטגרציה של Hugging Face.
- **ספק OPENAI**: נוסף cmdlet חדש ליצירת קריאות לכלי: `ConvertTo-OpenaiTool`, התומך בכלים המוגדרים בבלוקים של סקריפטים.
- **ספק OLLAMA**: cmdlet חדש `Get-OllamaEmbeddings` להחזרת הטבעות באמצעות Ollama.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **שינוי שובר**: הפרמטר של הצ'אט `ContextFormatter` שונה ל-`PromptBuilder`.
- שונה התצוגה ברירת המחדל (formats.ps1xml) של כמה cmdlets כמו `Get-AiModels`.
- שיפור ביומן המפורט בעת הסרת ההיסטוריה הישנה עקב `MaxContextSize` בצ'אטים.
- דרך חדשה לאחסון הגדרות PowershAI, המכניסה מושג של "אחסון הגדרות", המאפשרת החלפה של הגדרה (לדוגמה, לבדיקות).
- עדכון אימוג'ים המוצגים יחד עם שם המודל בעת שימוש בפקודה Send-PowershaiChat
- שיפורים בהצפנה של ייצוא/ייבוא הגדרות (Export=-PowershaiSettings). כעת משתמש בנגזרת מפתח ומלח.
- שיפור בהחזרת הממשק *_Chat, כך שתהיה נאמנה יותר לתקן של OpenAI.
- נוספה האפשרות `IsOpenaiCompatible` לספקים. ספקים שרוצים להשתמש מחדש ב-cmdlets של OpenAI צריכים להגדיר דגל זה כ-`true` כדי שיפעלו כראוי.
- שיפור בטיפול בשגיאות של `Invoke-AiChatTools` בעיבוד של קריאה לכלי.
- **ספק GOOGLE**: נוסף ה-cmdlet `Invoke-GoogleApi` כדי לאפשר למשתמשים קריאות API ישירות.
- **ספק HUGGING FACE**: התאמות קטנות באופן הכנסת האסימון לבקשות של ה-API.
- **ספק OPENAI**: `Get-OpenaiToolFromCommand` ו-`Get-OpenaiToolFromScript` כעת משתמשים ב-`ConvertTo-OpenaiTool` כדי למרכז את המרת הפקודה לכלי OpenAI.
- **ספק GROQ**: עודכן מודל ברירת המחדל מ-`llama-3.1-70b-versatile` ל-`llama-3.2-70b-versatile`.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תוקן באג בפונקציה `New-GradioSessionApiProxyFunction`, הקשור לפונקציות פנימיות מסוימות.
- נוספה תמיכה ב-Gradio 5, הנדרשת עקב שינויים בנקודות הקצה של ה-API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- תמיכה בתמונות ב-`Send-PowershaiChat` עבור ספקי OpenAI ו-Google.
- פקודה ניסיונית, `Invoke-AiScreenshots`, שמוסיפה תמיכה בצילום צילומי מסך וניתוחם!
- תמיכה בקריאות לכלי בספק Google.
- יומן שינויים הוחל.
- תמיכה ב-TAB עבור Set-AiProvider.
- נוספה תמיכה בסיסית לפלט מובנה לפרמטר `ResponseFormat` של ה-cmdlet `Get-AiChat`. זה מאפשר להעביר טבלת גיבוב המתארת את סכמת OpenAPI של התוצאה.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **שינוי שובר**: המאפיין `content` של הודעות OpenAI נשלח כעת כמערך כדי להתאים למפרטים עבור סוגי מדיה אחרים. זה דורש עדכון סקריפטים שתלויים בפורמט מחרוזת יחיד קודם ובגרסאות ישנות של ספקים שאינם תומכים בתחביר זה.
- הפרמטר `RawParams` של `Get-AiChat` תוקן. כעת ניתן להעביר פרמטרים של ה-API לספק הרלוונטי כדי לקבל שליטה קפדנית על התוצאה
- עדכוני DOC: מסמכים חדשים מתורגמים עם AiDoc ועדכונים. תיקון קטן ב-AiDoc.ps1 כדי לא לתרגם כמה פקודות של תחביר markdown.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- תיקון #13. הגדרות האבטחה שונו וטיפול באותיות גדולות וקטנות שופר. זה לא היה מאומת, מה שהוביל לשגיאה.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0


<!--PowershaiAiDocBlockStart-->
_מתורגם אוטומטית באמצעות PowershAI ו-AI
_
<!--PowershaiAiDocBlockEnd-->
