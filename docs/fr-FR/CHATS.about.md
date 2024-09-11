# Chats 

# Introduction <!--! @#Short --> 

PowershAi définit le concept de Chats, qui aident à créer un historique et un contexte de conversations !  

# Détails  <!--! @#Long --> 

PowershAi crée le concept de Chats, qui sont très similaires au concept de Chats dans la plupart des services de LLM.  

Les chats permettent de converser avec des services de LLM de manière standard, indépendamment du fournisseur actuel.  
Ils fournissent un moyen standard pour ces fonctionnalités :

- Historique des chats 
- Contexte 
- Pipeline (utiliser le résultat d'autres commandes)
- Appel d'outils (exécuter des commandes à la demande du LLM)

Tous les fournisseurs n'implémentent pas le support des Chats.  
Pour savoir si un fournisseur a le support du chat, utilisez la commande Get-AiProviders, et consultez la propriété "Chat". Si c'est $true, alors le chat est supporté.  
Et, une fois que le chat est supporté, tous les fonctionnalités peuvent ne pas l'être, en raison des limitations du fournisseur.  

## Démarrer un nouveau chat 

La manière la plus simple de commencer un nouveau chat est d'utiliser la commande Send-PowershaiChat.  
Évidemment, vous devez l'utiliser après avoir configuré le fournisseur (en utilisant `Set-AiProvider`) et les configurations initiales, comme l'authentification, si nécessaire.  

```powershell 
Send-PowershaiChat "Bonjour, je suis en train de converser avec vous à partir de Powershai"
```

Pour simplifier, la commande `Send-PowershaiChat` a un alias appelé `ia` (abréviation du français, Intelligence Artificielle).  
Avec cela, vous réduisez considérablement et vous concentrez davantage sur le prompt :

```powershell 
ia "Bonjour, je suis en train de converser avec vous à partir de Powershai"
```

Chaque message est envoyé dans un chat. Si vous ne créez pas explicitement un chat, le chat spécial appelé `default` est utilisé.  
Vous pouvez créer un nouveau chat en utilisant `New-PowershaiChat`.  

Chaque chat a son propre historique de conversations et configurations. Il peut contenir ses propres fonctions, etc.  
Créer des chats supplémentaires peut être utile si vous devez maintenir plus d'un sujet sans qu'ils se mélangent !


## Commandes de Chat  

Les commandes qui manipulent les chats d'une manière ou d'une autre sont au format `*-Powershai*Chat*`.  
En général, ces commandes acceptent un paramètre -ChatId, qui permet de spécifier le nom ou l'objet du chat créé avec `New-PowershaiChat`.  
S'il n'est pas spécifié, elles utilisent le chat actif.  

## Chat Actif  

Le chat actif est le chat par défaut utilisé par les commandes PowershaiChat.  
Lorsqu'il n'y a qu'un seul chat créé, il est considéré comme le chat actif.  
Si vous avez plus d'un chat actif, vous pouvez utiliser la commande `Set-PowershaiActiveChat` pour définir lequel est actif. Vous pouvez passer le nom ou l'objet retourné par `New-PowershaiChat`.


## Paramètres du chat  

Chaque chat possède certains paramètres qui contrôlent divers aspects.  
Par exemple, le nombre maximum de tokens à retourner par le LLM.  

De nouveaux paramètres peuvent être ajoutés à chaque version de PowershAI.  
La manière la plus simple d'obtenir les paramètres et ce qu'ils font est d'utiliser la commande `Get-PowershaiChatParameter`;  
Cette commande retournera la liste des paramètres qui peuvent être configurés, avec la valeur actuelle et une description de leur utilisation.  
Vous pouvez modifier les paramètres en utilisant la commande `Set-PowershaiChatParameter`.  

Certains paramètres listés sont les paramètres directs de l'API du fournisseur. Ils viendront avec une description qui l'indique.  

## Contexte et Historique  

Chaque Chat possède un contexte et un historique.  
L'historique est l'ensemble des messages envoyés et reçus dans la conversation.  
La taille du contexte est la quantité d'historique qu'il va envoyer au LLM, afin qu'il se souvienne des réponses.  

Notez que cette taille de contexte est un concept de PowershAI, et ce n'est pas la même "longueur de contexte" qui est définie dans les LLM.  
La taille du contexte n'affecte que Powershai, et, selon la valeur, elle peut dépasser la longueur de contexte du fournisseur, ce qui peut entraîner des erreurs.  
Il est important de maintenir la taille du contexte équilibrée entre tenir le LLM à jour avec ce qui a déjà été dit et ne pas dépasser le maximum de tokens du LLM.Par défaut, il convertit en une représentation standard de Powershell, selon le type (en utilisant la commande `Out-String`).  
Vous pouvez modifier cela en utilisant la commande `Set-PowershaiChatContextFormatter`. Vous pouvez définir, par exemple, JSON, tableau, et même un script personnalisé pour avoir un contrôle total.  

L'autre façon de contrôler comment le contexte est envoyé est d'utiliser le paramètre de chat `ContextFormat`.  
Ce paramètre contrôle tout le message qui sera injecté dans l'invite. C'est un scriptblock.  
Vous devez retourner un tableau de chaînes, qui équivaut à l'invite envoyée.  
Ce script a accès à des paramètres comme l'objet formaté qui passe dans le pipeline, les valeurs des paramètres de la commande Send-PowershaiChat, etc.  
La valeur par défaut du script est codée en dur, et vous devez vérifier directement dans le code pour savoir comment il envoie (et pour un exemple de comment implémenter le vôtre).  

### Outils

Une des grandes fonctionnalités mises en œuvre est le support de l'appel de fonction (ou appel d'outil).  
Cette fonctionnalité, disponible dans plusieurs LLMs, permet à l'IA de décider d'invoquer des fonctions pour apporter des données supplémentaires dans la réponse.  
Fondamentalement, vous décrivez une ou plusieurs fonctions et leurs paramètres, et le modèle peut décider de les invoquer.  

