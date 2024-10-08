﻿# دردشة 


# مقدمة <!--! @#Short --> 

يحدد PowershAI مفهوم الدردشة، والذي يساعد في إنشاء سجل وسياق للمحادثات!  

# تفاصيل  <!--! @#Long --> 

يقوم PowershAI بإنشاء مفهوم الدردشة، والذي يشبه إلى حد كبير مفهوم الدردشة في معظم خدمات LLM.  

تسمح الدردشة بالتحدث مع خدمات LLM بطريقة قياسية، بغض النظر عن مزود الخدمة الحالي.  
توفر طريقة قياسية لهذه الوظائف:

- سجل الدردشة 
- السياق 
- خط الأنابيب (استخدام نتيجة أوامر أخرى)
- استدعاء الأداة (تنفيذ الأوامر بناءً على طلب LLM)

لا يدعم جميع المزودين الدردشة.  
للتأكد من دعم المزود للدردشة، استخدم cmdlet Get-AiProviders، وقم بالرجوع إلى خاصية "Chat". إذا كانت $true، فسيتم دعم الدردشة.  
وبمجرد دعم الدردشة، قد لا يتم دعم جميع الميزات، بسبب قيود المزود.  

## بدء دردشة جديدة 

أبسط طريقة لبدء دردشة جديدة هي استخدام أمر Send-PowershaiChat.  
بالتأكيد، يجب عليك استخدامه بعد تكوين المزود (باستخدام `Set-AiProvider`) والإعدادات الأولية، مثل المصادقة، إذا لزم الأمر.  

```powershell 
Send-PowershaiChat "مرحبًا، أُحادثك من PowershAI"
```

للمزيد من البساطة، فإن الأمر `Send-PowershaiChat` لديه اسم مستعار يسمى `ia` (اختصار لـ الذكاء الاصطناعي).  
باستخدامه، يمكنك اختصار الأمر إلى حد كبير والتركيز على موجه الإدخال:

```powershell 
ia "مرحبًا، أُحادثك من PowershAI"
```

يتم إرسال كل رسالة في دردشة.  إذا لم تقم بإنشاء دردشة بشكل صريح، فستُستخدم الدردشة الخاصة التي تُسمى `default`.  
يمكنك إنشاء دردشة جديدة باستخدام `New-PowershaiChat`.  

كل دردشة لها سجل محادثة خاص بها وإعدادات. قد تحتوي على وظائفها الخاصة، إلخ.
قد يكون إنشاء دردشة إضافية مفيدًا إذا كنت بحاجة إلى الحفاظ على أكثر من موضوع دون اختلاطها!


## أوامر الدردشة  

الأوامر التي تتعامل مع الدردشة بطريقة أو بأخرى تأتي بتنسيق `*-Powershai*Chat*`.  
عادةً، تقبل هذه الأوامر معلمة -ChatId، والتي تتيح لك تحديد اسم أو كائن الدردشة التي تم إنشاؤها باستخدام `New-PowershaiChat`.  
إذا لم يتم تحديده، فسيتم استخدام الدردشة النشطة.  

## الدردشة النشطة  

الدردشة النشطة هي الدردشة الافتراضية التي تستخدمها أوامر PowershAI.  
عندما يتم إنشاء دردشة واحدة فقط، يتم اعتبارها الدردشة النشطة.  
إذا كان لديك أكثر من دردشة نشطة، فيمكنك استخدام الأمر `Set-PowershaiActiveChat` لتحديد أي منها نشطة. يمكنك تمرير الاسم أو الكائن الذي تم إرجاعه بواسطة `New-PowershaiChat`.


## معلمات الدردشة  

كل دردشة لها بعض المعلمات التي تتحكم في جوانب متنوعة.  
على سبيل المثال، الحد الأقصى لعدد الرموز المراد إرجاعها بواسطة LLM.  

يمكن إضافة معلمات جديدة مع كل إصدار من PowershAI.  
أبسط طريقة للحصول على المعلمات وما تفعله هي استخدام الأمر `Get-PowershaiChatParameter`;  
سيعرض هذا الأمر قائمة المعلمات التي يمكن ضبطها، جنبًا إلى جنب مع القيمة الحالية ووصف كيفية استخدامها.  
يمكنك تغيير المعلمات باستخدام الأمر `Set-PowershaiChatParameter`.  

