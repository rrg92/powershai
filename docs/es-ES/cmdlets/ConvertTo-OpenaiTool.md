---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiTool

## SYNOPSIS <!--!= @#Synop !-->
Convierte un comando powershell (función, etc.) a la herramienta OpenAI

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiTool [[-function] <Object>] [[-UserDescription] <Object>] [[-Parameters] <Object>] [[-Help] <Object>] [[-JsonSchema] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -function
Nombre de la función, o objeto comando (resultado de Get-Command)

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

### -UserDescription
Descripción adicional

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

### -Parameters
filtrar parámetros específicos para agregar

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: *
Accept pipeline input: false
Accept wildcard characters: false
```

### -Help
Ayuda del comando (resultado de get-help)
Debes proporcionar una ayuda alternativa si deseas construir una ayuda personalizada o manualmente deseas obtener la ayuda debido a los casos de ámbito.

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

### -JsonSchema
Especifica un esquema personalizado para cada parámetro de función 
Este esquema JSON se combinará con el esquema generado originalmente, teniendo prioridad, por ejemplo: si el personalizado tiene la clave descripción, y en el original, el del personalizado se usa.
La combinación se realiza recursivamente, es decir, las propiedades que son objetos también se combinan.
Especifica una clave para cada parámetro.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
