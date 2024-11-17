---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
Takes constant screenshots of the screen and sends them to the active model.
This command is EXPERIMENTAL and may change or not be available in future versions!

## DESCRIPTION <!--!= @#Desc !-->
This command allows you to take screenshots of the screen in a loop!

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Default prompt to be used with the sent image!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: Explain this image
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
Loops taking multiple screenshots.
By default, manual mode is used, where you need to press a key to continue.
The following keys have special functions:
	c - clears the screen 
 ctrl + c - ends the command

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

### -AutoMs
If specified, enables automatic repeat mode, where every specified number of ms, it will send to the screen.
WARNING: In automatic mode, you may see the window flashing constantly, which can be bad for reading.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: $nulls
Accept pipeline input: false
Accept wildcard characters: false
```

### -RecreateChat
Recreates the chat used!

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
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