بعض المعلمات المدرجة هي معلمات مباشرة من واجهة برمجة تطبيقات المزود. ستأتي مع وصف يشير إلى ذلك.  

## السياق والسجل  

كل دردشة لها سياق وسجل.  
السجل هو جميع سجل الرسائل التي تم إرسالها واستلامها في المحادثة.
حجم السياق هو مقدار السجل الذي سيتم إرساله إلى LLM، حتى يتذكر الردود.  

لاحظ أن حجم السياق هو مفهوم من PowershAI، وليس هو نفسه "طول السياق" الذي تم تعريفه في LLM.  
يؤثر حجم السياق فقط على PowershAI، وقد يتجاوز، اعتمادًا على القيمة، طول سياق المزود، مما قد يؤدي إلى حدوث أخطاء.  
من المهم الحفاظ على توازن حجم السياق بين الحفاظ على LLM مُحدثًا بما قيل سابقًا وعدم تجاوز الحد الأقصى لعدد رموز LLM.  

يمكنك التحكم في حجم السياق باستخدام معلمة الدردشة، أي باستخدام `Set-PowershaiChatParameter`.

لاحظ أن السجل والسياق يتم تخزينهما في ذاكرة الجلسة، أي إذا قمت بإغلاق جلسة Powershell، فسيُفقدان.  
في المستقبل، قد يكون لدينا آليات تتيح للمستخدم حفظ البيانات تلقائيًا واسترجاعها بين الجلسات.  

أيضًا، من المهم أن تتذكر أنه بمجرد تخزين السجل في ذاكرة Powershell، قد تؤدي المحادثات الطويلة جدًا إلى حدوث تجاوز أو استهلاك كبير لذاكرة Powershell.  
يمكنك إعادة تعيين الدردشة في أي وقت باستخدام الأمر `Reset-PowershaiCurrentChat`، والذي سيحذف جميع سجلات الدردشة النشطة.  
استخدم بحذر، لأن هذا سيؤدي إلى فقدان جميع السجلات ولن يتذكر LLM التفاصيل المذكورة خلال المحادثة.  


## خط الأنابيب  

واحدة من أقوى ميزات دردشة PowershAI هي التكامل مع خط أنابيب Powershell.  
ببساطة، يمكنك تمرير نتيجة أي أمر Powershell وسيتم استخدامه كسياق.  

يقوم PowershAI بذلك بتحويل الكائنات إلى نص وإرسالها في موجه الإدخال.  
ثم، سيتم إضافة رسالة الدردشة بعد ذلك.  

على سبيل المثال:

```
Get-Service | ia "قم بإجراء ملخص حول الخدمات غير شائعة في Windows"
```

في إعدادات PowershAI الافتراضية، سيحصل الأمر `ia` (اسم مستعار لـ `Send-PowershaiChat`) على جميع الكائنات التي تم إرجاعها بواسطة `Get-Service` وصيغتها كسلسلة واحدة ضخمة.  
ثم سيتم حقن هذه السلسلة في موجه إدخال LLM، وسيتم توجيهه لاستخدام هذه النتيجة كـ "سياق" لموجه إدخال المستخدم.  

سيتم دمج موجه إدخال المستخدم بعد ذلك.  

بهذه الطريقة، يتم إنشاء تأثير قوي: يمكنك دمج مخرجات الأوامر بسهولة مع موجه الإدخال، باستخدام خط أنابيب بسيط، وهو عملية شائعة في Powershell.  
يميل LLM إلى مراعاة ذلك جيدًا.  

على الرغم من امتلاكها قيمة افتراضية، إلا أن لديك تحكمًا كاملاً في كيفية إرسال هذه الكائنات.  
أول طريقة للتحكم هي كيفية تحويل الكائن إلى نص. نظرًا لأن موجه الإدخال هو سلسلة، فمن الضروري تحويل هذا الكائن إلى نص.  
بشكل افتراضي، يحول إلى تمثيل قياسي لـ Powershell، وفقًا للنوع (باستخدام الأمر `Out-String`).  
يمكنك تغيير ذلك باستخدام الأمر `Set-PowershaiChatContextFormatter`. يمكنك تحديد، على سبيل المثال، JSON أو جدول، وحتى برنامج نصي مخصص للحصول على تحكم كامل.  

