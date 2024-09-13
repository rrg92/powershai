---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-PowershaiChatParameter

## SYNOPSIS
Returns the list of available parameters in a chat

## SYNTAX

```
Get-PowershaiChatParameter [[-ChatId] <Object>]
```

## DESCRIPTION
This command returns an object containing the list of properties.
 
The object is, in fact, an array, where each element represents a property.
 

This returned array has some modifications to facilitate access to the parameters. 
You can access the parameters using the returned object directly, without the need to filter over the list of parameters.
This is useful when you want to access a specific parameter from the list.

## EXAMPLES

### EXAMPLE 1
```
$MyParams = Get-PowershaiChatParameter
```

\> $MyParams.MaxTokens # Accesses the max TOKENS parameter
\> $MyParams | %{ write-host Parameter $_.name has the value $_.value } # iterates over the parameters!

## PARAMETERS

### -ChatId
{{ Fill ChatId Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
