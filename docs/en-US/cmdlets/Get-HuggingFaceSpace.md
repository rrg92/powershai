---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-HuggingFaceSpace

## SYNOPSIS
Gets information about a specific space!

## SYNTAX

### Single
```
Get-HuggingFaceSpace [[-Space] <Object>] [-NoGradioSession] [<CommonParameters>]
```

### Multiple
```
Get-HuggingFaceSpace [-author <Object>] [-My] [-NoGradioSession] [<CommonParameters>]
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

### -Space
Filters by a specific space (or array of spaces)

```yaml
Type: Object
Parameter Sets: Single
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -author
Filter all spaces by author

```yaml
Type: Object
Parameter Sets: Multiple
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -My
Filter all spaces of the current user!

```yaml
Type: SwitchParameter
Parameter Sets: Multiple
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoGradioSession
Does not create an automatic gradio session.
By default, in gradio spaces, it already creates a gradio session!

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
