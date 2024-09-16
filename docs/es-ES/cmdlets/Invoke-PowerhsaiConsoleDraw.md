---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Crea un cuadro virtual de texto, y escribe caracteres dentro de los límites de ese cuadro

## DESCRIPTION <!--!= @#Desc !-->
Crea un cuadro de dibujo en la consola, que se actualiza en solo una región específica!
Puedes enviar varias líneas de texto y la función se encargará de mantener el dibujo en el mismo cuadro, dando la impresión de que solo una región se está actualizando.
Para el efecto deseado, esta función debe ser invocada repetidamente, sin otras escrituras entre las invocaciones!

Esta función solo debe usarse en el modo interactivo de powershell, ejecutándose en una ventana de consola.
Es útil para usar en situaciones en las que deseas ver el progreso de un resultado en string exactamente en la misma área, pudiendo comparar mejor variaciones.
Es solo una función auxiliar.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
El siguiente ejemplo escribe 3 string de texto cada 2 segundos.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Texto a ser escrito. Puede ser un array. Si supera los limites de W y H, será truncado 
Si es un script bloc, invoca el código pasando el objeto del pipeline!

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
Max de caracteres en cada línea

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
Max de líneas

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
Caracter usado como espacio vacío

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
Repasa el objeto

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
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
