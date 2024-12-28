---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Runs code under a specific provider

## DESCRIPTION <!--!= @#Desc !-->
With this cmdlet, you can run code that uses a specific provider.
This allows you to ensure that a given provider will be returned by functions that depend on a provider.

For example:

Set-AiProvider openai
Enter-AiProvider ollama { Get-AiCurrentProvider } # Returns ollama
Get-AiCurrentProvider # returns openai

With this, you can force the execution of a code snippet under a specific provider.
You can combine several nested Enter-AiProviders;

Set-AiProvider openai
Get-AiCurrentProvider # returns openai
Enter-AiProvider ollama {

Get-AiCurrentProvider # Returns ollama
Enter-AiProvider groq {
Get-AiCurrentProvider # Returns groq
}

Get-AiCurrentProvider # Returns ollama
}

## SYNTAX <!--!= @#Syntax !-->

```
Enter-AiProvider [[-Provider] <Object>] [[-code] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Provider

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -code

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
