---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-AiChatTools

## SYNOPSIS
Sends a message to a LLM, with support for Tool Calling, and executes the tools requested by the model as PowerShell commands.

## SYNTAX

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>]
 [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] <Object>]
 [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
```

## DESCRIPTION
This is an auxiliary function to help make processing tools easier with PowerShell.
It handles the processing of the "Tools", executing when the model requests!

You must pass the tools in a specific format, documented in the about_Powershai_Chats topic.
This format correctly maps functions and PowerShell commands to the schema accepted by OpenAI (OpenAPI Schema).
 

This command encapsulates all the logic that identifies when the model wants to invoke the function, the execution of these functions, and the sending of that response back to the model.
 
It stays in this loop until the model stops deciding to invoke more functions, or the interaction limit (yes, here we call it interactions, not iterations) with the model has ended.

The concept of interaction is simple: Every time the function sends a prompt to the model, it counts as an integration.
 
Below is a typical flow that may occur:
	

You can get more details on how it works by consulting the about_Powershai_Chats topic.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -prompt
{{ Fill prompt Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tools
Array of tools, as explained in the documentation for this command.
Use the results of Get-OpenaiTool* to generate possible values.
 
You can pass an array of objects of type OpenaiTool.
If the same function is defined in more than one tool, the first one found in the defined order will be used!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrevContext
{{ Fill PrevContext Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxTokens
max output!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 500
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxInteractions
In total, allow a maximum of 5 interactions!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxSeqErrors
Maximum number of consecutive errors that your function can generate before it stops.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -temperature
{{ Fill temperature Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0.6
Accept pipeline input: False
Accept wildcard characters: False
```

### -model
{{ Fill model Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -on
Event handler
Each key is an event that will be triggered at some point by this command!
events:
answer: triggered after obtaining the model's response (or when a response becomes available when using stream).
func: triggered before starting the execution of a tool requested by the model.
	exec: triggered after the model executes the function.
	error: triggered when the executed function generates an error
	stream: triggered when a response has been sent (via stream) and -DifferentStreamEvent
	beforeAnswer: Triggered after all responses.
Used when streamed!
	afterAnswer: Triggered before starting the responses.
Used when streamed!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Json
Sends the response_format = "json", forcing the model to return a json.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RawParams
Add custom parameters directly to the call (will overwrite the parameters defined automatically).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream
{{ Fill Stream Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
