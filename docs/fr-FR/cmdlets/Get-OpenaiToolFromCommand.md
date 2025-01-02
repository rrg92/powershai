---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromCommand

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Convertit des commandes PowerShell en OpenaiTool.

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromCommand [[-functions] <Object>] [[-parameters] <Object>] [[-UserDescription] <Object>] [[-JsonSchema] <Hashtable[]>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -functions
Liste des commandes

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
Filtrer quels paramètres seront ajoutés

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
Description personnalisée supplémentaire

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
Définit un schéma personnalisé. Spécifiez une hashtable, où chaque clé est le nom du paramètre de la fonction et la valeur est le schéma JSON. 
Le schéma JSON défini sera fusionné avec le schéma du paramètre. Les configurations définies dans ce paramètre ont la priorité.
Vous pouvez spécifier un schéma JSON pour chaque fonction dans -functions, il suffit de spécifier un tableau de la même taille. Le schéma au même offset est utilisé.

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
