![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

PowershAI (PowerShell + AI) is a module that integrates Artificial Intelligence services directly into PowerShell. You can invoke commands both in scripts and in the command line. This module is ideal for testing calls or integrating simple tasks with AI services. It is perfect for those who are already familiar with PowerShell and want to bring AI into their scripts in a simpler and easier way!

The idea is for PowershAI to be integrated with the main existing AI and LLM APIs, allowing an easy way to access their API from your terminal! To facilitate this, we created the concept of an _AI provider_ within PowershAI, which represents each manufacturer or service that exposes some AI through an API. The list of supported and/or being-implemented providers can be checked in issue #3.

[This post contains an old video demonstrating the use of PowershAI. You can check it out to get an idea of the general functionality.](https://iatalk.ing/powershai-powershell-inteligencia-artificial/)

**IMPORTANT: Since the post above was published, many things have changed. Use it only for quick ideas on how to use it in practice. But I recommend reading this documentation if you are not yet familiar!**

## Installation

All functionality is in the `powershai` directory, which is a PowerShell module. The simplest installation option is with the command:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

After installing, just import it into your session:

```powershell
import-module powershai
# See available commands
Get-Command -mo powershai
```

You can also clone this project directly and import the powershai directory:

```powershell
cd PATH
# Clone
git clone ...
# Import from the specific path!
Import-Module .\powershai
```

Now, the commands are imported into your session. You can get help (which we will be improving over the next versions) using PowerShell itself:

```powershell
# List all available commands and functions:
get-command -mo powershai

# List aliases (shortcuts for commands)
get-alias | ? {$_.source -eq 'powershai'}

# Get help for a specific command
get-command -full CommandName
```

## Usage

PowershAI can interact with various AI services. By default, it uses the OpenAI API (the creator of ChatGPT). Depending on the provider you want to use, you will need to perform some configurations before invoking the chat. The [documentation for providers](docs/en-US/providers) contains the details you need to know for each one!

### Quick Guide to Main Providers

Quick guide:

**OpenAI**
The only thing needed is an API Token. You set the API Token with the command `Set-OpenaiToken`. Follow the instructions.

**Ollama**
To use Ollama, you need to change the provider using the command `Set-AiProvider ollama`. By default, it uses the URL http://localhost:11434, but you can change it by passing the second argument `Set-OllamaUrl http://myollamaserver`. You then need to configure a model to be used. Use the command `Get-AiModels` to list the available models. Use `Set-AiDefaultModel NAME` to set the model to be used, using the `name` field resulting from the previous command's listing.

**Groq**
Groq is a service that provides access to various open-source LLMs using a new technology called LPU. The response is really fast. To use Groq in PowershAI is very simple: define the provider with `Set-AiProvider groq`. Add the API key using `Set-OpenaiToken` (yes, you can use the same function since Groq's API is compatible with OpenAI). List the models using `Get-AiModels` and set a default with `Set-AiDefaultModel`.

**Maritalk**
Maritalk is an LLM developed by Brazilians! To use it: `Set-AiProvider maritalk` and then set the token with `Set-MaritalkToken`. You must generate the token on the Maritalk platform. Maritalk only supports some simple functions, so you can use it with the commands `ia` (see below) and/or `Get-AiChat`.

### Conversing with AI

Once the initial provider configuration is done, you can start the conversation! The easiest way to start a conversation is using the command `Send-PowershaiChat` or the alias `ia`:

```powershell
ia "Hello, do you know PowerShell?"
```

This command will send the message to the model of the configured provider, and the response will be displayed afterward. Note that the response time depends on the model's capacity and the network.

You can use the pipeline to pass the result of other commands directly as context to the AI:

```powershell
1..100 | Get-Random -count 10 | ia "Tell me curiosities about these numbers"
```

The command above will generate a sequence from 1 to 100 and filter only 10 of those numbers randomly. Then, this sequence will be passed (all at once) to the AI along with the message you placed in the parameter.

You can use the `-ForEach` parameter to have the AI process each input one at a time, for example:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Tell me curiosities about these numbers"
```

The difference with the command above is that the AI will be called 10 times, once for each number. In the previous example, it will be called only once, with all 10 numbers. The advantage of using this method is to reduce context, but it may take longer since more requests will be made. Test according to your needs!

### Object Mode

By default, the `ia` command returns nothing. But you can change this behavior using the `-Object` parameter. When this parameter is activated, it asks the LLM to generate the result in JSON and writes the return back to the pipeline. This means you can do something like:

```powershell
ia -Obj "5 random numbers, with their value written in full"

# or using the alias io
io "5 random numbers, with their value written in full"
```

**IMPORTANT: Note that not every provider may support this mode, as the model needs to be capable of handling JSON! If you receive errors, confirm if the same command works with an OpenAI model. You may also open an issue.**

### Interactive Mode

The early versions of PowershAI featured the command `Chatest`. It was the first implementation I created for interactive chat, aiming to combine all the functionalities of PowershAI into a single command, simulating a more complete chat client directly in your PowerShell. You can still use Chatest, but it is deprecated and I will soon remove it. I recommend using `ia`, which contains many more functionalities and leverages PowerShell's prompt itself. If you still prefer an interactive mode similar to Chatest, you can use the command `Enter-PowershaiChat`.

### Chats

When using the `ia` command, it uses a default chat. The entire context of the conversation is maintained, including previous messages. To start a new chat with a new context, use the command `New-PowershaiChat ChatId`. This command creates a chat identified by `ChatId`, which can be any unique string you want. If you do not specify a NAME, it will create one automatically using a timestamp.

Chats are like those chats in the ChatGPT interface. Each chat has its own message history, settings, and context. You can set the current chat using the command `Set-PowershaiActiveChat ChatId`. Most commands, like `ia`, operate in the active chat. You can clear the history and context of the current chat using the command `Reset-PowershaiCurrentChat`.

### Export and Import of Settings and Tokens

To facilitate the reuse of data (tokens, default models, chat history, etc.), PowershAI allows you to export the session. For this, use the command `Export-PowershaiSettings`. You will need to provide a password, which will be used to create a key and encrypt this file. Only with this password can you import it again. To import, use the command `Import-PowershaiSettings`. By default, chats are not exported. To export them, you can add the `-Chats` parameter: `Export-PowershaiSettings -Chats`. Note that this may make the file larger and increase the export/import time. The advantage is that you can continue the conversation between different sessions. This functionality was originally created to avoid having to generate API keys every time you needed to use PowershAI. With it, you generate your API keys once for each provider and export them as you update. Since it's password protected, you can safely save it in a file on your computer. Use the help command to get more information on how to use it.

### Function Calling

One of the great functionalities implemented is support for Function Calling (or Tool Calling). This feature, available in several LLMs, allows the AI to decide to invoke functions to assist in the response. Basically, you describe one or more functions and their parameters, and the model can decide to invoke them.

**IMPORTANT: You will only be able to use this feature in providers that expose function calling using the same specification as OpenAI.** For more details, see OpenAI's official documentation on Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling). The model is responsible for invoking the function, but the execution of this invocation is done by the client, in our case, PowersAI. To make this process easy and dynamic, PowershAI allows you to write your own functions, enabling the LLM to decide to invoke them. You are responsible for describing and controlling the code that the model will run. The result of your function must be sent back to the model for it to continue generating the response.

To demonstrate, create a file called `MyFunctions.ps1` with the following content:

```powershell
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

**Note the use of comments to describe functions and parameters.** This is a syntax supported by PowerShell known as [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4). Now, load these functions into your active chat:

```powershell
iaf C:\temp\MyFunctions.ps1
# TIP: iaf is an alias for the command Update-PowershaiChatFunctions
```

Try asking the model what the current date is or ask it to generate a random number! You will see that it will execute your functions! This opens up infinite possibilities, and your creativity is the limit!

```powershell
ia "Generate a random number and then tell me what the current date is!"
```

### **VERY IMPORTANT ABOUT FUNCTION CALLING**

The Function Calling feature is powerful because it allows code execution, but it is also dangerous, VERY DANGEROUS. Therefore, exercise extreme caution with what you implement and execute. Here are some security tips:

- Avoid running the script with an Administrator user.
- Avoid implementing code that deletes or modifies important data.
- Test the functions beforehand.
- Do not include modules or scripts from third parties that you do not know or trust.

## Explore and Contribute

There is still much to document and evolve in PowershAI! As I make improvements, I leave comments in the code to help those who want to learn how I did it! Feel free to explore and contribute suggestions for improvements.

## Other Projects with PowerShell

Here are some other interesting projects that integrate PowerShell with AI:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Explore, learn, and contribute!

---

If you need further modifications or additional details, feel free to ask!