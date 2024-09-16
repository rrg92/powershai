# ספק Hugging Face

Hugging Face הוא מאגר המודלים הגדול בעולם!  
שם, יש לך גישה למגוון מדהים של מודלים, מערכי נתונים, הדגמות עם Gradio, ועוד הרבה!  

זהו GitHub של הבינה המלאכותית, מסחרית ופתוחה! 

ספק ה-Hugging Face של PowershAI מחבר את PowerShell שלך למגוון מדהים של שירותים ומודלים.  

## Gradio

Gradio היא מסגרת לבניית הדגמות עבור מודלים של בינה מלאכותית. עם קוד Python מועט, ניתן להעלות ממשקים שמקבלים קלטים שונים, כמו טקסט, קבצים, וכו'.  
בנוסף, הוא מנהל בעיות רבות כמו תורים, העלאות, וכו'.  וכדי להשלים את התמונה, יחד עם הממשק, הוא יכול להנגיש API כך שניתן יהיה לגשת לפונקציונליות שנחשפה דרך ממשק המשתמש גם דרך שפות תכנות.  
PowershAI נהנה מכך, וחושף את ה-APIs של Gradio בצורה קלה יותר, שבה ניתן להפעיל פונקציונליות מהטרמינל שלך ולקבל כמעט את אותה חוויה!


## Hugging Face Hub  

Hugging Face Hub הוא הפלטפורמה שאתה נכנס אליה בכתובת https://huggingface.co  
היא מאורגנת במודלים (models), שהם בעצם קוד המקור של מודלי ה-AI שאנשים וחברות אחרות יוצרים ברחבי העולם.  
יש גם "Spaces", שזה המקום שבו אתה יכול להעלות קוד כדי לפרסם יישומים שנכתבים ב-Python (באמצעות Gradio, לדוגמה) או ב-Docker.  

