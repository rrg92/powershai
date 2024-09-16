---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Crée un nouveau Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
PowershaAI introduit le concept de "chats", similaires aux chats que vous voyez sur OpenAI, ou les "threads" de l'API Assistants.  
Chaque chat créé possède son propre ensemble de paramètres, contexte et historique.  
Lorsque vous utilisez l'applet de commande Send-PowershaiChat (alias ia), vous envoyez des messages au modèle, et l'historique de cette conversation avec le modèle est stocké dans le chat créé ici par PowershAI.  
En d'autres termes, tout l'historique de votre conversation avec le modèle est conservé ici dans votre session PowershAI, et non pas dans le modèle ou l'API.  
Ainsi, PowershAI garde le contrôle total de ce qui est envoyé au LLM et ne dépend pas des mécanismes des différentes API de différents fournisseurs pour gérer l'historique. 


Chaque Chat possède un ensemble de paramètres qui, lorsqu'ils sont modifiés, n'affectent que ce chat.  
Certains paramètres de PowershAI sont globaux, comme par exemple le fournisseur utilisé. En changeant de fournisseur, le Chat commence à utiliser le nouveau fournisseur, mais conserve le même historique.  
Cela vous permet de discuter avec différents modèles tout en conservant le même historique.  

En plus de ces paramètres, chaque Chat possède un historique.  
L'historique contient toutes les conversations et interactions effectuées avec les modèles, en conservant les réponses retournées par les API.

Un Chat possède également un contexte, qui n'est rien de plus que toutes les messages envoyées.  
Chaque fois qu'un nouveau message est envoyé dans un chat, Powershai ajoute ce message au contexte.  
Lors de la réception de la réponse du modèle, cette réponse est ajoutée au contexte.  
Dans le message suivant envoyé, tout cet historique de messages du contexte est envoyé, ce qui permet au modèle, quel que soit le fournisseur, d'avoir la mémoire de la conversation.  

Le fait que le contexte soit conservé ici dans votre session Powershell permet des fonctionnalités telles que l'enregistrement de votre historique sur disque, la mise en œuvre d'un fournisseur exclusif pour conserver votre historique dans le cloud, le maintien uniquement sur votre PC, etc. Les fonctionnalités futures peuvent en bénéficier.

Toutes les commandes *-PowershaiChat tournent toutes autour du chat actif ou du chat que vous spécifiez explicitement dans le paramètre (généralement avec le nom -ChatId).  
Le ChatActif est le chat vers lequel les messages seront envoyés, si vous ne spécifiez pas le ChatId  (ou si la commande ne permet pas de spécifier un chat explicite).  

Il existe un chat spécial appelé "default" qui est le chat créé chaque fois que vous utilisez Send-PowershaiChat sans spécifier de chat et s'il n'y a pas de chat actif défini.  

Si vous fermez votre session Powershell, tout cet historique de Chats est perdu.  
Vous pouvez enregistrer sur disque, en utilisant la commande Export-PowershaiSettings. Le contenu est enregistré crypté avec un mot de passe que vous spécifiez.

Lors de l'envoi de messages, PowershAI maintient un mécanisme interne qui nettoie le contexte du chat, pour éviter d'envoyer plus que nécessaire.
La taille du contexte local (ici dans votre session Powershai, et non dans le LLM), est contrôlée par un paramètre (utilisez Get-PowershaiChatParameter pour voir la liste des paramètres)

Notez que, en raison de cette façon de fonctionner de Powershai, en fonction de la quantité d'informations envoyées et retournées, ainsi que des configurations des paramètres, vous pouvez faire en sorte que votre Powershell consomme beaucoup de mémoire. Vous pouvez nettoyer manuellement le contexte et l'historique de votre chat en utilisant Reset-PowershaiCurrentChat

Voir plus de détails sur le sujet dans le sujet about_Powershai_Chats,

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id du chat. Si non spécifié, il générera un modèle 
Certains modèles d'identifiant sont réservés à un usage interne. Si vous les utilisez, vous risquez de provoquer des instabilités dans PowershAI.
Les valeurs suivantes sont réservées :
 default 
 _pwshai_*

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

### -IfNotExists
Crée uniquement s'il n'existe pas de chat portant le même nom

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

### -Recreate
Forcer la recréation du chat s'il est déjà créé !

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

### -Tools
Crée le chat et inclut ces outils !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
