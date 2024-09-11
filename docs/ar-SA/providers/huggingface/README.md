# مزود Hugging Face

Hugging Face هو أكبر مستودع لنماذج الذكاء الاصطناعي في العالم!  
هناك، لديك وصول إلى مجموعة مذهلة من النماذج، ومجموعات البيانات، والعروض التوضيحية مع Gradio، والمزيد!  

إنه GitHub للذكاء الاصطناعي، تجاري ومفتوح المصدر! 

يوصل مزود Hugging Face في PowershAI powershell الخاص بك بمجموعة مذهلة من الخدمات والنماذج.  

## Gradio

Gradio هو إطار عمل لإنشاء عروض توضيحية لنماذج الذكاء الاصطناعي. مع القليل من التعليمات البرمجية في بايثون، يمكنك رفع واجهات تقبل مدخلات متنوعة، مثل النص، والملف، وما إلى ذلك.  
وعلاوة على ذلك، فإنه يدير العديد من القضايا مثل قوائم الانتظار، والتحميلات، وما إلى ذلك. وأخيرًا، جنبًا إلى جنب مع الواجهة، يمكنه توفير واجهة برمجة تطبيقات (API) حتى تكون الوظيفة المعروضة عبر واجهة المستخدم قابلة للوصول أيضًا من خلال لغات البرمجة.  
يستفيد PowershAI من ذلك، ويعرض واجهات برمجة التطبيقات من Gradio بطريقة أسهل، حيث يمكنك استدعاء وظيفة من المحطة الخاصة بك والحصول على تجربة مشابهة تقريبًا!


## مركز Hugging Face  

مركز Hugging Face هو المنصة التي يمكنك الوصول إليها على https://huggingface.co  
إنه منظم في نماذج (models)، والتي هي أساسًا الشيفرة المصدرية لنماذج الذكاء الاصطناعي التي ينشئها أشخاص وشركات في جميع أنحاء العالم.  
هناك أيضًا "Spaces"، وهي المكان الذي يمكنك فيه رفع الشيفرة لنشر تطبيقات مكتوبة في بايثون (باستخدام Gradio، على سبيل المثال) أو Docker.  

