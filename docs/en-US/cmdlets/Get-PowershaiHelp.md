---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-PowershaiHelp

## SYNOPSIS
Uses the current provider to help obtain help about powershai!

## SYNTAX

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet uses PowershAI's own commands to help the user obtain help about itself.
 
Basically, starting from the user's question, it builds a prompt with some common information and basic helps.
 
Then, this is sent to the LLM in a chat.

Due to the large volume of data being sent, it is recommended to use this command only with providers and models that accept more than 128k and that are inexpensive.
 
For now, this command is experimental and works only with these models:
	- OpenAI gpt-4*
	
Internally, it will create a Powershai Chat called "_pwshai_help", where it will keep all the history!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -helptext
Describe the help text!

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

### -command
If you want help for a specific command, provide the command here 
It does not have to be just a command from PowershaiChat.

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

### -Recreate
Recreates the chat!

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
