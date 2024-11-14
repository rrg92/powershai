---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
Faz print constantes da tela e envia para o modelo ativo.
Este comando é EXPERIMENTAL e pode mudar ou não ser disponibilizado nas próximas versões!

## DESCRIPTION <!--!= @#Desc !-->
Este comando permite, em um loop, obter prints da tela!

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Prompt padrão para ser usado com a imagem enviada!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: Explique essa imagem
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
Fica em loop em tirando vários screenshots
Por padrão, o modo manual é usado, onde você precisa pressionar uma tecla para continuar.
as seguintes teclas possuem funcoes especiais:
	c - limpa a tela 
 ctrl + c - encerra o comando

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

### -AutoMs
Se especificado, habilita o modo repeat automático, onde a cada número de ms especificados, ele irá enviar para a tela tela.
ATENÇÃO: No modo automatico, você poderá ver a janela piscar constatemente, o que pode ser ruim para a leitura.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: $nulls
Accept pipeline input: false
Accept wildcard characters: false
```

### -RecreateChat
Recria o chat usado!

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