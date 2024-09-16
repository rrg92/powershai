![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [english](docs/en-US/START-README.md)
* [Français](docs/fr-FR/START-README.md)
* [日本語](docs/ja-JP/START-README.md)
* [العربية](docs/sa-SA/START-README.md)

PowershAI (PowerShell + AI) هو وحدة نمطية تُدمج خدمات الذكاء الاصطناعي مباشرة في PowerShell.  
يمكنك استدعاء الأوامر في كل من البرامج النصية وسطر الأوامر.  

توجد أوامر متعددة تسمح بالمحادثات مع LLMs واستدعاء مساحات Hugging Face و Gradio، إلخ.  
يمكنك التحدث إلى GPT-4o-mini و gemini flash و llama 3.1، إلخ، باستخدام رموزك الخاصة لهذه الخدمة.  
أي أنك لا تدفع أي رسوم لاستخدام PowershAI، بالإضافة إلى التكاليف التي ستكون عليك دفعها بشكل طبيعي عند استخدام هذه الخدمات.  

هذه الوحدة النمطية مثالية لدمج أوامر PowerShell مع LLMs المفضلة لديك، واختبار المكالمات، و POCs، إلخ.  
مثالية لأولئك الذين اعتادوا على استخدام PowerShell ويرغبون في دمج الذكاء الاصطناعي في نصوصهم بطريقة أسهل وأبسط!

توضح الأمثلة التالية كيفية استخدام Powershai في المواقف الشائعة:

## تحليل سجلات Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # يضبط رمزًا لـ OpenAI (يجب القيام بذلك مرة واحدة فقط)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "هل هناك حدث مهم؟"
```

## وصف الخدمات 
```powershell 
import-module powershai 

Set-GoogleApiKey # يضبط رمزًا لـ Google Gemini (يجب القيام بذلك مرة واحدة فقط)
Set-AiProvider google

Get-Service | ia "قم بإعداد ملخص لخدمات غير أصلية في Windows والتي قد تشكل خطورة"
```

## شرح التزامات git 
```powershell 
import-module powershai 

Set-MaritalkToken # يضبط رمزًا لـ Maritaca.AI (LLM برازيلي)
Set-AiProvider maritalk

git log --oneline | ia "قم بإعداد ملخص لهذه التزامات التي تم إجراؤها"
```


الأمثلة أعلاه هي مجرد عرض صغير لكيفية سهولة البدء في استخدام الذكاء الاصطناعي في Powershell ودمجه مع أي أمر تقريبًا!
[استكشف المزيد في الوثائق](docs/pt-BR)

## التثبيت

توجد جميع الوظائف في دليل `powershai`، وهو وحدة نمطية PowerShell.  
أبسط خيار للتثبيت هو استخدام الأمر `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

بعد التثبيت، ما عليك سوى استيراده إلى جلسة عملك:

```powershell
import-module powershai

# شاهد الأوامر المتاحة
Get-Command -mo powershai
```

يمكنك أيضًا نسخ هذا المشروع مباشرة واستيراد دليل powershai:

```powershell
cd CAMINHO

# النسخ
git clone ...

# استيراد من المسار المحدد!
Import-Module .\powershai
```

## استكشف واساهم

لا يزال هناك الكثير لتوثيقه وتطويره في PowershAI!  
مع قيامي بإجراء تحسينات، أترك تعليقات في الكود لمساعدة أولئك الذين يرغبون في معرفة كيفية قيامي بذلك!  
لا تتردد في استكشاف والمساهمة باقتراحات لتحسينات.

## مشاريع أخرى مع PowerShell

فيما يلي بعض المشاريع المثيرة للاهتمام الأخرى التي تُدمج PowerShell مع الذكاء الاصطناعي:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

استكشف وتعلم واساهم!




<!--PowershaiAiDocBlockStart-->
_ترجمت تلقائيًا باستخدام PowershAI و AI. 
_
<!--PowershaiAiDocBlockEnd-->
