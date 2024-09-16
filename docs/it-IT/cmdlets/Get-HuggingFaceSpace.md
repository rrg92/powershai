---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
Obtiene informazioni da uno spazio specifico!

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
Filtra per uno spazio specifico (o un array di spazi)

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
Filtra tutti gli spazi per autore

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
Filtra tutti gli spazi dell'utente corrente!

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
Non crea una sessione Gradio automatica.
Per impostazione predefinita, negli spazi Gradio, crea già una sessione Gradio!

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
