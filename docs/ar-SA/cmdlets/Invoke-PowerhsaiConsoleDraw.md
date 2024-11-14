---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
يخلق إطار نصي افتراضي، ويكتب الأحرف داخل حدود هذا الإطار

## DESCRIPTION <!--!= @#Desc !-->
يخلق إطار رسم في الكونسول، يتم تحديثه في منطقة محددة فقط!
يمكنك إرسال عدة أسطر من النص وستقوم الوظيفة بالاعتناء بالحفاظ على الرسم في نفس الإطار، مما يعطي انطباعًا بأن منطقة واحدة فقط يتم تحديثها.
للحصول على التأثير المطلوب، يجب استدعاء هذه الوظيفة بشكل متكرر، دون أي كتابات أخرى بين الاستدعاءات!

يجب استخدام هذه الوظيفة فقط في وضع PowerShell التفاعلي، وتشغيلها في نافذة كونسول.
إنها مفيدة للاستخدام في الحالات التي تريد فيها رؤية تقدم نتيجة نصية بالضبط في نفس المنطقة، مما يتيح لك مقارنة التغييرات بشكل أفضل.
إنها مجرد وظيفة مساعدة.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
المثال التالي يكتب 3 سلاسل نصية كل 2 ثانية.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
النص المراد كتابته. يمكن أن يكون مصفوفة. إذا تجاوز الحدود W و H، سيتم اقتطاعه 
إذا كانت كتلة سكريبت، تستدعي الكود مع تمرير كائن خط الأنابيب!

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

### -w
أقصى عدد من الأحرف في كل سطر

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
أقصى عدد من الأسطر

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
الحرف المستخدم كفراغ فارغ

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

### -PipeObj
كائن خط الأنابيب

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
يمرر الكائن

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
_تمت الترجمة تلقائيًا باستخدام PowershAI والذكاء الاصطناعي._
<!--PowershaiAiDocBlockEnd-->
