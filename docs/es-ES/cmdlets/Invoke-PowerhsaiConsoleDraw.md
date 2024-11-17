---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Crea un marco virtual de texto y escribe caracteres dentro de los límites de ese marco

## DESCRIPTION <!--!= @#Desc !-->
Crea un marco de dibujo en la consola, que se actualiza en solo una región específica.
¡Puedes enviar varias líneas de texto y la función se encargará de mantener el dibujo en el mismo marco, dando la impresión de que solo una región está siendo actualizada!
Para el efecto deseado, esta función debe ser invocada repetidamente, sin otros writes entre las invocaciones.

Esta función solo debe ser utilizada en el modo interactivo de PowerShell, ejecutándose en una ventana de consola.
Es útil para utilizar en situaciones en las que deseas ver el progreso de un resultado en cadena exactamente en la misma área, pudiendo comparar mejor las variaciones.
Es solo una función auxiliar.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
El siguiente ejemplo escribe 3 cadenas de texto cada 2 segundos.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Texto a ser escrito. Puede ser un array. Si excede los límites de W y H, será truncado.
Si es un bloque de script, invoca el código pasando el objeto del pipeline.

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
Máximo de caracteres en cada línea

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
Máximo de líneas

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
Carácter usado como espacio vacío

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
Objeto del pipeline

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
Reenvía el objeto

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
