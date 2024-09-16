---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
liste les modèles disponibles sur le fournisseur actuel

## DESCRIPTION <!--!= @#Desc !-->
Cette commande liste tous les LLM qui peuvent être utilisés avec le fournisseur actuel pour une utilisation dans PowershaiChat.  
Cette fonction dépend de la mise en œuvre de la fonction GetModels par le fournisseur.

L'objet retourné varie en fonction du fournisseur, mais chaque fournisseur doit retourner un tableau d'objets, chacun devant contenir, au minimum, la propriété id, qui doit être une chaîne utilisée pour identifier le modèle dans d'autres commandes qui dépendent d'un modèle.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
