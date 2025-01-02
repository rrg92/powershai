---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Envoie des données à un Gradio et renvoie un objet représentant l'événement !  
Passez cet objet aux autres cmdlets pour obtenir les résultats.

FONCTIONNEMENT DE L'API GRADIO 

	Base sur : https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	Pour mieux comprendre comment utiliser ce cmdlet, il est important de comprendre comment l'API Gradio fonctionne.  
	Lorsque nous invoquons un point de terminaison de l'API, il ne renvoie pas immédiatement les données.  
	Cela est dû au simple fait que le traitement est long, en raison de la nature (IA et apprentissage automatique).  
	
	Alors, au lieu de retourner le résultat, ou d'attendre indéfiniment, Gradio renvoie un "Event Id".  
	Avec cet événement, nous pouvons obtenir périodiquement les résultats générés.  
	Gradio va générer des messages d'événements avec les données qui ont été générées. Nous devons passer l'EventId généré pour obtenir les nouveaux morceaux générés.  
	Ces événements sont envoyés via des événements côté serveur (SSE), et peuvent être l'un de ceux-ci :
		- heartbeat 
		Chaque 15 secondes, Gradio enverra cet événement pour maintenir la connexion active.  
		C'est pourquoi, en utilisant le cmdlet Update-GradioApiResult, il peut falloir un certain temps pour retourner.
		
		- complete 
		C'est le dernier message envoyé par Gradio lorsque les données ont été générées avec succès !
		
		- error 
		Envoyé lorsqu'il y a eu une erreur dans le traitement.  
		
		- generating
		Il est généré lorsque l'API a déjà des données disponibles, mais il peut encore y en avoir plus.
	
	Ici dans PowershAI, nous avons également séparé cela en 3 parties : 
		- Ce cmdlet (Send-GradioApi) fait la requête initiale à Gradio et renvoie un objet représentant l'événement (nous l'appelons un objet GradioApiEvent)
		- Cet objet résultant, de type GradioApiEvent, contient tout ce qui est nécessaire pour interroger l'événement et il garde également les données et les erreurs obtenues.
		- Enfin, nous avons le cmdlet Update-GradioApiResult, où vous devez passer l'événement généré, et il interrogera l'API de Gradio et obtiendra les nouvelles données.  
			Consultez l'aide de ce cmdlet pour plus d'informations sur la façon de contrôler ce mécanisme pour obtenir les données.
			
	
	Alors, dans un flux normal, vous devez faire ce qui suit : 
	
		#Invoquez le point de terminaison de Gradio !
		$MonÉvénement = Send-GradioApi ... 
	
		# Obtenez les résultats jusqu'à ce que cela soit terminé !
		# Vérifiez l'aide de ce cmdlet pour en savoir plus !
		$MonÉvénement | Update-GradioApiResult
		
Objet GradioApiEvent

	L'objet GradioApiEvent résultant de ce cmdlet contient tout ce qui est nécessaire pour que PowershAI contrôle le mécanisme et obtienne les données.  
	Il est important que vous connaissiez sa structure pour savoir comment collecter les données générées par l'API.  
Propriétés :
	
		- Status  
		Indique le statut de l'événement.  
		Lorsque ce statut est "complete", cela signifie que l'API a déjà terminé le traitement et que toutes les données possibles ont déjà été générées.  		Tant que cela est différent, vous devez invoquer Update-GradioApiResult pour qu'il vérifie le statut et mette à jour les informations. 
		
		- QueryUrl  
		Valeur interne qui contient le point de terminaison exact pour la consultation des résultats
		
		- data  
		Un tableau contenant toutes les données de réponse générées. Chaque fois que vous invoquez Update-GradioApiResult, s'il y a des données, il les ajoutera à ce tableau.  
		
		- events  
		Liste des événements qui ont été générés par le serveur. 
		
		- error  
		Si des erreurs se sont produites dans la réponse, ce champ contiendra un objet, une chaîne, etc., décrivant plus de détails.
		
		- LastQueryStatus  
		Indique le statut de la dernière requête à l'API.  
		Si "normal", cela indique que l'API a été consultée et a retourné jusqu'à la fin normalement.
		Si "HeartBeatExpired", cela indique que la requête a été interrompue en raison du délai d'expiration de heartbeat configuré par l'utilisateur dans le cmdlet Update-GradioApiResult
		
		- req 
		Données de la requête faite !

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] [[-token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

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

### -ApiName

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

### -Params

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

### -SessionHash

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

### -EventId
Si renseigné, n'appelle pas l'API, mais crée l'objet et utilise cette valeur comme si c'était le retour

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

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
