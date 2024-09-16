---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
أنشئ وظائف تغلف مكالمات نقطة نهاية Gradio (أو جميع نقاط النهاية).  
هذه الوحدة النمطية مفيدة للغاية لإنشاء وظائف PowerShell تغلف نقطة نهاية API Gradio ، حيث يتم إنشاء معلمات API كمعلمات للوظيفة.  
وبالتالي ، يمكن استخدام ميزات PowerShell الأصلية ، مثل إكمال التلقائي ونوع البيانات والتوثيق ، ويصبح من السهل جدًا استدعاء أي نقطة نهاية من جلسة.

يقوم الأمر باستعلام عن البيانات الوصفية لنقاط النهاية والمعلمات وإنشاء وظائف PowerShell في النطاق العالمي.  
بذلك ، يمكن للمستخدم استدعاء الوظائف مباشرة ، كما لو كانت وظائف عادية.  

على سبيل المثال ، افترض أن تطبيق Gradio على العنوان http://mydemo1.hf.space يحتوي على نقطة نهاية تسمى /GenerateImage لإنشاء صور باستخدام Stable Diffusion.  
افترض أن هذا التطبيق يقبل معلمين: Prompt (وصف الصورة المراد إنشاؤها) و Steps (إجمالي عدد الخطوات).

عادةً ، يمكنك استخدام الأمر Invoke-GradioSessionApi ، على النحو التالي: 

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

سيؤدي ذلك إلى بدء تشغيل API ، ويمكنك الحصول على النتائج باستخدام Update-GradioApiResult:

$ApiEvent | Update-GradioApiResult

باستخدام هذه الوحدة النمطية ، يمكنك تغليف هذه المكالمات بشكل أكبر قليلاً:

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

سيؤدي الأمر أعلاه إلى إنشاء وظيفة تسمى Invoke-GradioApiGenerateimage.
ثم ، يمكنك استخدامها بطريقة بسيطة لإنشاء الصورة:

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100 

بشكل افتراضي ، سينفذ الأمر ويحصل على أحداث النتائج ، وسيقوم بكتابتها في خط الأنابيب بحيث يمكنك دمجها مع أوامر أخرى.  
وتشمل ذلك توصيل مساحات متعددة بشكل بسيط ، انظر أدناه حول خط الأنابيب.

التسمية

	اسم الوظائف التي تم إنشاؤها يتبع التنسيق:  <Prefix><NomeOp>
		<Prefix> هو قيمة المعلمة -Prefix لهذه الوحدة النمطية. 
		<NomeOp> هو اسم العملية ، يتم الاحتفاظ فقط بالحروف والأرقام
		
		على سبيل المثال ، إذا كانت العملية هي /Op1 ، وكان البادئة INvoke-GradioApi ، فسيتم إنشاء الوظيفة التالية: Invoke-GradioApiOp1

	
المعلمات
	تحتوي الوظائف التي تم إنشاؤها على المنطق اللازم لتحويل المعلمات المارة وتنفيذ الوحدة النمطية Invoke-GradioSessionApi.  
	بمعنى آخر ، ينطبق نفس العائد كما لو كنت تقوم باستدعاء هذه الوحدة النمطية مباشرة.  (أي سيتم إرجاع حدث وإضافته إلى قائمة أحداث الجلسة الحالية).
	
	قد تختلف معلمات الوظائف وفقًا لنقطة نهاية API ، لأن كل نقطة نهاية لها مجموعة مختلفة من المعلمات وأنواع البيانات.
	المعلمات التي هي ملفات (أو قائمة الملفات) ، لديها خطوة إضافية لتحميل الملفات. يمكن الرجوع إلى الملف محليًا وسيتم تحميله إلى الخادم.  
	في حالة تقديم عنوان URL ، أو كائن FileData تم استلامه من أمر آخر ، لن يتم تحميل أي ملف إضافي ، سيتم إنشاء كائن FileData مطابق فقط للإرسال عبر API.

	بالإضافة إلى معلمات نقطة النهاية ، هناك مجموعة إضافية من المعلمات التي سيتم إضافتها دائمًا إلى الوظيفة التي تم إنشاؤها.  
	وهي كالتالي:
		- Manual  
		إذا تم استخدامه ، فسيؤدي إلى إرجاع الوحدة النمطية الحدث الناتج عن INvoke-GradioSessionApi.  
		في هذه الحالة ، ستحتاج إلى الحصول على النتائج يدويًا باستخدام Update-GradioSessionApiResult
		
		- ApiResultMap 
		يقوم بإنشاء خريطة لنتائج أوامر أخرى إلى المعلمات. شاهد المزيد حول ذلك في قسم خط الأنابيب.
		
		- DebugData
		لأغراض تصحيح الأخطاء من قبل المطورين.
		
تحميل الملفات	
	يتم التعامل مع المعلمات التي تقبل الملفات بطريقة خاصة.  
	قبل استدعاء API ، يتم استخدام الوحدة النمطية Send-GradioSessionFiles لتحميل هذه الملفات إلى تطبيق Gradio المعني.  
	هذه ميزة كبيرة أخرى لاستخدام هذه الوحدة النمطية ، لأن هذا الأمر شفاف ، ولا يحتاج المستخدم إلى التعامل مع عمليات تحميل الملفات.