למד עוד על Hugging Face [בפוסט הזה בבלוג Ia Talking](https://iatalk.ing/hugging-face/)
ולמד עוד על Hugging Face Hub [בתיעוד הרשמי](https://huggingface.co/docs/hub/en/index)

עם PowershAI, אתה יכול לרשום מודלים ואפילו ליצור אינטראקציה עם ה-API של Spaces רבים, ולהריץ מגוון רחב של אפליקציות AI מהטרמינל שלך.  


# שימוש בסיסי

ספק ה-Hugging Face של PowershAI כולל Cmdlets רבים עבור אינטראקציה.  
הוא מאורגן בפקודות הבאות:

* פקודות שיוצרות אינטראקציה עם Hugging Face מכילות `HuggingFace` או `Hf` בשם. לדוגמה: `Get-HuggingFaceSpace` (כינוי `Get-HfSpace`).  
* פקודות שיוצרות אינטראקציה עם Gradio, ללא קשר אם הן Space של Hugging Face או לא, מכילות `Gradio` או `GradioSession'  בשם: `Send-GradioApi`, `Update-GradioSessionApiResult`
* אתה יכול להשתמש בפקודה זו כדי לקבל את הרשימה המלאה: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

אין צורך לאמת את הזהות שלך כדי לגשת למשאבים הציבוריים של Hugging Face.  
ישנם אינספור מודלים ו-spaces זמינים בחינם ללא צורך באימות.  
לדוגמה, הפקודה הבאה מרשימה את 5 המודלים המורדים ביותר מ-Meta (מחבר: meta-llama):

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

ה-cmdlet Invoke-HuggingFaceHub אחראי להפעיל נקודות קצה ב-API של ה-Hub.  הפרמטרים זהים לאלו שתועדו בכתובת https://huggingface.co/docs/hub/en/api
עם זאת, תצטרך אסימון אם תצטרך לגשת למשאבים פרטיים: `Set-HuggingFaceToken` (או `Set-HfToken`)  הוא ה-cmdlet להזנת אסימון ברירת המחדל המשמש בכל הבקשות.  



# מבנה פקודות של ספק Hugging Face  
 
ספק ה-Hugging Face מאורגן ב-3 קבוצות עיקריות של פקודות: Gradio, Gradio Session ו-Hugging Face.  


## פקודות Gradio*`

ה-Cmdlets בקבוצת "gradio" מכילים את המבנה Verbo-GradioName.  פקודות אלו מיישמות גישה ל-API של Gradio.  
פקודות אלו הן בעצם עטיפות עבור ה-APIs. בנייתן התבססה על מסמך זה: https://www.gradio.app/guides/querying-gradio-apps-with-curl  וגם על צפייה בקוד המקור של Gradio (לדוגמה: [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
ניתן להשתמש בפקודות אלו עם כל אפליקציה של Gradio, ללא קשר למקום שבו היא מאוחסנת: במחשב המקומי שלך, ב-space של Hugging Face, בשרת בענן... 
אתה רק צריך את כתובת ה-URL הראשית של היישום.  


שקול אפליקציית Gradio זו:

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="Duration, in, seconds", value=5);
    txtResults = gr.Text(label="Resultado");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

בפשטות, אפליקציה זו מציגה 2 שדות טקסט, אחד מהם שבו המשתמש מזין טקסט והשני משמש להצגת הפלט.  
כפתור, שכאשר לוחצים עליו, מפעיל את הפונקציה Op1. הפונקציה מבצעת לולאה במשך מספר שניות שצוינו בפרמטר.  
בכל שניה, היא מחזירה את הזמן שעבר.  

נניח שבעת ההפעלה, אפליקציה זו זמינה בכתובת http://127.0.0.1:7860.
עם ספק זה, חיבור לאפליקציה זו פשוט:

```powershell
# התקן את powershai, אם הוא לא מותקן!
Install-Module powershai 

# ייבוא
import-module powershai 

# בדוק את נקודות הקצה של ה-api!
Get-GradioInfo http://127.0.0.1:7860
```

ה-cmdlet `Get-GradioInfo` הוא הפשוט ביותר. הוא רק קורא את נקודת הקצה /info שקיימת בכל אפליקציה של Gradio.  
נקודת קצה זו מחזירה מידע בעל ערך, כגון נקודות הקצה של ה-API הזמינות:

```powershell
# בדוק את נקודות הקצה של ה-api!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# רשימת הפרמטרים של נקודת הקצה
$AppInfo.named_endpoints.'/op1'.parameters
```

אתה יכול להפעיל את ה-API באמצעות ה-cmdlet `Send-GradioApi`.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

שים לב שעלינו להעביר את כתובת ה-URL, את שם נקודת הקצה ללא הסלש ואת מערך עם רשימת הפרמטרים.
תוצאת בקשה זו היא אירוע שניתן יהיה להשתמש בו כדי לשאול את תוצאת ה-API.
כדי לקבל את התוצאות, עליך להשתמש ב- `Update-GradioApiResult' 

```powershell
$Event | Update-GradioApiResult
```

ה-cmdlet `Update-GradioApiResult` יכתוב את האירועים שנוצרו על ידי ה-API בצינור.  
יוחזר אובייקט עבור כל אירוע שנוצר על ידי השרת. המאפיין `data` של אובייקט זה מכיל את הנתונים שוחזרו, אם קיימים.  


יש גם את הפקודה `Send-GradioFile`, שמאפשרת להעלות קבצים.  היא מחזירה מערך של אובייקטי FileData, שמייצגים את הקובץ בשרת.  

שים לב כיצד Cmdlets אלו פשוטים מאוד: אתה צריך לעשות הכל באופן ידני. לקבל את נקודות הקצה, להפעיל את ה-API, לשלוח את הפרמטרים כמערך, לבצע העלאת קבצים.  
למרות שפקודות אלו מופשטות מהקריאה הישירה ל-HTTP של Gradio, הן עדיין דורשות מהמשתמש לעשות הרבה.  
זו הסיבה שנוצרה קבוצת הפקודות GradioSession, שעוזרות להפשיט עוד יותר ולהקל על חיי המשתמש!


## פקודות GradioSession*  

פקודות קבוצת GradioSession עוזרות להפשיט עוד יותר את הגישה לאפליקציית Gradio.  
בעזרתן, אתה קרוב יותר ל-PowerShell בזמן האינטראקציה עם אפליקציית Gradio ורחוק יותר מהקריאה המקורית.  

נשתמש בדוגמה עצמה של האפליקציה הקודמת כדי לעשות כמה השוואות:

```powershell
# יוצר Session חדשה 
New-GradioSession http://127.0.0.1:7860
```

ה-cmdlet `New-GradioSession` יוצר Session חדשה עם Gradio.  ל-Session חדשה זו יש אלמנטים ייחודיים כמו SessionId, רשימת קבצים שהועלו, תצורות, וכו'.  
הפקודה מחזירה את האובייקט שמייצג Session זו, ואתה יכול לקבל את כל ה-Sessions שנוצרו באמצעות `Get-GradioSession`.  
דמיין Session של GradioSession ככרטיסיה בדפדפן פתוחה עם האפליקציה שלך של Gradio פתוחה.  

פקודות GradioSession פועלות, כברירת מחדל, ב-Session ברירת המחדל. אם קיימת רק Session אחת, היא Session ברירת המחדל.  
אם קיימות יותר משתיים, המשתמש צריך לבחור איזו היא ברירת המחדל באמצעות הפקודה `Set-GradioSession`

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

אחת הפקודות החזקות ביותר היא `New-GradioSessionApiProxyFunction` (או הכינוי GradioApiFunction).  
פקודה זו הופכת את ה-APIs של Gradio ב-Session לפונקציות PowerShell, כלומר, אתה יכול להפעיל את ה-API כאילו היא פונקציה של PowerShell.  
נחזור לדוגמה הקודמת


```powershell
# ראשית, פתיחת ה-Session!
New-GradioSession http://127.0.0.1:7860

# עכשיו, נצור את הפונקציות!
New-GradioSessionApiProxyFunction
```

הקוד לעיל ייצור פונקציה של PowerShell בשם Invoke-GradioApiOp1.  
לפונקציה זו יש אותם פרמטרים כמו נקודת הקצה '/op1', ואתה יכול להשתמש ב-get-help לקבלת מידע נוסף:  

```powershell
get-help -full Invoke-GradioApiOp1
```

כדי להפעיל, פשוט הפעל:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

שים לב כיצד הפרמטר `Duration` שהוגדר באפליקציית Gradio הפך לפרמטר של PowerShell.  
מאחורי הקלעים, Invoke-GradioApiOp1 מפעיל את `Update-GradioApiResult`, כלומר, ההחזרה היא אותו אובייקט!
אבל, שים לב כמה פשוט היה להפעיל את ה-API של Gradio ולקבל את התוצאה!

אפליקציות שמגדירות קבצים, כמו מוזיקה, תמונות, וכו', יוצרות פונקציות שמתבצעות באופן אוטומטי להעלאת קבצים אלו.  
המשתמש רק צריך לציין את הנתיב המקומי.  

אולי, יהיו סוגי נתונים נוספים שלא נתמכים בהמרה, ואם תמצא כאלה, פתח Issue (או שלח PR) כדי שנבדוק וניישם!



## פקודות HuggingFace* (או Hf*)  

פקודות קבוצה זו נוצרו כדי לפעול עם ה-API של Hugging Face.  
בפשטות, הן סוגרות בקריאת HTTP לנקודות קצה שונות של Hugging Face.  

לדוגמה:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

פקודה זו מחזירה אובייקט שמכיל מידע רב על ה-space diffusers-labs, של המשתמש rrg92.  
כיוון שזהו space של Gradio, אתה יכול לחבר אותו עם Cmdlets אחרים (Cmdlets של GradioSession יכולים להבין מתי אובייקט שמוחזר על ידי Get-HuggingFaceSpace מועבר אליהם!)

```
# חיבור ל-space (ובאופן אוטומטי, יצירת Session של Gradio)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

# ברירת מחדל
Set-GradioSession -Default $diff

# יצירת פונקציות!
New-GradioSessionApiProxyFunction

# הפעלה!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**חשוב: זכור שגישה ל-spaces מסוימים יכולה להתבצע רק עם אימות, במקרים אלו, עליך להשתמש ב-Set-HuggingFaceToken ולציין אסימון גישה.;**



<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
