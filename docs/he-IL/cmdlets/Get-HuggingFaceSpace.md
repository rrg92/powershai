---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
Obtém informações de um espaço específico!

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
Filtra por um espaço específico (ou array de espaços)

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
Filtrar todos os espaços por autor

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
Filtrar todos os espaços do usuário atual!

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
Por padrão, em espaços gradio, ele já cria uma gradio session!

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
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
