﻿---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-HuggingFaceInferenceApi

## SYNOPSIS <!--!= @#Synop !-->
Invoca a API de Inferência Hugging Face
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
Forçar usar endpoint de chat completion 
Params deverá ser tratado como o mesmo params da Api da Openai (Veja o cmdle Get-OpenaiChat).
Mais info: https://huggingface.co/blog/tgi-messages-api
So funciona com modelos que possuem um chat template!

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
Stream Callback para ser usado no caso de streamS!

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