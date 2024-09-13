---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Wait-HuggingFaceSpace

## SYNOPSIS
Waits for the space to start.
Returns $true if it started successfully or $false if it timed out!

## SYNTAX

```
Wait-HuggingFaceSpace [[-Space] <Object>] [-timeout <Object>] [-SleepTime <Object>] [-NoStatus] [-NoStart]
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

### -Space
Filters by a specific space

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

### -timeout
How many seconds, at most, to wait.
If null, then waits indefinitely!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SleepTime
Wait time until the next check, in ms

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 5000
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoStatus
Don't print progress status...

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

### -NoStart
Does not start, just waits!

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
