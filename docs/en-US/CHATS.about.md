# Chats


# Introduction <!--! @#Short --> 

PowershAI defines the concept of Chats, which helps to create history and context for conversations!  

# Details  <!--! @#Long --> 

PowershAI creates the concept of Chats, which are very similar to the concept of Chats in most LLM services.  

Chats allow you to talk to LLM services in a standard way, regardless of the current provider.  
They provide a standard way for these features:

- Chat history 
- Context 
- Pipeline (use the result of other commands)
- Tool calling (execute commands on request of the LLM)

Not all providers implement support for Chats.  
To find out if a provider supports chat, use the `Get-AiProviders` cmdlet, and check the "Chat" property. If it is `$true`, then chat is supported.  
And, once chat is supported, not all features may be supported, due to provider limitations.  

## Starting a new chat 

The easiest way to start a new chat is to use the `Send-PowershaiChat` command.  
Obviously, you must use it after configuring the provider (using `Set-AiProvider`) and the initial settings, such as authentication, if necessary.  

```powershell 
Send-PowershaiChat "Hello, I'm talking to you from Powershai"
```

For simplicity, the command `Send-PowershaiChat` has an alias called `ia` (short for English, Artificial Intelligence).  
With it, you can reduce a lot and focus more on the prompt:

```powershell 
ia "Hello, I'm talking to you from Powershai"
```

Every message is sent in a chat.  If you don't explicitly create a chat, the special chat called `default` is used.  
You can create a new chat using `New-PowershaiChat`.  

Each chat has its own conversation history and settings. It can contain its own functions, etc.
Creating additional chats can be useful if you need to keep more than one topic without them mixing!


## Chat Commands  

Commands that manipulate chats in some way are in the format `*-Powershai*Chat*`.  
Usually, these commands accept a -ChatId parameter, which allows you to specify the name or object of the chat created with `New-PowershaiChat`.  
If not specified, they use the active chat.  

## Active Chat  

The active Chat is the default chat used by PowershaiChat commands.  
When there is only 1 chat created, it is considered the active chat.  
If you have more than 1 active chat, you can use the `Set-PowershaiActiveChat` command to define which one it is. You can pass the name or object returned by `New-PowershaiChat`.


## Chat Parameters  

Every chat has some parameters that control various aspects.  
For example, the maximum number of tokens to be returned by the LLM.  

New parameters can be added with each version of PowershAI.  
The easiest way to get the parameters and what they do is to use the `Get-PowershaiChatParameter` command;  
This command will bring the list of parameters that can be configured, along with the current value and a description of how to use it.  
You can change the parameters using the `Set-PowershaiChatParameter` command.  

Some listed parameters are the direct parameters of the provider's API. They will come with a description indicating this.  

## Context and History  

Every Chat has a context and history.  
The history is all the history of messages sent and received in the conversation.
The context size is how much of the history it will send to the LLM, so it remembers the responses.  

Note that this Context Size is a PowershAI concept, and is not the same "Context length" defined in LLMs.  
The Context Size only affects Powershai, and, depending on the value, it may exceed the Context Length of the provider, which can generate errors.  
It is important to keep the Context Size balanced between keeping the LLM updated with what has already been said and not exceeding the LLM's maximum number of tokens.  

You control the context size through the chat parameter, that is, using `Set-PowershaiChatParameter`.

Note that history and context are stored in the memory of the session, that is, if you close your Powershell session, they will be lost.  
In the future, we may have mechanisms that allow the user to automatically save and retrieve between sessions.  

Also, it is important to remember that, since history is saved in Powershell's memory, very long conversations can cause overflow or high Powershell memory consumption.  
You can reset the chats at any time using the `Reset-PowershaiCurrentChat` command, which will erase all the history of the active chat.  
Use with caution, as this will cause all the history to be lost and the LLM will not remember the peculiarities informed throughout the conversation.  


## Pipeline  

One of the most powerful features of Powershai Chats is the integration with the Powershell pipeline.  
Basically, you can throw the result of any Powershell command and it will be used as context.  

