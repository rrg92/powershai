---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
Clears the AI Tools cache.

## DESCRIPTION <!--!= @#Desc !-->
PowershAI maintains a cache with the "compiled" tools.
When PowershAI sends the list of tools to the LLM, it needs to send along the tool description, list of parameters, description, etc.
Building this list can take significant time, as it will scan the list of tools, functions, and for each one, scan the help (and the help of each parameter).

When you add a cmdlet like Add-AiTool, it doesn't compile at that moment.
It leaves it to do that when it needs to invoke the LLM, in the Send-PowershaiChat function. 
If the cache doesn't exist, then it compiles there at the time, which can cause this first send to the LLM to take a few milliseconds or seconds longer than usual.

This impact is proportional to the number of functions and parameters sent.

Whenever you use Add-AiTool or Add-AiScriptTool, it invalidates the cache, causing it to be generated on the next execution. 
This allows you to add many functions at once without being compiled each time you add one.

However, if you modify your function, the cache is not recalculated.
So, you should use this cmdlet so that the next execution contains the updated data of your tools after code or script changes.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
