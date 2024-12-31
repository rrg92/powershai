# Using PowershAI

This file contains some basic examples of how you can use PowershAI.

After reading this file, you will be able to:

- Install and import PowershAI  
- Understand what a PowershAI provider is in practice  
- Create a free account on the Groq provider  
- Set up provider authentication credentials  
- Interact with the LLM model Llama3.3 via the Groq provider  
- Understand and use the commands `Get-AiChat` and `ia` (`Send-PowershaiChat`)  
- Securely export and import settings, such as API keys  
- Add new skills to the LLM through PowerShell functions (Tool Calling)  

---

## Installing PowershAI

Installing PowershAI is simple:

1. Open a PowerShell session
2. Type the command `Install-Module -Scope CurrentUser powershai`

> [!NOTE]
> The -Scope CurrentUser parameter ensures that PowershAI is installed only for your user, without needing to open PowerShell as an administrator.

Now that you have installed the module, you can import it into the current session using the command `import-module powershai`.

Whenever you open a new PowerShell session, you will need to import the module again using the same command `import-module`.

### About Execution Policy

If you receive error messages related to Execution Policy, you will need to authorize the execution of scripts.

You can do this in two ways:

- In your PowerShell session, use the command `Set-ExecutionPolicy -Scope Process Bypass`. This will allow execution only in the current session.
- You can also configure it permanently using `Set-ExecutionPolicy Bypass`.

Execution Policy is a PowerShell-specific configuration. Since the PowershAI module is not digitally signed (like most published modules), it may generate these error messages. If you want to learn more about Execution Policy and its implications, check out the official Microsoft documentation: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4

## Creating an account on Groq and obtaining an API KEY

PowershAI provides access to several LLMs through providers. Each provider is an organization or LLM developer that makes its API available for access.

For example, OpenAI provides access to the GPT model, which is a paid model developed by themselves.

PowershAI supports several providers, and for this example, we will use the Groq provider. Groq is a company that offers access to several open-source LLMs through its API. They offer a free plan, which is sufficient for the examples shown here.

To create an account, go to https://console.groq.com/login and create your account if you don't already have one. After creating your account, go to https://console.groq.com/keys and click the **Create API Key** button. Copy the generated key and give it a name you prefer. Suggestion: _Powershai-Tests_

> [!WARNING]
> After closing the screen that shows the API KEY, it cannot be viewed again.
> Therefore, I recommend that you only close it when you have completed all the following examples

## First conversation

Now that you have your API key, define it in PowershAI using the following commands:

```powershell
import-module powershai
Set-AiProvider groq
Set-AiCredential
```

The command above imports the module and changes the current provider to groq.
The current provider is the default provider in some powershai commands that need to communicate with an LLM.
The `Set-AiCredential` command configures a credential in the current provider. Each provider defines the necessary information.
You need to consult the [providers documentation](../providers/) (or `get-help Set-AiCredential`) for more details on what to provide.
In the case of groq, the only information is the API KEY that you obtain from the portal

---
Now you are ready to chat with Groq's LLMs.

You can use the command `ai` to start a conversation with the LLM, keeping the message history. These commands are just aliases for the `Send-PowershaiChat` cmdlet, which is used to start a conversation directly from the shell with the provider's default model.

For example, type in PowerShell:

```powershell
ai "Hello! I'm talking to you from PowershAI, following the first example!"
```

The command above will, transparently, invoke the Groq API, pass your prompt and write the result to the screen.

## Integrating the result

As a good shell, one of the most powerful features of PowerShell is the ability to integrate commands using the pipe `|`.
PowershAI takes advantage of this functionality, allowing you to connect virtually any PowerShell command with an AI!

For example, see how easy it is to ask the LLM to identify the top ten processes that consume the most memory:

```powershell
Get-Process | sort-object WorkingSet64 -Descending | select -First 10 | ai "What are these running processes?"
```

In the example above, you used the `Get-Process` cmdlet to get a list of processes. This is a well-known command in PowerShell.
Then, the result of `Get-Process` was sent to Sort-Object, which ordered the results by the WorkingSet64 property, that is, the total memory allocated, in bytes.
Then, you choose the first 10 results after sorting, a task that the `Select-Object` (alias `select`) command does very well!.
And finally, the ai command obtained these 10 results, sent them to groq followed by the prompt asking to explain the processes.

## Listing and changing models

PowershAI assumes that every provider can have one or more models available for conversation.
This reflects the fact that each provider may have different versions of each model, each with its advantages and disadvantages.

