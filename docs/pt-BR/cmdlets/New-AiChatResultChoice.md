---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-AiChatResultChoice

## SYNOPSIS <!--!= @#Synop !-->
Cria um novo objeto chat tool choice para ser especificado em choices do parâmetro de New-AiChatResult

## SYNTAX <!--!= @#Syntax !-->

```
New-AiChatResultChoice [[-FinishReason] <String>] [[-role] <String>] [[-content] <Object>] [[-tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -FinishReason
chat.completion.choices[0].finish_reason

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -role
chat.completion.choices[0].message.role

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: assistant
Accept pipeline input: false
Accept wildcard characters: false
```

### -content
conteúdo, em texto, da mensagem

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

### -tools
se finish_Reason é tools_calls , criar cada tool com New-AiChatToolCall e adicionar aqui!

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