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

PowershAI (PowerShell + AI) هو وحدة نمطية تقوم بدمج خدمات الذكاء الاصطناعي مباشرةً في PowerShell.  
يمكنك استدعاء الأوامر في كل من البرامج النصية وسطر الأوامر.  

هناك العديد من الأوامر التي تسمح لك بإجراء محادثات مع LLMs ، واستدعاء مساحات من Hugging Face و Gradio ، إلخ.  
يمكنك الدردشة مع GPT-4o-mini و gemini flash و llama 3.1 ، إلخ ، باستخدام رموزك الخاصة من هذه الخدمة.  
بمعنى آخر ، لا تدفع أي شيء لاستخدام PowershAI ، بالإضافة إلى التكاليف التي ستكون لديك عادةً عند استخدام هذه الخدمات.  

هذه الوحدة النمطية مثالية لدمج أوامر PowerShell مع LLMs المفضلة لديك ، واختبار المكالمات ، و PoCs ، إلخ.  
إنه مثالي لأولئك الذين اعتادوا بالفعل على PowerShell ويريدون إحضار الذكاء الاصطناعي إلى نصوصهم بطريقة أبسط وأسهل!

تُظهر الأمثلة التالية كيفية استخدام Powershai في مواقف شائعة:

## تحليل سجلات Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configure a token for OpenAI (only need to do this 1x)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Algum evento importante?"
```

## وصف الخدمات 
```powershell 
import-module powershai 

Set-GoogleApiKey # configure a token for Google Gemini (only need to do this 1x)
Set-AiProvider google

Get-Service | ia "Faça um resumo de quais serviços não são nativos do Windows e podem representar um risco"
```

## شرح التزامات git 
```powershell 
import-module powershai 

Set-MaritalkToken # configure a token for Maritaca.AI (Brazilian LLM)
Set-AiProvider maritalk

git log --oneline | ia "Faça um resumo desses commits feitos"
```


الأمثلة المذكورة أعلاه هي مجرد عرض صغير لمدى سهولة بدء استخدام الذكاء الاصطناعي في Powershell الخاص بك ودمجه مع أي أمر تقريبًا!
[Explore more in the complete documentation](/docs/ar-SA)

## التثبيت

كل وظائف موجودة في الدليل `powershai` ، وهي وحدة نمطية PowerShell.  
أبسط طريقة للتثبيت هي استخدام الأمر `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

بعد التثبيت ، ما عليك سوى استيراده في جلستك:

```powershell
import-module powershai

# See the available commands
Get-Command -mo powershai
```

يمكنك أيضًا نسخ هذا المشروع مباشرةً واستيراد الدليل powershai:

```powershell
cd CAMINHO

# Clona
git clone ...

#Importar a partir do caminho específico!
Import-Module .\powershai
```

## استكشاف ومساهمة

لا يزال هناك الكثير لتوثيقه وتطويره في PowershAI!  
مع إجراء التحسينات ، أترك تعليقات في الكود لمساعدة أولئك الذين يرغبون في معرفة كيف فعلت ذلك!  
لا تتردد في استكشاف والمساهمة باقتراحات للتحسينات.

## مشاريع أخرى مع PowerShell

فيما يلي بعض المشاريع الأخرى المثيرة للاهتمام التي تقوم بدمج PowerShell مع الذكاء الاصطناعي:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

استكشف وتعلم وشارك!




<!--PowershaiAiDocBlockStart-->
_ترجم بشكل آلي باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
