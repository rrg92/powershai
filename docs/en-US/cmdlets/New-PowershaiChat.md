---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# New-PowershaiChat

## SYNOPSIS
Creates a new Powershai Chat.

## SYNTAX

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## DESCRIPTION
PowershaAI brings a concept of "chats", similar to the chats you see in OpenAI, or the "threads" of the Assistants API.

Each created chat has its own set of parameters, context, and history.

When you use the cmdlet Send-PowershaiChat (alias ia), you are sending messages to the model, and the history of that conversation with the model is kept in the chat created here by PowershAI.

In other words, all the history of your conversation with the model is maintained here in your PowershAI session, and not in the model or in the API.

This means that PowershAI keeps full control over what to send to the LLM and does not rely on mechanisms from different APIs of different providers to manage the history.

Each Chat has a set of parameters that, when changed, only affect that chat.

Certain parameters of PowershAI are global, such as the provider used. Changing the provider will make the Chat use the new provider while keeping the same history.

This allows you to converse with different models while maintaining the same history.

In addition to these parameters, each Chat has a history.

The history contains all conversations and interactions made with the models, storing the responses returned by the APIs.

A Chat also has a context, which is nothing more than all the messages sent.

Each time a new message is sent in a chat, Powershai adds this message to the context.

Upon receiving a response from the model, this response is added to the context.

In the next message sent, all this message history from the context is sent, allowing the model, regardless of the provider, to have the memory of the conversation.

The fact that the context is maintained here in your Powershell session allows functionalities like saving your history to disk, implementing a dedicated provider to store your history in the cloud, keeping it only on your PC, etc. Future functionalities may benefit from this.

All *-PowershaiChat commands revolve around the active chat or the chat you explicitly specify in the parameter (usually with the name -ChatId).

The Active Chat is the chat in which messages will be sent if the ChatId is not specified (or if the command does not allow specifying an explicit chat).

There is a special chat called "default" that is created whenever you use Send-PowershaiChat without specifying a chat and if no active chat is defined.

If you close your Powershell session, all this chat history is lost.

You can save to disk using the command Export-PowershaiSettings. The content is saved encrypted with a password that you specify.

When sending messages, PowershaAI maintains an internal mechanism that cleans the chat context to avoid sending more than necessary. The size of the local context (here in your Powershai session, and not from the LLM) is controlled by a parameter (use Get-PowershaiChatParameter to see the list of parameters).

Note that, due to the way Powershai works, depending on the amount of information sent and returned, along with parameter configurations, you may have your Powershell consuming a lot of memory. You can manually clear the context and history of your chat using Reset-PowershaiCurrentChat.

See more details in the topic about_Powershai_Chats.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ChatId
Chat ID.
If not specified, it will generate a default one. 
Some default IDs are reserved for internal use. 
Using them may cause instabilities in PowershAI. 
The following values are reserved:
 default 
 _pwshai_*

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

### -IfNotExists
Creates only if a chat with the same name does not exist.

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

### -Recreate
Force recreate the chat if it is already created!

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

### -Tools
Creates the chat and includes these tools!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: @()
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
