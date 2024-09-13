---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS
Defines which function will be used to format the objects passed to the Send-PowershaiChat -Context parameter.

## SYNTAX

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>]
```

## DESCRIPTION
When invoking Send-PowershaiChat in a pipe, or directly passing the -Context parameter, it will inject this object into the LLM prompt.

Before injecting, it must convert this object to a string.

This conversion is called "Context Formatter" here in Powershai.

The Context Formatter is a function that will take each object passed and convert it to a string to be injected into the prompt. The function used must accept the object to be converted as the first parameter.

The other parameters are at your discretion. Their values can be specified using the -Params parameter of this function!

Powershai provides native context formatters.

Use Get-Command ConvertTo-PowershaiContext* or Get-PowershaiContextFormatters to obtain the list!

Since the native context formatters are just PowerShell functions, you can use the Get-Help Name command to get more details.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

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

### -Func
Name of the PowerShell function
Use the Get-PowershaiContextFormatters command to see the list

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Str
Accept pipeline input: False
Accept wildcard characters: False
```

### -Params
{{ Fill Params Description }}

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
