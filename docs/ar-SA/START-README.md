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

PowershAI (PowerShell + AI) هو وحدة تدمج خدمات الذكاء الاصطناعي مباشرة في PowerShell.  
يمكنك استدعاء الأوامر سواء في السكربتات أو في سطر الأوامر.  

يوجد العديد من الأوامر التي تسمح بالمحادثات مع LLMs، استدعاء المساحات من Hugging Face، Gradio، إلخ.  
يمكنك التحدث مع GPT-4o-mini، gemini flash، llama 3.1، إلخ، باستخدام الرموز الخاصة بك من هذه الخدمات.  
هذا يعني أنك لا تدفع شيئًا لاستخدام PowershAI، بخلاف التكاليف التي قد تكون لديك عادة عند استخدام هذه الخدمات.  

هذه الوحدة مثالية لدمج أوامر PowerShell مع LLM المفضل لديك، اختبار المكالمات، إثبات المفاهيم، إلخ.  
إنها مثالية لمن اعتاد بالفعل على PowerShell ويريد إدخال الذكاء الاصطناعي في سكريبتاته بطريقة أبسط وأسهل!

> [!IMPORTANT]
> هذه ليست وحدة رسمية من OpenAI أو Google أو Microsoft أو أي مزود آخر مدرج هنا!
> هذا المشروع هو مبادرة شخصية، وهدفه أن يتم الحفاظ عليه من قبل المجتمع المفتوح المصدر.

تظهر الأمثلة التالية كيف يمكنك استخدام PowershAI في مواقف شائعة:

## تحليل سجلات Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # يهيئ رمزًا لـ OpenAI (يحتاج إلى القيام بذلك مرة واحدة فقط)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "هل هناك حدث مهم؟"
```

## وصف الخدمات 
```powershell 
import-module powershai 

Set-GoogleApiKey # يهيئ رمزًا لـ Google Gemini (يحتاج إلى القيام بذلك مرة واحدة فقط)
Set-AiProvider google

Get-Service | ia "قم بعمل ملخص للخدمات التي ليست أصلية في Windows وقد تمثل خطرًا"
```

## شرح التغييرات في git 
```powershell 
import-module powershai 

Set-MaritalkToken # يهيئ رمزًا لـ Maritaca.AI (LLM برازيلي)
Set-AiProvider maritalk

git log --oneline | ia "قم بعمل ملخص لهذه التغييرات"
```

الأمثلة أعلاه هي مجرد عرض صغير لكيفية سهولة البدء في استخدام الذكاء الاصطناعي في PowerShell الخاص بك ودمجه مع أي أمر تقريبًا!
[استكشف المزيد في الوثائق الكاملة](/docs/ar-SA)

## التثبيت

توجد جميع الوظائف في الدليل `powershai`، وهو وحدة PowerShell.  
أبسط خيار للتثبيت هو باستخدام الأمر `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

بعد التثبيت، ما عليك سوى استيرادها في جلستك:

```powershell
import-module powershai

# عرض الأوامر المتاحة
Get-Command -mo powershai
```

يمكنك أيضًا استنساخ هذا المشروع مباشرة واستيراد دليل powershai:

```powershell
cd CAMINHO

# استنساخ
git clone ...

#استيراد من المسار المحدد!
Import-Module .\powershai
```

## استكشف وساهم

لا يزال هناك الكثير لتوثيقه وتطويره في PowershAI!  
بينما أقوم بتحسينات، أترك تعليقات في الكود لمساعدة أولئك الذين يرغبون في التعلم كيف فعلت ذلك!  
لا تتردد في الاستكشاف والمساهمة بأفكار لتحسينات.

## مشاريع أخرى مع PowerShell

إليك بعض المشاريع الأخرى المثيرة للاهتمام التي تدمج PowerShell مع الذكاء الاصطناعي:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

استكشف، تعلم وساهم!


<!--PowershaiAiDocBlockStart-->
_تمت الترجمة تلقائيًا باستخدام PowershAI و الذكاء الاصطناعي_
<!--PowershaiAiDocBlockEnd-->
