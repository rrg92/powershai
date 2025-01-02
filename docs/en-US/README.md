# PowershAI

# SUMMARY <!--! @#Short --> 

PowershAI (Powershell + AI) is a module that adds AI access through Powershell

# DETAILS  <!--! @#Long --> 

PowershAI (PowerShell + AI) is a module that integrates Artificial Intelligence services directly into PowerShell.  
You can invoke the commands in both scripts and the command line.  

There are several commands that allow conversations with LLMs, invoke Hugging Face spaces, Gradio, etc.  
You can chat with GPT-4-mini, Gemini Flash, Llama 3.3, etc., using your own tokens from these services.  
That is, you don't pay anything to use PowershAI, besides the costs you would normally have when using these paid services or running them locally.

This module is ideal for integrating PowerShell commands with your favorite LLMs, testing calls, POCs, etc.  
It's ideal for those who are already familiar with PowerShell and want to bring AI to their scripts in a simpler and easier way!

> [!IMPORTANT]
> This is not an official OpenAI, Google, Microsoft, or any other provider listed here module!
> This project is a personal initiative and aims to be maintained by the open-source community itself.

The following examples show how you can use PowershAI.

## Getting Started 

The [examples documentation](examples/) contains several practical examples of how to use it.  
Start with [example 0001], and go one by one, to gradually learn how to use PowershAI from basic to advanced.

Here are some quick and simple examples to help you understand what PowershAI is capable of:

```powershell 
import-module powershai 

# Interpreting Windows Logs using OpenAI's GPT
Set-AiProvider openai 
Set-AiCredential 
Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Is there any important event?"

# Describing Windows services using Google Gemini
Set-AiProvider google
Set-AiCredential
Get-Service | ia "Summarize which services are not native to Windows and may pose a risk"

# Explaining Github commits using Sabia, a Brazilian LLM from Maritaca AI 
Set-AiProvider maritalk
Set-AiCredential # configures a token for Maritaca.AI (Brazilian LLM)
git log --oneline | ia "Summarize these commits"
```


### Installation

All functionality is in the `powershai` directory, which is a PowerShell module.  
The simplest installation option is with the `Install-Module` command:

```powershell
Install-Module powershai -Scope CurrentUser
```

After installing, just import it into your session:

```powershell
import-module powershai

# See the available commands
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

### Next Steps 

After installing PowershAI, you can start using it.  
To get started, you must choose a provider and configure the authentications for it.  
A provider is what connects powershai to some model API. There are several implemented.  
See [example 0001] to understand how to use providers.  
See the [provider documentation](providers/) to learn more about the architecture and operation.

Here's a simple script to list providers:
```powershell 
import-module powershai

# List of providers 
Get-AiProviders

# You should consult the documentation for each provider for details on how to use it!
# The documentation can be accessed using get-help 
Get-Help about_ProviderName

# Example:
Get-Help about_huggingface
```

### Getting Help  

Despite the effort to document PowershAI as much as possible, we will most likely not be able to create all the necessary documentation in time to clarify doubts, or even talk about all the available commands. Therefore, it is important that you know how to do some of this yourself.

You can list all available commands when using the `Get-Command -mo powershai` command.  
This command will return all cmdlets, aliases, and functions exported by the powershai module.  
It's the easiest starting point to discover which commands. Many commands are self-explanatory, just by looking at the name.  

And, for each command, you can get more details using `Get-Help -Full CommandName`. 
If the command still doesn't have complete documentation, or if any doubt you need is missing, you can open a git issue requesting more additions.  

Finally, you can explore the PowershAI source code, looking for comments left throughout the code, which can explain some functionality or architecture, in a more technical way.  

We will be updating the documentation as new versions are released.
We encourage you to contribute to PowershAI by submitting Pull Requests or issues with documentation improvements if you find something that can be better explained, or that has not yet been explained.


## Basic PowershAI Architecture 

This section provides a general overview of PowershAI.  
I recommend reading it after you have followed at least [example 0001], so that you become more familiar with its use.


## Command Structure  

PowershAI exports several commands that can be used.  
Most of these commands have "Ai" or "Powershai". 
We call these commands the "global commands" of Powershai, as they are not commands for a specific provider.

For example: `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Providers also export commands, which will usually have a provider name. Consult the provider's documentation to learn more about the exported command pattern.  

By convention, no provider should implement commands with "Ai" or "Powershai" in the name, as they are reserved for global commands, regardless of provider.  
However, the names Ai + ProviderName can still be used by them (e.g., AiHuggingFace*, AiOpenai*, AiAzure*, AiGoogle*) and are reserved only for the provider.
Also, aliases defined by providers must always contain more than 5 characters. Smaller aliases are reserved for global commands.

You can find the documentation for these commands in the [global commands documentation](cmdlets/).  
You can use the Get-PowershaiGlobalCommands command to get the list!

### Providers  

Providers are scripts that connect powershai to various AI providers around the world.  
The [provider documentation](providers) is the official place to get help on how each provider works.  
This documentation can also be accessed through the PowerShell `Get-Help` command.  

Provider documentation is always provided via help `about_Powershai_ProviderName_Topic`.  
The `about_Powershai_ProviderName` topic is the starting point and should always contain the initial information for first uses, as well as explanations for the correct use of other topics.


### Chats  

Chats are the main starting point and allow you to chat with the various LLMs provided by the providers.  
See the [chats](CHATS.about.md) document for more details. Here's a quick introduction to chats.

#### Chatting with the model

Once the initial provider configuration is done, you can start the conversation!  
The easiest way to start a conversation is using the `Send-PowershaiChat` command or the `ia` alias:

