---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Clear-PowershaiChat

## SYNOPSIS
Deletes elements from a chat!

## SYNTAX

```
Clear-PowershaiChat [-History] [-Context] [[-ChatId] <Object>]
```

## DESCRIPTION
Deletes specific elements from a chat.
 
Useful for freeing up resources, or breaking the addiction of the llm due to the history.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -History
Deletes the entire history

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

### -Context
Deletes the context 
Chat ID.
Default: active.

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
