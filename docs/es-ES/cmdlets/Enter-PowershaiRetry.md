---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-PowershaiRetry

## SYNOPSIS <!--!= @#Synop !-->
Gestiona la ejecución de comandos en función del resultado

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet ayuda a ejecutar comandos mientras no se alcance un resultado determinado.
Con esto, es posible, por ejemplo, solicitar al LLM que genere un resultado nuevamente si la respuesta no es la solicitada!

## SYNTAX <!--!= @#Syntax !-->

```
Enter-PowershaiRetry [[-Code] <Object>] [[-Expected] <Object>] [[-Retries] <Object>] [-ShowProgress] [-CheckErrors] [[-ModifyResult] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Code
El scriptblock con el código a ser ejecutado

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
Puede ser una cadena con la cual el resultado del código será comparado.
Puede ser un script block que será invocado!
¡Debe retornar un bool true para ser considerado como válido!
$_ apunta al resultado actual!

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
Máximo de intentos

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
Muestra el progreso de los intentos

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
¡Incluye excepciones en la verificación!
Si no se especifica, si el código en -Code resulta en error, el error se dispara de vuelta para quien llamó.
Al ser especificado, el error se envía como resultado para que el código -Expected decida qué hacer!

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
Permite modificar el valor a ser usado en la verificación. $_ apuntará al objeto resultante de la ejecución!

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
