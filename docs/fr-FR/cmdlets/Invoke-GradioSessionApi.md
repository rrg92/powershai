---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Crée un nouvel appel vers une extrémité de la session actuelle.

## DESCRIPTION <!--!= @#Desc !-->
Effectue un appel en utilisant l'API Gradio, sur une extrémité spécifique en passant les paramètres souhaités.  
Cet appel générera un GradioApiEvent (voir Send-GradioApi), qui sera enregistré en interne dans les paramètres de la session.  
Cet objet contient tout ce qui est nécessaire pour obtenir le résultat de l'API.  

Le cmdlet retournera un objet de type SessionApiEvent contenant les propriétés suivantes :
	id - Id interne de l'événement généré.
	event - L'événement interne généré. Peut être utilisé directement avec les cmdlets qui manipulent les événements.
	
Les sessions ont une limite d'appels définies.
Le but est d'empêcher la création d'appels indéfinies de manière à perdre le contrôle.

Il existe deux options de la session qui affectent l'appel (peuvent être modifiées avec Set-GradioSession) :
	- MaxCalls 
	Contrôle le nombre maximum d'appels pouvant être créées
	
	- MaxCallsPolicy 
	Contrôle ce qu'il faut faire lorsque le Max est atteint.
	Valeurs possibles :
		- Error 	= génère une erreur !
		- Remove 	= supprime la plus ancienne
		- Warning 	= Affiche un avertissement, mais permet de dépasser la limite.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Nom de l'extrémité (sans la barre initiale)

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
Liste de paramètres 
S'il s'agit d'un tableau, il est passé directement à l'API Gradio 
S'il s'agit d'une table de hachage, il assemble le tableau en fonction de la position des paramètres retournés par /info

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
Si spécifié, il est créé avec un id d'événement existant (il peut avoir été généré en dehors du module).

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
Forcer l'utilisation d'un nouveau jeton. Si "public", alors aucun jeton n'est utilisé !

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
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
