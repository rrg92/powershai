---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Creates a virtual text frame and writes characters within the boundaries of that frame.

## DESCRIPTION <!--!= @#Desc !-->
Creates a drawing frame in the console, which is updated in only a specific region!
You can send multiple lines of text and the function will take care of keeping the drawing in the same frame, giving the impression that only one region is being updated.
For the desired effect, this function should be invoked repeatedly, with no other writes between the invocations!

This function should only be used in the interactive mode of PowerShell, running in a console window.
It is useful for situations where you want to see the progress of a string result exactly in the same area, allowing for better comparison of variations.
It is merely a helper function.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
The following example writes 3 strings of text every 2 seconds.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Text to be written. It can be an array. If it exceeds the limits of W and H, it will be truncated. 
If it is a script block, it invokes the code passing the pipeline object!

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

### -w
Max number of characters per line

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
Max number of lines

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
Character used as empty space

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PipeObj
Pipeline object

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
Passes the object through

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
