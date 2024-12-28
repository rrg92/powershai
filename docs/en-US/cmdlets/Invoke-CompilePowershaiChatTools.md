---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-CompilePowershaiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Converts all added tools into the format expected by the Invoke-AiChatTools function.

## DESCRIPTION <!--!= @#Desc !-->
Gets all the tools registered by the user with New-PowershaiChatTool and compiles them into a single object to be sent to the LLM using Invoke-AiChatTools.
This process can be quite slow, depending on the number of tools added.

The cmdlet will iterate through all the tools, obtain the help from the commands and parameters, and convert this into a format that can be sent in Invoke-AiChatTools
As PowershAI defines that the tools mechanism must follow the OpenAI standard, the Get-OpenaiTool* function from the OpenAI provider is used.
These functions contain the necessary logic to generate the tool calling schema following the OpenAI specifications.

This command iterates through each tool available for the current chat and creates what is necessary to be sent with Invoke-AiChatTools.
Invoke-AiChatTools contains all the logic to handle sending, executing and responding to the LLM.

Basically, there are 2 types of tools that Powershai supports: Script or Command.
Command is any code executable by powershell: functions, .exe, native cmdlets, etc.

Scripts are simple .ps1 files that define the functions that can be used as tools.
It's like a group of commands.

This command invokes everything necessary to convert these tools into the standard format expected by Invoke-AiChatTools.
Invoke-AiChatTools knows nothing about chats, global tools. It is a generic function that does not depend on the Chat mechanism created by Powershai.

Therefore, it is necessary for this function to do all this "translation" of Powershai Chat facilities to what is expected by Invoke-AiChatTools.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-CompilePowershaiChatTools [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Chat from which the tools will be obtained
In addition to the chat, global tools will be included

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
