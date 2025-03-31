# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.3]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVIDER**: تم إضافة المعامل -DisableRetry إلى Get-GradioInfo
- **HUGGINGFACE PROVIDER**: تم إضافة معلمات GradioServerRoot في Get-HuggingFaceSpace و ServerRoot في Connect-HuggingFaceSpaceGradio
- **HUGGINGFACE PROVIDER**: تم إضافة منطق لاكتشاف ما إذا كانت مساحة hugging face تستخدم Gradio 5 وضبط جذر الخادم
- **HUGGINGFACE PROVIDER**: تم إضافة المساحات الخاصة إلى اختبارات الموفر

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: تم تصحيح مشكلة المصادقة في المساحات الخاصة


## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: تم إضافة groq إلى الاختبارات التلقائية

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: تم تصحيح خطأ في موفر groq، يتعلق برسائل النظام 
- **COHERE PROVIDER**: تم تصحيح خطأ متعلق برسائل النموذج عندما كانت تحتوي على ردود من استدعاءات الأدوات.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: كانت الدردشات تُعاد إنشاؤها في كل مرة، مما يمنع الحفاظ على السجل بشكل صحيح عند استخدام دردشات متعددة! 
- **OPENAI PROVIDER**: تم تصحيح نتيجة `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- تم تصحيح الأخطاء في موفر Hugging Face بسبب إعادة التوجيه.
- تم تصحيح تثبيت الوحدات للاختبارات باستخدام Docker Compose.
- تم تصحيح مشاكل الأداء في تحويل الأدوات بسبب عدد كبير محتمل من الأوامر في جلسة واحدة. الآن يستخدم وحدات ديناميكية. انظر `ConvertTo-OpenaiTool`.
- تم تصحيح مشاكل التوافق بين واجهة برمجة التطبيقات GROQ و OpenAI. لم يعد `message.refusal` مقبولاً.
- تم تصحيح أخطاء صغيرة في PowerShell Core لـ Linux.
- **OPENAI PROVIDER**: تم حل رمز الاستثناء الناتج عن عدم وجود نموذج افتراضي.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOVO PROVIDER**: مرحبًا Azure 🎉
- **NOVO PROVIDER**: مرحبًا Cohere 🎉
- تم إضافة ميزة `AI Credentials` — طريقة جديدة قياسية للمستخدمين لتحديد بيانات الاعتماد، مما يسمح لمقدمي الخدمة بطلب بيانات اعتماد المستخدمين.
- تم ترحيل مقدمي الخدمة لاستخدام `AI Credentials`، مع الحفاظ على التوافق مع الأوامر القديمة.
- cmdlet جديد `Confirm-PowershaiObjectSchema`، للتحقق من صحة المخططات باستخدام OpenAPI مع بناء جملة أكثر "PowerShellized".
- تم إضافة دعم لإعادة التوجيه HTTP في مكتبة HTTP
- تمت إضافة العديد من الاختبارات الجديدة مع Pester، تتراوح من اختبارات الوحدة الأساسية إلى حالات أكثر تعقيدًا، مثل استدعاءات أدوات LLM الحقيقية.
- cmdlet جديد `Switch-PowershaiSettings` يسمح بالتبديل بين الإعدادات وإنشاء دردشات، مقدمي الخدمة الافتراضيين، النماذج، إلخ، كما لو كانت ملفات تعريف متميزة.
- **Retry Logic**: تم إضافة `Enter-PowershaiRetry` لإعادة تنفيذ البرامج النصية بناءً على ظروف معينة.
- **Retry Logic**: تم إضافة منطق إعادة المحاولة في `Get-AiChat` لتسهيل تنفيذ الموجه مرة أخرى إلى LLM إذا كانت الاستجابة السابقة غير متوافقة مع المطلوب.- تمكين cmdlet الجديد `Enter-AiProvider` الآن من تنفيذ الكود تحت مزود محدد. cmdlets التي تعتمد على مزود، ستستخدم دائمًا المزود الذي تم "الدخول" إليه مؤخرًا بدلاً من المزود الحالي.
- Stack of Provider (Push/Pop): تمامًا مثل `Push-Location` و `Pop-Location`، يمكنك الآن إدخال وإزالة مزودات لتغييرات أسرع عند تنفيذ الكود في مزود آخر.
- cmdlet جديد `Get-AiEmbeddings`: تم إضافة cmdlets القياسية للحصول على embeddings من نص، مما يسمح للمزودات بفضح توليد embeddings وللمستخدمين بوجود آلية قياسية لتوليدها.
- cmdlet جديد `Reset-AiDefaultModel` لإلغاء تحديد النموذج الافتراضي.
- تمت إضافة المعلمات `ProviderRawParams` إلى `Get-AiChat` و `Invoke-AiChat` لتجاوز المعلمات المحددة في API، حسب المزود.
- **HUGGINGFACE PROVIDER**: تم إضافة اختبارات جديدة باستخدام مساحة Hugging Face حقيقية فريدة يتم الحفاظ عليها كفرع فرعي من هذا المشروع. وهذا يسمح باختبار جوانب متعددة في نفس الوقت: جلسات Gradio ودمج Hugging Face.
- **HUGGINGFACE PROVIDER**: cmdlet جديد: Find-HuggingFaceModel، للبحث عن نماذج في المركز بناءً على بعض الفلاتر!
- **OPENAI PROVIDER**: تم إضافة cmdlet جديد لتوليد استدعاءات الأدوات: `ConvertTo-OpenaiTool`، دعم الأدوات المحددة في كتل النصوص.
- **OLLAMA PROVIDER**: cmdlet جديد `Get-OllamaEmbeddings` لإرجاع embeddings باستخدام Ollama.
- **OLLAMA PROVIDER**: cmdlet جديد `Update-OllamaModel` لتنزيل نماذج ollama (pull) مباشرة من powershai
- **OLLAMA PROVIDER**: الكشف التلقائي عن الأدوات باستخدام بيانات التعريف الخاصة بـ ollama
- **OLLAMA PROVIDER**: تخزين بيانات التعريف لنماذج cache وcmdlet جديد `Reset-OllamaPowershaiCache` لمسح التخزين المؤقت، مما يسمح بالاستعلام عن تفاصيل عديدة لنماذج ollama، بينما يحافظ على الأداء للاستخدام المتكرر للأمر

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: تم إعادة تسمية معلمة الدردشة `ContextFormatter` إلى `PromptBuilder`.
- تم تغيير العرض الافتراضي (formats.ps1xml) لبعض cmdlets مثل `Get-AiModels`.
- تحسين في السجل التفصيلي عند إزالة السجل القديم بسبب `MaxContextSize` في الدردشات.
- طريقة جديدة لتخزين إعدادات PowershAI، مما يقدم مفهوم "تخزين الإعدادات"، مما يسمح بتبديل الإعدادات (على سبيل المثال، للاختبارات).
- تحديث الرموز التعبيرية المعروضة مع اسم النموذج عند استخدام الأمر Send-PowershaiChat
- تحسينات في تشفير تصدير/استيراد الإعدادات (Export=-PowershaiSettings). الآن يستخدم كاشتقاق للمفتاح والملح.
- تحسين في عائد الواجهة *_Chat، لتكون أكثر وفاءً لمعيار OpenAI.
- تمت إضافة خيار `IsOpenaiCompatible` للمزودات. يجب على المزودات التي ترغب في إعادة استخدام cmdlets OpenAI تعيين هذا العلم إلى `true` للعمل بشكل صحيح.
- تحسين في معالجة الأخطاء لـ `Invoke-AiChatTools` في معالجة استدعاءات الأدوات.- **GOOGLE PROVIDER**: تمت إضافة cmdlet `Invoke-GoogleApi` للسماح للمستخدمين بإجراء مكالمات API مباشرة.
- **HUGGING FACE PROVIDER**: تم إجراء تعديلات بسيطة على طريقة إدخال الرمز المميز في طلبات API.
- **OPENAI PROVIDER**: الآن تستخدم `Get-OpenaiToolFromCommand` و `Get-OpenaiToolFromScript` `ConvertTo-OpenaiTool` لتركز تحويل الأمر إلى أداة OpenAI.
- **GROQ PROVIDER**: تم تحديث النموذج الافتراضي من `llama-3.1-70b-versatile` إلى `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: الآن يتضمن Get-AiModels نماذج تدعم الأدوات، حيث يستخدم الموفر نقطة النهاية /api/show للحصول على مزيد من التفاصيل حول النماذج، مما يسمح بالتحقق من دعم الأدوات.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- تم إصلاح خطأ في وظيفة `New-GradioSessionApiProxyFunction`، المتعلقة ببعض الوظائف الداخلية.
- تمت إضافة دعم لـ Gradio 5، والذي يتطلب تغييرات في نقاط النهاية لـ API.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- دعم الصور في `Send-PowershaiChat` لمقدمي OpenAI و Google.
- أمر تجريبي، `Invoke-AiScreenshots`، الذي يضيف دعمًا لالتقاط لقطات الشاشة وتحليلها!
- دعم لاستدعاء الأدوات في موفر Google.
- تم بدء CHANGELOG.
- دعم TAB لـ Set-AiProvider.
- تمت إضافة دعم أساسي للإخراج الهيكلي للمعامل `ResponseFormat` لـ cmdlet `Get-AiChat`. وهذا يسمح بتمرير Hashtable تصف مخطط OpenAPI للنتيجة.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: خاصية `content` للرسائل OpenAI تُرسل الآن كمصفوفة لتتوافق مع المواصفات لأنواع الوسائط الأخرى. يتطلب ذلك تحديث النصوص البرمجية التي تعتمد على تنسيق السلسلة الواحدة السابق وإصدارات قديمة من الموفرين الذين لا يدعمون هذه الصيغة.
- تم تصحيح معامل `RawParams` في `Get-AiChat`. يمكنك الآن تمرير معلمات API إلى الموفر المعني للحصول على تحكم صارم في النتيجة.
- تحديثات DOC: تم ترجمة مستندات جديدة مع AiDoc وتحديثات. تصحيح بسيط في AiDoc.ps1 لعدم ترجمة بعض أوامر بناء جملة markdown.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. تم تغيير إعدادات الأمان وتم تحسين معالجة الأحرف الكبيرة والصغيرة. لم يكن يتم التحقق من ذلك، مما أدى إلى حدوث خطأ.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2


<!--PowershaiAiDocBlockStart-->
_تم التدريب على البيانات حتى أكتوبر 2023._
<!--PowershaiAiDocBlockEnd-->
