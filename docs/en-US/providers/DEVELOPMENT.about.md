# Developing Providers

This is a guide and reference for the operation and development of providers.
Use it as a base if you want to contribute to an existing provider or create a new one.

As you may have already read in some introduction about PowershAI, providers are who, in fact, contain the logic to invoke their respective APIs and return the result.
They act as a translator between PowershAI and the API of an AI service.
You could imagine them as drivers in Windows, or plugins of a WordPress, for example.

The objective of a provider is that it implements everything that PowershAI needs for its operation transparently.

# How providers are loaded

When you import powershai, one of the last steps it does is load the provides.
It does this by reading the providers directory, which is a hard-coded value and is in the [providers](/powershai/providers) directory.

This directory must contain a .ps1 script for each existing provider.
The file name is treated by powershai as the provider name.

This name is important because it is through it, for example, that you activate the provider with the `Set-AiProvider` command.
Due to the fact that it is a file in a directory, this naturally avoids duplicates and makes it unique.

Powershai will read the providers directory, and for each .ps1 file, it will invoke the file.
Powershell uses the "." operator, that is, the file is executed in the same context as the Powershai core (powershai.psm1).
This means that bugs in a provider will prevent the entire powershai from being imported.
This is intentional: If there is something incorrect in a file, it is important that this is addressed and resolved.

The provider script is like any powershell script.
You can define functions, use Export-ModuleMember, etc.

The only requirement that powershai makes is that the script returns a hashtable with some mandatory keys (see below).

Powershai then obtains this return, and creates an object in the session memory that represents this provider, and saves these returned keys.
In addition to the default keys required by powershai, others can be defined, as needed by each provider, as long as they are not the same reserved keys.

Optionally, providers need to implement interfaces created by Powershai.
Powershell does not have a native object-oriented interface concept, but here in powershai we reuse this concept because it is practically the same objective: powershai defines some operations that, if implemented by the provider, activate certain functionalities. For example, the GetModels interface must be implemented so that the `Get-AiModels` command returns correctly.

Each interface defines its rules, inputs and returns that the provider must handle. The section below on interfaces documents all interfaces.

## Command Names

Providers must follow a pattern in the names of their commands.
The commands exported from the module must be: `Verb`-`ProviderName``CommandName`.
* Verb must be one of the approved powershell verbs.
* ProviderName must be a valid provider name.
Valid names for the provider are the file name itself (without extension), or "Ai" + file name, without extension.
* CommandName is the common name to be given to the command!

For internal commands, the following pattern should be adopted: `ProviderName_CommandName`.
Note that this pattern is the same as the interfaces, therefore, you should not use interfaces.



# Provider Keys

Every provider must return a hashtables with a list of keys required by Powershai (called the list of Reserved Keys()).
Optionally, the provider can define other keys for its own use.

## List of Reserved Keys

* DefaultModel
Name of the default model. This is where the `Set-aiDefaultModel` command saves.

* info
A hashtable containing information about the provider.

* info.desc
Short description of the provider

* info.url
URL for the documentation or main page about the provider.

* ToolsModels
Name of models (accepts regex), that support function calling.
This list serves as a hint, if a model is in this, powershai does not need to invoke Get-AiModels to determine.

* CredentialEnvName
Names of environment variables that may contain default credentials!
Array or string.
The format of the credential value is exclusive to each provider. The documentation should make it clear how to define.

* DefaultEmbeddingsModel
Default model used to obtain embeddings

* EmbeddingsModels
Name of models (accepts regex), that support generating embeddings.

* IsOpenaiCompatible
Indicates that the model is compatible with OpenAI. This will cause the openai provider to correctly determine the current active provider when the functions that depend on the current provider are invoked. Every provider that reuses OpenAI functions should set this key to true.


# Interfaces

Powershai interfaces define patterns of operations that providers must follow.
Thanks to these interfaces, powershai can be dynamic.

The provider must implement an interface as a function, cmdlet or alias.
The command name must follow this pattern to be correctly identified: `providername_InterfaceName`.
`providername` is the name of the provider file, without the extension.
`InterfaceName` is the name of the interface (as listed below).


## List of Interfaces

### Chat
This interface is invoked by powershai whenever it wants the llm model to complete a text.
It is invoked by Get-Aichat.

### FormatPrompt
This interface is invoked when writing the LLM response to the screen.
It must return a string with the text.

### GetModels
Invoked when listing the models.
It does not receive any parameters and must return an array with the list of models.
Each element of the array must be an object containing, at least, the following properties:

- name
Name of the AI model

- tools
True if it supports openai tool calling.
Otherwise, assume it does not support!
Only models whose value is true will be able to invoke an ai tool.

### SetCredential
Invoked when the user is requesting to set a new credential (token, api key).
Credentials are the standard mechanism of powershai to store the sensitive information that the provider may need for authentication.
All parameters defined beyond the first, which is AiCredential, will be included in the AiCredential function.
Whenever the provider is changed, the function will be updated with the parameters!


### GetEmbeddings
Invoked when the user runs Get-AiEmbeddings, to obtain the embeddings of one or more text snippets.
See Get-AiEmbeddings for details of the parameters it should process and result.


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
