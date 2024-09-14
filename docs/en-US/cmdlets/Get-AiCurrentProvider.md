---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-AiCurrentProvider

## SYNOPSIS
Gets the active provider

## SYNTAX

```
Get-AiCurrentProvider [-ContextProvider]
```

## DESCRIPTION
Returns the object that represents the active provider.
 
Providers are implemented as objects and stored in the session memory, in a global variable.
 
This function returns the active provider, which was set with the command Set-AiProvider.

The returned object is a hashtable containing all the fields of the provider.
 
This command is commonly used by providers to obtain the name of the active provider.
 

The -ContextProvider parameter returns the current provider where the script is running.
 
If running in a script of a provider, it will return that provider, instead of the provider set with Set-AiProvider.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ContextProvider
If enabled, uses the context provider, that is, if the code is running in a file in the directory of a provider, it assumes this provider.
Otherwise, it gets the currently enabled provider.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
