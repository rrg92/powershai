---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiTool

## SYNOPSIS <!--!= @#Synop !-->
Convertit une commande powershell (fonction, etc.) en outil OpenAI

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiTool [[-function] <Object>] [[-UserDescription] <Object>] [[-Parameters] <Object>] [[-Help] <Object>] [[-JsonSchema] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -function
Nom de la fonction, ou objet commande (résultat de Get-Command)

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
Description supplémentaire

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
filtrer les paramètres spécifiques à ajouter

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
Aide de la commande (résultat de get-help)
Vous devez fournir une aide alternative si vous souhaitez créer une aide personnalisée ou si vous voulez obtenir l'aide en raison des cas de portée.

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
Spécifiez un schéma personnalisé pour chaque paramètre de fonction 
Ce schéma JSON sera fusionné avec le schéma généré à l'origine, ayant la priorité, par exemple : si le personnalisé a la clé description, et dans l'original, celui du personnalisé est utilisé.
La fusion se fait de manière récursive, c'est-à-dire que les propriétés qui sont des objets sont également fusionnées.
Spécifiez une clé pour chaque paramètre.

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
