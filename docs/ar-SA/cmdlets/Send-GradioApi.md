---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
يرسل البيانات إلى Gradio ويعيد كائنًا يمثل الحدث!  
مرر هذا الكائن إلى cmdlets الأخرى للحصول على النتائج.

كيفية عمل واجهة برمجة التطبيقات Gradio 

	استنادًا إلى: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	لفهم كيفية استخدام هذا cmdlet بشكل أفضل، من المهم فهم كيفية عمل واجهة برمجة التطبيقات Gradio.  
	عند استدعاء أي نقطة نهاية لواجهة برمجة التطبيقات، فإنها لا تعيد البيانات على الفور.  
	وهذا يرجع ببساطة إلى أن المعالجة طويلة، بسبب طبيعتها (الذكاء الاصطناعي وتعلم الآلة).  
	
	لذا، بدلاً من إعادة النتيجة، أو الانتظار إلى أجل غير مسمى، فإن Gradio يعيد "معرف الحدث".  
	مع هذا الحدث، يمكننا الحصول على النتائج التي تم إنشاؤها بشكل دوري.  
	سوف يقوم Gradio بإنشاء رسائل أحداث مع البيانات التي تم إنشاؤها. نحتاج إلى تمرير EventId الذي تم إنشاؤه للحصول على الأجزاء الجديدة التي تم إنشاؤها.  
	تُرسل هذه الأحداث عبر أحداث جانب الخادم (SSE)، ويمكن أن تكون واحدة من هذه:
		- heartbeat 
		كل 15 ثانية، سيرسل Gradio هذا الحدث للحفاظ على الاتصال نشطًا.  
		لهذا السبب، عند استخدام cmdlet Update-GradioApiResult، قد يستغرق الأمر بعض الوقت للعودة.
		
		- complete 
		هذه هي آخر رسالة يرسلها Gradio عندما يتم إنشاء البيانات بنجاح!
		
		- error 
		يتم إرساله عندما يحدث خطأ في المعالجة.  
		
		- generating
		يتم إنشاؤه عندما تكون واجهة برمجة التطبيقات لديها بيانات متاحة، ولكن قد يكون هناك المزيد.
	
	هنا في PowershAI، نحن نفصل ذلك أيضًا إلى 3 أجزاء: 
		- يقوم هذا cmdlet (Send-GradioApi) بإجراء الطلب الأولي إلى Gradio ويعيد كائنًا يمثل الحدث (نطلق عليه اسم كائن GradioApiEvent)
		- يحتوي هذا الكائن الناتج، من نوع GradioApiEvent، على كل ما هو ضروري لاستعلام الحدث كما أنه يحتفظ بالبيانات والأخطاء المستلمة.
		- أخيرًا، لدينا cmdlet Update-GradioApiResult، حيث يجب عليك تمرير الحدث الذي تم إنشاؤه، وسيتحقق من واجهة برمجة التطبيقات Gradio ويحصل على البيانات الجديدة.  
			تحقق من المساعدة الخاصة بهذا cmdlet لمزيد من المعلومات حول كيفية التحكم في هذه الآلية للحصول على البيانات.
			
	
	لذا، في تدفق عادي، يجب عليك القيام بما يلي: 
	
		#استدعاء نقطة النهاية لـ Gradio!
		$MeuEvento = SEnd-GradioApi ... 
	
		# الحصول على النتائج حتى تنتهي!
		# تحقق من المساعدة الخاصة بهذا cmdlet لتتعلم المزيد!
		$MeuEvento | Update-GradioApiResult
		
كائن GradioApiEvent

	يحتوي كائن GradioApiEvent الناتج عن هذا cmdlet على كل ما هو ضروري لـ PowershAI للتحكم في الآلية والحصول على البيانات.  
	من المهم أن تعرف هيكله حتى تعرف كيفية جمع البيانات التي تم إنشاؤها بواسطة واجهة برمجة التطبيقات.
	الخصائص:
	
		- Status  
		تشير إلى حالة الحدث. 
		عندما تكون هذه الحالة "complete"، فهذا يعني أن واجهة برمجة التطبيقات قد انتهت بالفعل من المعالجة وتم إنشاء جميع البيانات الممكنة.  
		طالما كانت مختلفة عن ذلك، يجب عليك استدعاء Update-GradioApiResult للتحقق من الحالة وتحديث المعلومات. 
		
		- QueryUrl  
		قيمة داخلية تحتوي على نقطة النهاية الدقيقة لاستعلام النتائج
		
		- data  
		مصفوفة تحتوي على جميع بيانات الاستجابة التي تم إنشاؤها. في كل مرة تستدعي فيها Update-GradioApiResult، إذا كانت هناك بيانات، فسيتم إضافتها إلى هذه المصفوفة.  
		
		- events  
		قائمة بالأحداث التي تم إنشاؤها بواسطة الخادم. 
		
		- error  
		إذا كانت هناك أخطاء في الاستجابة، فسيحتوي هذا الحقل على كائن، سلسلة، إلخ، تصف المزيد من التفاصيل.
		
		- LastQueryStatus  
		تشير إلى حالة آخر استعلام في واجهة برمجة التطبيقات.  
		إذا كانت "normal"، فهذا يعني أنه تم استعلام واجهة برمجة التطبيقات وعادت حتى النهاية بشكل طبيعي.
		إذا كانت "HeartBeatExpired"، فهذا يعني أن الاستعلام قد توقف بسبب انتهاء مهلة heartbeat المكونة من قبل المستخدم في cmdlet Update-GradioApiResult
		
		- req 
		بيانات الطلب المقدم!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] 
[[-token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ApiName

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -SessionHash

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -EventId
إذا تم تقديمه، فلا يتم استدعاء واجهة برمجة التطبيقات، ولكنه ينشئ الكائن ويستخدم هذه القيمة كما لو كانت الاستجابة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_تمت الترجمة تلقائيًا باستخدام PowershAI والذكاء الاصطناعي._
<!--PowershaiAiDocBlockEnd-->
