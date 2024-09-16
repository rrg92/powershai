---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
Lists the available models in the current provider

## DESCRIPTION <!--!= @#Desc !-->
This command lists all the LLMs that can be used with the current provider for use in PowershaiChat.  
This function depends on the provider implementing the GetModels function.

The returned object varies by provider, but, every provider must return an array of objects, each must contain, at least, the id property, which should be a string used to identify the model in other commands that depend on a model.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
