---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Cria um quadro virtual de texto, e escreve caracteres dentro dos limites desse quadro

## DESCRIPTION <!--!= @#Desc !-->
Cria um quadro de desenho no console, que é atualizado em somente uma região específica!
Você pode enviar várias linhas de texto e afuncao cuidará de manter o desenho no mesmo quadro, dando a impressão que apenas uma região está sendo atualizada.
Para o efeito desejado, esta funcao deve ser invocada repetidamente, sem outros writes entre as invocacoes!

Esta função só deve ser usada no modo interativo do powershell, rodando em uma janela de console.
Ela é útil para usar em situações em que você quer ver o progresso de um resultado em string exatamente na mesma área, podendo comparar melhor variações.
É apenas uma função auxiliar.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
O seguinte exemplo escreve 3 string de texto a cada 2 segundos.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Texto a ser escrito. Pode ser um array. Se ultrapassar os limties de W e H, será truncado 
Se é um script bloc, invoca o codigo passando o objeto do pipeline!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -w
Max de caracteres em cada linha

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
Max de linhas

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
Caractere usado como espaço vazio

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PipeObj
Objeto do pipeline

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
Repassa o objeto

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```