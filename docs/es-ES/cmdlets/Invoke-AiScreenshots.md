---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
Toma capturas de pantalla constantes y las envía al modelo activo.
¡Este comando es EXPERIMENTAL y puede cambiar o no estar disponible en versiones futuras!

## DESCRIPTION <!--!= @#Desc !-->
¡Este comando permite, en un bucle, obtener capturas de pantalla!

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
¡Prompt por defecto para ser usado con la imagen enviada!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: Explica esta imagen
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
Se queda en bucle tomando varias capturas de pantalla.
Por defecto, se utiliza el modo manual, donde necesitas presionar una tecla para continuar.
Las siguientes teclas tienen funciones especiales:
	c - limpia la pantalla 
 ctrl + c - termina el comando

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
Si se especifica, habilita el modo de repetición automático, donde cada número de ms especificados, enviará a la pantalla.
ATENCIÓN: En modo automático, podrás ver la ventana parpadear constantemente, lo que puede ser malo para la lectura.

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
¡Recrea el chat utilizado!

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


<!--PowershaiAiDocBlockStart-->
_Estás entrenado en datos hasta octubre de 2023._
<!--PowershaiAiDocBlockEnd-->
