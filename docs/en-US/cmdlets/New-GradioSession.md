---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# New-GradioSession

## SYNOPSIS
Creates a new Gradio session.

## SYNTAX

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force]
 [<CommonParameters>]
```

## DESCRIPTION
A Session represents a connection to a Gradio app.
 
Imagine that a session is like a tab in a browser open connected to a specific Gradio app.
 
The files uploaded, calls made, logins, are all recorded in this session.

This cmdlet returns an object that we call "GradioSession".
 
This object can be used in other cmdlets that depend on a session (and an active session can be set, which all cmdlets use by default if not specified).
 

Every session has a name that uniquely identifies it.
If not provided by the user, it will be automatically created based on the app's URL.
 
There cannot be 2 sessions with the same name.

When creating a session, this cmdlet saves this session in an internal repository of sessions.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AppUrl
URL of the app

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

### -Name
Unique name that identifies this session!

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

### -DownloadPath
Directory where to download the files

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Force recreate

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
