---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Sends a message to a LLM, with support for Tool Calling, and executes the tools requested by the model as PowerShell commands.

## DESCRIPTION <!--!= @#Desc !-->
This is an auxiliary function to help make tool processing easier with PowerShell.
It handles the processing of "Tools", executing when the model requests!

You must pass the tools in a specific format, documented in the about_Powershai_Chats topic.
This format correctly maps functions and PowerShell commands to the schema acceptable by OpenAI (OpenAPI Schema).

This command encapsulates all the logic that identifies when the model wants to invoke the function, the execution of these functions, and the sending of that response back to the model.
It stays in this loop until the model decides to stop invoking more functions, or the limit of interactions (yes, here we call it interactions, not iterations) with the model has ended.

The concept of interaction is simple: Each time the function sends a prompt to the model, it counts as an integration.
Below is a typical flow that may occur:

You can get more details on how it works by consulting the about_Powershai_Chats topic.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] 
<Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] 
[-Stream] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt

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

### -Tools
Array of tools, as explained in the documentation of this command.
Use the results from Get-OpenaiTool* to generate possible values.
You can pass an array of objects of type OpenaiTool.
If the same function is defined in more than one tool, the first one found in the defined order will be used!

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

### -PrevContext

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

### -MaxTokens
max output!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 500
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
In total, allow a maximum of 5 iterations!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Maximum number of consecutive errors that your function can generate before it ends.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 2
Accept pipeline input: false
Accept wildcard characters: false
```

### -temperature

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -on
Event handler
Each key is an event that will be triggered at some point by this command!
events:
answer: triggered after obtaining the response from the model (or when a response becomes available when using stream).
func: triggered before starting the execution of a tool requested by the model.
exec: triggered after the model executes the function.
error: triggered when the executed function generates an error.
stream: triggered when a response has been sent (by the stream) and -DifferentStreamEvent.
beforeAnswer: Triggered after all responses. Useful when used in stream!
afterAnswer: Triggered before starting the responses. Useful when used in stream!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Sends the response_format = "json", forcing the model to return a json.

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

### -RawParams
Add custom parameters directly to the call (will overwrite automatically defined parameters).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Stream

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
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