**IMPORTANT : Vous ne pourrez utiliser cette fonctionnalité que dans des fournisseurs qui exposent l'appel de fonction en utilisant la même spécification qu'OpenAI**

Pour plus de détails, consultez la documentation officielle d'OpenAI sur l'appel de fonction : [Function Calling](https://platform.openai.com/docs/guides/function-calling).

Le modèle décide uniquement quelles fonctions invoquer, quand les invoquer et leurs paramètres. L'exécution de cette invocation est effectuée par le client, dans notre cas, le PowershAI.  
Les modèles s'attendent à une définition des fonctions décrivant ce qu'elles font, leurs paramètres, leurs retours, etc. À l'origine, cela se fait en utilisant quelque chose comme OpenAPI Spec pour décrire les fonctions.  
Cependant, Powershell possède un puissant système d'aide utilisant des commentaires, qui permet de décrire des fonctions et leurs paramètres, ainsi que les types de données.  

Le PowershAI s'intègre à ce système d'aide, le traduisant en une spécification OpenAPI. L'utilisateur peut écrire ses fonctions normalement, en utilisant des commentaires pour les documenter et cela est envoyé au modèle.  

Pour démontrer cette fonctionnalité, passons à un simple tutoriel : créez un fichier nommé `MinhasFuncoes.ps1` avec le contenu suivant

```powershell
# Fichier MinhasFuncoes.ps1, enregistrez-le dans un répertoire de votre choix !

<#
    .DESCRIPTION
    Liste l'heure actuelle
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    Obtient un nombre aléatoire !
#>
function NumeroAleatorio {
    param(
        # Nombre minimum
        $Min = $null,
        
        # Nombre maximum
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**Notez l'utilisation des commentaires pour décrire les fonctions et les paramètres**.  
C'est une syntaxe prise en charge par PowerShell, connue sous le nom de [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Maintenant, ajoutons ce fichier au PowershAI :

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #configurez le token si vous ne l'avez pas encore configuré.


# Ajoutez le script comme outils !
# Supposons que le script soit enregistré dans C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Confirmez que les outils ont été ajoutés 
Get-AiTool
```

Essayez de demander au modèle quelle est la date actuelle ou demandez-lui de générer un nombre aléatoire ! Vous verrez qu'il exécutera vos fonctions ! Cela ouvre des possibilités infinies, et votre créativité est la limite !

```powershell
ia "Combien d'heures ?"
```

Dans la commande ci-dessus, le modèle va invoquer la fonction. À l'écran, vous verrez la fonction être appelée !  
Vous pouvez ajouter n'importe quelle commande ou script PowerShell comme un outil.  
Utilisez la commande `Get-Help -Full Add-AiTool` pour plus de détails sur l