PowershAI does this by converting the objects to text and sending them in the prompt.  
Then, the chat message is added next.  

For example:

```
Get-Service | ia "Make a summary about which services are not common in Windows"
```

In Powershai's default settings, the `ia` command (alias for `Send-PowershaiChat`) will get all the objects returned by `Get-Service` and format them as a single giant string.  
Then, this string will be injected into the LLM prompt, and it will be instructed to use this result as "context" for the user prompt.  

The user's prompt is concatenated right after.  

This creates a powerful effect: You can easily integrate the outputs of commands with your prompts, using a simple pipe, which is a common operation in Powershell.  
The LLM tends to consider well.  

Despite having a default value, you have total control over how this object is sent.  
The first way to control is how the object is converted to text.  As the prompt is a string, it is necessary to convert this object to text.  
By default, it converts to a standard Powershell representation, according to the type (using the `Out-String` command).  
You can change this using the `Set-PowershaiChatContextFormatter` command. You can define, for example, JSON, table, and even a custom script to have total control.  

The other way to control how the context is sent is to use the chat parameter `ContextFormat`.  
This parameter controls the entire message that will be injected into the prompt. It is a scriptblock.  
You must return an array of string, which is equivalent to the prompt sent.  
This script has access to parameters like the formatted object that is being passed in the pipeline, the values of the parameters of the Send-PowershaiChat command, etc.  
The default value of the script is hard-coded, and you should check it directly in the code to see how it sends (and for an example of how to implement your own).  


###  Tools

One of the great features implemented is support for Function Calling (or Tool Calling).  
This feature, available in several LLMs, allows the AI to decide to invoke functions to bring additional data in the response.  
Basically, you describe one or more functions and their parameters, and the model can decide to invoke them.  

**IMPORTANT: You will only be able to use this feature in providers that expose function calling using the same OpenAI specification**

For more details, see the official OpenAI documentation on Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling).

The model only decides which functions to invoke, when to invoke them, and their parameters. The execution of this invocation is done by the client, in our case, PowershAI.  
Models expect function definitions describing what they do, their parameters, returns, etc.  Originally this is done using something like OpenAPI Spec to describe functions.  
However, Powershell has a powerful Help system using comments, which allows you to describe functions and their parameters, in addition to the data types.  

PowershAI integrates with this Help system, translating it to an OpenAPI specification. The user can write their functions normally, using comments to document them and this is sent to the model.  

To demonstrate this feature, let's go through a simple tutorial: create a file called `MinhasFuncoes.ps1` with the following content

```powershell
# MinhasFuncoes.ps1 file, save in a directory of your choice!

<#
    .DESCRIPTION
    Lists the current time
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    Gets a random number!
#>
function NumeroAleatorio {
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
Set-OpenaiToken #configure the token if you haven't already.


# Add the script as tools!
# Assuming the script was saved in C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Confirm that s tools have been added 
Get-AiTool
```

Try asking the model what the current date is or ask it to generate a random number! You will see that it will execute your functions! This opens up endless possibilities, and your creativity is the limit!

```powershell
ia "How many hours?"
```

In the command above, the model will invoke the function. On the screen you will see the function being called!  
You can add any Powershell command or script as a tool.  
Use the `Get-Help -Full Add-AiTol` command for more details on how to use this powerful functionality.

PowershAI automatically takes care of executing the commands and sending the response back to the model.  
If the model decides to run multiple functions in parallel, or insists on running new functions, PowershAI will manage this automatically.  
Note that, to avoid an infinite loop of executions, PowershAI enforces a limit with the maximum number of executions.  
The parameter that controls these interactions with the model is `MaxInteractions`.  


### Invoke-AiChatTools and Get-AiChat 

These two cmdlets are the basis of the Powershai chat feature.  
`Get-AiChat` is the command that allows you to communicate with the LLM in the most primitive way possible, almost close to an HTTP call.  
It is, basically, a standardized wrapper for the API that allows you to generate text.  
You provide the parameters, which are standardized, and it returns a response, which is also standardized,
Regardless of the provider, the response must follow the same rule!