خط الأنابيب 
	
	إحدى أقوى وظائف PowerShell هي خط الأنابيب ، حيث يمكن توصيل العديد من الأوامر باستخدام الأنبوب |.
	وتحاول هذه الوحدة النمطية الاستفادة من هذا المورد إلى أقصى حد.  
	
	يمكن توصيل جميع الوظائف التي تم إنشاؤها باستخدام |.
	عند القيام بذلك ، يتم تمرير كل حدث يتم إنشاؤه بواسطة الوحدة النمطية السابقة إلى الوحدة النمطية التالية.  
	
	فكر في تطبيقين Gradio ، App1 و App2.
	يحتوي App1 على نقطة النهاية Img ، مع معلمة تسمى Text ، والتي تولد صورًا باستخدام Diffusers ، وعرض الإصدارات الجزئية من كل صورة أثناء إنشائها.
	يحتوي App2 على نقطة نهاية Ascii ، مع معلمة تسمى Image ، والتي تحول صورة إلى إصدار نصي ascii.
	
	يمكنك توصيل هذين الأمرين بطريقة بسيطة للغاية باستخدام خط الأنابيب.  
	أولاً ، قم بإنشاء الجلسات

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator
		
	قم بإنشاء الوظائف 
		$App1 | New-GradioSessionApiProxy -Prefix App # سيؤدي هذا إلى إنشاء الوظيفة AppImg
		$App2 | New-GradioSessionApiProxy -Prefix App # سيؤدي هذا إلى إنشاء الوظيفة AppAscii
		
	قم بإنشاء الصورة وتوصيلها بإنشاء ascii :
	
	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data[0]; write-host $_.pipeline[0].data[0].url } 
	
	دعنا نكسر التسلسل أعلاه.
	
	قبل الأنبوب الأول ، لدينا الأمر الذي ينشئ الصورة: AppImg -Text "A car" 
	تستدعي هذه الوظيفة نقطة النهاية /Img من App1. ينتج عن هذه نقطة النهاية مخرجات لخطوة إنشاء الصور باستخدام مكتبة Diffusers من hugging face.  
	في هذه الحالة ، ستكون كل مخرجات صورة (مشوهة بشكل جيد) ، حتى آخر مخرجات ستكون الصورة النهائية.  
	توجد هذه النتيجة في خاصية data لكائن خط الأنابيب. وهي عبارة عن مصفوفة تحتوي على النتائج.
	
	بعد ذلك مباشرةً في الأنبوب ، لدينا الأمر: AppAscii -Map ImageInput=0
	سيستلم هذا الأمر كل كائن يتم إنشاؤه بواسطة الأمر AppImg ، والذي في هذه الحالة ، هي الصور الجزئية لعملية الانتشار.  
	
	نظرًا لأن الأوامر يمكن أن تولد مصفوفة من المخرجات ، فمن الضروري إنشاء خريطة بشكل دقيق لأي من النتائج يجب أن تكون مرتبطة بأي من المعلمات.  
	لهذا السبب ، نستخدم المعلمة -Map (-Map هو اسم مستعار ، في الواقع ، الاسم الصحيح هو ApiResultMap)
	البنية بسيطة: NomeParam=DataIndex,NomeParam=DataIndex  
	في الأمر أعلاه ، نقول: AppAscii ، استخدم القيمة الأولى من خاصية data في المعلمة ImageInput.  
	على سبيل المثال ، إذا كان AppImg يرد بـ 4 قيم ، وكانت الصورة في آخر موضع ، فيجب عليك استخدام ImageInput=3 (0 هو الأول).
	
	
	أخيرًا ، الأنبوب الأخير يطبع فقط نتيجة AppAscii ، والتي توجد الآن في كائن خط الأنابيب ، $_ ، في خاصية .data (مثل نتيجة AppImg).  
	ولإكمال ، يحتوي كائن خط الأنابيب على خاصية خاصة تسمى pipeline. باستخدام هذه الخاصية ، يمكنك الوصول إلى جميع نتائج الأوامر التي تم إنشاؤها.  
	على سبيل المثال ، $_.pipeline[0] ، يحتوي على نتيجة الأمر الأول (AppImg). 
	
	بفضل هذه الآلية ، يصبح توصيل تطبيقات Gradio المختلفة في خط أنابيب واحد أسهل بكثير.
	لاحظ أن هذا التسلسل يعمل فقط بين الأوامر التي تم إنشاؤها بواسطة New-GradioSessionApiProxy.  
	لن ينتج عن تمرير أوامر أخرى هذا التأثير نفسه (سيتعين عليك استخدام شيء مثل For-EachObject وربط المعلمات مباشرةً)


الجلسات 
	عند إنشاء الوظيفة ، يتم إرفاق جلسة المصدر بالوظيفة.  
	إذا تم إزالة الجلسة ، فستؤدي الوحدة النمطية إلى حدوث خطأ.  
	في هذه الحالة ، يجب عليك إنشاء الوظيفة باستدعاء هذه الوحدة النمطية مرة أخرى.  


يوضح الرسم البياني التالي التبعيات المشاركة:

	New-GradioSessionApiProxyFunction(Prefix)
		---> function <Prefix><OpName>
			---> Send-GradioSessionFiles (عندما تكون هناك ملفات)
			---> Invoke-GradioSessionApi | Update-GradioSessionApiResult

بمجرد تنفيذ Invoke-GradioSessionApi في النهاية ، تنطبق عليها جميع القواعد.
يمكنك استخدام Get-GradioSessionApiProxyFunction للحصول على قائمة بما تم إنشاؤه و Remove-GradioSessionApiProxyFunction لإزالة وظيفة أو أكثر تم إنشاؤها.  
يتم إنشاء الوظائف باستخدام وحدة نمطية ديناميكية.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
أنشئ فقط لهذه نقطة النهاية المحددة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -Prefix
بادئة الوظائف التي تم إنشاؤها

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Invoke-GradioApi
Accept pipeline input: false
Accept wildcard characters: false
```

### -Session
جلسة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
قوة إنشاء الوظيفة ، حتى لو كانت موجودة بالفعل باسم مطابق!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
