---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioApiResult

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
يُحدّث حدثًا تمّ إرجاعه بواسطة Send-GradioApi بنتائج جديدة من الخادم، و بشكل افتراضي، يُعيد evenots إلى خط الأنابيب.

لا يتمّ إنشاء نتائج Api Gradio على الفور، كما هو الحال في معظم خدمات HTTP REST.  
شرح help للأمر Send-GradioApi تفصيلًا كيفية عمل العملية.  

يجب استخدام هذا الأمر لتحديث كائن GradioApiEvent، الذي تمّ إرجاعه بواسطة Send-GradioApi.
يُمثّل هذا الكائن استجابة كلّ مكالمة تقوم بها إلى API، فهو يحتوي على كلّ ما تحتاجه للاستعلام عن النتيجة، بما في ذلك البيانات والسجل.

في الأساس، يعمل هذا cmdlet باستدعاء نقطة نهاية الاستعلام عن حالة استدعاء Api.
تتوفّر المعلمات اللازمة للاستعلام في الكائن نفسه الذي تمّ إرساله في المعلمة -ApiEvent (التي تمّ إنشاؤها وإرجاعها بواسطة cmdlet Send-GradioApi)

كلّما تمّ تنفيذ هذا cmdlet، فإنه يتواصل عبر اتصال HTTP دائم مع الخادم وينتظر الأحداث.  
مع إرسال الخادم للبيانات، فإنه يُحدّث الكائن الذي تمّ إرساله في المعلمة -ApiEvent، و بشكل افتراضي، يُكتب الحدث الذي تمّ إرجاعه في خط الأنابيب.

الحدث الذي تمّ إرجاعه هو كائن من نوع GradioApiEventResult، و يُمثّل حدثًا تمّ إنشاؤه بواسطة استجابة تنفيذ API.  

إذا تمّ تحديد المعلمة -History، فستبقى جميع الأحداث التي تمّ إنشاؤها في خاصية events للكائن المحدّد في -ApiEvent، بالإضافة إلى البيانات التي تمّ إرجاعها.

في الأساس، يمكن أن ترسل الأحداث التي تمّ إنشاؤها نبضة قلب أو بيانات.

OBJETO GradioApiEventResult
	num 	= الرقم التسلسلي للحدث. يبدأ من 1.
	ts 		= تاريخ إنشاء الحدث (تاريخ محلي، ليس من الخادم).
	event 	= اسم الحدث
	data 	= البيانات التي تمّ إرجاعها في هذا الحدث

بيانات (DATA)

	الحصول على بيانات Gradio، هو في الأساس قراءة الأحداث التي تمّ إرجاعها بواسطة هذا cmdlet والنظر في خاصية data لـ GradioApiEventResult
	عادةً ما تُعيد واجهة Gradio كتابة الحقل بأحدث حدث تمّ استقباله.  
	
	إذا تمّ استخدام -History، فبالإضافة إلى الكتابة في خط الأنابيب، فسيقوم cmdlet بتخزين البيانات في حقل data، وبالتالي، سيكون لديك حق الوصول إلى السجل الكامل لما تمّ إنشاؤه بواسطة الخادم.  
	لاحظ أن ذلك قد يؤدي إلى استهلاك إضافي للذاكرة، إذا تمّ إرجاع العديد من البيانات.
	
	يوجد "مشكلة" معروفة: في بعض الأحيان، قد يصدر gradio آخر حدثين بنفس البيانات (سيحمل أحد الأحداث اسم "generating"، وآخر سيكون complete).  
	لا يوجد لدينا حلّ لفصل ذلك بطريقة آمنة، ولهذا، يجب على المستخدم تحديد أفضل طريقة لإدارته.  
	إذا كنت تستخدم دائمًا آخر حدث تمّ استقباله، فلن تكون هذه مشكلة.
	إذا كنت بحاجة إلى استخدام جميع الأحداث مع توفرها، فسيتعين عليك معالجة هذه الحالات.
	مثال بسيط سيكون هو شراء المحتوى، إذا كانا متشابهين، فلا داعي لتكراره. لكن قد تكون هناك سيناريوهات حيث يشير حدثان بنفس المحتوى، مع ذلك، إلى أحداث مختلفة من الناحية المنطقية.
	
	

