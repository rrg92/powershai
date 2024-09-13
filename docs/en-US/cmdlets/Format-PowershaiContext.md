---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Format-PowershaiContext

## SYNOPSIS
Formats an object to be injected into the context of a message sent in a Powershai Chat

## SYNTAX

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>]
 [<CommonParameters>]
```

## DESCRIPTION
Given that LLMs process only strings, the objects passed in the context need to be converted to a string format before being injected into the prompt.
And, since there are various string representations of an object, Powershai allows the user to have full control over this.

Whenever an object needs to be injected into the prompt, when invoked with Send-PowershaAIChat, via pipeline or Context parameter, this cmdlet will be invoked.
This cmdlet is responsible for transforming this object into a string, regardless of the object, be it an array, hashtable, custom, etc.

It does this by invoking the configured formatter function using Set-PowershaiChatContextFormatter.
In general, you do not need to invoke this function directly, but you may want to invoke it whenever you want to do some testing!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -obj
Any object to be injected

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

### -params
Parameter to be passed to the formatter function

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

### -func
Override the function to be invoked.
If not specified, uses the default of the chat.

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

### -ChatId
Chat in which to operate

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: .
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
