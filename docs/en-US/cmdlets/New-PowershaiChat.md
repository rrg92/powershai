---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Creates a new Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
PowershaAI brings a concept of "chats", similar to the chats you see in OpenAI, or the "threads" of the Assistants API.  
Each created chat has its own set of parameters, context and history.  
When you use the cmdlet Send-PowershaiChat (alias ia), it's sending messages to the model, and the history of that conversation with the model stays in the chat created here by PowershAI.  
That is, all the history of your conversation with the model is kept here in your PowershAI session, and not there in the model or API.  
With that, PowershAI keeps all control of what to send to the LLM and does not depend on mechanisms from different APIs of different providers to manage the history.


Each Chat has a set of parameters that, when changed, affect only that chat.  
Certain PowershAI parameters are global, such as the provider used. When changing the provider, the Chat starts using the new provider, but keeps the same history.  
This allows you to chat with different models, while keeping the same history.  

In addition to these parameters, each Chat has a history.  
The history contains all the conversations and interactions made with the models, keeping the responses returned by the APIs.

A Chat also has a context, which is nothing more than all the messages sent.  
Every time a new message is sent in a chat, Powershai adds this message to the context.  
Upon receiving the model's response, this response is added to the context.  
In the next message sent, all this message context history is sent, causing the model, regardless of the provider, to have the memory of the conversation.  

The fact that the context is kept here in your Powershell session allows functionalities such as saving your history to disk, implementing a dedicated provider to store your history in the cloud, keeping it only on your PC, etc. Future functionalities can benefit from this.

All *-PowershaiChat commands revolve around the active chat or the chat you explicitly specify in the parameter (usually named -ChatId).  
The Active Chat is the chat where messages will be sent if you don't specify ChatId  (or if the command does not allow you to specify an explicit chat).  

There is a special chat called "default" which is the chat created whenever you use Send-PowershaiChat without specifying a chat and if there is no active chat defined.  

If you close your Powershell session, all this Chat history is lost.  
You can save to disk using the Export-PowershaiSettings command. The content is saved encrypted with a password you specify.

When sending messages, PowershAI maintains an internal mechanism that cleans up the chat context to avoid sending more than necessary.
The size of the local context (here in your Powershai session, and not the LLM), is controlled by a parameter (use Get-PowershaiChatParameter to see the list of parameters)

Note that, due to the way Powershai works, depending on the amount of information sent and returned, plus the parameter settings, you can make your Powershell consume a lot of memory. You can manually clear the context and history of your chat using Reset-PowershaiCurrentChat

See more details in the about_Powershai_Chats topic,

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Chat Id. If not specified, it will generate a default
Some Id patterns are reserved for internal use. If you use them you may cause instability in PowershAI.
The following values are reserved:
 default 
 _pwshai_*

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

### -IfNotExists
Creates only if a chat with the same name does not exist

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

### -Recreate
Force recreate the chat if it already exists!

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

### -Tools
Creates the chat and includes these tools!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
