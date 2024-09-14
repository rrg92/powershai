---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-PowershaiDefaultParams

## SYNOPSIS
Gets a reference to a variable that defines the default parameters

## SYNTAX

```
Get-PowershaiDefaultParams
```

## DESCRIPTION
In PowerShell, modules have their own variable scope.

Therefore, trying to define this variable outside the correct scope will not affect the commands of the modules.

This command allows the user to access the variable that controls the default parameter of the module's commands.

For the most part, this will be used for debugging, but eventually, a user may want to set default parameters.

## EXAMPLES

### EXAMPLE 1
```
The example below shows how to set the default debug variable for the command Invoke-Http.
```

$HttpDebug = @{}
$ModDefaults = Get-PowershaiDefaultParams
$ModDefaults\['Invoke-Http:DebugVarName'\] = 'HttpDebug';
Note that the parameter -DebugVarName is an existing parameter in the command Invoke-Http.

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
