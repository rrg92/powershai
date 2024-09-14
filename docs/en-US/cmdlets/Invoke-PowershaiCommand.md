---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-PowershaiCommand

## SYNOPSIS
Allows invoking most functions in a compact manner

## SYNTAX

```
Invoke-PowershaiCommand [[-CommandName] <Object>] [[-RemArgs] <Object>] [<CommonParameters>]
```

## DESCRIPTION
This is a simple utility that allows invoking various functions in a more concise way from the command line.

Note that not all commands may be supported yet.

It is best used with the alias pshai.

## EXAMPLES

### EXAMPLE 1
```
pshai tools # lists the tools
```

\> pshai params MaxTokens 2048 #updates a parameter

## PARAMETERS

### -CommandName
Command name

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

### -RemArgs
{{ Fill RemArgs Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
