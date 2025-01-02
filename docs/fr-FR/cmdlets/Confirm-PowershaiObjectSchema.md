---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Confirm-PowershaiObjectSchema

## SYNOPSIS <!--!= @#Synop !-->
Valide si un objet suit un schéma correct

## DESCRIPTION <!--!= @#Desc !-->
Cette commande valide si la structure d'un objet, ou d'une hashtable, suit un schéma.  
Le schéma est défini dans le paramètre schema, et possède la syntaxe suivante :
	@{	
		# Définir chaque clé attendue dans l'objet !
		Key1 = [string] 		# type de donnée attendu !
		Key2 = "val1","val2" 	# liste de valeurs attendues
		
		# Une clé qui est un objet ! Chaque élément doit spécifier les propriétés de l'objet attendu !
		Key3 = @{
					SubKey1 = [int] # Signifie : Key3.SubKey1 doit être int
				}
				
		# Une clé qui est un tableau !
		Key4 = @{
				'$schema' = "array" # la clé spéciale $schema est une métadonnée qui définit le schéma !
				
				SubKey1 = [string] # Donc, chaque sous-clé est traitée comme 
			}
	}
	
'$schema' doit suivre les mêmes spécifications que l'OpenAPI.
Si $schema est un type, c'est la même chose que de spécifier $schema.type = "array".

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
