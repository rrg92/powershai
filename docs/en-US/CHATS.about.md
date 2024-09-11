# Chats 

# Introduction <!--! @#Short --> 

PowershAi defines the concept of Chats, which help create a history and context for conversations!  

# Details  <!--! @#Long --> 

PowershAi creates the concept of Chats, which are very similar to the concept of Chats in most LLM services.  

Chats allow for interaction with LLM services in a standardized manner, regardless of the current provider.  
They provide a standard way for these functionalities:

- Chat history 
- Context 
- Pipeline (using the result of other commands)
- Tool calling (executing commands at the request of the LLM)

Not all providers implement support for Chats.  
To check if a provider has chat support, use the cmdlet Get-AiProviders, and check the "Chat" property. If it is $true, then chat is supported.  
And, once chat is supported, not all features may be supported due to provider limitations.  

## Starting a New Chat 

The simplest way to start a new chat is by using the command Send-PowershaiChat.  
Of course, you should use it after configuring the provider (using `Set-AiProvider`) and the initial settings, such as authentication, if necessary.  

```powershell 
Send-PowershaiChat "Hello, I am talking to you from Powershai"
```

For simplicity, the command `Send-PowershaiChat` has an alias called `ia` (abbreviation in Portuguese, Inteligência Artificial).  
With it, you significantly reduce and focus more on the prompt:

```powershell 
ia "Hello, I am talking to you from Powershai"
```

Every message is sent in a chat. If you do not explicitly create a chat, the special chat called `default` is used.  
You can create a new chat using `New-PowershaiChat`.  

Each chat has its own conversation history and settings. It can contain its own functions, etc.  
Creating additional chats can be useful if you need to keep more than one topic without mixing them up!


## Chat Commands  

The commands that manipulate chats in some way are in the format `*-Powershai*Chat*`.  
Typically, these commands accept a -ChatId parameter, which allows you to specify the name or object of the chat created with `New-PowershaiChat`.  
If not specified, they use the active chat.  

## Active Chat  

The active chat is the default chat used by PowershaiChat commands.  
When there is only 1 chat created, it is considered the active chat.  
If you have more than 1 active chat, you can use the command `Set-PowershaiActiveChat` to define which one it is. You can pass the name or the object returned by `New-PowershaiChat`.


## Chat Parameters  

Every chat has some parameters that control various aspects.  
For example, the maximum tokens to be returned by the LLM.  

New parameters may be added with each version of PowershAI.  
The easiest way to obtain the parameters and what they do is by using the command `Get-PowershaiChatParameter`;  
This command will bring the list of parameters that can be configured, along with the current value and a description of how to use it.  
You can change the parameters using the command `Set-PowershaiChatParameter`.  

Some listed parameters are direct parameters of the provider's API. They will come with a description indicating this.  

## Context and History  

Every Chat has a context and history.  
The history is the entire record of messages sent and received in the conversation.  
The context size is how much of the history it will send to the LLM, so it remembers the responses.  

Note that this Context Size is a concept of PowershAI and is not the same as the "Context length" defined in LLMs.  
The Context Size only affects Powershai, and depending on the value, it may exceed the Provider's Context Length, which can cause errors.  
It is important to keep the Context Size balanced between keeping the LLM updated with what has already been said and not exceeding the maximum tokens of the LLM.  

You control the context size using the chat parameter, that is, by using `Set-PowershaiChatParameter`.

Note that the history and context are stored in the session memory, that is, if you close your Powershell session, they will be lost.  
In the future, we may have mechanisms that allow the user to automatically save and retrieve between sessions.  

Also, it is important to remember that once the history is saved in Powershell's memory, very long conversations may cause overflow or high memory consumption in Powershell.  
You can reset the chats at any time using the command `Reset-PowershaiCurrentChat`, which will erase the entire history of the active chat.  
Use with caution, as this will cause the entire history to be lost and the LLM will not remember the peculiarities informed throughout the conversation.  


## Pipeline  

One of the most powerful features of Powershai Chats is the integration with the Powershell pipeline.  
Basically, you can throw the result of any Powershell command, and it will be used as context.  

PowershAI does this by converting the objects to text and sending it in the prompt.  
Then, the chat message is added afterwards.  

For example:

```
Get-Service | ia "Summarize which services are uncommon in Windows"
```

