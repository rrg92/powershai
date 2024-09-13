---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Remove-GradioSessionApi

## SYNOPSIS
Remove api cals da lista interna da sessão

## SYNTAX

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Este cmdlet auxilia na remoção de evenots gerados por Invoke-GradioSessionApi da lista internas de calls. 
Normalmente, você quer remover os eventos que já processou, passanso o id direto.
 
Mas, este cmdlet permite fazer vários tipos de removação, incluindo eventos não procesando.
 
Use com cautela, pois, uma vez que um vento é removido da lista, os dados associados com ele também são removidos.
 
A menos que você tenha feito uma cópia do evento (ou dos dados resultantes) para uma outra variável, você não será mais capaz de recuperar estas informações.
 

A removação de evenots também é útil para ajudar a liberar a memória consumida, que, dependendo da quantidade de eventos e dados, pode ser alta.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Target
Especifica o evento, ou eventos, a serem removidos
Id também pode ser um desses valores especiais:
	clean 	- Remove somente as calls que já completaram!
  all 	- Remove tudo, inclunido os que não concluiram!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
Por padrão, apenas os eventos passados com status "completed" são removidos!
Use -Force para remover inpdenente do status!

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

### -Elegible
Nao faz nenhuma remocação, mas retorna os candidados!

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

### -session
Id da sessão

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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
