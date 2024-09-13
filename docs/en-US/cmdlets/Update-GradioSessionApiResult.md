---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Update-GradioSessionApiResult

## SYNOPSIS
Updates the return of a call generated as Invoke-GradioSessionApi

## SYNTAX

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>]
 [-History] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet follows the same principle as its equivalents in Send-GradioApi and Update-GradioApiResult.
However, it only works for events generated in a specific session.
It returns the event itself so it can be used with other cmdlets that depend on the updated event!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Id
Event Id, returned by Invoke-GradioSessionApi or the object returned itself.

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

### -NoOutput
Do not throw the result back to the output!

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

### -MaxHeartBeats
Max consecutive heartbeats.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -session
Session Id

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -History
Adds the events to the event history of the GradioApiEvent object specified in -Id

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
