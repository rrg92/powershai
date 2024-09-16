---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Adds functions, scripts, executables as a tool invocable by the LLM in the current chat (or default for all).

## DESCRIPTION <!--!= @#Desc !-->
Adds functions to the current session to the list of allowed Tool calling!
When a command is added, it is sent to the current model as an option for Tool Calling.
The available help of the function will be used to describe it, including the parameters.
With that, you can, at runtime, add new skills to the AI that can be invoked by the LLM and executed by PowershAI.

When adding scripts, all functions within the script are added at once.

For more information on tools see the about_Powershai_Chats topic

VERY IMPORTANT:
NEVER ADD COMMANDS THAT YOU DO NOT KNOW OR THAT COULD COMPROMISE YOUR COMPUTER.
POWERSHELL WILL EXECUTE IT AT THE REQUEST OF THE LLM AND WITH THE PARAMETERS THAT THE LLM INVOKES, AND WITH THE CURRENT USER'S CREDENTIALS.
IF YOU ARE LOGGED IN WITH A PRIVILEGED ACCOUNT, SUCH AS THE ADMINISTRATOR, NOTE THAT YOU MAY PERFORM ANY ACTION AT THE REQUEST OF A REMOTE SERVER (THE LLM).

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
Command name, script path or executable
It can be an array of string with these elements mixed.
When a name ending with .ps1 is passed, it is treated as a script (that is, the functions of the script will be loaded)
If you want to treat it as a command (execute the script), inform the -Command parameter, to force it to be treated as a command!

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

### -description
Description for this tool to be passed to the LLM.
The command will use the help and send the described content as well.
If this parameter is added, it is sent along with the help.

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

### -ForceCommand
Forces to be treated as a command. Useful when you want a script to be executed as a command.
Useful only when you pass an ambiguous file name, which coincides with the name of some command!

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

### -ChatId
Chat in which to create the tool

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
Creates the tool globally, that is, it will be available in all chats

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
