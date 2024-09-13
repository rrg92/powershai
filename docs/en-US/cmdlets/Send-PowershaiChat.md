---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Send-PowershaiChat

## SYNOPSIS
Sends a message in a Powershai Chat

## SYNTAX

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json]
 [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>]
 [-FormatterParams <Object>] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet allows you to send a new message to the LLM of the current provider.
 
By default, it sends to the active chat.
You can overwrite the chat using the -Chat parameter. 
If there is no active chat, it will use the default.
 

Various chat parameters affect how this command works.
See the Get-PowershaiChatParameter command for more info about chat parameters.
 
In addition to the chat parameters, the command's own parameters can overwrite behavior. 
For more details, consult the documentation for each parameter of this cmdlet using get-help.
 

For simplicity, and to keep the command line clean, allowing the user to focus more on the prompt and data, some aliases are provided.
 
These aliases can activate certain parameters.
They are:
	ia|ai
		Abbreviation for "Artificial Intelligence" in Portuguese.
This is a simple alias and does not change any parameter.
It helps to significantly reduce the command line.
	
	iat|ait
		The same as Send-PowershaAIChat -Temporary
		
	io|ao
		The same as Send-PowershaAIChat -Object

The user can create their own aliases.
For example:
	Set-Alias ki ia # Defines the alias for German!
	Set-Alias kit iat # Defines the alias kit for iat, making the behavior the same as iat (temporary chat) when using kit!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -prompt
the prompt to be sent to the model

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

### -SystemMessages
System message to be included

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -context
The context 
This parameter is preferably used by the pipeline.
It will make the command place the data in <context></context> tags and inject it along with the prompt.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ForEach
Forces the cmdlet to execute for each object in the pipeline
By default, it accumulates all objects in an array, converts the array to string only, and sends it all at once to the LLM.

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

### -Json
Enables JSON mode 
in this mode the returned results will always be JSON.
The current model must support it!

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

### -Object
Object mode!
in this mode JSON mode will be automatically activated!
The command will not write anything to the screen, and will return the results as an object!
Which will be thrown back into the pipeline!

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

### -PrintContext
Shows the context data sent to the LLM before the response!
It is useful for debugging what is being injected as data into the prompt.

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

### -Forget
Do not send previous conversations (the context history), but include the prompt and response in the context history.

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

### -Snub
Ignore the LLM's response, and do not include the prompt in the context history

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

### -Temporary
Does not send the history nor include the response and prompt.
 
It is the same as passing -Forget and -Snub together.

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

### -DisableTools
Disables the function call for this execution only!

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoCalls, NoTools, nt

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatterFunc
Change the context formatter to this
See more about it in Format-PowershaiContext

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatterParams
Parameters of the changed context formatter.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns the messages back in the pipeline, without writing directly to the screen!
This option assumes that the user will be responsible for providing the correct destination for the message!
The object passed to the pipeline will have the following properties:
	text 			- The text (or excerpt) from the text returned by the model 
	formatted		- The formatted text, including the prompt, as if it were written directly to the screen (without colors)
	event			- The event.
Indicates the event that originated.
These are the same events documented in Invoke-AiChatTools
	interaction 	- The interaction object generated by Invoke-AiChatTools

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
