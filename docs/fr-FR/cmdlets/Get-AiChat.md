---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Envoie des messages à un LLM et renvoie la réponse

## DESCRIPTION <!--!= @#Desc !-->
Il s'agit de la forme la plus basique de chat promue par PowershAI.  
Avec cette fonction, vous pouvez envoyer un message à un LLM du fournisseur actuel.  

Cette fonction est plus bas niveau, de manière standardisée, d'accès à un LLM que powershai met à disposition.  
Elle ne gère pas l'historique ou le contexte. Elle est utile pour invoquer des invites simples, qui ne nécessitent pas plusieurs interactions comme dans un chat. 
Bien qu'elle prenne en charge l'appel de fonction, elle n'exécute aucun code, et ne renvoie que la réponse du modèle.



** INFORMATIONS POUR LES FOURNISSEURS
	Le fournisseur doit implémenter la fonction Chat pour que cette fonctionnalité soit disponible. 
	La fonction chat doit renvoyer un objet avec la réponse avec la même spécification que la fonction OpenAI Chat Completion.
	Les liens suivants servent de base :
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (retour sans streaming)
	Le fournisseur doit implémenter les paramètres de cette fonction. 
	Consultez la documentation de chaque paramètre pour plus de détails et la manière de mapper vers un fournisseur ;
	
	Lorsque le modèle ne prend pas en charge l'un des paramètres spécifiés (c'est-à-dire qu'il n'y a pas de fonctionnalité équivalente ou qui peut être implémentée de manière équivalente), une erreur doit être renvoyée.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
L'invite à envoyer. Doit être au format décrit par la fonction ConvertTo-OpenaiMessage

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
Nom du modèle. S'il n'est pas spécifié, utilise la valeur par défaut du fournisseur.

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
Nombre maximal de jetons à renvoyer

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
Les formats acceptables et le comportement doivent suivre les mêmes que ceux d'OpenAI : https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Raccourcis :
	"json", équivaut à {"type": "json_object"}

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
Liste des outils à invoquer !
Vous pouvez utiliser les commandes comme Get-OpenaiTool*, pour transformer facilement les fonctions powershell au format attendu !
Si le modèle appelle la fonction, la réponse, à la fois en streaming et normale, doit également suivre le modèle d'appel d'outil d'OpenAI.
Ce paramètre doit suivre le même schéma que l'appel de fonction d'OpenAI : https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
Spécifiez les paramètres directs de l'API du fournisseur.
Cela remplacera les valeurs qui ont été calculées et générées en fonction des autres paramètres.

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
Vous devez spécifier un ScriptBlock qui sera appelé pour chaque texte généré par le LLM.
Le script doit recevoir un paramètre qui représente chaque extrait, au même format de streaming renvoyé
	Ce paramètre est un objet qui contiendra la propriété choices, qui est au même schéma renvoyé par le streaming d'OpenAI :
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
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
