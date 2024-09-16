---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
يُنشئ محادثة Powershai جديدة.

## DESCRIPTION <!--!= @#Desc !-->
يجلب PowershaAI مفهوم "المحادثات" ، على غرار المحادثات التي تراها في OpenAI ، أو "الخيوط" لواجهة برمجة التطبيقات المساعدة.  
لكل محادثة تم إنشاؤها مجموعة خاصة بها من المعلمات والسياق والسجل.  
عندما تستخدم الأمر Send-PowershaiChat (alias ia) ، فإنك ترسل رسائل إلى النموذج ، ويبقى سجل هذه المحادثة مع النموذج في المحادثة التي تم إنشاؤها هنا بواسطة PowershAI.  
بمعنى آخر ، يتم الاحتفاظ بسجل كامل محادثتك مع النموذج هنا في جلسة PowershAI الخاصة بك ، وليس في النموذج أو واجهة برمجة التطبيقات.  
وبذلك ، يحتفظ PowershAI بالتحكم الكامل في ما يتم إرساله إلى LLM ولا يعتمد على آليات واجهات برمجة التطبيقات المختلفة لمختلف الموردين لإدارة السجل. 


كل محادثة لها مجموعة من المعلمات التي تؤثر على تغييرها فقط على تلك المحادثة.  
بعض معلمات PowershAI عالمية ، مثل المورد المستخدم. عند تغيير المورد ، تبدأ المحادثة في استخدام المورد الجديد ، لكنها تحتفظ بالسجل نفسه.  
يسمح ذلك بالتحدث إلى نماذج مختلفة ، مع الاحتفاظ بالسجل نفسه.  

بالإضافة إلى هذه المعلمات ، لكل محادثة سجل.  
يحتوي السجل على جميع المحادثات والتفاعلات التي تم إجراؤها مع النماذج ، مع حفظ الردود التي تم إرجاعها بواسطة واجهات برمجة التطبيقات.

تحتوي المحادثة أيضًا على سياق ، وهو ليس سوى جميع الرسائل التي تم إرسالها.  
في كل مرة يتم إرسال رسالة جديدة في محادثة ، يضيف Powershai هذه الرسالة إلى السياق.  
عند تلقي رد النموذج ، يتم إضافة هذا الرد إلى السياق.  
في الرسالة التالية التي يتم إرسالها ، يتم إرسال سجل رسائل السياق بالكامل ، مما يجعل النموذج ، بغض النظر عن المورد ، لديه ذاكرة المحادثة.  

حقيقة أن السياق محفوظ هنا في جلسة Powershell الخاصة بك يسمح بوظائف مثل حفظ سجلك على القرص ، وتنفيذ موفر حصري لحفظ سجلك في السحابة ، والحفاظ عليه فقط على جهاز الكمبيوتر الخاص بك ، إلخ. يمكن أن تستفيد الوظائف المستقبلية من ذلك.

كل الأوامر *-PowershaiChat تدور حول المحادثة النشطة أو المحادثة التي تحددها صراحةً في المعلمة (عادةً باسم -ChatId).  
المحادثة النشطة هي المحادثة التي سيتم إرسال الرسائل إليها ، إذا لم يتم تحديد ChatId  (أو إذا لم يسمح الأمر بتحديد محادثة صريحة).  

هناك محادثة خاصة تسمى "الافتراضية" وهي المحادثة التي يتم إنشاؤها دائمًا عند استخدام Send-PowershaiChat دون تحديد محادثة وإذا لم تكن هناك محادثة نشطة محددة.  

إذا قمت بإغلاق جلسة Powershell الخاصة بك ، فستضيع جميع سجلات المحادثات هذه.  
يمكنك الحفظ على القرص ، باستخدام الأمر Export-PowershaiSettings. يتم حفظ المحتوى مشفرًا بكلمة مرور تحددها.

عند إرسال الرسائل ، يحافظ PowershAI على آلية داخلية تنظف سياق المحادثة ، لتجنب إرسال أكثر مما هو ضروري.
يتم التحكم في حجم السياق المحلي (هنا في جلسة Powershai الخاصة بك ، وليس في LLM) بواسطة معلمة (استخدم Get-PowershaiChatParameter لعرض قائمة المعلمات)

لاحظ أن ، بسبب هذه الطريقة في عمل Powershai ، اعتمادًا على كمية المعلومات التي تم إرسالها وإرجاعها ، بالإضافة إلى إعدادات المعلمات ، يمكنك جعل Powershell يستهلك ذاكرة كبيرة. يمكنك مسح سياق وسجل محادثتك يدويًا باستخدام Reset-PowershaiCurrentChat

شاهد المزيد من التفاصيل حول الموضوع about_Powershai_Chats ،

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
معرف المحادثة. إذا لم يتم تحديده ، فسيقوم بإنشاء نمط
بعض أنماط المعرفات محجوزة للاستخدام الداخلي. إذا كنت تستخدم -ها ، فقد يؤدي ذلك إلى عدم استقرار PowershAI.
القيم التالية محجوزة:
 الافتراضي 
 _pwshai_*

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

### -IfNotExists
يُنشئ فقط إذا لم تكن هناك محادثة بنفس الاسم

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

### -Recreate
إجبار إعادة إنشاء المحادثة إذا كانت موجودة بالفعل!

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

### -Tools
يُنشئ المحادثة ويضم هذه الأدوات!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
