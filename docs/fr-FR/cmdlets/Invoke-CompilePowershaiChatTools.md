---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-CompilePowershaiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Convertit tous les outils ajoutés au format attendu par la fonction Invoke-AiChatTools.

## DESCRIPTION <!--!= @#Desc !-->
Obtient tous les outils enregistrés par l'utilisateur avec New-PowershaiChatTool et les compile en un seul objet à envoyer au LLM en utilisant Invoke-AiChatTools.  
Ce processus peut être assez lent, en fonction du nombre d'outils ajoutés.

Le cmdlet va parcourir tous les outils, obtenir l'aide des commandes et des paramètres, et convertir cela en un format pouvant être envoyé dans Invoke-AiChatTools.  
Comme PowershAI définit que le moteur d'outils doit suivre le modèle d'OpenAI, la fonction Get-OpenaiTool* du fournisseur OpenAI est utilisée.  
Ces fonctions contiennent la logique nécessaire pour générer le schéma de l'appel d'outil en suivant les spécifications d'OpenAI.  

Cette commande itère sur chaque outil disponible pour le chat actuel et crée ce qui est nécessaire pour être envoyé avec Invoke-AiChatTools.  
Invoke-AiChatTools contient toute la logique pour gérer l'envoi, l'exécution et la réponse du LLM.  

Fondamentalement, il existe 2 types d'outils que Powershai prend en charge : Script ou Commande.  
Commande est tout code exécutable par PowerShell : fonctions, .exe, cmdlets natifs, etc.

Les scripts sont de simples fichiers .ps1 qui définissent les fonctions pouvant être utilisées comme outils.  
C'est comme un groupe de commandes.

Cette commande invoque tout ce qui est nécessaire pour convertir ces outils au format standard attendu par Invoke-AiChatTools.  
Invoke-AiChatTools ne sait rien sur les chats, les outils globaux. C'est une fonction générique qui ne dépend pas du mécanisme de Chats créé par Powershai.  

C'est pourquoi il est nécessaire que cette fonction fasse toute cette "traduction" des facilités du Powershai Chat vers ce qui est attendu par Invoke-AiChatTools.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-CompilePowershaiChatTools [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Chat à partir duquel les outils seront obtenus  
En plus du chat, les outils globaux seront inclus

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
