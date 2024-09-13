---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Set-PowershaiChatTool

## SYNOPSIS
Disables a tool (but does not remove it).
Disabled tool is not sent to the LLM.

## SYNTAX

### Enable
```
Set-PowershaiChatTool [-tool <Object>] [-Enable] [-ForceCommand] [-ChatId <Object>] [-Global]
 [<CommonParameters>]
```

### Disable
```
Set-PowershaiChatTool [-tool <Object>] [-Disable] [-ForceCommand] [-ChatId <Object>] [-Global]
 [<CommonParameters>]
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
Name of the tool (same as Add-PowershaiChatTool) or via pipe the result of Get-PowershaiChatTool

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Enable
Enables the tool.

```yaml
Type: SwitchParameter
Parameter Sets: Enable
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disable
Disables the tool.

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceCommand
If specified, and the tool is a name, forces it to be treated as a script!

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
Chat in which the tool is

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -Global
Searches for the tool in the global list of Tools

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
