---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Clear-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
حذف عناصر الدردشة!

## DESCRIPTION <!--!= @#Desc !-->
حذف عناصر محددة من دردشة.  
مفيد لتحرير الموارد، أو لتعطيل الاعتماد على llm بسبب السجل.

## SYNTAX <!--!= @#Syntax !-->

```
Clear-PowershaiChat [-History] [-Context] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -History
حذف جميع السجل

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

### -Context
حذف السياق
معرف الدردشة. القيمة الافتراضية: النشط.

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




<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
