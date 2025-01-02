---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiDefaultCredential

## SYNOPSIS <!--!= @#Synop !-->
Obtient la crédential par défaut du fournisseur actuel !

## DESCRIPTION <!--!= @#Desc !-->
Obtient la crédential par défaut. 
Ce cmdlet doit être utilisé principalement par les fournisseurs, lorsqu'ils ont besoin de s'authentifier. 
Cependant, il est exposé publiquement pour permettre à l'utilisateur de vérifier les crédentials actifs et de faire un minimum de dépannage.

Le cmdlet va obtenir la crédential par défaut à partir de ce qui a été défini par l'utilisateur et aussi en vérifiant certaines des variables d'environnement, si elles sont prises en charge par le fournisseur.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiDefaultCredential [-IgnoreNotExists] [[-MigrateScript] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -IgnoreNotExists
S'il n'existe pas, ignore, au lieu de provoquer une erreur !

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

### -MigrateScript
Script pour migrer des crédentials existants.
Utilisé exclusivement par les fournisseurs. 
Chaque fournisseur peut spécifier un script qui doit retourner des objets AiCredential créés avec NewAiCredential.

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


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
