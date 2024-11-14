---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Envoie un message dans un chat Powershai

## DESCRIPTION <!--!= @#Desc !-->
Ce cmdlet permet d'envoyer un nouveau message au LLM du fournisseur actuel.  
Par défaut, il envoie dans le chat actif. Vous pouvez remplacer le chat en utilisant le paramètre -Chat. S'il n'y a pas de chat actif, il utilisera le par défaut.  

Divers paramètres du chat affectent ce commande. Voir la commande Get-PowershaiChatParameter pour plus d'infos sur les paramètres du chat.  
En plus des paramètres du chat, les propres paramètres de la commande peuvent remplacer le comportement. Pour plus de détails, consultez la documentation de chaque paramètre de ce cmdlet en utilisant get-help.  

Pour simplifier et garder la ligne de commande propre, permettant à l'utilisateur de se concentrer davantage sur l'invite et les données, certains alias sont disponibles.  
Ces alias peuvent activer certains paramètres.
Ils sont :
	ia|ai
		Abbréviation de "Intelligence Artificielle" en français. C'est un alias simple et ne change aucun paramètre. Il aide à réduire considérablement la ligne de commande.
	
	iat|ait
		Identique à Send-PowershaAIChat -Temporary
		
	io|ao
		Identique à Send-PowershaAIChat -Object
		
	iam|aim 
		Identique à Send-PowershaiChat -Screenshot 

L'utilisateur peut créer ses propres alias. Par exemple :
	Set-Alias ki ia # Définit l'alias pour l'allemand !
	Set-Alias kit iat # Définit l'alias kit pour iat, rendant le comportement identique à iat (chat temporaire) lorsqu'il utilise kit !

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] 
[-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] 
[-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
le prompt à envoyer au modèle

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
Ce paramètre est à utiliser de préférence par le pipeline.
Il fera en sorte que la commande place les données dans des balises <contexto></contexto> et les injectera avec le prompt.

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
Force le cmdlet à s'exécuter pour chaque objet du pipeline
Par défaut, il accumule tous les objets dans un tableau, convertit le tableau en chaîne et envoie tout d'un coup au LLM.

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
dans ce mode, les résultats retournés seront toujours un JSON.
Le modèle actuel doit le supporter !

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
La commande n'écrira rien à l'écran et retournera les résultats sous forme d'objet !
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
Montre les données de contexte envoyées au LLM avant la réponse !
C'est utile pour déboguer ce qui est injecté comme données dans le prompt.

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
Ne pas envoyer les conversations précédentes (l'historique de contexte), mais inclure le prompt et la réponse dans l'historique du contexte.

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
Ignorer la réponse du LLM et ne pas inclure le prompt dans l'historique du contexte

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
Ne pas envoyer l'historique et ne pas inclure la réponse et le prompt.  
C'est identique à passer -Forget et -Snub ensemble.

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
Désactive l'appel de fonction pour cette exécution seulement !

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
Modifier le formateur de contexte pour celui-ci
Voir plus sur Format-PowershaiContext

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
Retourne les messages dans le pipeline, sans écrire directement à l'écran !
Cette option suppose que l'utilisateur sera responsable de donner la bonne destination au message !
L'objet passé au pipeline aura les propriétés suivantes :
	text 			- Le texte (ou extrait) du texte retourné par le modèle 
	formatted		- Le texte formaté, incluant le prompt, comme s'il était écrit directement à l'écran (sans les couleurs)
	event			- L'événement. Indique l'événement qui a été à l'origine. Ce sont les mêmes événements documentés dans Invoke-AiChatTools
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

### -Lines
Retourne un tableau de lignes 
Si le mode stream est activé, retournera une ligne à la fois !

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

### -ChatParamsOverride
Remplacer les paramètres du chat !
Spécifiez chaque option dans des hashtables !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Spécifie directement la valeur du paramètre de chat RawParams !
S'il est également spécifié dans ChatParamOverride, un merge est effectué, donnant la priorité aux paramètres spécifiés ici.
Le RawParams est un paramètre de chat qui définit les paramètres qui seront envoyés directement à l'API du modèle !
Ces paramètres vont remplacer les valeurs par défaut calculées par powershai !
Cela permet à l'utilisateur d'avoir un contrôle total sur les paramètres, mais nécessite de connaître chaque fournisseur !
De plus, chaque fournisseur est responsable de fournir cette implémentation et d'utiliser ces paramètres dans son API.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
Capture une capture d'écran de l'écran derrière la fenêtre de PowerShell et l'envoie avec le prompt. 
Notez que le mode actuel doit supporter les images (modèles de langage vision).

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
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
