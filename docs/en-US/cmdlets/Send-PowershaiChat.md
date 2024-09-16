---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Sends a message in a Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet lets you send a new message to the LLM of the current provider.  
By default, it sends to the active chat. You can override the chat using the -Chat parameter.  If there is no active chat, it will use the default.  

Several Chat parameters affect how this command works. See the Get-PowershaiChatParameter command for more info about chat parameters.  
In addition to chat parameters, command parameters themselves can override behavior.  For more details, consult the documentation for each parameter of this cmdlet using get-help.  

For simplicity, and to keep the command line clean, allowing the user to focus more on the prompt and data, some aliases are provided.  
These aliases can activate certain parameters.
They are:
	ia|ai
		Abbreviation for "Artificial Intelligence" in English. This is a simple alias and does not change any parameter. It helps to reduce the command line a lot.
	
	iat|ait
		Same as Send-PowershaAIChat -Temporary
		
	io|ao
		Same as Send-PowershaAIChat -Object

The user can create their own aliases. For example:
	Set-Alias ki ia # DEfine the alias for german!
	Set-Alias kit iat # DEfine the kit alias for iat, making the behavior the same as iat (temporary chat) when using kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] 
[-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] [<CommonParameters>]
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
It will cause the command to put the data in <context></context> tags and inject it along with the prompt.

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
By default, it accumulates all objects in an array, converts the array to string only and sends it all at once to the LLM.

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
Enable json mode
in this mode the returned results will always be a JSON.
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
in this mode JSON mode will be activated automatically!
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
Do not send the previous conversations (the context history), but include the prompt and the response in the historical context.

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
Do not send the history or include the response and prompt.  
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
Disables function call for this execution only!

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
Change the context formatter for this
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
Parameters of the altered context formatter.

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
	text 			- The text (or portion) of the text returned by the model 
	formatted		- The formatted text, including the prompt, as if it were written directly to the screen (without the colors)
	event			- The event. Indicates the event that originated. They are the same events documented in Invoke-AiChatTools
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




<!--PowershaiAiDocBlockStart-->
_Translated automatically using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
