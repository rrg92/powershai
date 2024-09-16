---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioApiResult

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Met à jour un événement retourné par Send-GradioApi avec de nouveaux résultats du serveur et, par défaut, renvoie les evenots dans le pipeline.

Les résultats des API Gradio ne sont pas générés instantanément, comme c'est le cas pour la plupart des services HTTP REST.  
L'aide de la commande Send-GradioApi explique en détail comment fonctionne le processus.  

Cette commande doit être utilisée pour mettre à jour l'objet GradioApiEvent, retourné par Send-GradioApi.
Cet objet représente la réponse de chaque appel que vous faites à l'API, il contient tout ce qu'il faut pour interroger le résultat, y compris les données et l'historique.

En gros, ce cmdlet fonctionne en invoquant le point de terminaison de la requête de statut de l'appel d'API.
Les paramètres nécessaires à la requête sont disponibles dans l'objet lui-même passé au paramètre -ApiEvent (qui est créé et retourné par le cmdlet Send-GradioApi)

Chaque fois que ce cmdlet s'exécute, il communique via une connexion HTTP persistante avec le serveur et attend les événements.  
Au fur et à mesure que le serveur envoie les données, il met à jour l'objet passé au paramètre -ApiEvent et, par défaut, écrit l'événement retourné dans le pipeline.

L'événement retourné est un objet de type GradioApiEventResult et représente un événement généré par la réponse à l'exécution de l'API.  

Si le paramètre -History est spécifié, tous les événements générés sont stockés dans la propriété events de l'objet fourni à -ApiEvent, ainsi que les données retournées.

En gros, les événements générés peuvent envoyer un signal ou des données.

OBJETS GradioApiEventResult
	num 	= numéro séquentiel de l'événement. commence à 1.
	ts 		= date à laquelle l'événement a été créé (date locale, pas du serveur).
	event 	= nom de l'événement
	data 	= données retournées dans cet événement

DONNÉES (DATA)

	Pour obtenir les données de Gradio, il suffit de lire les événements retournés par ce cmdlet et de regarder dans la propriété data de GradioApiEventResult
	En général, l'interface de Gradio écrase le champ avec le dernier événement reçu.  
	
	Si -History est utilisé, en plus d'écrire dans le pipeline, le cmdlet va stocker la donnée dans le champ data, et donc, vous aurez accès à l'historique complet de ce qui a été généré par le serveur.  
	Notez que cela peut entraîner une consommation de mémoire supplémentaire, si beaucoup de données sont retournées.
	
	Il existe un cas "problématique" connu : éventuellement, gradio peut émettre les 2 derniers événements avec la même donnée (1 événement aura le nom "generating", et le dernier sera complete).  
	Nous n'avons pas encore de solution pour séparer cela de manière sécurisée, et c'est pourquoi, l'utilisateur doit décider de la meilleure façon de procéder.  
	Si vous utilisez toujours le dernier événement reçu, ce n'est pas un problème.
	Si vous devez utiliser tous les événements au fur et à mesure qu'ils sont générés, vous devrez traiter ces cas.
	Un exemple simple serait de comparer le contenu, si c'était le même, ne pas répéter. Mais il peut exister des scénarios où 2 événements avec le même contenu, malgré tout, sont des événements logiquement différents.
	
	

SIGNAL 

	L'un des événements générés par l'API Gradio sont les signaux.  
	Toutes les 15 secondes, Gradio envoie un événement de type "HeartBeat", juste pour maintenir la connexion active.  
	Cela fait que le cmdlet "bloque", car, comme la connexion HTTP est active, il attend une réponse (qui sera des données, des erreurs ou le signal).
	
	S'il n'y a pas de mécanisme de contrôle, le cmdlet fonctionnerait indéfiniment, sans possibilité d'annuler, même avec CTRL + C.
	Pour résoudre ce problème, ce cmdlet met à disposition le paramètre MaxHeartBeats.  
	Ce paramètre indique combien d'événements de signal consécutifs seront tolérés avant que le cmdlet cesse d'essayer de consulter l'API.  
	
	Par exemple, considérez ces deux scénarios d'événements envoyés par le serveur :
	
		scénario 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		scénario 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	Considérant la valeur par défaut, 2, dans le scénario 1, le cmdlet ne se terminerait jamais avant complete, car il n'y a jamais eu 2 signaux consécutifs.
	
	Dans le scénario 2, après avoir reçu 2 événements de données (generating), au quatrième événement (heartbeat), il se termine, car 2 signaux consécutifs ont été envoyés.  
	On dit que le signal a expiré, dans ce cas.
	Dans ce cas, vous devriez à nouveau appeler Update-GradioApiResult pour obtenir le reste.
	
	Chaque fois que la commande se termine en raison d'une expiration du signal, elle met à jour la valeur de la propriété LastQueryStatus à HeartBeatExpired.  
	Avec cela, vous pouvez vérifier et traiter correctement quand vous devez appeler à nouveau
	
	
STREAM  
	
	En raison du fait que l'API Gradio répond déjà en utilisant SSE (Server Side Events), il est possible d'utiliser un effet similaire au "stream" de nombreuses API.  
	Ce cmdlet, Update-GradioApiResult, traite déjà les événements du serveur en utilisant SSE.  
	En plus, si vous voulez aussi faire un traitement au fur et à mesure que l'événement devient disponible, vous pouvez utiliser le paramètre -Script et spécifier un scriptblock, des fonctions, etc. qui sera invoqué au fur et à mesure que l'événement est reçu.  
	
	En combinant avec le paramètre -MaxHeartBeats, vous pouvez créer un appel qui met à jour quelque chose en temps réel. 
	Par exemple, s'il s'agit d'une réponse d'un chatbot, vous pouvez écrire immédiatement à l'écran.
	
	notez que ce paramètre est appelé en séquence avec le code qui vérifie (c'est-à-dire le même thread).  
	Par conséquent, les scripts qui prennent beaucoup de temps peuvent gêner la détection de nouveaux événements et, par conséquent, la livraison des données.
	
.

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiEvent
Résultat de  Send-GradioApi

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

### -Script
script qui sera invoqué  à chaque événement généré !
Reçoit une table de hachage avec les clés suivantes :
 	event - contient l'événement généré. event.event est le nom de l'événement. event.data sont les données retournées.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxHeartBeats
Nombre maximal de signaux consécutifs avant l'arrêt !
Fait que la commande n'attende que ce nombre de signaux consécutifs du serveur.
Lorsque le serveur envoie cette quantité, le cmdlet se termine et définit le LastQueryStatus de l'événement sur HeartBeatExpired

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoOutput
N'écrit pas le résultat à la sortie du cmdlet

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

### -History
Conserve l'historique des événements et des données dans l'objet ApiEvent
Notez que cela entraînera une consommation de mémoire supplémentaire de PowerShell !

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
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
