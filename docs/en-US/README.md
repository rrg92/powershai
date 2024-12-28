# PowershAI

# SUMMARY <!--! @#Short --> 

PowershAI (Powershell + AI) is a module that adds AI access through Powershell

# DETAILS  <!--! @#Long --> 

PowershAI is a module that adds AI capabilities to your Powershell session. 
The goal is to simplify and encapsulate complex calls and treatments for the APIs of the main existing AI services. 

PowershAI defines a set of standards that allow the user to converse with LLMs, directly from the prompt, or to use the result of commands as context in a prompt. 
And, through a standardized set of functions, different providers can be used: For example, you can talk to GPT-4 or Gemini Flash using exactly the same code. 

In addition to this standardization, PowershAI also exposes internal and specific functions for connecting with different AI service providers. 
With this, you can customize and create scripts that use specific features of these APIs. 

The PowershAI architecture defines the concept of "provider", which are files that implement all the details necessary to talk to their respective APIs. 
New providers can be added, with new functionalities, as they become available. 

In the end, you have several options to start using AI in your scripts. 

Examples of famous providers that are already fully or partially implemented:

- OpenAI 
- Hugging Face 
- Gemini 
- Ollama
- Maritalk (Brazilian LLM)

To start using PowershAI is very simple: 

```powershell 
# Install the module!
Install-Module -Scope CurrentUser powershai 

# Import!
import-module powershai

# List of providers 
Get-AiProviders

# You should consult the documentation of each provider for details on how to use it!
# The documentation can be accessed using get-help 
Get-Help about_NomeProvider

# Example:
Get-Help about_huggingface
```

## Getting Help  

Despite the effort to document PowershAI as much as possible, we will most likely not be able to create all the necessary documentation in time to clarify doubts, or even talk about all the available commands. Therefore, it is important that you know how to do some of this yourself. 

You can list all available commands when the command `Get-Command -mo powershai`. 
This command will return all cmdlets, aliases and functions exported from the powerhsai module. 
It is the easiest starting point to discover which commands. Many commands are self-explanatory, just by looking at the name. 

And, for each command, you can get more details using `Get-Help -Full NomeComando`. 
If the command still does not have complete documentation, or if any doubt you need is missing, you can open an issue on git requesting more completion. 

Finally, you can explore the PowershAI source code, looking for comments left throughout the code, which may explain some functionality or architecture, in a more technical way. 

We will be updating the documentation as new versions are released. 
We encourage you to contribute to PowershAI, submitting Pull Requests or issues with documentation improvements if you find something that can be better explained, or that has not yet been explained.  


## Command Structure  

PowershAI exports several commands that can be used. 
Most of these commands have "Ai" or "Powershai". 
We call these commands the `global commands` of Powershai, because they are not commands for a specific provider. 

For example: `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`. 
Providers also export commands, which will usually have a provider name. Consult the provider documentation to learn more about the exported command pattern. 

By convention, no provider should implement commands with "Ai" or "Powershai" in the name, as they are reserved for global commands, regardless of provider. 
However, the names Ai + ProviderName can still be used by them (eg: AiHuggingFace*, AiOpenai*, AiAzure*, AiGoogle*) and are reserved only for the provider. 
Also, aliases defined by providers must always contain more than 5 characters. Smaller aliases are reserved for global commands. 

You can find the documentation for these commands in the [global commands doc](cmdlets/). 
You can use the Get-PowershaiGlobalCommands command to get the list!

## Provider Documentation  

The [provider documentation](providers) is the official place to get help on how each provider works. 
This documentation can also be accessed through the PowerShell `Get-Help` command. 

Provider documentation is always available via help `about_Powershai_NomeProvider_Topico`. 
The topic `about_Powershai_NomeProvider` is the starting point and should always contain the initial information for the first uses, as well as explanations for the correct use of other topics. 


## Chats  

Chats are the main starting point and allow you to chat with the various LLMs provided by the providers. 
See the document [chats](CHATS.about.md) for more details. Here is a quick introduction to chats.

### Talking to the model

