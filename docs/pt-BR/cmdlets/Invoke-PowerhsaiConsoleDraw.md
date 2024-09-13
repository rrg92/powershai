---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS
Cria um quadro virtual de texto, e escreve caracteres dentro dos limites desse quadro

## SYNTAX

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>]
 [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Cria um quadro de desenho no console, que é atualizado em somente uma região específica!
Você pode enviar várias linhas de texto e afuncao cuidará de manter o desenho no mesmo quadro, dando a impressão que apenas uma região está sendo atualizada.
Para o efeito desejado, esta funcao deve ser invocada repetidamente, sem outros writes entre as invocacoes!

Esta função só deve ser usada no modo interativo do powershell, rodando em uma janela de console.
Ela é útil para usar em situações em que você quer ver o progresso de um resultado em string exatamente na mesma área, podendo comparar melhor variações.
É apenas uma função auxiliar.

## EXAMPLES

### EXAMPLE 1
```
O seguinte exemplo escreve 3 string de texto a cada 2 segundos.
```

Você vai perceber que as strings serão escritas exatamente na mesm alinha, substuindo a anterior!

"ISso",@("é","um teste"),"de escrita","com\`nvarias\`nlinhas!!" | Invoke-PowerhsaiConsoleDraw -w 60x10 {  $_; start-sleep -s 1 };

## PARAMETERS

### -Text
Texto a ser escrito.
Pode ser um array.
Se ultrapassar os limties de W e H, será truncado 
Se é um script bloc, invoca o codigo passando o objeto do pipeline!

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

### -w
Max de caracteres em cada linha

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -h
Max de linhas

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlankChar
Caractere usado como espaço vazio

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

### -PipeObj
Objeto do pipeline

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -PassThru
Repassa o objeto

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
