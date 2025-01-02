---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiEmbeddings

## SYNOPSIS <!--!= @#Synop !-->
Obtient des embeddings d'une ou plusieurs entrées de texte !

## DESCRIPTION <!--!= @#Desc !-->
Cette fonction obtient des embeddings en utilisant un modèle prenant en charge les embeddings !

## POUR PROVIDERS
	Les fournisseurs qui souhaitent exporter cette fonctionnalité doivent implémenter l'interface GetEmbeddings
	Résultat attendu :
		un tableau où chaque élément est un objet contenant :
			- embeddings : l'embedding généré.
			- texte : le texte d'origine, si le paramètre include text a été spécifié.
			
		l'embedding doit être généré dans le même ordre que le texte dans lequel il a été fourni !

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiEmbeddings [[-text] <String[]>] [-IncludeText] [[-model] <Object>] [[-BatchSize] <Object>] [[-dimensions] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -text
Tableau de textes à générer !

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
Inclure le texte dans la réponse !

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
modèle

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
Max embeddings à traiter d'un seul coup !

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
Nombre de dimensions 
Si null, utilisera la valeur par défaut de chaque fournisseur !
Tous les fournisseurs ne prennent pas en charge la définition. Si non pris en charge, une erreur est déclenchée !

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