The `Invoke-AiChatTools` cmdlet is a bit more elaborate and a bit higher level.  
It allows you to specify Powershell functions as Tools. These functions are converted to a format that the LLM understands.  
It uses the Powershell help system to get all possible metadata to send to the model.  
It sends the data to the model using the `Get-Aichat` command. When it gets the response, it validates if there is tool calling, and if there is, it executes the equivalent functions and returns the response.  
It keeps doing this cycle until the model finishes the response or the maximum number of interactions is reached.  
An interaction is an API call to the model. When invoking Invoke-AiChatTools with functions, it may take several calls to return the responses to the model.  

The following diagram explains this flow:

```
	sequenceDiagram
		Invoke-AiChatTools->>modelo:prompt (INTERAÇÃO 1)
		modelo->>Invoke-AiChatTools:(response, 3 function call)
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 1
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 2
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 3
		Invoke-AiChatTools->>modelo:Resultado tool call + prompts anteriores prompt (INTERAÇÃO 2)
		modelo->>Invoke-AiChatTools:resposta final
```


#### How commands are transformed and invoked

The `Invoke-AiChatTools` command expects in the -Functions parameter a list of Powershell commands mapped to OpenAPI schemas.  
It expects an object that we call OpenaiTool, containing the following props: (the name OpenAiTool is due to the fact that we use the same OpenAI tool calling format)

- tools  
This property contains the function calling schema that will be sent to the LLM (in the parameters that expect this information)  

- map  
This is a method that returns the Powershell command (function, alias, cmdlet, exe, etc.) to be executed.  
This method must return an object with the property called "func", which must be the name of a function, executable command or scriptblock.  
It will receive the name of the tool in the first argument, and the OpenAiTool object itself in the second (as if it were the this).

In addition to these properties, any other is free to be added to the OpenaiTool object. This allows the script map to access any external data it needs.  

When the LLM returns the function calling request, the name of the function to be invoked is passed to the `map` method, and it must return which command to execute. 
This opens up numerous possibilities, allowing, at runtime, the command to be executed to be determined from a name.  
Thanks to this mechanism, the user has total control and flexibility over how they will respond to the LLM's tool calling.  

Then, the command will be invoked and the parameters and values sent by the model will be passed as Bounded Arguments.  
That is, the command or script must be able to receive the parameters (or identify them dynamically) from their name.


All this is done in a loop that will iterate, sequentially, on each Tool Calling returned by the LLM.  
There is no guarantee of the order in which the tools will be executed, so one should never assume order, unless the LLM sends a tool sequentially.  
This means that, in future implementations, several tool callings can be executed at the same time, in parallel (in Jobs, for example).  

Internally, PowershAI creates a default script map for commands added using `Add-AiTool`.  

For an example of how to implement functions that return this format, see in the openai.ps1 provider, commands that start with Get-OpenaiTool*

Note that this Tool Calling feature only works with models that support Tool Calling following the same OpenAI specifications (both input and output).  


#### IMPORTANT CONSIDERATIONS ABOUT USING TOOLS

The Function Calling feature is powerful because it allows you to execute code, but it is also dangerous, VERY DANGEROUS.  
Therefore, exercise extreme caution with what you implement and execute.
Remember that PowershAI will execute as the model asks. 

Some safety tips:

- Avoid running the script as an Administrator user.
- Avoid implementing code that deletes or modifies important data.
- Test the functions before.
- Do not include third-party modules or scripts that you do not know or trust.  

The current implementation executes the function in the same session, and with the same credentials, as the logged-in user.  
This means that, for example, if the model (intentionally or erroneously) asks to execute a dangerous command, your data, or even your computer, can be damaged or compromised.  

Therefore, this warning is worth it: Be extremely careful and only add tools with scripts you trust completely.  

There are plans to add future mechanisms to help increase security, such as isolating them in other runspaces, opening a separate process, with fewer privileges, and allowing the user to have options to configure this.






<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
