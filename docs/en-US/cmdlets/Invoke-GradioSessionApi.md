---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Creates a new call to an endpoint in the current session.

## DESCRIPTION <!--!= @#Desc !-->
Makes a call using the Gradio API, to a specific endpoint and passing the desired parameters. 
This call will generate a GradioApiEvent (see Send-GradioApi), which will be saved internally in the session settings. 
This object contains everything necessary to obtain the API result. 

The cmdlet will return a SessionApiEvent object containing the following properties:
id - Internal ID of the generated event.
event - The internal event generated. Can be used directly with cmdlets that handle events.

Sessions have a defined Calls limit.
The goal is to prevent creating undefined calls in a way that loses control.

There are two session options that affect the call (can be changed with Set-GradioSession):




- MaxCalls 
Controls the maximum number of calls that can be created

- MaxCallsPolicy 
Controls what to do when the Max is reached.
Possible values:

- Error 
= results in an error!
- Remove 
= removes the oldest
- Warning 
= Displays a warning, but allows exceeding the limit.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Endpoint name (without the initial slash)

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

### -Params
List of parameters 
If it is an array, it passes directly to the Gradio Api 
If it is a hashtable, it assembles the array based on the position of the parameters returned by /info

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -EventId
IF specified, creates with an existing event id (may have been generated outside the module).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -session
Session

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
Force the use of a new token. If "public", then it does not use any token!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
