---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
تصدير إعدادات الجلسة الحالية إلى ملف ، مشفر بواسطة كلمة مرور

## DESCRIPTION <!--!= @#Desc !-->
هذا cmdlet مفيد لحفظ الإعدادات ، مثل الرموز المميزة ، بطريقة آمنة.  
يطلب كلمة مرور ويستخدمها لإنشاء تجزئة وتشفير بيانات إعدادات الجلسة في AES256.  

الإعدادات المصدرة هي كل تلك التي تم تحديدها في متغير $POWERSHAI_SETTINGS.  
هذا المتغير هو جدول سلسلة يحتوي على جميع البيانات المحددة بواسطة الموفرين ، بما في ذلك الرموز المميزة.  

بشكل افتراضي ، لا يتم تصدير الدردشات بسبب كمية البيانات المعنية ، مما قد يجعل الملف كبيرًا جدًا!

يتم حفظ الملف المصدر في دليل تم إنشاؤه تلقائيًا ، بشكل افتراضي ، في ملف تعريف المستخدم ($HOME).  
يتم تصدير الكائنات عبر التحويل التسلسلي ، وهي نفس الطريقة المستخدمة بواسطة Export-CliXml.  

يتم تصدير البيانات في تنسيق خاص يمكن استيراده فقط باستخدام Import-PowershaiSettings وتحديد نفس كلمة المرور.  

بما أن PowershAI لا يقوم بعمل تصدير تلقائي ، فمن المستحسن استدعاء هذا الأمر كلما تم إجراء أي تغييرات في التكوين ، مثل تضمين رموز مميزة جديدة.  

يمكن أن يكون دليل التصدير أي مسار صالح ، بما في ذلك محركات الأقراص السحابية مثل OneDrive ، Dropbox ، إلخ.  

تم إنشاء هذا الأمر ليكون تفاعليًا ، أي أنه يحتاج إلى إدخال المستخدم من لوحة المفاتيح.

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### تصدير الإعدادات الافتراضية!
```powershell
Export-PowershaiSettings
```

### تصدير كل شيء ، بما في ذلك الدردشات!
```powershell
Export-PowershaiSettings -Chat
```

### تصدير إلى OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
دليل التصدير
بشكل افتراضي ، هو دليل يسمى .powershai في ملف تعريف المستخدم ، ولكن يمكنك تحديد متغير البيئة POWERSHAI_EXPORT_DIR لتغييره.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -Chats
إذا تم تحديده ، فإنه يشمل الدردشات في التصدير
سيتم تصدير جميع الدردشات

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
