---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Supprime les appels d'API de la liste interne de la session

## DESCRIPTION <!--!= @#Desc !-->
Cette cmdlet aide à supprimer les événements générés par Invoke-GradioSessionApi de la liste interne des appels. 
Normalement, vous souhaitez supprimer les événements que vous avez déjà traités, en passant l'ID directement.  
Cependant, cette cmdlet vous permet d'effectuer plusieurs types de suppression, y compris des événements non traités.  
Utilisez-la avec prudence, car une fois qu'un événement est supprimé de la liste, les données qui lui sont associées sont également supprimées.  
À moins que vous n'ayez fait une copie de l'événement (ou des données résultantes) dans une autre variable, vous ne pourrez plus récupérer ces informations.  

La suppression d'événements est également utile pour aider à libérer la mémoire consommée, qui, en fonction du nombre d'événements et de données, peut être élevée.

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
Spécifie l'événement ou les événements à supprimer
L'ID peut également être l'une de ces valeurs spéciales :
	clean 	- Supprime uniquement les appels qui ont déjà été terminés !
  all 	- Supprime tout, y compris ce qui n'est pas terminé !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
Par défaut, seuls les événements passés avec le statut « completed » sont supprimés !
Utilisez -Force pour supprimer indépendamment du statut !

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

### -Elegible
Ne fait aucune suppression, mais renvoie les candidats !

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

### -session
ID de la session

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -WhatIf

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: wi
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Confirm

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: cf
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
