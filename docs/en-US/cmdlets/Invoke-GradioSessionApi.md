---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-GradioSessionApi

## SYNOPSIS
Creates a new call to an endpoint in the current session.

## SYNTAX

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>]
 [[-Token] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Makes a call using the Gradio API, to a specific endpoint and passing the desired parameters.
 
This call will generate a GradioApiEvent (see Send-GradioApi), which will be saved internally in the session settings.
 
This object contains everything needed to obtain the API result.
 

The cmdlet will return an object of type SessionApiEvent containing the following properties:
	id - Internal ID of the generated event.
	event - The internal event generated.
It can be used directly with the cmdlets that manipulate events.
	
Sessions have a limit on defined Calls.
The goal is to prevent creating indefinite calls in such a way that control is lost.

There are two session options that affect the call (they can be changed with Set-GradioSession):
	- MaxCalls 
	Controls the maximum number of calls that can be created
	
	- MaxCallsPolicy 
	Controls what to do when the Max is reached.
	Possible values:
		- Error 	= results in an error!
		- Remove 	= removes the oldest one 
		- Warning 	= Displays a warning, but allows exceeding the limit.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ApiName
Name of the endpoint (without the leading slash)

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

### -Params
List of parameters 
If it is an array, it passes directly to the Gradio API 
If it is a hashtable, it builds the array based on the position of the parameters returned by /info

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

### -EventId
IF specified, creates with an already existing event ID (it may have been generated outside the module).

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

### -session
Session

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: .
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Token
Force the use of a new token.
If "public", then it does not use any token!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
