---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
تعطيل أداة (ولكن لا تتم إزالتها). لا يتم إرسال الأداة المعطلة إلى LLM.

## SYNTAX <!--!= @#Syntax !-->

### Enable
```
Set-PowershaiChatTool [-tool <Object>] [-Enable] [-ForceCommand] [-ChatId <Object>] [-Global] [<CommonParameters>]
```

### Disable
```
Set-PowershaiChatTool [-tool <Object>] [-Disable] [-ForceCommand] [-ChatId <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
اسم الأداة (مثل Add-PowershaiChatTool) أو عبر الأنبوب، نتيجة Get-PowershaiChatTool

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Enable
تمكين الأداة.

```yml
Parameter Set: Enable
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -Disable
تعطيل الأداة.

```yml
Parameter Set: Disable
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ForceCommand
إذا تم تحديده، والأداة هي اسم، فإن هذا يجبر التعامل معه على أنه نص برمجي!

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
الدردشة التي توجد فيها الأداة

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
البحث عن الأداة في قائمة أدوات عالمية

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
