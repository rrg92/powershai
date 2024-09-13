---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Clear-PowershaiChat

## SYNOPSIS
Apaga elementos de um chat!

## SYNTAX

```
Clear-PowershaiChat [-History] [-Context] [[-ChatId] <Object>]
```

## DESCRIPTION
Apaga elementos específico de um chat.
 
Útil apra liberar recursos, ou tirar o vício do llm devido ao histórico.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -History
Apaga todo o histórico

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
Apaga o contexto 
Id do chat.
Padrão: ativo.

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
