---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS
Creates a virtual text box and writes characters within the limits of that box

## SYNTAX

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>]
 [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Creates a drawing box in the console, which is updated in only a specific area!
You can send several lines of text and the function will take care of maintaining the drawing in the same box, giving the impression that only one area is being updated.
For the desired effect, this function must be invoked repeatedly, without other writes between the invocations!

This function should only be used in interactive mode of PowerShell, running in a console window.
It is useful to use in situations where you want to see the progress of a string result exactly in the same area, allowing for better comparison of variations.
It is just a helper function.

## EXAMPLES

### EXAMPLE 1
```
The following example writes 3 strings of text every 2 seconds.
```

You will notice that the strings will be written exactly on the same line, replacing the previous one!

"ISso",@("É","a test"),"of writing","with`nmultiple`nlines!!" | Invoke-PowerhsaiConsoleDraw -w 60x10 {  $_; start-sleep -s 1 };

## PARAMETERS

### -Text
Text to be written.
It can be an array.
If it exceeds the limits of W and H, it will be truncated.
If it is a script block, it invokes the code passing the pipeline object!

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

### -w
Max number of characters in each line

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -h
Max number of lines

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlankChar
Character used as empty space

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PipeObj
Pipeline object

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -PassThru
Passes the object through

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
