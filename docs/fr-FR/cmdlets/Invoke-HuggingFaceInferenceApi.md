---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-HuggingFaceInferenceApi

## SYNOPSIS <!--!= @#Synop !-->
Appelle l'API d'Inference Hugging Face
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
Forcer l'utilisation de l'endpoint de chat completion 
Les params doivent être traités comme les mêmes params que l'API d'Openai (Voir le cmdlet Get-OpenaiChat).
Plus d'infos : https://huggingface.co/blog/tgi-messages-api
Ne fonctionne qu'avec des modèles qui possèdent un chat template !

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
Stream Callback à utiliser en cas de streamS !

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
