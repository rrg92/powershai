---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-HuggingFaceInferenceApi

## SYNOPSIS <!--!= @#Synop !-->
Ruft die Hugging Face Inferenz-API auf
https://huggingface.co/docs/hub/en/api

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-HuggingFaceInferenceApi [[-model] <Object>] [[-params] <Object>] [-Public] [-OpenaiChatCompletion] [[-StreamCallback] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model

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

### -params

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Public

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

### -OpenaiChatCompletion
Erzwingt die Verwendung des Chat-Completion-Endpunkts
Params sollten wie die gleichen Params der Openai Api behandelt werden (siehe Cmdlet Get-OpenaiChat).
Weitere Informationen: https://huggingface.co/blog/tgi-messages-api
Funktioniert nur mit Modellen, die eine Chat-Vorlage haben!

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

### -StreamCallback
Stream-Callback für die Verwendung im Falle von Streams!

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
