---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
يرسل البيانات إلى Gradio ويرجع كائنًا يمثل الحدث!
مرر هذا الكائن إلى cmdlets الأخرى للحصول على النتائج.

كيف تعمل واجهة برمجة التطبيقات في Gradio

	بناءً على: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	لفهم أفضل لكيفية استخدام هذا cmdlet ، من المهم فهم كيفية عمل واجهة برمجة التطبيقات في Gradio.  
	عندما نستدعي أي نقطة نهاية من واجهة برمجة التطبيقات ، فإنه لا يرجع البيانات على الفور.  
	يرجع ذلك إلى حقيقة بسيطة أن المعالجة تستغرق وقتًا طويلاً ، نظرًا لطبيعتها (الذكاء الاصطناعي وتعلم الآلة).  
	
	لذلك ، بدلاً من إرجاع النتيجة ، أو الانتظار إلى أجل غير مسمى ، يعيد Gradio "معرف الحدث".  
	باستخدام هذا الحدث ، يمكننا الحصول على النتائج التي تم إنشاؤها بشكل دوري.  
	سيقوم gradio بإنشاء رسائل أحداث بالبيانات التي تم إنشاؤها.  
	يجب أن نمرر معرف الحدث الذي تم إنشاؤه للحصول على القطع الجديدة التي تم إنشاؤها.
	يتم إرسال هذه الأحداث عبر أحداث جانب الخادم (SSE) ، ويمكن أن تكون واحدة من هذه:
		- hearbeat 
		كل 15 ثانية ، سيقوم Gradio بإرسال هذا الحدث للحفاظ على الاتصال نشطًا.  
		لهذا السبب ، عند استخدام cmdlet Update-GradioApiResult ، قد يستغرق الأمر بعض الوقت للرجوع.
		
		- complete 
		هي آخر رسالة يتم إرسالها بواسطة Gradio عند إنشاء البيانات بنجاح!
		
		- error 
		يتم إرساله عند حدوث خطأ في المعالجة.  
		
		- generating
		يتم إنشاؤه عندما يكون لدى واجهة برمجة التطبيقات بيانات متاحة بالفعل ، ولكن قد يكون هناك المزيد.
	
	هنا في PowershAI ، نقوم بفصل ذلك أيضًا إلى 3 أجزاء: 
		- هذا cmdlet (Send-GradioApi) يقدم الطلب الأولي إلى Gradio ويرجع كائنًا يمثل الحدث (يطلق عليه كائن GradioApiEvent)
		- يحتوي كائن النتيجة هذا ، من نوع GradioApiEvent ، على كل ما هو ضروري لاستعلام الحدث ، كما أنه يحفظ البيانات والأخطاء التي تم الحصول عليها.
		- أخيرًا ، لدينا cmdlet Update-GradioApiResult ، حيث يجب عليك تمرير الحدث الذي تم إنشاؤه ، وسوف يستعلم عن واجهة برمجة التطبيقات في Gradio ويحصل على البيانات الجديدة.  
			راجع مساعدة هذا cmdlet لمزيد من المعلومات حول كيفية التحكم في آلية الحصول على البيانات.
			
	
	لذلك ، في تدفق عادي ، يجب عليك القيام بما يلي: 
	
		# استدعاء نقطة نهاية Gradio!
		$MeuEvento = SEnd-GradioApi ... 
	
		# الحصول على النتائج حتى تنتهي!
		# راجع مساعدة هذا cmdlet لمعرفة المزيد!
		$MeuEvento | Update-GradioApiResult
		
كائن GradioApiEvent

	يحتوي كائن GradioApiEvent الناتج عن هذا cmdlet على كل ما هو ضروري لكي يتحكم PowershAI في الآلية ويحصل على البيانات.  
	من المهم أن تتعرف على هيكله لمعرفة كيفية جمع البيانات التي تم إنشاؤها بواسطة واجهة برمجة التطبيقات.
	الخصائص:
	
		- Status  
		يشير إلى حالة الحدث. 
		عندما تكون هذه الحالة "complete" ، فهذا يعني أن واجهة برمجة التطبيقات قد انتهت من المعالجة وتم إنشاء جميع البيانات الممكنة بالفعل.  
		طالما كانت مختلفة عن ذلك ، يجب عليك استدعاء Update-GradioApiResult لكي يفحص الحالة ويقوم بتحديث المعلومات. 
		
		- QueryUrl  
		قيمة داخلية تحتوي على نقطة النهاية الدقيقة لاستعلام النتائج
		
		- data  
		مصفوفة تحتوي على جميع بيانات الاستجابة التي تم إنشاؤها. في كل مرة تقوم فيها باستدعاء Update-GradioApiResult ، إذا كانت هناك بيانات ، فسوف تضيفها إلى هذه المصفوفة.  
		
		- events  
		قائمة بالأحداث التي تم إنشاؤها بواسطة الخادم. 
		
		- error  
		إذا كانت هناك أخطاء في الاستجابة ، فسوف تحتوي هذه الحقل على بعض الكائنات أو السلسلة أو ما إلى ذلك ، ويوضح المزيد من التفاصيل.
		
		- LastQueryStatus  
		يشير إلى حالة الاستعلام الأخير عن واجهة برمجة التطبيقات.  
		إذا كانت "normal" ، فهذا يشير إلى أن واجهة برمجة التطبيقات تم استعلامها وعادت حتى النهاية بشكل طبيعي.
		إذا كانت "HeartBeatExpired" ، فهذا يشير إلى أن الاستعلام تم مقاطعته بسبب مهلة النبض الذي تم تعيينه بواسطة المستخدم في cmdlet Update-GradioApiResult
		
		- req 
		بيانات الطلب التي تم إجراؤها!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] [[-token] <Object>] [<CommonParameters>]
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
If provided, it does not call the API, but creates the object and uses this value as if it were the return

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
