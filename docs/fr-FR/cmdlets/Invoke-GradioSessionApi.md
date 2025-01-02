---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Crée un nouvel appel à un point de terminaison dans la session actuelle.

## DESCRIPTION <!--!= @#Desc !-->
Effectue un appel en utilisant l'API de Gradio, à un point de terminaison spécifique et en passant les paramètres souhaités.  
Cet appel générera un GradioApiEvent (voir Send-GradioApi), qui sera sauvegardé en interne dans les configurations de la session.  
Cet objet contient tout ce qui est nécessaire pour obtenir le résultat de l'API.  

Le cmdlet renverra un objet de type SessionApiEvent contenant les propriétés suivantes :
	id - Id interne de l'événement généré.
	event - L'événement interne généré. Peut être utilisé directement avec les cmdlets qui manipulent des événements.
	
Les sessions ont une limite d'appels définie.
L'objectif est d'empêcher de créer des appels indéfinis de manière à perdre le contrôle.

Il existe deux options de session qui affectent l'appel (peuvent être modifiées avec Set-GradioSession) :
	- MaxCalls 
	Contrôle le maximum d'appels pouvant être créés
	
	- MaxCallsPolicy 
	Contrôle ce qu'il faut faire lorsque le maximum est atteint.
	Valeurs possibles :
		- Error 	= entraîne une erreur !
		- Remove 	= supprime le plus ancien 
		- Warning 	= Affiche un avertissement, mais permet de dépasser la limite.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Nom du point de terminaison (sans le slash initial)

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

### -Params
Liste des paramètres 
S'il s'agit d'un tableau, passe directement à l'API de Gradio 
S'il s'agit d'une hashtable, construit le tableau en fonction de la position des paramètres retournés par /info

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

### -EventId
S'il est spécifié, crée avec un identifiant d'événement déjà existant (peut avoir été généré en dehors du module).

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

### -session
Session

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
Forcer l'utilisation d'un nouveau token. Si "public", alors n'utilise aucun token !

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