```powershell
ia "Hello, do you know PowerShell?"
```

This command will send the message to the configured provider's model and the response will be displayed immediately.  
Note that the response time depends on the model's capacity and the network.  

You can use the pipeline to directly pass the results of other commands as context for the AI:

```powershell
1..100 | Get-Random -count 10 | ia "Tell me some trivia about these numbers"
```  
The above command will generate a sequence from 1 to 100 and pass each number into the PowerShell pipeline.  
Then, the Get-Random command will filter only 10 of these numbers, randomly.  
And finally, this sequence will be passed (all at once) to the AI and will be sent with the message you put in the parameter.  

You can use the `-ForEach` parameter so that the AI processes each input at a time, for example:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Tell me some trivia about these numbers"
```  

The difference in this command above is that the AI will be called 10 times, one for each number.  
In the previous example, it will only be called once, with all 10 numbers.  
The advantage of using this method is to reduce the context, but it may take longer, as more requests will be made.  
Test according to your needs!

#### Object Mode  

By default, the `ia` command returns nothing. But you can change this behavior using the `-Object` parameter.  
When this parameter is enabled, it asks the LLM to generate the result in JSON and writes the return back to the pipeline.  
This means you can do something like this:

```powershell
ia -Obj "5 random numbers, with their value written in full"

#or using the alias, io/powershellgallery/dt/powershai

io "5 random numbers, with their value written in full"
```  

**IMPORTANT: Note that not every provider can support this mode, as the model needs to be able to support JSON! If you receive errors, confirm if the same command works with an OpenAI model. You can also open an issue**


### Saving Settings  

PowershAI allows you to adjust a number of settings, such as chat parameters, authentication tokens, etc.  
Whenever you change a setting, this setting is saved only in the memory of your PowerShell session.  
If you close and open it again, all the settings made will be lost.  

So that you don't have to keep generating tokens every time, for example, Powershai provides 2 commands to export and import settings.  
The `Export-PowershaiSettings` command exports the settings to a file in the profile directory of the logged-in user.  
Due to the fact that the exported data may be sensitive, you need to provide a password, which will be used to generate an encryption key.  
The exported data is encrypted using AES-256.  
You can import using `Import-PowershaiSettings`. You will have to provide the password you used to export.

Note that this password is not stored anywhere, so you are responsible for memorizing it or storing it in a vault of your choice.

### Costs  

It is important to remember that some providers may charge for the services used.  
PowershAI does not do any cost management.  It can inject data into prompts, parameters, etc.  
You should track using the tools the provider's website provides for this purpose.  

Future versions may include commands or parameters to help better control, but for now, the user must monitor.



### Export and Import of Settings and Tokens

To facilitate the reuse of data (tokens, default models, chat history, etc.), PowershAI allows you to export the session.  
To do this, use the `Export-PowershaiSettings` command. You will need to provide a password, which will be used to create a key and encrypt this file.  
Only with this password can you import it again. To import, use the `Import-PowershaiSettings` command.  
By default, Chats are not exported. To export them, you can add the -Chats parameter: `Export-PowershaiSettings -Chats`.  
Note that this can make the file larger, as well as increase the export/import time. The advantage is that you can continue the conversation between different sessions.  
This functionality was originally created with the intention of avoiding having to generate API Keys every time you needed to use PowershAI. With it, you generate your API keys once in each provider, and export as you update. Since it is password-protected, you can safely save it in a file on your computer.  
Use the command help to get more information on how to use it.

# NOTES 

## Other Projects with PowerShell

Here are some other interesting projects that integrate PowerShell with AI:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

# EXAMPLES <!--! @#Ex -->

## Basic Usage 

Using PowershAI is very simple. The example below shows how you can use it with OpenAI:

```powershell 
# Change the current provider to OpenAI
Set-AiProvider openai 

# Configure the authentication token (You must generate the token on the platform.openai.com website)
Set-OpenaiToken 

# Use one of the commands to start a chat! ia is an alias for Send-PowershaiChat, which sends a message in the default chat!
ia "Hello, I'm talking to you from Powershaui!"
```

## Exporting Settings 


```powershell 
# define some token, for example 
Set-OpenaiToken 

# After the above command runs, just export!
Export-PowershaiSettings

# You will have to provide the password!
```

## Importing Settings 


```powershell 
import-module powershai 

# Import the settings 
Import-PowershaiSettings # The command will ask for the password used in the export
```

# Important Information <!--! @#Note -->

PowershAI has a range of available commands.  
Each provider provides a series of commands with a naming pattern.  
You should always read the provider's documentation for more details on how to use it.  

# Troubleshooting <!--! @#Troub -->

Although it has a lot of code and already has a lot of functionality, PowershAI is a new project that is under development.  
Some bugs may be found and, at this stage, it is important that you always help by reporting, through issues, in the official repository at https://github.com/rrg92/powershai  

If you want to troubleshoot a problem, I recommend following these steps:

- Use Debug to help you. Commands like Set-PSBreakpoint are simple to invoke on the command line and can save you time
- Some functions do not display the complete error. You can use the $error variable, and access the last one. For example:  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # This helps find the exact line where the exception occurred!
```

# See also <!--! @#Also -->

- Video on How to use the Hugging Face Provider: https://www.youtube.com/watch?v=DOWb8MTS5iU
- See each provider's documentation for more details on how to use its cmdlets

# Tags <!--! @#Kw -->

- Artificial Intelligence
- AI


[example 0001]: examples/0001.md



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
