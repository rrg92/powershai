---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-PowershaiRetry

## SYNOPSIS <!--!= @#Synop !-->
Gerencia a execuÃ§Ã£o de comandos com base no resultado

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet ajuda a executar comandos enquanto um determinado resultado nÃ£o for alcanÃ§ado.
Com isso, Ã© possÃ­vel, por exemplo, solicitar o LLM que gere um resultado novamente caso a resposta nÃ£o seja a solicitada!

## SYNTAX <!--!= @#Syntax !-->

```
Enter-PowershaiRetry [[-Code] <Object>] [[-Expected] <Object>] [[-Retries] <Object>] [-ShowProgress] [-CheckErrors] [[-ModifyResult] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Code
O scriptblock com o cÃ³digo a ser executado

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

### -Expected
Resultado esperado 
Pode ser uma string co o qual o resultado do cÃ³digo serÃ¡ comparado.
Pode ser um script block que serÃ¡ invocado!
Deve retornar um bool true para ser considerado como vÃ¡lido!
$_ aponta para o resultado atual!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Retries
MÃ¡ximo de retry

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 1
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowProgress
Exibe o progresso das tentativas

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

### -CheckErrors
Inclui exceptions no check!
Se nÃ£o especifciado, se o codigo em -Code resultar em erro, o erro Ã© disparado de volta para quem chamou.
Ao ser especificado, o erro Ã© enviado como resultado para que o codigo -Expected decida o que fzer!

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

### -ModifyResult
Permite modificar o vlaor a ser usado no check. $_  apontarÃ¡ para o objeto resultante da execuÃ§Ã£o!

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