Most providers define a default model, so when using that provider, you can already chat immediately, as is the case with groq.
You can list all available LLM models using `Get-AiModels`.

To change the default model, use `Set-AiDefaultModel`. For example:

```
import-module powershai

Set-AiProvider groq
# Lists the available models
Get-AiModels

# Changes the default model
Set-AiDefaultModel gemma2-9b-it # Changes to the open-source Gemma2 model, from Google.

ai "What platform are we talking on?"
```

## Generating simple completions

You can also generate text manually using the `Get-AiChat` command. This command sends a prompt to the LLM, without conversation history. You have total control over the parameters used, such as prompt, message history, streaming, etc.

For example:
```
$resp = Get-AiChat "Hello!"
$resp.choices[0].message.content # The result of this command will always be a chat.completion object, from OpenAI, regardless of the provider used.
```

## Adding tools

PowershAI allows you to add tools to models that support them. Think of a tool as a function that you give to the LLM. It's like giving the model additional abilities, allowing it to obtain external information, perform actions, etc. This is where your creativity comes into play.

In PowershAI, you define a tool by creating a function and documenting it with comments in the code. See this example:

```powershell

function GetDateTime {
	<# 
	.SYNOPSIS 
	Gets the current date and time.
	#> 
	param()

	Get-Date
}


function GetTopProcesses {
	<# 
	.SYNOPSIS 
	Gets the processes that consume the most memory, showing the process name, the total amount of memory (in bytes), and the total CPU usage.
	#> 
	param(
	# Limits the number of processes returned
	[int]$top = 10
	)

	Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First $top -Property Name, WorkingSet64, CPU

}


# Import the PowershAI module
import-module powershai;

# Use the Groq provider
Set-AiProvider groq 

# Select a model that supports tool calls
Get-AiModels | ? { $_.tools }

# Set the default model
Set-AiDefaultModel llama-3.3-70b-versatile

# Test without added tools
ai "What time is it now?"


# Add the GetDateTime tool
Add-AiTool GetDateTime

ai "What time is it now?"

# Get an overview of the processes without tools
ai "Give me an overview of the 20 running processes."

# Add the GetTopProcesses function as a tool
Add-AiTool GetTopProcesses

ai "Give me an overview of the 15 processes that consume the most memory."
```

Note in the example above how we used comments to document the function and its parameters. This brings flexibility and agility to the integration of your scripts with AI models. Then we used the Add-AiTool command to register this function as a tool that can be invoked. All the function help, and parameters, are transformed into a format acceptable by the model. The model then, based on the text sent (and the previous history), can decide to invoke the tool. When it decides to invoke the tool, it sends a response back to PowershAI, containing the tools it wants to invoke and the arguments to be passed. Powershai then detects this request and executes the requested functions. That is, the functions are executed in the same PowerShell session you are in.

You can also add native PowerShell commands. PowershAI will use the documentation of these commands to describe the tool and its parameters.

For example, you could add the Get-Date command directly as a tool.

```powershell
# Remove all previously added tools (this command does not delete the functions, only removes the association with the conversation)
Get-AiTools | Remove-AiTool

# Clear the conversation history (you must confirm). We do this so that the model does not consider the previous answers.
Reset-PowershaiCurrentChat

# Ask about the current date without adding tools
ai "What is today's date?"

# Add the Get-Date command as a tool
Add-AiTool Get-Date
```

You can add tools in other ways, such as .ps1 scripts or executables. See the help for the `Add-AiTool` command for more details.

> [!WARNING]
> Even though the models have filters and several security barriers, giving it access to your powershai session can be dangerous
> Therefore, only add tools defined and reviewed by you (or from sources you trust)
> Since the model can freely decide to invoke a tool, it will have access to the same level of privilege as yours!

## Saving settings

Finally, it is important to know the ability to save your PowershAI settings. It would be tedious to have to generate a new API key every time you want to use the module.

To facilitate the use of PowershAI and maintain security, you can export your settings using `Export-PowershaiSettings`.


```powershell 
Export-PowershaiSettings
```

Just type the command and PowershAI will ask for a password. Then, it will encrypt all the settings of the current session into a file, using the keys generated from this password.

To import the saved settings, use `Import-PowershaiSettings`.

```powershell 
Import-PowershaiSettings
```

Remember to choose a strong password and memorize it, or keep it in a safe place. The purpose of this command is to facilitate the interactive use of PowershAI. For background use, it is recommended to configure environment variables.


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
