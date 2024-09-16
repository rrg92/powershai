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

PowershAI (PowerShell + AI) هو وحدة نمطية تُدمج خدمات الذكاء الاصطناعي مباشرةً في PowerShell.  
يمكنك استدعاء الأوامر في كل من البرامج النصية وسطر الأوامر.  

تتوفر العديد من الأوامر التي تسمح لك بإجراء محادثات مع LLMs واستدعاء مساحات Hugging Face و Gradio ، إلخ.  
يمكنك الدردشة مع GPT-4o-mini و Gemini Flash و Llama 3.1 ، إلخ ، باستخدام رموزك الخاصة من هذه الخدمة.  
أيًّا كان، فأنت لا تدفع أي مبلغ لاستخدام PowershAI ، بالإضافة إلى التكاليف التي ستكون عليك دفعها عادةً عند استخدام هذه الخدمات.  

هذه الوحدة النمطية مثالية لدمج أوامر PowerShell مع LLMs المفضلة لديك، واختبار المكالمات، وpocs ، إلخ.  
إنها مثالية لأولئك الذين اعتادوا على استخدام PowerShell ويريدون دمج AI في برامجهم النصية بطريقة أبسط وأسهل!

تُظهر الأمثلة التالية كيفية استخدام Powershai في حالات شائعة:

## تحليل سجلات Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configure a token for OpenAI (only need to do this once)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Algum evento importante?"
```

## وصف الخدمات 
```powershell 
import-module powershai 

Set-GoogleApiKey # configure a token for Google Gemini (only need to do this once)
Set-AiProvider google

Get-Service | ia "Faça um resumo de quais serviços não são nativos do Windows e podem representar um risco"
```

## شرح التزامات git 
```powershell 
import-module powershai 

Set-MaritalkToken # configure a token for Maritaca.AI (brazilian LLM)
Set-AiProvider maritalk

git log --oneline | ia "Faça um resumo desses commits feitos"
```


الأمثلة المذكورة أعلاه هي مجرد عرض صغير لمدى سهولة البدء في استخدام AI في Powershell الخاص بك ودمجه مع أي أمر عمليًا!
[اكتشف المزيد في الوثائق](docs/pt-BR)

## التثبيت

توجد جميع الوظائف في دليل `powershai` ، وهو وحدة نمطية PowerShell.  
أبسط خيار للتثبيت هو باستخدام الأمر `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

بعد التثبيت، ما عليك سوى استيراده في جلستك:

```powershell
import-module powershai

# See the available commands
Get-Command -mo powershai
```

يمكنك أيضًا نسخ هذا المشروع مباشرةً واستيراد دليل powershai:

```powershell
cd CAMINHO

# Clone
git clone ...

#Import from the specific path!
Import-Module .\powershai
```

## استكشاف واساهم

لا يزال هناك الكثير مما يجب توثيقه وتطويره في PowershAI!  
مع تقدمي في إدخال التحسينات، أترك تعليقات في الكود لمساعدة أولئك الذين يرغبون في معرفة كيفية القيام بذلك!  
لا تتردد في استكشاف والمساهمة باقتراحات لتحسينات.

## مشاريع أخرى باستخدام PowerShell

فيما يلي بعض المشاريع المثيرة للاهتمام الأخرى التي تُدمج PowerShell مع AI:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

استكشف وتعلم واساهم!




<!--PowershaiAiDocBlockStart-->
_أرجو توضيح طلبك. ما الذي تريدني أن أترجمه؟ 
_
<!--PowershaiAiDocBlockEnd-->