الطريقة الأخرى للتحكم في كيفية إرسال السياق هي استخدام معلمة الدردشة `ContextFormat`.  
تتحكم هذه المعلمة في جميع الرسائل التي سيتم حقنها في موجه الإدخال. إنها كتلة برنامج نصي.  
يجب عليك إرجاع مصفوفة من السلاسل، والتي تعادل موجه الإدخال المرسل.  
يحتوي هذا البرنامج النصي على وصول إلى معلمات مثل الكائن المُنسق الذي يتم تمريره عبر خط الأنابيب، وقيم معلمات الأمر Send-PowershaiChat، إلخ.  
قيمة البرنامج النصي الافتراضية مدمجة، ويجب عليك التحقق مباشرة من الكود لمعرفة كيفية إرساله (وللحصول على مثال لكيفية تنفيذ البرنامج النصي الخاص بك).  


###  أدوات

واحدة من الميزات الرائعة التي تم تنفيذها هي دعم استدعاء الوظيفة (أو استدعاء الأداة).  
تتيح هذه الميزة، المتاحة في العديد من LLMs، للذكاء الاصطناعي تحديد استدعاء الوظائف لجلب بيانات إضافية في الرد.  
ببساطة، تصف وظيفة واحدة أو أكثر ومعلماتها، ويمكن للنموذج تحديد استدعاءها.  

**هام: ستتمكن فقط من استخدام هذه الميزة في المزودين الذين يعرّفون استدعاء الوظيفة باستخدام نفس المواصفات المحددة في OpenAI**

