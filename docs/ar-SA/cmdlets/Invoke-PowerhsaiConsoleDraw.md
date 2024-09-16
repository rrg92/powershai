---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
يُنشئ إطارًا نصيًا افتراضيًا، ويكتب أحرفًا داخل حدود هذا الإطار

## DESCRIPTION <!--!= @#Desc !-->
ينشئ إطار رسم في وحدة التحكم، والذي يتم تحديثه في منطقة محددة فقط!
يمكنك إرسال العديد من أسطر النص وستعتني الوظيفة بالحفاظ على الرسم في نفس الإطار، مما يعطي انطباعًا بأن منطقة واحدة فقط يتم تحديثها.
للحصول على التأثير المطلوب، يجب استدعاء هذه الوظيفة مرارًا وتكرارًا، دون أي عمليات كتابة أخرى بين الاستدعاءات!

يجب استخدام هذه الوظيفة فقط في وضع التفاعل في powershell، والذي يعمل في نافذة وحدة التحكم.
إنها مفيدة للاستخدام في المواقف التي تريد فيها رؤية تقدم نتيجة نصية في نفس المنطقة تمامًا، مما يسمح لك بمقارنة الاختلافات بشكل أفضل.
إنها مجرد وظيفة مساعدة.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
يُظهر هذا المثال 3 سلاسل نصية كل 2 ثانية.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
النص الذي سيتم كتابته. يمكن أن يكون مصفوفة. إذا تجاوز حدود W و H، فسيتم اقتطاعه
إذا كان نصًا برمجيًا كتلة، فسيستدعي الكود بمرور الكائن من خط الأنابيب!

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
الحد الأقصى لعدد الأحرف في كل سطر

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
الحد الأقصى لعدد الأسطر

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
الحرف المستخدم كمساحة فارغة

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
