---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Crée un nouvel objet qui représente les paramètres d'un PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
Crée un objet standard contenant tous les paramètres possibles qui peuvent être utilisés dans le chat !
L'utilisateur peut utiliser un get-help New-PowershaiParameters pour obtenir la documentation des paramètres.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] [[-MaxInteractions] <Object>] 
[[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] 
[[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-PromptBuilder] <Object>] [[-PrintToolCalls] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Lorsque vrai, utilise le mode stream, c'est-à-dire que les messages sont affichés au fur et à mesure que le modèle les produit

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Active le mode JSON. Dans ce mode, le modèle est contraint de renvoyer une réponse avec JSON.  
Lorsqu'il est activé, les messages générés via le stream ne sont pas affichés au fur et à mesure de leur production, et seul le résultat final est renvoyé.

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Nom du modèle à utiliser  
Si null, utilise le modèle défini avec Set-AiDefaultModel

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
Maximum de tokens à renvoyer par le modèle

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 2048
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowFullSend
Affiche l'intégralité du prompt qui est envoyé au LLM

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowTokenStats
À la fin de chaque message, affiche les statistiques de consommation, en tokens, renvoyées par l'API

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
Maximum d'interactions à effectuer d'un seul coup  
Chaque fois qu'un message est envoyé, le modèle exécute 1 itération (envoie le message et reçoit une réponse).  
Si le modèle demande un appel de fonction, la réponse générée sera renvoyée au modèle. Cela compte comme une autre interaction.  Esse parâmetro controla o máximo de interações que podem existir em cada chamada.  
Isso ajuda a prevenir loops infinitos inesperados.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 50
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Maximum d'erreurs en séquence généré par Tool Calling.  
En utilisant tool calling, ce paramètre limite combien d'outils sans séquence qui ont échoué peuvent être appelés.  
L'erreur considérée est l'exception déclenchée par le script ou la commande configurée.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 5
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxContextSize
Taille maximale du contexte, en caractères  
À l'avenir, ce sera en tokens  
Contrôle la quantité de messages dans le contexte actuel du chat. Lorsque ce nombre est dépassé, le Powershai nettoie automatiquement les messages les plus anciens.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: 8192
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterFunc
Fonction utilisée pour le formatage des objets passés via pipeline

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: ConvertTo-PowershaiContextOutString
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterParams
Arguments à passer à la ContextFormatterFunc

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowArgs
Si vrai, affiche les arguments des fonctions lorsque le Tool Calling est activé pour exécuter une fonction  
DÉPRÉCIÉ. Sera supprimé bientôt. Utilisez -PrintToolCalls

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolsResults
Affiche les résultats des outils lorsqu'ils sont exécutés par le PowershAI en réponse à l'appel d'outil du modèle

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 13
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -SystemMessageFixed
Message système qui est garanti d'être envoyé à chaque fois, indépendamment de l'historique et du nettoyage du chat !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 14
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Paramètres à passer directement à l'API qui invoque le modèle.  
Le fournisseur doit implémenter le support pour cela.  
Pour l'utiliser, vous devez connaître les détails d'implémentation du fournisseur et comment son API fonctionne !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
```Accept wildcard characters: false
```

### -PromptBuilder
Contrôle le modèle utilisé pour injecter des données de contexte !
Ce paramètre est un scriptblock qui doit retourner une chaîne avec le contexte à injecter dans le prompt !
Les paramètres du scriptblock sont :
	FormattedObject 	- L'objet avec les données du contexte (envoyé via pipe), déjà formaté avec le Formatter configuré
	CmdParams 			- Les paramètres passés à Send-PowershaAIChat. C'est le même objet retourné par GetMyParams
	Chat 				- Le chat dans lequel les données sont envoyées.
S'il est nul, un défaut sera généré. Vérifiez le cmdlet Send-PowershaiChat pour plus de détails

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 16
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolCalls
Contrôle comment les appels d'outils sont affichés par la commande Send-PowershaiChat
Valeurs possibles :
	Aucun			- n'affiche rien lié aux appels d'outils.
	NomSeulement 	- N'affiche que le nom au format FunctionaName{...}, sur une ligne propre.
	NomArguments	- Affiche le nom et les arguments !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 17
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
