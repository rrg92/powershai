---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Envoie des messages à un LLM et retourne la réponse

## DESCRIPTION <!--!= @#Desc !-->
C'est la forme la plus basique de Chat promue par PowershAI.  
Avec cette fonction, vous pouvez envoyer un message à un LLM du fournisseur actuel.  

Cette fonction est un accès à un LLM à un niveau plus bas, de manière standardisée, que powershai met à disposition.  
Elle ne gère pas l'historique ou le contexte. Elle est utile pour invoquer des prompts simples, qui ne nécessitent pas plusieurs interactions comme dans un Chat. 
Bien qu'elle supporte le Functon Calling, elle n'exécute aucun code, et ne retourne que la réponse du modèle.

** INFORMATIONS POUR FOURNISSEURS
	Le fournisseur doit implémenter la fonction Chat pour que cette fonctionnalité soit disponible. 
	La fonction chat doit retourner un objet avec la réponse selon la même spécification que OpenAI, fonction Chat Completion.
	Les liens suivants servent de base :
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (retour sans streaming)
	Le fournisseur doit implémenter les paramètres de cette fonction. 
	Consultez la documentation de chaque paramètre pour des détails et comment mapper à un fournisseur ;
	
	Lorsque le modèle ne prend pas en charge l'un des paramètres fournis (c'est-à-dire, qu'il n'y a pas de fonctionnalité équivalente, ou qui peut être implémentée de manière équivalente) une erreur doit être retournée.
	Les paramètres qui ne sont pas transmis au fournisseur auront une description l'informant !

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] 
<Object>] [-IncludeRawResp] [[-Check] <Object>] [[-Retries] <Object>] [-ContentOnly] [[-ProviderRawParams] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Le prompt à envoyer. Doit être au format décrit par la fonction ConvertTo-OpenaiMessage

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

### -temperature
Température du modèle

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Nom du modèle. S'il n'est pas spécifié, utilise le défaut du fournisseur.

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

### -MaxTokens
Nombre maximum de tokens à retourner

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
Format de la réponse Les formats acceptables, et le comportement, doivent suivre le même que celui de OpenAI : https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format  
Raccourcis :  
	"json"|"json_object", équivaut à {"type": "json_object"}  
	l'objet doit spécifier un schéma comme s'il était passé directement à l'API de OpenAI, dans le champ response_format.json_schema  

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

### -Functions  
Liste des outils qui doivent être invoqués !  
Vous pouvez utiliser des commandes comme Get-OpenaiTool*, pour transformer des fonctions powershell facilement dans le format attendu !  
Si le modèle invoque la fonction, la réponse, tant en flux qu'en normal, doit également suivre le modèle d'appel d'outil de OpenAI.  
Ce paramètre doit suivre le même schéma que l'appel de fonction de OpenAI : https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools  

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams  
Spécifiez des paramètres directs de l'API du fournisseur.  
Cela écrasera les valeurs qui ont été calculées et générées sur la base des autres paramètres.  

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback  
Active le mode Stream  
Vous devez spécifier un ScriptBlock qui sera invoqué pour chaque texte généré par le LLM.  
Le script doit recevoir un paramètre qui représente chaque morceau, dans le même format de streaming retourné  
	Ce paramètre est un objet qui contiendra la propriété choices, qui est dans le même schéma retourné par le streaming de OpenAI :  
		https://platform.openai.com/docs/api-reference/chat/streaming  

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -IncludeRawResp  
Inclure la réponse de l'API dans un champ appelé IncludeRawResp  
 Les paramètres suivants ne sont pas transmis aux fournisseurs !  

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

### -Check  
Valide la réponse et si elle n'est pas comme attendu, essaie à nouveau !  
Peut être une chaîne ou un scriptblock  
N'est pas transmis au fournisseur !  

```yml
Parameter Set: (All)
Type: Object
Aliases: CheckLike,CheckRegex,CheckJson
Accepted Values: 
Required: false
Position: 9
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Retries  
Max tentatives si le Check échoue  
N'est pas transmis au fournisseur !  

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 1
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContentOnly  Retourné uniquement le texte de la réponse.
Il n'est pas transmis au fournisseur !

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

### -ProviderRawParams
Spécifie les paramètres bruts par fournisseur. Cela a la priorité sur -RawParams (si 2 paramètres avec le même nom (et chemin) sont spécifiés).
Vous devez spécifier une hashtable et chaque clé est le nom du fournisseur. Alors, la valeur de chaque clé est la même que ce que vous spécifieriez dans -RawParams.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
