---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
Gets a reference to the variable that defines the default parameters

## DESCRIPTION <!--!= @#Desc !-->
In PowerShell, modules have their own variable scope.
Therefore, trying to define this variable outside the correct scope will not affect the module's commands.
This command allows the user to access the variable that controls the default parameter of the module's commands.
For the most part, this will be used for debugging, but eventually a user may want to define default parameters.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiDefaultParams [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
The example below shows how to define the debug variable default of the Invoke-Http command.
```

## PARAMETERS <!--!= @#Params !-->


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
