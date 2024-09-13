---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-OpenaiToolFromScript

## SYNOPSIS

## SYNTAX

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Helper function to convert a .ps1 script into a schema format expected by OpenAI.
Basically, what this function does is read a .ps1 file (or string) along with its help doc.
 
Then, it returns an object in the format specified by OpenAI so that the model can invoke it!

Returns a hashtable containing the following keys:
	functions - A list of functions, with their code read from the file.
 
				When the model invokes, you can execute directly from here.
				
	tools - List of tools, to be sent in the OpenAI call.
	
You can document your functions and parameters following the Comment Based Help of PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ScriptPath
{{ Fill ScriptPath Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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
