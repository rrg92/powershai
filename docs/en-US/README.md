# PowershAI

# SUMMARY <!--! @#Short --> 

PowershAI (Powershell + AI) is a module that adds access to AI through Powershell.

# DETAILS <!--! @#Long --> 

PowershAI is a module that adds AI features to your Powershell session.  
The goal is to simplify and encapsulate complex calls and handling for the APIs of the main existing AI services.  

PowershAI defines a set of standards that allow the user to converse with LLMs directly from the prompt or use the result of commands as context in a prompt.  
And, through a standardized set of functions, different providers can be used: For example, you can chat with GPT-4 or Gemini Flash using exactly the same code.  

In addition to this standardization, PowershAI also exposes internal and specific functions for connecting with different AI service providers.  
With this, you can customize and create scripts that utilize specific features of these APIs.  

The architecture of PowershAI defines the concept of "provider," which are files that implement all the necessary details to communicate with their respective APIs.  
New providers can be added, with new functionalities, as they become available.  

In the end, you have various options to start using AI in your scripts. 

Examples of well-known providers that are already implemented completely or partially:

- OpenAI 
- Hugging Face 
- Gemini 
- Ollama
- Maritalk (Brazilian LLM)

To start using PowershAI is quite simple: 

```powershell 
# Install the module!
Install-Module -Scope CurrentUser powershai 

# Import!
import-module powershai

# List of providers 
Get-AiProviders

# You should consult the documentation of each provider for details on how to use it!
# The documentation can be accessed using get-help 
Get-Help about_ProviderName

# Example:
Get-Help about_huggingface
```

## Getting Help  

Despite the effort to document PowershAI as much as possible, it is very likely that we will not be able to create all the necessary documentation in time to clarify doubts or even cover all available commands. Therefore, it is important that you know how to do some basics on your own. 

You can list all available commands when using the command `Get-Command -mo powershai`.  
This command will return all cmdlets, aliases, and functions exported from the powershai module.  
It is the easiest starting point to discover which commands are available. Many commands are self-explanatory just by looking at their names.  

And, for each command, you can get more details using `Get-Help -Full CommandName`.
If the command does not have complete documentation or if you have a question that is missing, you can open an issue on Git requesting more information.  

Finally, you can explore the source code of PowershAI, looking for comments left throughout the code, which may explain some functionality or architecture in a more technical way.  

We will be updating the documentation as new versions are released.
We encourage you to contribute to PowershAI by submitting Pull Requests or issues with improvements to the documentation if you find something that could be better explained or that has not yet been explained.  


## Command Structure  

PowershAI exports various commands that can be used.  
Most of these commands have "Ai" or "Powershai" in their names.  
We call these commands `global commands` of Powershai, as they are not commands for a specific provider.

For example: `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Providers also export commands, which will generally have the provider's name. Consult the provider's documentation to learn more about the exported command pattern.  

By convention, no provider should implement commands with "Ai" or "Powershai" in their names, as these are reserved for global commands regardless of the provider.  
Also, aliases defined by providers must always contain more than 5 characters. Shorter aliases are reserved for global commands.

You can find the documentation for these commands in the [global command docs](cmdlets/).  
You can also use the command Get-PowershaiGlobalCommands to obtain the list!

## Providers Documentation  

The [providers documentation](providers) is the official place to get help on how each provider works.  
This documentation can also be accessed through the `Get-Help` command in Powershell.  

Providers documentation is always made available via help `about_Powershai_ProviderName_Topic`.  
The topic `about_Powershai_ProviderName` is the starting point and should always contain initial information for first uses, as well as explanations for the correct usage of other topics.  


## Chats  

Chats are the main starting point and allow you to converse with the various LLMs made available by the providers.  
See the document [chats](CHATS.about.md) for more details. Below is a quick introduction to chats.

### Conversing with the model

Once the initial configuration of the provider is done, you can start the conversation!  
The easiest way to start the conversation is by using the command `Send-PowershaiChat` or the alias `ia`:

```powershell
ia "Hello, do you know PowerShell?"
```

This command will send the message to the model of the configured provider, and the response will be displayed next.  
Note that the response time depends on the model's capability and the network.  

You can use the pipeline to pass the result of other commands directly as context to the AI:

```powershell
1..100 | Get-Random -count 10 | ia "Tell me interesting facts about these numbers"
```  
The above command will generate a sequence from 1 to 100 and pass each number into the Powershell pipeline.  
Then, the Get-Random command will filter only 10 of those numbers randomly.  
Finally, this sequence will be sent (all at once) to the AI with the message you placed in the parameter.  

You can use the `-ForEach` parameter so that the AI processes each input one at a time, for example:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Tell me interesting facts about these numbers"
```  

