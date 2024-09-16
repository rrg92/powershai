---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
إزالة مكالمات API من قائمة الجلسة الداخلية

## DESCRIPTION <!--!= @#Desc !-->
يساعد هذا cmdlet في إزالة الأحداث التي تم إنشاؤها بواسطة Invoke-GradioSessionApi من قائمة المكالمات الداخلية. 
عادةً ما تريد إزالة الأحداث التي قمت بمعالجتها بالفعل، تمرير المعرف المباشر.  
لكن، يسمح لك هذا cmdlet بإجراء أنواع متعددة من الإزالة، بما في ذلك الأحداث غير المعالجة.  
استخدم بحذر، لأنه بمجرد إزالة حدث من القائمة، يتم أيضًا إزالة البيانات المرتبطة به.  
ما لم تقم بعمل نسخة من الحدث (أو البيانات الناتجة) إلى متغير آخر، فلن تتمكن من استرداد هذه المعلومات بعد الآن.  

إزالة الأحداث مفيدة أيضًا للمساعدة في تحرير الذاكرة المستهلكة، والتي يمكن أن تكون عالية، اعتمادًا على كمية الأحداث والبيانات.

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
يحدد الحدث، أو الأحداث، المراد إزالتها
يمكن أن يكون المعرف أيضًا أحد هذه القيم الخاصة:
	clean 	- إزالة المكالمات المكتملة فقط!
  all 	- إزالة كل شيء، بما في ذلك ما لم يكتمل!

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

### -Force
بشكل افتراضي، يتم إزالة الأحداث المارة فقط مع حالة "completed"!
استخدم -Force لإزالة inpdenente من الحالة!

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

### -Elegible
لا يقوم بأي إزالة، لكنه يعيد المرشحين!

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

### -session
معرف الجلسة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -WhatIf

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: wi
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Confirm

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: cf
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
