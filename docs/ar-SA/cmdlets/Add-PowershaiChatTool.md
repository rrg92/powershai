---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
يضيف الدوال، البرامج النصية، الملفات القابلة للتنفيذ كأداة قابلة للدعوة بواسطة LLM في الدردشة الحالية (أو الافتراضية لجميعها).

## DESCRIPTION <!--!= @#Desc !-->
يضيف الدوال إلى جلسة العمل الحالية إلى قائمة أدوات الدعوة المسموح بها!
عند إضافة أمر، يتم إرساله إلى النموذج الحالي كخيار لدعوة الأداة.
سيتم استخدام مساعدة الدالة المتاحة لوصفها، بما في ذلك المعلمات.
بذلك، يمكنك، في وقت التشغيل، إضافة مهارات جديدة إلى الذكاء الاصطناعي والتي يمكن استدعاؤها بواسطة LLM وتنفيذها بواسطة PowershAI.  

عند إضافة البرامج النصية، يتم إضافة جميع الدوال داخل البرنامج النصي دفعة واحدة.

لمزيد من المعلومات حول الأدوات، راجع موضوع about_Powershai_Chats

مهم للغاية: 
لا تقم أبدًا بإضافة أوامر لا تعرفها أو التي قد تعرض جهاز الكمبيوتر الخاص بك للخطر.  
سيقوم POWERSHELL بتنفيذها بناءً على طلب LLM وبالمعلمات التي يستدعيها LLM، وباستخدام بيانات اعتماد المستخدم الحالي.  
إذا كنت مسجلاً دخولًا باستخدام حساب ممتاز، مثل المسؤول، لاحظ أنه يمكنك تنفيذ أي إجراء بناءً على طلب خادم بعيد (LLM).

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
اسم الأمر أو مسار البرنامج النصي أو الملف القابل للتنفيذ
يمكن أن يكون مصفوفة سلسلة تحتوي على هذه العناصر المختلطة.
عندما يكون الاسم الذي ينتهي بـ .ps1، يتم التعامل معه كبرنامج نصي (أي سيتم تحميل الدوال من البرنامج النصي)
إذا كنت ترغب في التعامل مع أمر (تنفيذ البرنامج النصي)، فقم بتحديد المعلمة -Command، لإجبارها على التعامل معها كأمر!

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

### -description
وصف لهذه الأداة التي سيتم تمريرها إلى LLM.  
سيستخدم الأمر المساعدة ويرسل أيضًا المحتوى الموصوف
إذا تم إضافة هذه المعلمة، فسيتم إرسالها مع المساعدة.

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

### -ForceCommand
إجبار التعامل معه كأمر. مفيد عندما تريد تنفيذ برنامج نصي كأمر.
مفيد فقط عندما تمرر اسم ملف غامض، يتطابق مع اسم أحد الأوامر!

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

### -ChatId
الدردشة التي سيتم إنشاء الأداة فيها

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
إنشاء الأداة عالميًا، أي ستكون متاحة في جميع الدردشات

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