تعرف على المزيد حول Hugging Face [في هذه التدوينة من مدونة Ia Talking](https://iatalk.ing/hugging-face/)  
وتعرف على مركز Hugging Face [في الوثائق الرسمية](https://huggingface.co/docs/hub/en/index)  

مع PowershaAI، يمكنك قائمة النماذج والتفاعل مع واجهة برمجة التطبيقات للعديد من المساحات، وتشغيل مجموعة متنوعة من تطبيقات الذكاء الاصطناعي من محطة العمل الخاصة بك.  


# الاستخدام الأساسي

يمتلك مزود Hugging Face في PowershAI العديد من cmdlets للتفاعل.  
إنه منظم في الأوامر التالية:

* الأوامر التي تتفاعل مع Hugging Face تحتوي على `HuggingFace` أو `Hf` في الاسم. مثال: `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* الأوامر التي تتفاعل مع Gradio، بغض النظر عما إذا كانت مساحة من Hugging Face أم لا، تحتوي على `Gradio` أو `GradioSession` في الاسم: `Send-GradioApi`, `Update-GradioSessionApiResult`  
* يمكنك استخدام هذا الأمر للحصول على القائمة الكاملة: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`  

لا تحتاج إلى تسجيل الدخول للوصول إلى الموارد العامة من Hugging Face.  
هناك مجموعة لا حصر لها من النماذج والمساحات المتاحة مجانًا دون الحاجة إلى تسجيل الدخول.  
على سبيل المثال، الأمر التالي يسرد أفضل 5 نماذج تم تنزيلها من Meta (المؤلف: meta-llama):

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

الأمر Invoke-HuggingFaceHub مسؤول عن استدعاء نقاط النهاية لواجهة برمجة التطبيقات للمركز. المعلمات هي نفسها الموثقة في https://huggingface.co/docs/hub/en/api  
ومع ذلك، ستحتاج إلى رمز مميز إذا كنت تحتاج إلى الوصول إلى الموارد الخاصة: `Set-HuggingFaceToken` (أو `Set-HfToken`) هو الأمر لإدخال الرمز المميز الافتراضي المستخدم في جميع الطلبات.  


# هيكل أوامر مزود Hugging Face  

مزود Hugging Face منظم في 3 مجموعات رئيسية من الأوامر: Gradio، جلسة Gradio و Hugging Face.  


## أوامر Gradio*

تحتوي cmdlets في مجموعة "gradio" على هيكل فعل-Gradioاسم. هذه الأوامر تنفذ الوصول إلى واجهة برمجة تطبيقات Gradio.  
هذه الأوامر هي في الأساس أغلفة لواجهات برمجة التطبيقات. تم بناءها بناءً على هذه الوثيقة: https://www.gradio.app/guides/querying-gradio-apps-with-curl وكذلك من خلال مراقبة الشيفرة المصدرية لـ Gradio (مثل: [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py))  
يمكن استخدام هذه الأوامر مع أي تطبيق Gradio، بغض النظر عن مكان استضافته: على جهازك المحلي، في مساحة Hugging Face، على خادم في السحابة...  
كل ما تحتاجه هو عنوان URL الرئيسي للتطبيق.  


اعتبر هذا التطبيق Gradio:

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

أساسياً، هذا التطبيق يعرض حقلين نصيين، أحدهما حيث يقوم المستخدم بإدخال نص والآخر يستخدم لعرض الخرج.  
زر، عند النقر عليه، يشغل الوظيفة Op1. تقوم الوظيفة بعمل حلقة لمدة عدد معين من الثواني المحددة في المعامل.  
في كل ثانية، تعيد مقدار الوقت المنقضي.  

افترض أنه عند البدء، هذا التطبيق متاح على http://127.0.0.1:7860.  
مع هذا المزود، الاتصال بهذا التطبيق بسيط:

```powershell
# قم بتثبيت powershai، إذا لم يكن مثبتًا!
Install-Module powershai 

# استورد
import-module powershai 

# تحقق من نقاط نهاية واجهة برمجة التطبيقات!
Get-GradioInfo http://127.0.0.1:7860
```

الأمر `Get-GradioInfo` هو الأكثر بساطة. إنه فقط يقرأ نقطة النهاية /info التي تمتلكها كل تطبيق Gradio.  
تُرجع هذه النقطة معلومات قيمة، مثل نقاط نهاية واجهة برمجة التطبيقات المتاحة:

```powershell
# تحقق من نقاط نهاية واجهة برمجة التطبيقات!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# قائمة المعلمات لنقطة النهاية
$AppInfo.named_endpoints.'/op1'.parameters
```

يمكنك استدعاء واجهة برمجة التطبيقات باستخدام الأمر `Send-GradioApi`.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

لاحظ أننا بحاجة إلى تمرير عنوان URL، اسم نقطة النهاية بدون الشريط ومصفوفة مع قائمة المعلمات.  
نتيجة هذا الطلب هي حدث يمكن استخدامه للاستعلام عن نتيجة واجهة برمجة التطبيقات.  
للحصول على النتائج، يجب عليك استخدام `Update-GradioApiResult`  

```powershell
$Event | Update-GradioApiResult
```

الأمر `Update-GradioApiResult` سيكتب الأحداث الناتجة عن واجهة برمجة التطبيقات في سلسلة الأنابيب.  
سيتم إرجاع كائن لكل حدث تم إنشاؤه بواسطة الخادم. تحتوي الخاصية `data` لهذا الكائن على البيانات المرتجعة، إن وجدت.  


لا يزال هناك الأمر `Send-GradioFile`، الذي يسمح بتحميل الملفات. إنه يعيد مصفوفة من كائنات FileData، التي تمثل الملف على الخادم.  

لاحظ كيف أن هذه الأوامر بدائية جدًا: يجب عليك القيام بكل شيء يدويًا. الحصول على نقاط النهاية، استدعاء واجهة برمجة التطبيقات، إرسال المعلمات كمصفوفة، تحميل الملفات.  
على الرغم من أن هذه الأوامر تعزل المكالمات HTTP المباشرة لـ Gradio، إلا أنها لا تزال تتطلب الكثير من المستخدم.  
لهذا السبب، تم إنشاء مجموعة أوامر GradioSession، التي تساعد في تجريد المزيد وجعل حياة المستخدم أسهل! 


## أوامر GradioSession*  

تساعد أوامر مجموعة GradioSession في تجريد المزيد من الوصول إلى تطبيق Gradio.  
معها، تكون أقرب إلى powershell عند التفاعل مع تطبيق Gradio وأبعد عن المكالمات الأصلية.  

دعنا نستخدم المثال السابق للتطبيق لإجراء بعض المقارنات:

```powershell```powershell
# ينشئ جلسة جديدة
New-GradioSession http://127.0.0.1:7860
```

<!--! --> 
يستخدم الأمر `New-GradioSession` لإنشاء جلسة جديدة مع Gradio. تحتوي هذه الجلسة الجديدة على عناصر فريدة مثل SessionId، قائمة الملفات التي تم تحميلها، الإعدادات، إلخ.  
يعيد الأمر كائنًا يمثل هذه الجلسة، ويمكنك الحصول على جميع الجلسات التي تم إنشاؤها باستخدام `Get-GradioSession`.  
تخيل أن GradioSession مثل علامة تبويب في المتصفح مفتوحة مع تطبيق Gradio الخاص بك مفتوحًا.  

تعمل أوامر GradioSession، بشكل افتراضي، على الجلسة الافتراضية. إذا كان هناك جلسة واحدة فقط، فإنها هي الجلسة الافتراضية.  
إذا كان هناك أكثر من واحدة، يجب على المستخدم اختيار أيهما هي الجلسة الافتراضية باستخدام الأمر `Set-GradioSession`

```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

واحد من الأوامر الأكثر قوة هو `New-GradioSessionApiProxyFunction` (أو اسم مستعار GradioApiFunction).  
هذا الأمر يحول واجهات برمجة التطبيقات الخاصة بـ Gradio للجلسة إلى وظائف PowerShell، بمعنى أنك يمكنك استدعاء واجهة برمجة التطبيقات كما لو كانت وظيفة PowerShell.  
لنعد إلى المثال السابق

```powershell
# أولاً، فتح الجلسة!
New-GradioSession http://127.0.0.1:7860

# الآن، لننشئ الوظائف!
New-GradioSessionApiProxyFunction
```

سيولد الكود أعلاه وظيفة PowerShell تُدعى Invoke-GradioApiOp1.  
تحتوي هذه الوظيفة على نفس المعلمات التي يحتوي عليها نقطة النهاية '/op1'، ويمكنك استخدام get-help لمزيد من المعلومات:  

```powershell
get-help -full Invoke-GradioApiOp1
```

لتنفيذها، ما عليك سوى استدعاء:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

لاحظ كيف أن المعلمة `Duration` المحددة في تطبيق Gradio أصبحت معلمة PowerShell.  
تحت الغطاء، يقوم Invoke-GradioApiOp1 بتنفيذ `Update-GradioApiResult`، بمعنى أن الإرجاع هو نفس الكائن!  
لكن، لاحظ كم كان من الأسهل استدعاء واجهة برمجة التطبيقات الخاصة بـ Gradio واستلام النتيجة!

التطبيقات التي تحدد الملفات، مثل الموسيقى والصور، تولد وظائف تقوم تلقائيًا بتحميل تلك الملفات.  
يحتاج المستخدم فقط إلى تحديد المسار المحلي.  

في بعض الأحيان، قد يكون هناك نوع أو آخر من البيانات غير المدعومة في التحويل، وإذا واجهت ذلك، افتح مشكلة (أو قدم PR) لنقيمها وننفذها!

## أوامر HuggingFace* (أو Hf*)  

تم إنشاء أوامر هذه المجموعة للعمل مع واجهة برمجة التطبيقات الخاصة بـ Hugging Face.  
أساسًا، يقومون بتغليف المكالمات HTTP إلى نقاط النهاية المختلفة لـ Hugging Face.  

مثال:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

هذا الأمر يعيد كائنًا يحتوي على معلومات متنوعة حول مساحة diffusers-labs، من المستخدم rrg92.  
نظرًا لأنه مساحة Gradio، يمكنك توصيله بالأوامر الأخرى (تستطيع أوامر GradioSession فهم متى يتم تمرير كائن تم إعادته بواسطة Get-HuggingFaceSpace إليهم!)

```
# الاتصال بالمساحة (و، تلقائيًا، ينشئ جلسة Gradio)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

# افتراضي
Set-GradioSession -Default $diff

# إنشاء الوظائف!
New-GradioSessionApiProxyFunction

# استدعاء!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**مهم: تذكر أن الوصول إلى مساحات معينة قد يتطلب المصادقة، في هذه الحالات، يجب عليك استخدام Set-HuggingFaceToken وتحديد رمز وصول.**


_تمت الترجمة تلقائيًا باستخدام PowershAI و IA_
