---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Update-GradioSessionApiResult

## SYNOPSIS
Atualiza o retorno de uma call gerado como Invoke-GradioSessionApi

## SYNTAX

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>]
 [-History] [<CommonParameters>]
```

## DESCRIPTION
Este cmdlet segue o mesmo princípcio dos seus equivalentes em Send-GradioApi e Update-GradioApiResult.
Porém ele funciona apenas para os eventos gerados em uma sessão específica.
Retorna o próprio evento para que possa ser usado com outos cmdlets que deendam do evento atualizado!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Id
Id do evento, retornado por  Invoke-GradioSessionApi ou o próprio objeto retornado.

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

### -NoOutput
Não jogar o resultado de volta pro output!

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

### -MaxHeartBeats
Max hearbeats consecutivos.

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

### -session
Id da sessão

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

### -History
Adiciona o eventos no histórico de eventos do objeto GradioApiEvent informado em -Id

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
