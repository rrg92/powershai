---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiEmbeddings

## SYNOPSIS <!--!= @#Synop !-->
¡Obtiene embeddings de una o más entradas de texto!

## DESCRIPTION <!--!= @#Desc !-->
¡Esta función obtiene embeddings utilizando un modelo que soporta embeddings!

## PARA PROVIDERS
	Los proveedores que deseen exportar esta funcionalidad deben implementar la interfaz GetEmbeddings
	Resultado esperado:
		un array donde cada ítem es un objeto que contiene:
			- embeddings: el embedding generado.
			- texto: el texto de origen, si se informó el parámetro incluir texto.
			
		se debe generar el embedding en el mismo orden del texto en que fue informado!

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiEmbeddings [[-text] <String[]>] [-IncludeText] [[-model] <Object>] [[-BatchSize] <Object>] [[-dimensions] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -text
¡Array de textos a ser generados!

```yml
Parameter Set: (All)
Type: String[]
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -IncludeText
¡Incluir el texto en la respuesta!

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

### -model
modelo

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

### -BatchSize
¡Máximo de embeddings para procesar de una sola vez!

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

### -dimensions
Número de dimensiones 
¡Si es null, usará el valor predeterminado de cada proveedor!
¡No todos los proveedores soportan definir. Si no se soporta, se dispara un error!

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
