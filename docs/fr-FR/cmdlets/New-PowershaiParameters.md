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
L'utilisateur peut utiliser un get-help New-PowershaiParameters pour obtenir la doc des paramètres.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] 
<Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Quand true, utilise le mode stream, c'est-à-dire que les messages sont affichés au fur et à mesure que le modèle les produit

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
Active le mode JSON. Dans ce mode, le modèle est forcé à renvoyer une réponse avec JSON.  
Quand activé, les messages générés via stream ne sont pas affichés au fur et à mesure qu'ils sont produits, et seul le résultat final est renvoyé.

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
Maximum de jetons à renvoyer par le modèle

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
Affiche l'intégralité de l'invite qui est envoyée au LLM

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
À la fin de chaque message, affiche les statistiques de consommation, en jetons, renvoyées par l'API

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
Maximum d'interactions à effectuer en une seule fois 
Chaque fois qu'un message est envoyé, le modèle exécute 1 itération (envoie le message et reçoit une réponse).  
Si le modèle demande un appel de fonction, la réponse générée est renvoyée au modèle. Cela compte comme une autre interaction.  
Ce paramètre contrôle le maximum d'interactions qui peuvent exister à chaque appel.
Cela permet de prévenir les boucles infinies inattendues.

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
Lors de l'utilisation de tool calling, ce paramètre limite le nombre d'outils sans séquence qui ont entraîné une erreur et peuvent être appelés.  
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
Contrôle la quantité de messages dans le contexte actuel du chat. Lorsque ce nombre est dépassé, Powershai nettoie automatiquement les messages les plus anciens.

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
Fonction utilisée pour la mise en forme des objets passés via le pipeline

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
Arguments à passer à ContextFormatterFunc

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
Affiche les résultats des outils lorsqu'ils sont exécutés par PowershAI en réponse à l'appel d'outil du modèle

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
System Message qui est garantie d'être envoyée à chaque fois, indépendamment de l'historique et du nettoyage du chat !

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
Le fournisseur doit implémenter la prise en charge de ceci.  
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
Accept wildcard characters: false
```

### -ContextFormat
Contrôle le modèle utilisé lors de l'injection des données de contexte !
Ce paramètre est un scriptblock qui doit renvoyer une chaîne de caractères avec le contexte à injecter dans l'invite !
Les paramètres du scriptblock sont :
	FormattedObject 	- L'objet qui représente le chat actif, déjà formaté avec le formatteur configuré
	CmdParams 			- Les paramètres passés à Send-PowershaAIChat. C'est le même objet que celui renvoyé par GetMyParams
	Chat 				- Le chat dans lequel les données sont envoyées.
Si nul, il générera un défaut. Vérifiez le cmdlet Send-PowershaAIChat pour plus de détails

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
_Traduit automatiquement à l'aide de PowershAI et de l'IA. 
_
<!--PowershaiAiDocBlockEnd-->
