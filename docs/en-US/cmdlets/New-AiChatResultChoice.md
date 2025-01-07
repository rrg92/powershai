---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-AiChatResultChoice

## SYNOPSIS <!--!= @#Synop !-->
Creates a new chat tool choice object to be specified in choices of the New-AiChatResult parameter

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
content, in text, of the message

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
if finish_Reason is tools_calls, create each tool with New-AiChatToolCall and add here!

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


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
