---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Sends a message in a Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet allows you to send a new message to the current provider's LLM.  
By default, it sends to the active chat. You can override the chat using the -Chat parameter.  If there is no active chat, it will use the default one.  

Several Chat parameters affect how this command works. See the Get-PowershaiChatParameter command for more information on chat parameters.  
In addition to chat parameters, the command's own parameters can override behavior.  For more details, consult the documentation for each parameter of this cmdlet using get-help.  

For simplicity, and to keep the command line clean, allowing the user to focus more on the prompt and data, some aliases are available.  
These aliases can activate certain parameters.
They are:
	ia|ai
		Abbreviation of "Artificial Intelligence" in English. This is a simple alias and does not change any parameter. It helps to reduce the command line considerably.
	
	iat|ait
		Same as Send-PowershaAIChat -Temporary
		
	io|ao
		Same as Send-PowershaAIChat -Object

The user can create their own aliases. For example:
	Set-Alias ki ia # DEfine o alias para o alemao!
	Set-Alias kit iat # DEfine o alias kit para iat, fazendo o comportamento ser igual ao iat (chat temporaria) quando usado o kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] 
[-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [<CommonParameters>]
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
This parameter is preferred to be used by the pipeline.
It will cause the command to put the data in <contexto></contexto> tags and inject it into the prompt.

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
By default, it accumulates all objects into an array, converts the array to string only and sends it to the LLM at once.

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
Do not send previous conversations (context history), but include the prompt and response in the historical context.

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
Ignore the LLM's response, and do not include the prompt in the historical context

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
Do not send the history, nor include the response and prompt.  
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
Turns off function call for this execution only!

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
Change the context formatter to this
See more about it in Format-PowershaiContext

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
Returns messages back into the pipeline, without writing directly to the screen!
This option assumes that the user will be responsible for giving the correct message destination!
The object passed to the pipeline will have the following properties:
	text 			- The text (or excerpt) of the text returned by the model 
	formatted		- The formatted text, including the prompt, as if it were written directly to the screen (without the colors)
	event			- The event. Indicates the event that originated it. They are the same events documented in Invoke-AiChatTools
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




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
