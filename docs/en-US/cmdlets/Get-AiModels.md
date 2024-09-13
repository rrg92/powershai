---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-AiModels

## SYNOPSIS
Lists the available models in the current provider.

## SYNTAX

```
Get-AiModels [<CommonParameters>]
```

## DESCRIPTION
This command lists all the LLMs that can be used with the current provider for use in PowershaiChat.

This function depends on the provider implementing the GetModels function.

The returned object varies depending on the provider, but every provider must return an array of objects, each of which must contain at least the id property, which must be a string used to identify the model in other commands that depend on a model.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
