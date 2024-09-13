---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# New-PowershaiError

## SYNOPSIS
Cria um nova Exception cusotmizada para o PowershaAI

## SYNTAX

```
New-PowershaiError [[-Message] <Object>] [[-Props] <Object>] [[-Type] <Object>] [[-Parent] <Object>]
```

## DESCRIPTION
FAciltia a criação de exceptions customizadas!
É usada internamente pelos providers para criar exceptions com propriedades e tipos que podem ser restados posteriormente.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Message
A mensagem da exception!

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
Propriedades personazalidas

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
Tipo adicional!

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
Exception pai!

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
