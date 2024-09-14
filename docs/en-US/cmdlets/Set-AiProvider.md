---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Set-AiProvider

## SYNOPSIS
Changes the current provider

## SYNTAX

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Providers are scripts that implement access to their respective APIs.
 
Each provider has its own way of invoking APIs, data format, response schema, etc.
 

When changing the provider, you affect certain commands that operate on the current provider, such as `Get-AiChat`, `Get-AiModels`, or the Chats, like Send-PowershaAIChat.
To learn more details about the providers, refer to the topic about_Powershai_Providers

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -provider
name of the provider

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



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
