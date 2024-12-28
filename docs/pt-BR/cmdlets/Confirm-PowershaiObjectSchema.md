---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Confirm-PowershaiObjectSchema

## SYNOPSIS <!--!= @#Synop !-->
Valida se um objeto segue um schema correto

## DESCRIPTION <!--!= @#Desc !-->
Este comando valida se a estrutura deum objeto, ou hashtable, segue um schema.  
O schema Ã© definindo no parametro scehma, e possui a seguinte sintaxe:
	@{	
		#Definir cada key esperada no objeto!
		Key1 = [string] 		# tipo de dado esperado!
		Key2 = "val1","val2" 	# lista de valores esperados
		
		# Uma key que Ã© um objeto! Cada item deve especificar as props do objeto esperado!
		Key3 = @{
					SubKey1 = [int] # Significa: Key3.SubKey1 deve ser int
				}
				
		# Uma key que Ã© um array!
		Key4 = @{
				'$schema' = "array" # a key especial $schema Ã© uma metadado que define o schema!
				
				SubKey1 = [string] # Entao, cada subkey Ã© tratado como 
			}
	}
	
'$schema' deve seguir as mesmas especificacoes da OpenaAPI.
Se $schema for um type, Ã© o meso que especificr $schema.type = "array".

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