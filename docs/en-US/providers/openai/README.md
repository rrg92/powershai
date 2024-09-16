# OpenAI Provider  

# SUMMARY <!--! @#Short --> 

This is the official documentation for the OpenAI PowershAI provider. 

# DETAILS  <!--! @#Long --> 

The OpenAI provider provides all commands to communicate with the OpenAI services.  
The provider cmdlets are formatted in Verbo-OpenaiNoun.  
The provider implements the HTTP calls as documented in https://platform.openai.com/docs/api-reference

**Note**: Not all API features are implemented yet


## Initial Setup 

Using the OpenAI provider basically involves enabling it and setting up the token.  
You need to generate an API Token on the OpenAI website. This means you will need to create an account and insert credits.  
Check more at https://platform.openai.com/api-keys 

Once you have this information, you can run the following code to enable the provider:

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

If you are running in the background (without interactivity), the token can be configured using the `OPENAI_API_KEY` environment variable.  

With the token configured, you are ready to use the Powershai Chat:

```
ia "Hello, I'm talking to you from Powershai"
```

And, obviously, you can invoke the commands directly:

```
Get-OpenaiChat -prompt "s: You are a bot that answers questions about powershell","How to display the current time?"
```




* Use Set-AiProvider openai (it's the default)
Optionally you can pass an alternative URL

* Use Set-OpenaiToken to configure the token!


## Internals

OpenAI is an important provider, because besides providing various advanced and robust AI services, it also serves as a standardization guide for PowershAI.  
Most of the standards defined in PowershAI follow the OpenAI specifications, which is the most widely used provider and it is common practice to use OpenAI as a base.  


And, due to the fact that other providers usually follow OpenAI, this provider is also prepared for code reuse.  
Creating a new provider that uses the same specifications as OpenAI is very simple, just define some configuration variables!






<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
