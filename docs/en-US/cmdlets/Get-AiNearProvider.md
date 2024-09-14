---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-AiNearProvider

## SYNOPSIS
Gets the most recent provider from the current script

## SYNTAX

```
Get-AiNearProvider
```

## DESCRIPTION
This cmdlet is commonly used by providers indirectly through Get-AiCurrentProvider.

It looks at the PowerShell call stack and identifies if the caller (the function that executed) is part of a provider script.

If so, it returns that provider.

If the call was made in multiple providers, the most recent one is returned.
For example, consider this scenario:

	User -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
In this case, note that there are 2 provider calls involved.

In this case, the Get-AiNearProvider function will return provider Y, as it is the most recent in the call stack.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