Once the initial provider configuration is done, you can start the conversation! 
The easiest way to start the conversation is to use the `Send-PowershaiChat` command or the `ia` alias:

```powershell
ia "Hello, do you know PowerShell?"
```

This command will send the message to the model of the configured provider and the response will be displayed immediately. 
Note that the response time depends on the model's capacity and the network. 

You can use the pipeline to directly throw the result of other commands as context for the ai:

```powershell
1..100 | Get-Random -count 10 | ia "Tell me some curiosities about these numbers"
```  
The above command will generate a sequence from 1 to 100 and throw each number into the PowerShell pipeline. 
Then, the Get-Random command will filter only 10 of these numbers, randomly. 
And finally, this sequence will be thrown (all at once) to the ai and will be sent with the message you put in the parameter. 

You can use the `-ForEach` parameter so that the ai processes each input at a time, for example:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Tell me some curiosities about these numbers"
```  

The difference of this command above is that the AI will be called 10 times, one for each number. 
In the previous example, it will only be called once, with all 10 numbers. 
The advantage of using this method is to reduce the context, but it may take longer, as more requests will be made. 
Test according to your needs!

### Object Mode  

By default, the `ia` command does not return anything. But you can change this behavior using the `-Object` parameter. 
When this parameter is activated, it asks the LLM to generate the result in JSON and writes the return back to the pipeline. 
This means that you can do something like this:

```powershell
ia -Obj "5 random numbers, with their value written in full"

#or using the alias, io/powershellgallery/dt/powershai

io "5 random numbers, with their value written in full"
```  

**IMPORTANT: Note that not every provider can support this mode, as the model needs to be able to support JSON! If you receive errors, confirm if the same command works with an OpenAI model. You can also open an issue**


## Saving settings  

PowershAI allows you to adjust a series of settings, such as chat parameters, authentication tokens, etc. 
Whenever you change a setting, this setting is saved only in the memory of your Powershell session. 
If you close and open again, all the settings made will be lost. 

So that you don't have to generate tokens every time, for example, Powershai provides 2 commands to export and import settings. 
The `Export-PowershaiSettings` command exports the settings to a file in the profile directory of the logged-in user. 
Due to the fact that the exported data may be sensitive, you need to provide a password, which will be used to generate an encryption key. 
The exported data is encrypted using AES-256. 
You can import using `Import-PowershaiSettings`. You will have to provide the password you used to export. 

Note that this password is not stored anywhere, so you are responsible for memorizing it or storing it in a vault of your choice.

## Costs  

It is important to remember that some providers may charge for the services used. 
PowershAI does not do any cost management. It can inject data into prompts, parameters, etc. 
You should do the monitoring using the tools that the provider's website provides for this purpose. 

Future versions may include commands or parameters that help to better control, but, for now, the user must monitor. 



### Export and Import of Settings and Tokens

To facilitate the reuse of data (tokens, default models, chat history, etc.), PowershAI allows you to export the session. 
To do this, use the `Export-PowershaiSettings` command. You will need to provide a password, which will be used to create a key and encrypt this file. 
Only with this password can you import it again. To import, use the `Import-PowershaiSettings` command. 
By default, Chats are not exported. To export them, you can add the -Chats parameter: `Export-PowershaiSettings -Chats`. 
Note that this can make the file larger, as well as increase the export/import time. The advantage is that you can continue the conversation between different sessions. 
This functionality was originally created with the intention of avoiding having to generate Api Keys every time you needed to use PowershAI. With it, you generate your api keys once in each provider, and export as you update. As it is password protected, you can safely save it in a file on your computer. 
Use the help in the command to get more information on how to use it.


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

## Exporting settings 


```powershell 
# define some token, for example 
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

PowershAI has a range of commands available. 
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
$e.ErrorRecord.ScriptStackTrace # This helps to find the exact line where the exception occurred!
```

# See also <!--! @#Also -->

- Video on How to use the Hugging Face Provider: https://www.youtube.com/watch?v=DOWb8MTS5iU
- See the doc of each provider for more details on how to use its cmdlets

# Tags <!--! @#Kw -->

- Artificial Intelligence
- AI


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
