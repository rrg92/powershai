---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# ConvertTo-OpenaiMessage

## SYNOPSIS
Converts an array of strings and objects to a standard OpenAI message format!

## SYNTAX

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## DESCRIPTION
You can pass a mixed array where each item can be a string or an object. 
If it is a string, it may start with the prefix s, u, or a, which stands for system, user, or assistant, respectively. 
If it is an object, it is added directly to the resulting array.

See: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-OpenaiMessage "This is a text",@{role:"assistant";content="Assistant response"}, "s:Msg system"
```

Returns the following array:
	
	@{ role = "user", content = "This is a text" }
	@{role:"assistant";content="Assistant response"}
	@{ role = "system", content = "Msg system" }

## PARAMETERS

### -prompt
{{ Fill prompt Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
