---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Confirm-PowershaiObjectSchema

## SYNOPSIS <!--!= @#Synop !-->
Valida si un objeto sigue un esquema correcto

## DESCRIPTION <!--!= @#Desc !-->
Este comando valida si la estructura de un objeto, o hashtable, sigue un esquema.  
El esquema se define en el parámetro schema, y tiene la siguiente sintaxis:
	@{	
		#Definir cada clave esperada en el objeto!
		Key1 = [string] 		# tipo de dato esperado!
		Key2 = "val1","val2" 	# lista de valores esperados
		
		# Una clave que es un objeto! Cada ítem debe especificar las propiedades del objeto esperado!
		Key3 = @{
					SubKey1 = [int] # Significa: Key3.SubKey1 debe ser int
				}
				
		# Una clave que es un array!
		Key4 = @{
				'$schema' = "array" # la clave especial $schema es un metadato que define el esquema!
				
				SubKey1 = [string] # Entonces, cada subclave es tratada como 
			}
	}
	
'$schema' debe seguir las mismas especificaciones de OpenAPI.
Si $schema es un tipo, es lo mismo que especificar $schema.type = "array".

## SYNTAX <!--!= @#Syntax !-->

```
Confirm-PowershaiObjectSchema [[-obj] <Object>] [[-schema] <Object>] [[-parent] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj

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

### -schema

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

### -parent

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
