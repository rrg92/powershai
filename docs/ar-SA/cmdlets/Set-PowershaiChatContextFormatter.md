---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
يحدد الدالة التي سيتم استخدامها لتنسيق الكائنات التي يتم تمريرها إلى المعلمة Send-PowershaiChat -Context

## DESCRIPTION <!--!= @#Desc !-->
عند استدعاء Send-PowershaiChat في أنبوب ، أو عند تمرير المعلمة -Context مباشرة ، فإنه سيحقن هذا الكائن في موجه LLM.  
قبل حقنه ، يجب تحويل هذا الكائن إلى سلسلة.  
يُطلق على هذا التحويل "Context Formatter" هنا في Powershai.  
Context Formatter هو دالة ستأخذ كل كائن تم تمريره وتحويله إلى سلسلة ليتم حقنها في الموجه.
يجب أن تتلقى الدالة المستخدمة كمعلمة أولى الكائن المراد تحويله.  

تعتمد المعلمات الأخرى على التقدير. يمكن تحديد قيمها باستخدام المعلمة -Params لهذه الدالة!

يقدم Powershai منسقي سياق أصليين.  
استخدم Get-Command ConvertTo-PowershaiContext * أو Get-PowershaiContextFormatters للحصول على القائمة!

بمجرد أن تكون منسقي سياق أصليين هم مجرد دوال Powershell ، يمكنك استخدام Get-Help Name للحصول على مزيد من التفاصيل.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Func
اسم دالة Powershell
استخدم الأمر Get-PowershaiContextFormatters لعرض القائمة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Str
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




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
