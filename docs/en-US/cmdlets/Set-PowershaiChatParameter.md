---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Set-PowershaiChatParameter

## SYNOPSIS
Updates the value of a parameter in the Powershai Chat.

## SYNTAX

```
Set-PowershaiChatParameter [[-parameter] <Object>] [[-value] <Object>] [[-ChatId] <Object>] [-Force]
```

## DESCRIPTION
Updates the value of a parameter in a Powershai Chat.
 
If the parameter does not exist, an error is returned.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -parameter
Name of the parameter

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

### -value
Value of the parameter

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

### -ChatId
Chat that you want to update.
By default, updates the active chat

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Force update, even if the parameter does not exist in the parameter list

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
