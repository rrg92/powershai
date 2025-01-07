---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-AiChatResult

## SYNOPSIS <!--!= @#Synop !-->
Creates a new AiChat object, which is the object that should be returned by the *_Chat interface

## SYNTAX <!--!= @#Syntax !-->

```
New-AiChatResult [-id] <String> [-model] <String> [[-choices] <Object>] [[-SystemFingerprint] <Object>] [[-PromptTokens] <Int32>] [[-CompletionTokens] <Int32>] [[-TotalTokens] <Int32>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -id
internal message id (chat.completion.id)

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: true
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
AI model name (chat.completion.model)

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: true
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -choices
chat.completion.choices, created with New-AiChatToolChoice

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

### -SystemFingerprint
chat.completion.system_fingerprint

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PromptTokens
chat.completion.system_fingerprint

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -CompletionTokens
chat.completion.completion_tokens

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -TotalTokens
chat.completion.total_tokens

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
