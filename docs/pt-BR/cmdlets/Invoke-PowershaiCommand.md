---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-PowershaiCommand

## SYNOPSIS
Permite invocar a maioria das funções de uma maneira compacta

## SYNTAX

```
Invoke-PowershaiCommand [[-CommandName] <Object>] [[-RemArgs] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Este é um simples utilizario que permite invocar diversas funcoes de uma forma mais reduzia na linha de comando.
 
Note que nem todos os comandos podem ser suportados ainda.

É melhor usado com o alia pshai.

## EXAMPLES

### EXAMPLE 1
```
pshai tools # lista as tools
```

\> pshai params MaxTokens 2048 #atualiza um parâmetro

## PARAMETERS

### -CommandName
Command name

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

### -RemArgs
{{ Fill RemArgs Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
