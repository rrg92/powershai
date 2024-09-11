# Chats 


# Introduction <!--! @#Short --> 

PowershAi définit le concept de Chats, qui aident à créer un historique et un contexte de conversations !  

# Détails  <!--! @#Long --> 

PowershAi crée le concept de Chats, qui sont très similaires au concept de Chats dans la plupart des services de LLM.  

Les chats permettent de converser avec des services de LLM d'une manière standard, indépendamment du fournisseur actuel.  
Ils fournissent un moyen standard pour ces fonctionnalités :

- Historique des chats 
- Contexte 
- Pipeline (utiliser le résultat d'autres commandes)
- Appel d'outils (exécuter des commandes à la demande du LLM)

Tous les fournisseurs ne mettent pas en œuvre le support des Chats.  
Pour savoir si un fournisseur possède le support du chat, utilisez le cmdlet Get-AiProviders, et consultez la propriété "Chat". Si c'est $true, alors le chat est supporté.  
Et, une fois que le chat est supporté, tous les fonctionnalités peuvent ne pas être prises en charge, en raison des limitations du fournisseur.  

## Démarrer un nouveau chat 

La manière la plus simple de démarrer un nouveau chat est d'utiliser la commande Send-PowershaiChat.  
Évidemment, vous devez l'utiliser après avoir configuré le fournisseur (en utilisant `Set-AiProvider`) et les configurations initiales, comme l'authentification, si nécessaire.  

```powershell 
Send-PowershaiChat "Bonjour, je suis en train de discuter avec vous à partir de Powershai"
```

Pour simplifier, la commande `Send-PowershaiChat` a un alias appelé `ia` (abréviation du français, Intelligence Artificielle).  
Avec cela, vous réduisez considérablement et vous concentrez davantage sur l'invite :

```powershell 
ia "Bonjour, je suis en train de discuter avec vous à partir de Powershai"
```

Chaque message est envoyé dans un chat. Si vous ne créez pas un chat explicitement, le chat spécial appelé `default` est utilisé.  
Vous pouvez créer un nouveau chat en utilisant `New-PowershaiChat`.  

Chaque chat a son propre historique de conversations et ses configurations. Il peut contenir ses propres fonctions, etc.  
Créer des chats supplémentaires peut être utile si vous devez maintenir plus d'un sujet sans qu'ils se mélangent !


## Commandes de Chat  

Les commandes qui manipulent les chats d'une manière ou d'une autre sont au format `*-Powershai*Chat*`.  
Généralement, ces commandes acceptent un paramètre -ChatId, qui permet de spécifier le nom ou l'objet du chat créé avec `New-PowershaiChat`.  
S'il n'est pas spécifié, elles utilisent le chat actif.  

## Chat Actif  

Le Chat actif est le chat par défaut utilisé par les commandes PowershaiChat.  
Lorsqu'il n'y a qu'un seul chat créé, il est considéré comme le chat actif.  
Si vous avez plus d'un chat actif, vous pouvez utiliser la commande `Set-PowershaiActiveChat` pour définir lequel est actif. Vous pouvez passer le nom ou l'objet retourné par `New-PowershaiChat`.


## Paramètres du chat  

Chaque chat a quelques paramètres qui contrôlent divers aspects.  
Par exemple, le maximum de tokens à être retourné par le LLM.  

De nouveaux paramètres peuvent être ajoutés à chaque version de PowershAI.  
La manière la plus simple d'obtenir les paramètres et ce qu'ils font est d'utiliser la commande `Get-PowershaiChatParameter`;  
Cette commande va apporter la liste des paramètres qui peuvent être configurés, avec la valeur actuelle et une description de comment les utiliser.  
Vous pouvez modifier les paramètres en utilisant la commande `Set-PowershaiChatParameter`.  

Certains paramètres listés sont des paramètres directs de l'API du fournisseur. Ils viendront avec une description qui indique cela.  

## Contexte et Historique  

Chaque Chat possède un contexte et un historique.  
L'historique est l'ensemble des messages envoyés et reçus dans la conversation.  
La taille du contexte est la quantité de l'historique qu'il va envoyer au LLM, afin qu'il se souvienne des réponses.  

Notez que cette Taille de Contexte est un concept de PowershAI, et ce n'est pas la même chose que "Longueur de Contexte" qui est définie dans les LLM.  
La Taille de Contexte affecte uniquement le Powershai, et, selon la valeur, elle peut dépasser la Longueur de Contexte du fournisseur, ce qui peut générer des erreurs.  
Il est important de maintenir la Taille de Contexte équilibrée entre maintenir le LLM à jour avec ce qui a déjà été dit et ne pas dépasser le maximum de tokens du LLM.  

Vous contrôlez la taille du contexte en utilisant le paramètre du chat, c'est-à-dire en utilisant `Set-PowershaiChatParameter`.

Notez que l'historique et le contexte sont stockés dans la mémoire de la session, c'est-à-dire que si vous fermez votre session PowerShell, ils seront perdus.  
Futurément, nous pourrions avoir des mécanismes permettant à l'utilisateur de sauvegarder automatiquement et de récupérer entre les sessions.  

De plus, il est important de se rappeler qu'une fois que l'historique est sauvegardé dans la mémoire de PowerShell, des conversations très longues peuvent entraîner un débordement ou une forte consommation de mémoire de PowerShell.  
Vous pouvez réinitialiser les chats à tout moment en utilisant la commande `Reset-PowershaiCurrentChat`, qui effacera tout l'historique du chat actif.  
Utilisez avec prudence, car cela entraînera la perte de tout l'historique et le LLM ne se souviendra pas des particularités mentionnées au cours de la conversation.  


## Pipeline  

L'une des fonctionnalités les plus puissantes des Chats de Powershai est l'intégration avec le pipeline de PowerShell.  
Fondamentalement, vous pouvez jeter le résultat de n'importe quelle commande PowerShell et il sera utilisé comme contexte.  

PowershAI fait cela en convertissant les objets en texte et en les envoyant dans l'invite.  
Ensuite, le message du chat est ajouté par la suite.  

Par exemple :

```
Get-Service | ia "Faites un résumé des services qui ne sont pas courants dans Windows"
```

Dans les configurations par défaut de Powershai, la commande `ia` (alias pour `Send-PowershaiChat`), va obtenir tous les objets retournés par `Get-Service` et les formater comme une seule grande chaîne.  
Ensuite, cette chaîne sera injectée dans l'invite du LLM, et il sera instruit de l'utiliser comme "contexte" pour l'invite de l'utilisateur.  

L'invite de l'utilisateur est concaténée juste après.  

Avec cela, un effet puissant est créé : Vous pouvez facilement intégrer les sorties des commandes avec vos invites, en utilisant de simples pipes, ce qui est une opération courante dans PowerShell.  
Le LLM a tendance à bien considérer cela.  

Bien qu'il existe une valeur par défaut, vous avez un contrôle total sur la façon dont ces objets sont envoyés.  
La première façon de contrôler est de savoir comment l'objet est converti en texte. Comme l'invite est une chaîne, il est nécessaire de convertir cet objet en texte.  
Par défaut, il le convertit en une représentation standard de PowerShell, selon le type (en utilisant la commande `Out-String`).  
Vous pouvez modifier cela en utilisant la commande `Set-PowershaiChatContextFormatter`. Vous pouvez définir, par exemple, JSON, tableau, et même un script personnalisé pour avoir un contrôle total.  

L'autre façon de contrôler comment le contexte est envoyé est d'utiliser le paramètre du chat `ContextFormat`.  
Ce paramètre contrôle tout le message qui sera injecté dans l'invite. C'est un bloc de script.  
Vous devez retourner un tableau de chaînes, qui équivaut à l'invite envoyée.  
Ce script a accès à des paramètres tels que l'objet formaté qui passe dans le pipeline, les valeurs des paramètres de la commande Send-PowershaiChat, etc.  
La valeur par défaut du script est codée en dur, et vous devez vérifier directement dans le code pour savoir comment il envoie (et pour un exemple de la façon d'implémenter le vôtre).  


###  Outils

L'une des grandes fonctionnalités mises en œuvre est le support de l'Appel de Fonction (ou Appel d'Outil).  
Cette fonctionnalité, disponible dans plusieurs LLMs, permet à l'IA de décider d'invoquer des fonctions pour apporter des données supplémentaires dans la réponse.  
Fondamentalement, vous décrivez une ou plusieurs fonctions et leurs paramètres, et le modèle peut décider de les invoquer.  **IMPORTANT: Vous ne pourrez utiliser cette fonctionnalité qu'avec des fournisseurs qui exposent l'appel de fonction en utilisant la même spécification qu'OpenAI**

Pour plus de détails, consultez la documentation officielle d'OpenAI sur l'appel de fonction : [Appel de fonction](https://platform.openai.com/docs/guides/function-calling).

Le modèle décide uniquement quelles fonctions invoquer, quand les invoquer et leurs paramètres. L'exécution de cette invocation est effectuée par le client, dans notre cas, le PowershAI.  
Les modèles s'attendent à la définition des fonctions décrivant ce qu'elles font, leurs paramètres, retours, etc. À l'origine, cela se fait en utilisant quelque chose comme OpenAPI Spec pour décrire les fonctions.  
Cependant, PowerShell dispose d'un puissant système d'aide utilisant des commentaires, qui permet de décrire les fonctions et leurs paramètres, ainsi que les types de données.  

Le PowershAI s'intègre à ce système d'aide, le traduisant en spécification OpenAPI. L'utilisateur peut écrire ses fonctions normalement, en utilisant des commentaires pour les documenter et cela est envoyé au modèle.  

Pour démontrer cette fonctionnalité, voici un simple tutoriel : créez un fichier nommé `MinhasFuncoes.ps1` avec le contenu suivant

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
**Remarquez l'utilisation des commentaires pour décrire les fonctions et les paramètres**.  
C'est une syntaxe supportée par PowerShell, connue sous le nom de [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Maintenant, ajoutons ce fichier au PowershAI :

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #configurez le token si ce n'est pas encore fait.


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
Utilisez la commande `Get-Help -Full Add-AiTol` pour plus de détails sur la façon d'utiliser cette fonctionnalité puissante.

Le PowershAI s'occupe automatiquement d'exécuter les commandes et d'envoyer la réponse au modèle.  
Si le modèle décide d'exécuter plusieurs fonctions en parallèle, ou insiste pour exécuter de nouvelles fonctions, le PowershAI gérera cela automatiquement.  
Notez que, pour éviter une boucle infinie d'exécutions, le PowershAI impose une limite au nombre maximal d'exécutions.  
Le paramètre qui contrôle ces interactions avec le modèle est `MaxInteractions`.  

#### CONSIDÉRATIONS IMPORTANTES SUR L'UTILISATION DES OUTILS

La fonctionnalité d'appel de fonction est puissante car elle permet l'exécution de code, mais elle est également dangereuse, TRÈS DANGEREUSE.  
Par conséquent, soyez extrêmement prudent avec ce que vous implémentez et exécutez.  
N'oubliez pas que le PowershAI exécutera selon les demandes du modèle. 

Quelques conseils de sécurité :

- Évitez d'exécuter le script avec un utilisateur Administrateur.
- Évitez d'implémenter du code qui supprime ou modifie des données importantes.
- Testez les fonctions au préalable.
- N'incluez pas de modules ou de scripts tiers que vous ne connaissez pas ou en qui vous n'avez pas confiance.  


_Traduit automatiquement en utilisant PowershAI et IA._
