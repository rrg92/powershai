---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModel

## SYNOPSIS <!--!= @#Synop !-->
Devuelve la información de un modelo específico de la caché!

## DESCRIPTION <!--!= @#Desc !-->
Si el modelo existe en caché, utiliza los datos en caché!
Si no existe, intenta consultar, en caso de que no se haya intentado aún.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModel [[-ModelName] <Object>] [-MetaDataOnly] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ModelName
Nombre del modelo

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

### -MetaDataOnly
¡Verifica solo en el proveedor!

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
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
