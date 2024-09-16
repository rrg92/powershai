﻿---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
Configurer le LLM par défaut du fournisseur actuel

## DESCRIPTION <!--!= @#Desc !-->
Les utilisateurs peuvent configurer le LLM par défaut, qui sera utilisé lorsqu'un LLM est requis.  
Les commandes comme Send-PowershaAIChat, Get-AiChat, attendent un modèle, et s'il n'est pas fourni, il utilise celui qui a été défini avec cette commande.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
ID du modèle, tel que retourné par Get-AiModels
Vous pouvez utiliser la tabulation pour compléter la ligne de commande.

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

### -Force
Force la définition du modèle, même s'il n'est pas retourné par Get-AiModels

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