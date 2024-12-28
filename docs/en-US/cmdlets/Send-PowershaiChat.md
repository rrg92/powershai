---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS 
Sends a message in a Powershai Chat

## DESCRIPTION 
This cmdlet allows you to send a new message to the LLM of the current provider. 
By default, it sends to the active chat. You can overwrite the chat using the -Chat parameter. If there is no active chat, it will use the default.

Several Chat parameters affect how this command works. See the Get-PowershaiChatParameter command for more info on chat parameters.
In addition to the chat parameters, the command's own parameters can override behavior. For more details, see the documentation for each parameter of this cmdlet using get-help.

For simplicity, and to keep the command line clean, allowing the user to focus more on the prompt and data, some aliases are available.
These aliases can activate certain parameters.
They are:
ia|ai

Abbreviation of "Artificial Intelligence" in Portuguese. This is a simple alias and does not change any parameters. It helps to significantly reduce the command line.

iat|ait

Same as Send-PowershaAIChat -Temporary

io|ao

Same as Send-PowershaAIChat -Object

iam|aim 

Same as Send-PowershaaiChat -Screenshot

The user can create their own aliases. For example:
Set-Alias ki ia # DEfine the alias for German!
Set-Alias kit iat # DEfine the alias kit for iat, making the behavior the same as iat (temporary chat) when using kit!

## SYNTAX 

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] [-DisableTools] 
[-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] [-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS 

### -prompt
the prompt to be sent to the model

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

### -SystemMessages
System message to be included

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
The context
This parameter is preferably used by the pipeline.
It will cause the command to put the data in <context></context> tags and inject it into the prompt.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
Forces the cmdlet to execute for each object in the pipeline
By default, it accumulates all objects in an array, converts the array to a string only and sends it all at once to the LLM.

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

### -Json
Enables json mode
in this mode the results returned will always be a JSON.
The current model must support!

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

### -Object
Object mode!
in this mode JSON mode will be automatically activated!
The command will not write anything to the screen, and will return the results as an object!
Which will be thrown back into the pipeline!

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

### -PrintContext
Shows the context data sent to the LLM before the response!
It is useful for debugging what data is being injected into the prompt.

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

### -Forget
Do not send previous conversations (the context history), but include the prompt and response in the historical context.

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

### -Snub
Ignore the LLM response, and do not include the prompt in the historical context

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

### -Temporary
Do not send the history and do not include the response and prompt. 
It is the same as passing -Forget and -Snub together.

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

### -DisableTools
Turns off the function call for this execution only!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
Change the context formatter to this one
See more about in Format-PowershaiContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterParams
Parameters of the changed context formatter.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PassThru
Returns the messages back to the pipeline, without writing directly to the screen!
This option assumes that the user will be responsible for giving the correct destination of the message!
The object passed to the pipeline will have the following properties:

text 

- The text (or section) of the text returned by the model 
formatted

- The formatted text, including the prompt, as if it were written directly to the screen (without the colors)
event

- The event. Indicates the event that originated. They are the same events documented in Invoke-AiChatTools
interaction 

- The interaction object generated by Invoke-AiChatTools

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

### -Lines
Returns an array of lines 
If stream mode is enabled, it will return one line at a time!

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

### -ChatParamsOverride
Override chat parameters!
Specify each option in hashtables!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Specifies the value of the chat parameter RawParams directly!
If also specified in ChatParamOverride, a merge is performed, giving priority to the parameters specified here.
RawParams is a chat parameter that defines parameters that will be sent directly to the model's api!
These parameters will overwrite the default values calculated by powershai!
With this, the user has total control over the parameters, but needs to know each provider!
Also, each provider is responsible for providing this implementation and using these parameters in its api.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
Captures a screenshot of the screen behind the powershell window and sends it along with the prompt. 
Note that the current mode must support images (Vision Language Models).

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
