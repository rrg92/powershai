---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Add-PowershaiChatTool

## SYNOPSIS
Adds functions, scripts, executables as a tool callable by the LLM in the current chat (or default for all).

## SYNTAX

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>]
 [-Global] [<CommonParameters>]
```

## DESCRIPTION
Adds functions in the current session to the list of allowed Tool calling!
When a command is added, it is sent to the current model as an option for Tool Calling.
The available help from the function will be used to describe it, including the parameters.
With this, you can, at runtime, add new skills to the AI that can be invoked by the LLM and executed by PowershAI.
 

When adding scripts, all functions within the script are added at once.

For more information about tools, consult the topic about_Powershai_Chats

VERY IMPORTANT: 
NEVER ADD COMMANDS THAT YOU DO NOT KNOW OR THAT MAY COMPROMISE YOUR COMPUTER.
 
POWERSHELL WILL EXECUTE IT AT THE REQUEST OF THE LLM AND WITH THE PARAMETERS THAT THE LLM INVOKES, AND WITH THE CREDENTIALS OF THE CURRENT USER.
 
IF YOU ARE LOGGED IN WITH A PRIVILEGED ACCOUNT, SUCH AS ADMINISTRATOR, NOTE THAT YOU WILL BE ABLE TO EXECUTE ANY ACTION AT THE REQUEST OF A REMOTE SERVER (THE LLM).

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -names
Name of the command, script path, or executable
Can be an array of strings with these mixed elements.
When a name that ends with .ps1 is passed, it is treated as a script (that is, the functions from the script will be loaded)
If you want to treat it as a command (execute the script), specify the -Command parameter to force it to be treated as a command!

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

### -description
Description for this tool to be passed to the LLM.
 
The command will use the help and also send the described content
If this parameter is added, it is sent along with the help.

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

### -ForceCommand
Forces treatment as a command.
Useful when you want a script to be executed as a command.
Only useful when you pass an ambiguous file name that matches the name of some command!

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

### -ChatId
Chat in which to create the tool

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -Global
Creates the tool globally, that is, it will be available in all chats

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


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->