In the default settings of Powershai, the command `ia` (alias for `Send-PowershaiChat`), will get all the objects returned by `Get-Service` and format them as a single giant string.  
Then, this string will be injected into the LLM prompt, and it will be instructed to use this result as "context" for the user's prompt.  

The user's prompt is concatenated right after.  

With this, a powerful effect is created: You can easily integrate the outputs of commands with your prompts, using simple pipes, which is a common operation in Powershell.  
The LLM tends to consider it well.  

Despite having a default value, you have complete control over how these objects are sent.  
The first way to control is how the object is converted to text. Since the prompt is a string, it is necessary to convert this object to text.  
By default, it converts it into a standard Powershell representation, according to the type (using the command `Out-String`).  
You can change this using the command `Set-PowershaiChatContextFormatter`. You can set, for example, JSON, table, and even a custom script to have total control.  

The other way to control how the context is sent is by using the chat parameter `ContextFormat`.  
This parameter controls the entire message that will be injected into the prompt. It is a script block.  
You should return an array of strings, which corresponds to the prompt sent.  
This script has access to parameters such as the formatted object being passed in the pipeline, the values of the parameters of the Send-PowershaiChat command, etc.  
The default value of the script is hard-coded, and you should check directly in the code to know how it sends (and for an example of how to implement your own).  


### Tools

One of the great features implemented is the support for Function Calling (or Tool Calling).  
This feature, available in several LLMs, allows the AI to decide to invoke functions to bring additional data in the response.  
Basically, you describe one or more functions and their parameters, and the model can decide to invoke them.  **IMPORTANT: You will only be able to use this feature in providers that expose function calling using the same specification as OpenAI**

For more details, see the official OpenAI documentation on Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling).

The model only decides which functions to invoke, when to invoke them, and their parameters. The execution of this invocation is done by the client, in our case, PowershAI.  
The models expect the definition of functions describing what they do, their parameters, returns, etc. Originally, this is done using something like OpenAPI Spec to describe the functions.  
However, PowerShell has a powerful Help system using comments, which allows describing functions and their parameters, as well as data types.  

PowershAI integrates with this help system, translating it into an OpenAPI specification. The user can write their functions normally, using comments to document them, and this is sent to the model.  

To demonstrate this feature, let's go through a simple tutorial: create a file named `MyFunctions.ps1` with the following content

```powershell
# File MyFunctions.ps1, save it in any directory of your choice!

<#
    .DESCRIPTION
    Lists the current time
#>
function CurrentTime {
    return Get-Date
}

<#
    .DESCRIPTION
    Gets a random number!
#>
function RandomNumber {
    param(
        # Minimum number
        $Min = $null,
        
        # Maximum number
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**Note the use of comments to describe functions and parameters**.  
This is a syntax supported by PowerShell, known as [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Now, let's add this file to PowershAI:

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #configure the token if you haven't configured it yet.


# Add the script as tools!
# Assuming the script was saved in C:\temp\MyFunctions.ps1
Add-AiTool C:\temp\MyFunctions.ps1

# Confirm that the tools were added 
Get-AiTool
```

Try asking the model what the current date is or ask it to generate a random number! You will see that it will execute your functions! This opens up infinite possibilities, and your creativity is the limit!

```powershell
ia "What time is it?"
```

In the command above, the model will invoke the function. On the screen, you will see the function being called!  
You can add any PowerShell command or script as a tool.  
Use the command `Get-Help -Full Add-AiTool` for more details on how to use this powerful functionality.

PowershAI automatically takes care of executing the commands and sending the response back to the model.  
If the model decides to execute several functions in parallel, or insists on executing new functions, PowershAI will manage this automatically.  
Note that, to avoid an infinite loop of executions, PowershAI enforces a limit on the maximum number of executions.  
The parameter that controls these interactions with the model is `MaxInteractions`.  

#### IMPORTANT CONSIDERATIONS ABOUT THE USE OF TOOLS

The Function Calling feature is powerful because it allows code execution, but it is also dangerous, VERY DANGEROUS.  
Therefore, exercise extreme caution with what you implement and execute.  
Remember that PowershAI will execute as the model requests. 

Some security tips:

- Avoid running the script with an Administrator user.
- Avoid implementing code that deletes or modifies important data.
- Test the functions first.
- Do not include third-party modules or scripts that you do not know or trust.  


_Automatically translated using PowershAI and AI._
