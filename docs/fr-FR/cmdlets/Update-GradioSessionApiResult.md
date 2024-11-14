---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
Met à jour le retour d'un appel généré comme Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
Ce cmdlet suit le même principe que ses équivalents dans Send-GradioApi et Update-GradioApiResult.
Cependant, il fonctionne uniquement pour les événements générés dans une session spécifique.
Il retourne l'événement lui-même afin qu'il puisse être utilisé avec d'autres cmdlets qui dépendent de l'événement mis à jour !

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
Identifiant de l'événement, retourné par Invoke-GradioSessionApi ou l'objet retourné lui-même.

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

### -NoOutput
Ne pas renvoyer le résultat dans la sortie !

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

### -MaxHeartBeats
Max battements consécutifs.

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

### -session
Identifiant de la session

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -History
Ajoute les événements à l'historique des événements de l'objet GradioApiEvent spécifié dans -Id

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
_Traduit automatiquement à l'aide de PowershAI et de l'IA._
<!--PowershaiAiDocBlockEnd-->
