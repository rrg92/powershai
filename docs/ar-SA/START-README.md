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

PowershAI (PowerShell + AI) هو وحدة نمطية تدمج خدمات الذكاء الاصطناعي مباشرة في PowerShell.  
يمكنك استدعاء الأوامر في كل من النصوص البرمجية وسطر الأوامر.  

يوجد العديد من الأوامر التي تسمح بإجراء محادثات مع LLMs ، واستدعاء مساحات Hugging Face ، و Gradio ، إلخ.  
يمكنك التحدث مع GPT-4o-mini ، gemini flash ، llama 3.1 ، إلخ ، باستخدام رموزك الخاصة من هذه الخدمة.  
أي أنك لا تدفع أي شيء لاستخدام PowershAI ، بالإضافة إلى التكاليف التي كنت ستتحملها عادةً عند استخدام هذه الخدمات.  

هذه الوحدة النمطية مثالية لدمج أوامر powershell مع LLMs المفضلة لديك ، واختبار المكالمات ، و pocs ، إلخ.  
وهو مثالي لأولئك الذين اعتادوا بالفعل على استخدام PowerShell ويريدون جلب الذكاء الاصطناعي إلى نصوصهم بطريقة أبسط وأسهل!

تُظهر الأمثلة التالية كيفية استخدام Powershai في المواقف الشائعة:

## تحليل سجلات Windows 
```powershell 
import-module powershai 

Set-OpenaiToken #  يُحدد رمزًا لـ OpenAI (يجب عليك القيام بذلك مرة واحدة فقط)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "هل هناك حدث مهم؟"
```

## وصف الخدمات 
```powershell 
import-module powershai 

Set-GoogleApiKey # يُحدد رمزًا لـ Google Gemini (يجب عليك القيام بذلك مرة واحدة فقط)
Set-AiProvider google

Get-Service | ia "قم بإجراء ملخص للخدمات التي ليست أصلية لنظام Windows والتي قد تشكل خطرًا"
```

## شرح التزامات git 
```powershell 
import-module powershai 

Set-MaritalkToken #  يُحدد رمزًا لـ Maritaca.AI (LLM البرازيلي)
Set-AiProvider maritalk

git log --oneline | ia "قم بإجراء ملخص لهذه التزامات التي تم إجراؤها"
```


الأمثلة المذكورة أعلاه ليست سوى عرض صغير لكيفية سهولة بدء استخدام الذكاء الاصطناعي في Powershell الخاص بك ودمجه مع أي أمر تقريبًا!
[استكشف المزيد في الوثائق](docs/pt-BR)

## التثبيت

توجد جميع الوظائف في دليل `powershai` ، وهو وحدة نمطية PowerShell.  
أبسط خيار للتثبيت هو باستخدام الأمر `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

بعد التثبيت ، ما عليك سوى استيراده في جلسة العمل:

```powershell
import-module powershai

#  شاهد الأوامر المتاحة
Get-Command -mo powershai
```

يمكنك أيضًا نسخ هذا المشروع مباشرة واستيراد دليل powershai:

```powershell
cd CAMINHO

#  نسخ
git clone ...

#  استيراد من المسار المحدد!
Import-Module .\powershai
```

## استكشف وساهم

لا يزال هناك الكثير لتوثيقه وتطويره في PowershAI!  
مع إجراء التحسينات ، أترك تعليقات في الكود لمساعدة أولئك الذين يرغبون في معرفة كيفية القيام بذلك!  
لا تتردد في استكشاف والمساهمة بآراء لتحسينات.

## مشاريع أخرى باستخدام PowerShell

فيما يلي بعض المشاريع المثيرة للاهتمام الأخرى التي تدمج PowerShell مع الذكاء الاصطناعي:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

استكشف ، وتعلم ، وساهم!




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
