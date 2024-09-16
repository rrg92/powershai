---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
Uses the current provider to help get help about Powershai!

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet uses PowershAI's own commands to help the user get help about itself.  
Basically, from the user's question, it builds a prompt with some common information and basic helps.  
Then, it sends it to the LLM in a chat.

Due to the large amount of data being sent, it is recommended to use this command only with providers and models that accept more than 128k and are cheap.  
For now, this command is experimental and only works with these models:
	- Openai gpt-4*
	
Internally, it will create a Powershai Chat called "_pwshai_help", where it will keep all the history!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
Describe the help text!

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

### -command
If you want help from a specific command, enter the command here.
It doesn't need to be just a PowershaiChat command.

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

### -Recreate
Recreate the chat!

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
