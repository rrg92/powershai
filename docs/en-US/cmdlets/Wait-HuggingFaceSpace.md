---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Wait-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
Waits for the space to start. Returns $true if it started successfully or $false if it timed out!

## SYNTAX <!--!= @#Syntax !-->

```
Wait-HuggingFaceSpace [[-Space] <Object>] [-timeout <Object>] [-SleepTime <Object>] [-NoStatus] [-NoStart] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
Filters by a specific space

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -timeout
How many seconds, maximum, to wait. If null, then waits indefinitely!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -SleepTime
Wait time until next check, in ms

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 5000
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoStatus
dont print progress status...

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoStart
Do not start, just wait!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
