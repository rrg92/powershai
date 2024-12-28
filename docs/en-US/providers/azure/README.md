# Azure OpenAI Provider

The Azure OpenAI provider implements all the necessary functions to connect with the API of the models that can be configured in your Azure subscription.
The models follow the same pattern as OpenAI, and most commands work exactly like openai.

# Quick Start

Using the Azure provider involves the following steps:

- Create the resources in the Azure portal, or Azure AI Studio.



- Use `Set-AiProvider azure` to change the current provider to azure.
- Define the API URL information using the command `Set-AiAzureApiUrl`. The `-ChangeToken` parameter allows you to define the token along with it.

Once you have followed these steps, you can chat normally using commands with `ia`.


## APIs and URL

To use the azure provider, enable it using `Set-AiProvider azure`.
Basically, azure provides the following APIs to chat with LLMs:

- Azure OpenAI API
This API allows you to chat with OpenAI models that are in the Azure infrastructure or that have been provisioned exclusively for you.

- Inference API
This API allows you to chat with other models, such as Phi3, Llama3.1, several hugging face models, etc.
These models can be provisioned in a serverless way (you have a functional API, regardless of where it runs, with whom it shares, etc.) or exclusively (where the model is made available exclusively on a machine for you).

In the end, for you, as a powershai user, you only need to know that this provider can correctly adjust the API calls.
And they are all compatible with the same format as the OpenAI API (however, not all functionalities may be available for certain models, such as Tool Calling).

It is important to know that these two types exist, as this will guide you in the initial configuration.
You must use the `Set-AiAzureApiUrl` command to define the URL of your API.

This cmdlet is very flexible.
You can specify an Azure OpenAI URL. Ex.:

```powershell
Set-AiAzureApiUrl -ChangeToken https://iatalking.openai.azure.com/openai/deployments/gpt-4o-mini/chat/completions?api-version=2023-03-15-preview
```

With the command above, it will identify which API should be used and the correct parameters.
Also, it identifies the URLs related to the inference API:

```powershell
Set-AiAzureApiUrl -ChangeToken https://test-powershai.eastus2.models.ai.azure.com
```

Note the use of the `-ChangeToken` parameter.
This parameter will force you to enter the token again. It is useful when changing, or configuring for the first time.

You can change the API key later, if necessary, using the command `Set-AiAzureApiKey`


## Useful Links

The following links can help you configure your Azure OpenAI, and obtain your credentials.


- Azure OpenaAI Overview
https://learn.microsoft.com/en-us/azure/ai-services/openai/overview

- Resource Creation in the portal
https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/create-resource?pivots=web-portal

- About Azure AI Studio
https://learn.microsoft.com/en-us/azure/ai-studio/what-is-ai-studio

- API Reference
https://learn.microsoft.com/en-us/azure/ai-services/openai/reference


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
