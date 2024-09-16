---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Crée un nouvel objet représentant les paramètres d'un PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
Crée un objet par défaut contenant tous les paramètres possibles qui peuvent être utilisés dans le chat !
L'utilisateur peut utiliser un get-help New-PowershaiParameters pour obtenir la doc des paramètres.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] 
[[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Lorsque true, utilise le mode stream, c'est-à-dire que les messages sont affichés au fur et à mesure que le modèle les produit

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
Active le mode JSON. En ce mode, le modèle est forcé à retourner une réponse avec JSON.  
Lorsqu'activé, les messages générés via le stream ne sont pas affichés au fur et à mesure qu'ils sont produits, et seul le résultat final est retourné.

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
Maximum de jetons à retourner par le modèle

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
Imprime l'invite entière qui est envoyée au LLM

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
À la fin de chaque message, affiche les statistiques de consommation, en jetons, retournées par l'API

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
Si le modèle demande un function calling, la réponse générée est renvoyée au modèle. Cela compte comme une autre interaction.  
Ce paramètre contrôle le nombre maximum d'interactions qui peuvent exister à chaque appel.
Cela aide à prévenir les boucles infinies inattendues.

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
Maximum d'erreurs en séquence générées par Tool Calling.  
Lorsqu'on utilise le tool calling, ce paramètre limite le nombre de tools sans séquence qui ont abouti à une erreur pouvant être appelées.  
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
À l'avenir, ce sera en jetons 
Contrôle le nombre de messages dans le contexte actuel du chat. Lorsque ce nombre est dépassé, Powershai efface automatiquement les messages les plus anciens.

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
Fonction utilisée pour le formatage des objets passés via le pipeline

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
Arguments à transmettre à ContextFormatterFunc

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
Si true, affiche les arguments des fonctions lorsque Tool Calling est activé pour exécuter une fonction

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
Affiche les résultats des tools lorsqu'elles sont exécutées par PowershAI en réponse au tool calling du modèle

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
System Message qui est garantie d'être toujours envoyée, indépendamment de l'historique et du clenaup du chat !

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
Paramètres à passer directement à l'API qui appelle le modèle.  
Le fournisseur doit implémenter la prise en charge de cela.  
Pour l'utiliser, vous devez connaître les détails d'implémentation du fournisseur et le fonctionnement de son API !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormat
Contrôle le modèle utilisé lors de l'injection de données de contexte !
Ce paramètre est un scriptblock qui doit retourner une chaîne avec le contexte à injecter dans l'invite !
Les paramètres du scriptblock sont :
	FormattedObject 	- L'objet qui représente le chat actif, déjà formaté avec le Formatter configuré
	CmdParams 			- Les paramètres passés à Send-PowershaAIChat. C'est le même objet que celui retourné par GetMyParams
	Chat 				- Le chat dans lequel les données sont envoyées.
Si nul, il générera un par défaut. Consultez le cmdlet Send-PowershaAIChat pour plus de détails

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




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
