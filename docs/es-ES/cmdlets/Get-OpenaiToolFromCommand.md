---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromCommand

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Convierte comandos de powershell a OpenaiTool.

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromCommand [[-functions] <Object>] [[-parameters] <Object>] [[-UserDescription] <Object>] [[-JsonSchema] <Hashtable[]>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -functions
Lista de comandos

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

### -parameters
Filtrar qué parámetros serán añadidos

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: *
Accept pipeline input: false
Accept wildcard characters: false
```

### -UserDescription
Descripción personalizada adicional

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -JsonSchema
Define un esquema personalizado. Especifique una hashtable, donde cada clave es el nombre del parámetro de la función y el valor es el esquema JSON. 
El esquema JSON definido será mezclado en el esquema del parámetro. Las configuraciones definidas en este parámetro tienen prioridad.
Puede especificar un esquema JSON para cada función en -functions, simplemente especificando un array del mismo tamaño. El esquema en el mismo offset es usado.

```yml
Parameter Set: (All)
Type: Hashtable[]
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
