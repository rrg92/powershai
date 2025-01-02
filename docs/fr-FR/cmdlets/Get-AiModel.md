---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModel

## SYNOPSIS <!--!= @#Synop !-->
Retourne les informations d'un modèle spécifique du cache !

## DESCRIPTION <!--!= @#Desc !-->
Si le modèle existe dans le cache, utilise les données en cache !
S'il n'existe pas, essaie de consulter, si cela n'a pas encore été tenté.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModel [[-ModelName] <Object>] [-MetaDataOnly] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ModelName
Nom du modèle

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
Vérifie seulement dans le fournisseur !

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
