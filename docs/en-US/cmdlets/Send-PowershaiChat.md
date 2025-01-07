---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Sends a message in a Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet allows you to send a new message to the LLM of the current provider.  
By default, it sends in the active chat. You can override the chat using the -Chat parameter. If there is no active chat, it will use the default.  

Several chat parameters affect how this command works. See the Get-PowershaiChatParameter command for more info about the chat parameters.  
In addition to the chat parameters, the command's own parameters can override behavior. For more details, refer to the documentation for each parameter of this cmdlet using get-help.  

For simplicity, and to keep the command line clean, allowing the user to focus more on the prompt and the data, some aliases are available.  
These aliases can activate certain parameters.
They are:
	ia|ai
		Abbreviation of "Artificial Intelligence" in Portuguese. This is a simple alias and does not change any parameter. It helps significantly reduce the command line.
	
	iat|ait
		The same as Send-PowershaAIChat -Temporary
		
	io|ao
		The same as Send-PowershaAIChat -Object
		
	iam|aim 
		The same as Send-PowershaaiChat -Screenshot 

The user can create their own aliases. For example:
	Set-Alias ki ia # Defines the alias for German!
	Set-Alias kit iat # Defines the alias kit for iat, making the behavior the same as iat (temporary chat) when using kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] 
[-FormatterParams <Object>] [-PassThru] [-Lines] [-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

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
It will cause the command to place the data in <context></context> tags and inject it along with the prompt.

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
By default, it accumulates all objects in an array, converts the array to a single string, and sends it all at once to the LLM.

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false```markdown
### -Json
Enables the json mode 
in this mode the results returned will always be a JSON.
The current model must support it!

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
Object Mode!
in this mode the JSON mode will be activated automatically!
The command will not write anything to the screen, and will return the results as an object!
Which will be sent back to the pipeline!

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
It's useful for debugging what is being injected into the prompt.

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
Do not send previous conversations (the context history), but include the prompt and the response in the context history.

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
Ignore the LLM's response, and do not include the prompt in the context history

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
Does not send the history and does not include the response and prompt.  
It's the same as passing -Forget and -Snub together.

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
Disables the function call for this execution only!

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
Change the formatter context to this
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
Parameters of the altered formatter context.

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
This option assumes that the user will be responsible for directing the message correctly!
```The object passed to the pipeline will have the following properties:
	text 			- The text (or excerpt) of the text returned by the model 
	formatted		- The formatted text, including the prompt, as if it were written directly on the screen (without colors)
	event			- The event. Indicates the originating event. These are the same events documented in Invoke-AiChatTools
	interaction 	- The interaction object generated by Invoke-AiChatTools

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
If the stream mode is enabled, it will return one line at a time!

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
Specify each option in hash tables!

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
If also specified in ChatParamOverride, a merge is done, giving priority to the parameters specified here.
The RawParams is a chat parameter that defines parameters that will be sent directly to the model API!
These parameters will override the default values calculated by PowerShell!
With this, the user has full control over the parameters but needs to know each provider!
Also, each provider is responsible for providing this implementation and using these parameters in their API.

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
Captures a screenshot of the screen behind the PowerShell window and sends it along with the prompt. 
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
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
