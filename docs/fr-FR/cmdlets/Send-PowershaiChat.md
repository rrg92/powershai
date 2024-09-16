---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Envoie un message dans un chat Powershai

## DESCRIPTION <!--!= @#Desc !-->
Cette cmdlet vous permet d'envoyer un nouveau message au LLM du fournisseur actuel.  
Par défaut, il envoie dans le chat actif. Vous pouvez remplacer le chat en utilisant le paramètre -Chat.  S'il n'y a pas de chat actif, il utilisera le chat par défaut.  

Divers paramètres du Chat affectent le fonctionnement de cette commande. Consultez la commande Get-PowershaiChatParameter pour plus d'informations sur les paramètres du chat.  
En plus des paramètres du chat, les paramètres de la commande elle-même peuvent remplacer le comportement.  Pour plus de détails, consultez la documentation de chaque paramètre de cette cmdlet en utilisant get-help.  

Pour des raisons de simplicité, et pour garder la ligne de commande propre, permettant à l'utilisateur de se concentrer davantage sur l'invite et les données, des alias sont disponibles.  
Ces alias peuvent activer certains paramètres.
Ce sont:
	ia|ai
		Abréviation d'"intelligence artificielle" en français. Il s'agit d'un alias simple qui ne modifie aucun paramètre. Il contribue à réduire considérablement la ligne de commande.
	
	iat|ait
		Identique à Send-PowershaAIChat -Temporary
		
	io|ao
		Identique à Send-PowershaAIChat -Object

L'utilisateur peut créer ses propres alias. Par exemple:
	Set-Alias ki ia # Définit l'alias pour l'allemand !
	Set-Alias kit iat # Définit l'alias kit pour iat, faisant le comportement identique à iat (chat temporaire) lorsqu'il est utilisé !

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] 
[-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
l'invite à envoyer au modèle

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

### -SystemMessages
Message système à inclure

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
Le contexte 
Ce paramètre est destiné à être utilisé de préférence par le pipeline.
Il fera en sorte que la commande place les données dans des balises <contexte></contexte> et les injectera dans l'invite.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
Force la cmdlet à s'exécuter pour chaque objet du pipeline
Par défaut, il cumule tous les objets dans un tableau, convertit le tableau en chaîne et l'envoie en une seule fois au LLM.

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

### -Json
Active le mode json 
dans ce mode, les résultats renvoyés seront toujours un JSON.
Le modèle actuel doit le prendre en charge !

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

### -Object
Mode Object !
dans ce mode, le mode JSON sera activé automatiquement !
La commande n'écrira rien à l'écran et renverra les résultats sous forme d'objet !
Qui seront renvoyés dans le pipeline !

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

### -PrintContext
Affiche les données de contexte envoyées au LLM avant la réponse !
Cela est utile pour déboguer ce qui est injecté dans l'invite.

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

### -Forget
N'envoie pas les conversations précédentes (l'historique du contexte), mais inclut l'invite et la réponse dans l'historique du contexte.

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

### -Snub
Ignore la réponse du LLM et n'inclut pas l'invite dans l'historique du contexte.

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

### -Temporary
N'envoie pas l'historique et n'inclut pas non plus la réponse et l'invite.  
C'est la même chose que de passer -Forget et -Snub ensemble.

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

### -DisableTools
Désactive l'appel de fonction pour cette exécution uniquement !

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
Modifie le formateur de contexte pour celui-ci
En savoir plus dans Format-PowershaiContext

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

### -FormatterParams
Paramètres du formateur de contexte modifié.

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

### -PassThru
Renvoie les messages dans le pipeline, sans écrire directement à l'écran !
Cette option suppose que l'utilisateur sera responsable de la destination correcte du message !
L'objet passé au pipeline aura les propriétés suivantes :
	text 			- Le texte (ou l'extrait) du texte renvoyé par le modèle 
	formatted		- Le texte formaté, y compris l'invite, comme s'il était écrit directement à l'écran (sans les couleurs)
	event			- L'événement. Indique l'événement à l'origine. Ce sont les mêmes événements documentés dans Invoke-AiChatTools
	interaction 	- L'objet interaction généré par Invoke-AiChatTools

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
