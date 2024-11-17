---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Envoie des messages à un LLM et retourne la réponse

## DESCRIPTION <!--!= @#Desc !-->
Ceci est la forme la plus basique de Chat promue par PowershAI.  
Avec cette fonction, vous pouvez envoyer un message à un LLM du fournisseur actuel.  

Cette fonction est un accès à un LLM à un niveau plus bas, de manière standardisée, que PowershAI met à disposition.  
Elle ne gère pas l'historique ou le contexte. Elle est utile pour invoquer des prompts simples, qui ne nécessitent pas plusieurs interactions comme dans un Chat.  
Bien qu'elle prenne en charge l'appel de fonctions, elle n'exécute aucun code et ne renvoie que la réponse du modèle.

** INFORMATIONS POUR FOURNISSEURS
Le fournisseur doit implémenter la fonction Chat pour que cette fonctionnalité soit disponible. 
La fonction chat doit retourner un objet avec la réponse selon la même spécification qu'OpenAI, fonction Chat Completion.
Les liens suivants servent de base :
https://platform.openai.com/docs/guides/chat-completions
https://platform.openai.com/docs/api-reference/chat/object (retour sans streaming)
Le fournisseur doit implémenter les paramètres de cette fonction. 
Voir la documentation de chaque paramètre pour des détails et comment les mapper à un fournisseur ;
Lorsque le modèle ne prend pas en charge l'un des paramètres fournis (c'est-à-dire, qu'il n'y a pas de fonctionnalité équivalente, ou qui peut être implémentée de manière équivalente), une erreur doit être retournée.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] 
[[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
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
Nom du modèle. Si non spécifié, utilise le défaut du fournisseur.

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
Format de la réponse 
Les formats acceptés, et le comportement, doivent suivre ceux d'OpenAI : https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Raccourcis :
	"json"|"json_object", équivaut à {"type": "json_object"}
	l'objet doit spécifier un schéma comme s'il était passé directement à l'API d'OpenAI, dans le champ response_format.json_schema

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
Vous pouvez utiliser les commandes comme Get-OpenaiTool*, pour transformer facilement des fonctions PowerShell au format attendu !
Si le modèle invoque la fonction, la réponse, qu'elle soit en streaming ou normale, doit également suivre le modèle d'appel d'outils d'OpenAI.
Ce paramètre doit suivre le même schéma que l'appel de fonction d'OpenAI : https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
Active le modèle Stream 
Vous devez spécifier un ScriptBlock qui sera invoqué pour chaque texte généré par le LLM.
Le script doit recevoir un paramètre représentant chaque extrait, dans le même format de streaming retourné.
Ce paramètre est un objet qui contiendra la propriété choices, qui est dans le même schéma retourné par le streaming d'OpenAI :
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
_Traduit automatiquement à l'aide de PowershAI et de l'IA._
<!--PowershaiAiDocBlockEnd-->
