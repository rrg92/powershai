---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS
Clears the AI Tools cache.

## SYNTAX

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
```

## DESCRIPTION
PowershAI maintains a cache of "compiled" tools.
When PowershAI sends the list of tools to the LLM, it needs to send along with the description of the tools, list of parameters, description, etc.

Building this list can consume significant time, as it will scan the list of tools, functions, and for each, scan the help (and the help of each parameter).

When adding a cmdlet like Add-AiTool, it does not compile at that moment.
It waits to do that when it needs to invoke the LLM, in the function Send-PowershaiChat.

If the cache does not exist, it will compile it on the spot, which may cause that first send to the LLM to take a few milliseconds or seconds longer than normal.

This impact is proportional to the number of functions and parameters sent.

Whenever you use Add-AiTool or Add-AiScriptTool, it invalidates the cache, causing it to be generated on the next execution.

This allows you to add many functions at once, without being compiled each time you add one.

However, if you change your function, the cache is not recalculated.

Therefore, you should use this cmdlet so that the next execution contains the updated data of your tools after code or script changes.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ChatId
{{ Fill ChatId Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
