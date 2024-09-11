# Provider OpenAI  

# SUMMARY <!--! @#Short --> 

This is the official documentation for the OpenAI provider of PowershAI.

# DETAILS  <!--! @#Long --> 

The OpenAI provider provides all the commands to communicate with OpenAI services.  
The cmdlets of this provider have the format Verb-OpenaiName.  
The provider implements HTTP calls as documented at https://platform.openai.com/docs/api-reference

**Note**: Not all features of the API are implemented yet.

## Initial Setup 

Using the OpenAI provider essentially involves enabling it and configuring the token.  
You need to generate an API Token on the OpenAI website. In other words, you will need to create an account and add credits.  
Check more at https://platform.openai.com/api-keys 

Once you have this information, you can execute the following code to activate the provider:

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

If you are running in the background (without interactivity), the token can be configured using the environment variable `OPENAI_API_KEY`.  

With the token configured, you are ready to invoke and use the Chat from PowershAI:

```
ia "Hello, I am speaking with you from PowershAI"
```

And, of course, you can invoke the commands directly:

```
Get-OpenaiChat -prompt "s: You are a bot that answers questions about powershell","How to display the current time?"
```

* Use Set-AiProvider openai (it is the default)
Optionally, you can pass an alternative URL.

* Use Set-OpenaiToken to configure the token!


## Internals

OpenAI is an important provider because in addition to providing various advanced and robust AI services, it also serves as a standardization guide for PowershAI.  
Most of the standards defined in PowershAI follow OpenAI specifications, which is the most widely used provider and it is common practice to use OpenAI as a base.  

And, due to the fact that other providers tend to follow OpenAI, this provider is also prepared for code reuse.  
Creating a new provider that uses the same specifications as OpenAI is very simple, just define a few configuration variables!