نبضة قلب 

	واحد من الأحداث التي تمّ إنشاؤها بواسطة API Gradio هي نبضات القلب.  
	كلّ 15 ثانية، يرسل Gradio حدثًا من نوع "HeartBeat"، فقط للحفاظ على الاتصال نشطًا.  
	يُؤدي هذا إلى "تعليق" cmdlet، لأنّ الاتصال HTTP نشط، فهو يظلّ ينتظر ردًّا (سيكون بيانات أو أخطاء أو نبضة القلب).
	
	إذا لم يكن هناك آلية للتحكم في ذلك، فسيتواصل cmdlet في العمل إلى ما لا نهاية، دون إمكانية إلغائه حتى باستخدام CTRL + C.
	لحلّ هذه المشكلة، يُقدّم هذا cmdlet المعلمة MaxHeartBeats.  
	تُشير هذه المعلمة إلى عدد الأحداث المتتالية لنبضة القلب التي سيتمّ تحملها قبل توقف cmdlet عن محاولة الاستعلام عن API.  
	
	على سبيل المثال، ضع في اعتبارك سيناريوهين للأحداث التي يُرسلها الخادم:
	
		سيناريو 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		سيناريو 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	مع الأخذ في الاعتبار القيمة الافتراضية، 2، في السيناريو 1، لن ينتهي cmdlet أبدًا قبل الانتهاء، لأنّ لم يكن هناك أبدًا نبضتان متتاليتان للقلب.
	
	في السيناريو 2، بعد استلام حدثين للبيانات (generating)، في الحدث الرابع (heartbeat)، سينتهي، لأنّ تمّ إرسال نبضتين متتاليتين للقلب.  
	نقول إنّ نبضة القلب انتهت صلاحيتها، في هذه الحالة.
	في هذه الحالة، يجب عليك استدعاء Update-GradioApiResult مرة أخرى للحصول على الباقي.
	
	كلّما انتهى الأمر بسبب انتهاء صلاحية نبضة القلب، فإنه سيُحدّث قيمة خاصية LastQueryStatus إلى HeartBeatExpired.  
	بذلك، يمكنك التحقق من ذلك ومعالجته بشكل صحيح عندما يجب عليك الاتصال مرة أخرى
	
	
STREAM  
	
	بسبب حقيقة أنّ Api Gradio تُجيب بالفعل باستخدام SSE (أحداث جانب الخادم)، فمن الممكن استخدام تأثير يشبه "stream" لعديد من Apis.  
	يعالج هذا cmdlet، Update-GradioApiResult، بالفعل أحداث الخادم باستخدام SSE.  
	بالإضافة إلى ذلك، إذا كنت تريد أيضًا إجراء معالجة معينة مع توفر الحدث، يمكنك استخدام المعلمة -Script وتحديد scriptblock، أو وظائف، أو ما إلى ذلك، سيتمّ استدعاءها مع توفر الحدث.  
	
	مع الجمع مع المعلمة -MaxHeartBeats، يمكنك إنشاء مكالمة تُحدّث شيئًا ما في الوقت الفعلي. 
	على سبيل المثال، إذا كانت استجابة من روبوت دردشة، فيمكنك كتابتها على الفور على الشاشة.
	
	لاحظ أنّ هذه المعلمة يتمّ استدعاؤها بشكل متسلسل مع التعليمات البرمجية التي تتحقق (أيّ نفس السلسلة).  
	لذلك، فإنّ النصوص البرمجية التي تستغرق وقتًا طويلاً، قد تؤثّر على اكتشاف الأحداث الجديدة، ونتيجة لذلك، على تسليم البيانات.
	
.

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiEvent
نتيجة Send-GradioApi

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Script
النصّ البرمجي الذي سيتمّ استدعاؤه في كلّ حدث تمّ إنشاؤه!
يُحصل على hashtable مع المفاتيح التالية:
 	event - يحتوي على الحدث الذي تمّ إنشاؤه. event.event هو اسم الحدث. event.data هي البيانات التي تمّ إرجاعها.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxHeartBeats
أقصى عدد نبضات القلب المتتالية حتى التوقف!
يجعل الأمر ينتظر فقط هذا العدد من نبضات القلب المتتالية من الخادم.
عندما يُرسل الخادم هذه الكمية، ينتهي cmdlet و يحدّد LastQueryStatus للحدث إلى HeartBeatExpired

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoOutput
لا يكتب النتيجة إلى إخراج cmdlet

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

### -History
يُحفظ سجلّ الأحداث والبيانات في كائن ApiEvent
لاحظ أنّ هذا سيؤدي إلى استهلاك المزيد من ذاكرة powershell!

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