The difference with the above command is that the AI will be called 10 times, once for each number.  
In the previous example, it will be called only once, with all 10 numbers.  
The advantage of using this method is to reduce the context, but it may take longer since more requests will be made.  
Test according to your needs!

### Object Mode  

By default, the `ia` command does not return anything. But you can change this behavior using the `-Object` parameter.  
When this parameter is activated, it asks the LLM to generate the result in JSON and writes the return back to the pipeline.  
This means you can do something like this:

```powershell
ia -Obj "5 random numbers, with their value written in full"

# or using the alias, io/powershellgallery/dt/powershai

io "5 random numbers, with their value written in full"
```  

**IMPORTANT: Note that not all providers may support this mode, as the model needs to be capable of supporting JSON! If you receive errors, confirm whether the same command works with an OpenAI model. You can also open an issue.**


## Saving Configurations  The PowershAI allows you to adjust a series of settings, such as chat parameters, authentication tokens, etc.  
Whenever you change a setting, this setting is saved only in the memory of your Powershell session.  
If you close and reopen, all the settings made will be lost.  

So that you do not have to generate tokens every time, for example, PowershAI provides 2 commands to export and import settings.  
The command `Export-PowershaiSettings` exports the settings to a file in the logged-in user's profile directory.  
Due to the fact that the exported data may be sensitive, you need to provide a password, which will be used to generate an encryption key.  
The exported data is encrypted using AES-256.  
You can import using `Import-PowershaiSettings`. You will have to provide the password you used to export.  

Note that this password is not stored anywhere, so you are responsible for memorizing it or keeping it in a vault of your choice.

## Costs  

It is important to remember that some providers may charge for the services used.  
PowershAI does not manage costs. It can inject data into prompts, parameters, etc.  
You should track using the tools that the provider's website provides for this purpose.  

Future versions may include commands or parameters that help to better control, but for now, the user must monitor.  

### Export and Import of Settings and Tokens

To facilitate the reuse of data (tokens, default models, chat history, etc.), PowershAI allows you to export the session.  
To do this, use the command `Export-PowershaiSettings`. You will need to provide a password, which will be used to create a key and encrypt this file.  
Only with this password can you import it again. To import, use the command `Import-PowershaiSettings`.  
By default, chats are not exported. To export them, you can add the parameter -Chats: `Export-PowershaiSettings -Chats`.  
Note that this may make the file larger, as well as increase the export/import time. The advantage is that you can continue the conversation between different sessions.  
This functionality was originally created with the intention of avoiding having to generate an API Key every time you needed to use PowershAI. With it, you generate your API keys with each provider once, and export as you update. Since it is protected by a password, you can safely save it in a file on your computer.  
Use the help command to get more information on how to use it.

# EXAMPLES <!--! @#Ex -->

## Basic Usage 

Using PowershAI is very simple. The example below shows how you can use it with OpenAI:

```powershell 
# Change the current provider to OpenAI
Set-AiProvider openai 

# Configure the authentication token (You must generate the token on the site platform.openai.com)
Set-OpenaiToken 

# Use one of the commands to start a chat! ia is an alias for Send-PowershaiChat, which sends a message in the default chat!
ia "Hello, I'm talking about PowershAI with you!"
```

## Exporting settings 

```powershell 
# Set some token, for example 
Set-OpenaiToken 

# After the above command runs, just export!
Export-PowershaiSettings

# You will have to provide the password!
```

## Importing settings 

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

Despite having a lot of code and already having quite a few functionalities, PowershAI is a new project that is being developed.  
Some bugs may be found and, at this stage, it is important that you always help by reporting, through issues, in the official repository at https://github.com/rrg92/powershai  

If you want to troubleshoot a problem, I recommend following these steps:

- Use Debug to help you. Commands like Set-PSBreakpoint are simple to invoke at the command line and can save you time
- Some functions do not display the complete error. You can use the variable $error and access the last one. For example:  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # This helps to find the exact line where the exception occurred!
```

# See also <!--! @#Also -->

- Video on How to use the Hugging Face Provider: https://www.youtube.com/watch?v=DOWb8MTS5iU
- Check the documentation of each provider for more details on how to use their cmdlets

# Tags <!--! @#Kw -->

- Artificial Intelligence
- AI

<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
