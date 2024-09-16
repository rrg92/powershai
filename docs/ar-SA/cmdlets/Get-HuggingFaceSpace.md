---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
Obtém informações de um space específico!

## SYNTAX <!--!= @#Syntax !-->

### Multiple
```
Get-HuggingFaceSpace [-author <Object>] [-My] [-NoGradioSession] [<CommonParameters>]
```

### Single
```
Get-HuggingFaceSpace [[-Space] <Object>] [-NoGradioSession] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
Filtra por um space específico (ou array de spaces)

```yml
Parameter Set: Single
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -author
Filtrar todos os spaces por autor

```yml
Parameter Set: Multiple
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -My
Filtrar todos os spaces do usuário atual!

```yml
Parameter Set: Multiple
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoGradioSession
Não cria uma sessão gradio automática.
Por padrão, em spaces gradios, ele já cria uma gradio session!

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
