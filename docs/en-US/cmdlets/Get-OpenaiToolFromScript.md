---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Helper function to convert a .ps1 script to a schema format expected by OpenAI.
Essentially, this function does is read a .ps1 file (or string) along with its help doc.  
Then, it returns an object in the format specified by OpenAI so the model can invoke it!

Returns a hashtable containing the following keys:
	functions - The list of functions, with their code read from the file.  
				When the model invokes, you can execute directly from here.
				
	tools - List of tools, to be sent in the OpenAI call.
	
You can document your functions and parameters following the PowerShell Comment Based Help:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

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


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