لمزيد من التفاصيل، راجع وثائق OpenAI الرسمية حول استدعاء الوظيفة: [استدعاء الوظيفة](https://platform.openai.com/docs/guides/function-calling).

يقوم النموذج فقط بتحديد الوظائف التي يجب استدعاءها، ومتى يجب استدعاءها، ومعلماتها. يتم تنفيذ هذا الاستدعاء بواسطة العميل، في حالتنا، PowershAI.  
تتوقع النماذج تعريف الوظائف من خلال وصف ما تفعله، ومعلماتها، ونتائجها، إلخ.  في الأصل، يتم ذلك باستخدام شيء مثل مواصفات OpenAPI لوصف الوظائف.  
ومع ذلك، فإن Powershell لديه نظام مساعدة قوي باستخدام التعليقات، والذي يسمح بوصف الوظائف ومعلماتها، بالإضافة إلى أنواع البيانات.  

يدمج PowershAI مع هذا النظام لمساعدة المستخدمين على ترجمته إلى مواصفات OpenAPI. يمكن للمستخدم كتابة وظائفه كالمعتاد، باستخدام التعليقات لتوثيقها، وسيتم إرسالها إلى النموذج.  

لتوضيح هذه الميزة، دعونا نقدم دليلاً تعليميًا بسيطًا: أنشئ ملفًا يسمى `MinhasFuncoes.ps1` مع المحتوى التالي

```powershell
# ملف MinhasFuncoes.ps1، احفظه في أي مجلد تفضله!

<#
    .DESCRIPTION
    قائمة الوقت الحالي
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    احصل على رقم عشوائي!
#>
function NumeroAleatorio {
    param(
        # أدنى رقم
        $Min = $null,
        
        # أعلى رقم
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**لاحظ استخدام التعليقات لوصف الوظائف والمعلمات**.  
هذه عبارة عن صيغة يدعمها PowerShell، تُعرف باسم [المساعدة القائمة على التعليقات](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

الآن، دعونا نضيف هذا الملف إلى PowershAI:

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #قم بتكوين رمز الدخول إذا لم تقم بتكوينه بعد.


# أضف البرنامج النصي كأدوات!
# افترض أن البرنامج النصي تم حفظه في C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# تأكد من إضافة الأدوات 
Get-AiTool
```

جرب أن تطلب من النموذج التاريخ الحالي أو اطلب منه إنشاء رقم عشوائي! سترى أنه سيقوم بتنفيذ وظائفك! هذا يفتح إمكانيات لا حصر لها، وتكون إبداعك هو الحد!

```powershell
ia "كم الساعة؟"
```

في الأمر أعلاه، سيقوم النموذج باستدعاء الوظيفة. سترى على الشاشة تنفيذ الوظيفة!  
يمكنك إضافة أي أمر أو برنامج نصي Powershell كأداة.  
استخدم الأمر `Get-Help -Full Add-AiTol` لمزيد من التفاصيل حول كيفية استخدام هذه الوظيفة القوية.

يتولى PowershAI تلقائيًا مسؤولية تنفيذ الأوامر وإرسال الرد مرة أخرى إلى النموذج.  
إذا قرر النموذج تنفيذ العديد من الوظائف بالتوازي، أو أصرت على تنفيذ وظائف جديدة، فسيتعامل PowershAI مع ذلك تلقائيًا.  
لاحظ أنه لتجنب الدخول في حلقة لا نهائية من التنفيذ، يفرض PowershAI حدًا أقصى لعدد مرات التنفيذ.  
المعلمة التي تتحكم في هذه التفاعلات مع النموذج هي `MaxInteractions`.  


### Invoke-AiChatTools و Get-AiChat 

هذان cmdlet هما أساس ميزة الدردشة في PowershAI.  
`Get-AiChat` هو الأمر الذي يسمح لك بالتواصل مع LLM بالطريقة البدائية قدر الإمكان، شبه قريبة من مكالمة HTTP.  
إنه، في الأساس، غلاف موحد لواجهة برمجة التطبيقات التي تتيح لك إنشاء نص.  
تُقدم المعلمات، والتي تكون موحدة، ويرجع ردًا، يكون موحدًا أيضًا،
بغض النظر عن المزود، يجب أن يتبع الرد نفس القاعدة!

بينما cmdlet `Invoke-AiChatTools` أكثر تعقيدًا وذو مستوى أعلى قليلاً.  
يسمح لك بتحديد وظائف Powershell كأدوات. يتم تحويل هذه الوظائف إلى تنسيق يفهمه LLM.  
يستخدم نظام مساعدة PowerShell للحصول على جميع البيانات الوصفية الممكنة لإرسالها إلى النموذج.  
يقوم بإرسال البيانات إلى النموذج باستخدام الأمر `Get-Aichat`. عند الحصول على الرد، فإنه يصادق على وجود استدعاء للأداة، وإذا وجد، فإنه يقوم بتنفيذ الوظائف المكافئة ويرجع الرد.  
يستمر في القيام بهذه الدورة حتى يوقف النموذج الرد أو حتى يتم الوصول إلى الحد الأقصى لعدد التفاعلات.  
التفاعل هو مكالمة واجهة برمجة تطبيقات للنموذج. عند استدعاء Invoke-AiChatTools باستخدام الوظائف، قد يكون هناك حاجة إلى العديد من المكالمات لإرجاع الردود إلى النموذج.  

يوضح الرسم البياني التالي هذا التدفق:

```
	sequenceDiagram
		Invoke-AiChatTools->>modelo:prompt (INTERAÇÃO 1)
		modelo->>Invoke-AiChatTools:(response, 3 function call)
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 1
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 2
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 3
		Invoke-AiChatTools->>modelo:Resultado tool call + prompts anteriores prompt (INTERAÇÃO 2)
		modelo->>Invoke-AiChatTools:resposta final
```


#### كيف يتم تحويل الأوامر واستدعائها

يتوقع الأمر `Invoke-AiChatTools` في معلمة -Functions قائمة بأوامر Powershell مُقترنة بمخططات OpenAPI.  
يتوقع كائنًا نسميه OpenaiTool، والذي يحتوي على خصائص `tools` التالية: (اسم OpenAiTool يرجع إلى حقيقة أننا نستخدم نفس تنسيق استدعاء الأداة الخاص بـ OpenAI)

- tools  
تحتوي هذه الخاصية على مخطط استدعاء الوظيفة الذي سيتم إرساله إلى LLM (في المعلمات التي تتوقع هذه المعلومات).  

- map  
هذه هي طريقة تُرجع أمر Powershell (وظيفة أو اسم مستعار أو cmdlet أو ملف تنفيذي، إلخ.) الذي يجب تنفيذه.  
يجب أن تُرجع هذه الطريقة كائنًا يحتوي على خاصية تُسمى "func"، والتي يجب أن تكون اسم وظيفة أو أمر قابل للتنفيذ أو كتلة برنامج نصي.  
سيستقبل في الوسيطة الأولى اسم الأداة، وفي الوسيطة الثانية كائن OpenAiTool نفسه (كما لو كان this).

بالإضافة إلى هذه الخصائص، يُمكن إضافة أي خاصية أخرى إلى كائن OpenaiTool. يسمح ذلك لبرنامج النصي map بالوصول إلى أي بيانات خارجية قد يحتاجها.  

عندما يرد LLM بطلب استدعاء الوظيفة، يتم تمرير اسم الوظيفة التي يجب استدعاءها إلى طريقة `map`، ويجب أن تُرجع الأمر الذي يجب تنفيذه. 
يفتح هذا العديد من الاحتمالات، مما يسمح بتحديد الأمر الذي سيتم تنفيذه في وقت التشغيل من اسم.  
بفضل هذه الآلية، يكون لدى المستخدم تحكمًا كاملًا ومرونة في كيفية الرد على استدعاء الأداة من LLM.  

ثم سيتم استدعاء الأمر وسيتم تمرير المعلمات والقيم التي أرسلها النموذج كـ Bounded Arguments.  
بمعنى آخر، يجب أن يكون الأمر أو البرنامج النصي قادرًا على تلقي المعلمات (أو تحديدها ديناميكيًا) من اسمها.


يتم تنفيذ كل هذا في حلقة تتكرر، بشكل تسلسلي، في كل استدعاء للأداة التي تم إرجاعها بواسطة LLM.  
لا يوجد أي ضمان لترتيب تنفيذ الأدوات، لذلك، لا يجب أبدًا افتراض الترتيب، ما لم يرسل LLM أداة بالتسلسل.  
هذا يعني أنه في التطبيقات المستقبلية، قد يتم تنفيذ العديد من استدعاءات الأدوات في نفس الوقت، بالتوازي (في المهام، على سبيل المثال).  

داخليًا، يقوم PowershAI بإنشاء برنامج نصي map افتراضي للأوامر التي تمت إضافتها باستخدام `Add-AiTool`.  

للحصول على مثال لكيفية تنفيذ الوظائف التي تُرجع هذا التنسيق، راجع provider openai.ps1، والأوامر التي تبدأ بـ Get-OpenaiTool*

لاحظ أن هذه الميزة لاستدعاء الأداة تعمل فقط مع النماذج التي تدعم استدعاء الأداة باتباع نفس المواصفات المحددة في OpenAI (من حيث الإدخال والرد).  


#### اعتبارات هامة حول استخدام الأدوات

ميزة استدعاء الوظيفة قوية لأنها تسمح بتنفيذ الكود، لكنها خطرة أيضًا، خطرة للغاية.  
لذلك، احرص على أقصى درجة من الحذر فيما تقوم بتنفيذه وتشغيله.
تذكر أن PowershAI سيُنفذ وفقًا لطلب النموذج. 

بعض نصائح السلامة:

- تجنب تشغيل البرنامج النصي باستخدام مستخدم مسؤول.
- تجنب تنفيذ الكود الذي يحذف أو يغير البيانات المهمة.
- اختبر الوظائف قبل استخدامها.
- لا تقم بتضمين الوحدات أو البرامج النصية التابعة لجهات خارجية التي لا تعرفها أو لا تثق بها.  

يقوم التنفيذ الحالي بتنفيذ الوظيفة في نفس الجلسة، وبنفس بيانات الاعتماد، للمستخدم الذي سجل الدخول.  
هذا يعني أنه إذا طلب النموذج (عمدًا أو عن طريق الخطأ) تنفيذ أمر خطير، فقد تتضرر بياناتك أو حتى جهاز الكمبيوتر الخاص بك، أو قد يتم اختراقها.  

لذلك، يجدر بهذه التحذير: كن حذرًا قدر الإمكان ولا تضيف سوى الأدوات ذات البرامج النصية التي تثق بها تمامًا.  

هناك خطة لإضافة آليات مستقبلية للمساعدة في زيادة الأمان، مثل العزل في مساحات تشغيل أخرى، وفتح عملية منفصلة، بأقل امتيازات والسماح للمستخدم بتكوين ذلك.






<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
