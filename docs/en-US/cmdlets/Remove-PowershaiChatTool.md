---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Remove-PowershaiChatTool

## SYNOPSIS
Removes a tool permanently!

## SYNTAX

```
Remove-PowershaiChatTool [[-tool] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-global] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -tool
Name of the command, script, functions that was previously added as a tool.
If it is a .ps1 file, it is treated as a script unless -ForceCommand is used.
You can use the output of Get-PowershaiChatTool via pipe to this command, and it will recognize
When sending the returned object, all other parameters are ignored.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ForceCommand
Forces treating the tool as a command when it is a string

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

### -ChatId
Chat from which to remove

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -global
Remove from the global list if the tool was previously added as global

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
