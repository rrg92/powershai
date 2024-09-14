---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# New-PowershaiError

## SYNOPSIS
Creates a new customized Exception for PowershaAI

## SYNTAX

```
New-PowershaiError [[-Message] <Object>] [[-Props] <Object>] [[-Type] <Object>] [[-Parent] <Object>]
```

## DESCRIPTION
Facilitates the creation of customized exceptions!
It is used internally by providers to create exceptions with properties and types that can be retrieved later.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Message
The exception message!

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

### -Props
Customized properties

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Additional type!

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

### -Parent
Parent exception!

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
