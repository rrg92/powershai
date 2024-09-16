# Chats 


# Introduction <!--! @#Short --> 

PowershAi définit le concept de Chats, qui aident à créer l'historique et le contexte des conversations !  

# Détails  <!--! @#Long --> 

PowershAi crée le concept de Chats, qui sont très similaires au concept de Chats dans la plupart des services de LLM.  

Les chats permettent de converser avec les services de LLM d'une manière standard, indépendamment du fournisseur actuel.  
Ils fournissent un moyen standard pour ces fonctionnalités :

- Historique des chats 
- Contexte 
- Pipeline (utiliser le résultat d'autres commandes)
- Tool calling (exécuter des commandes à la demande du LLM)

Tous les fournisseurs n'implémentent pas la prise en charge des Chats.  
Pour savoir si un fournisseur prend en charge le chat, utilisez le cmdlet Get-AiProviders, et consultez la propriété "Chat". Si elle est à $true, alors le chat est pris en charge.  
Et, une fois que le chat est pris en charge, toutes les fonctionnalités peuvent ne pas être prises en charge, en raison de limitations du fournisseur.  

## Démarrer un nouveau chat 

La façon la plus simple de démarrer un nouveau chat est d'utiliser la commande Send-PowershaiChat.  
Bien sûr, vous devez l'utiliser après avoir configuré le fournisseur (à l'aide de `Set-AiProvider`) et les paramètres initiaux, tels que l'authentification, si nécessaire.  

```powershell 
Send-PowershaiChat "Bonjour, je te parle depuis Powershai"
```

Par souci de simplicité, la commande `Send-PowershaiChat` a un alias appelé `ia` (abréviation de l'anglais, Intelligence Artificielle).  
Avec lui, vous réduisez considérablement et vous concentrez davantage sur l'invite :

```powershell 
ia "Bonjour, je te parle depuis Powershai"
```

Chaque message est envoyé dans un chat.  Si vous ne créez pas explicitement un chat, le chat spécial appelé `default` est utilisé.  
Vous pouvez créer un nouveau chat en utilisant `New-PowershaiChat`.  

Chaque chat a son propre historique de conversations et ses propres paramètres. Il peut contenir ses propres fonctions, etc.
Créer des chats supplémentaires peut être utile si vous avez besoin de conserver plusieurs sujets sans qu'ils ne se mélangent !


## Commandes de Chat  

Les commandes qui manipulent les chats d'une manière ou d'une autre sont au format `*-Powershai*Chat*`.  
En général, ces commandes acceptent un paramètre -ChatId, qui vous permet de spécifier le nom ou l'objet du chat créé avec `New-PowershaiChat`.  
S'il n'est pas spécifié, ils utilisent le chat actif.  

## Chat actif  

Le Chat actif est le chat par défaut utilisé par les commandes PowershaiChat.  
Lorsqu'il n'y a qu'un seul chat créé, il est considéré comme le chat actif.  
Si vous avez plusieurs chats actifs, vous pouvez utiliser la commande `Set-PowershaiActiveChat` pour définir lequel est actif. Vous pouvez transmettre le nom ou l'objet renvoyé par `New-PowershaiChat`.


## Paramètres du chat  

Chaque chat possède quelques paramètres qui contrôlent divers aspects.  
Par exemple, le nombre maximum de jetons à retourner par le LLM.  

De nouveaux paramètres peuvent être ajoutés à chaque version de PowershAI.  
La façon la plus simple d'obtenir les paramètres et ce qu'ils font est d'utiliser la commande `Get-PowershaiChatParameter`;  
Cette commande affichera la liste des paramètres qui peuvent être configurés, ainsi que la valeur actuelle et une description de la façon de l'utiliser.  
Vous pouvez modifier les paramètres en utilisant la commande `Set-PowershaiChatParameter`.  

Certains paramètres listés sont les paramètres directs de l'API du fournisseur. Ils seront accompagnés d'une description qui l'indique.  

## Contexte et Historique  

Chaque Chat possède un contexte et un historique.  
L'historique est l'historique complet des messages envoyés et reçus dans la conversation.
La taille du contexte est la quantité d'historique qu'il va envoyer au LLM, afin qu'il se souvienne des réponses.  

Notez que cette taille de contexte est un concept de PowershAI, et n'est pas le même "Context length" qui est défini dans les LLM.  
La taille du contexte affecte uniquement Powershai, et, en fonction de la valeur, elle peut dépasser la longueur de contexte du fournisseur, ce qui peut générer des erreurs.  
Il est important de garder la taille du contexte équilibrée entre le fait de garder le LLM à jour avec ce qui a déjà été dit et de ne pas dépasser le nombre maximum de jetons du LLM.  

Vous contrôlez la taille du contexte en utilisant le paramètre du chat, c'est-à-dire en utilisant `Set-PowershaiChatParameter`.

notez que l'historique et le contexte sont stockés dans la mémoire de la session, c'est-à-dire que si vous fermez votre session Powershell, ils seront perdus.  
À l'avenir, nous pourrons avoir des mécanismes qui permettront à l'utilisateur de sauvegarder automatiquement et de récupérer entre les sessions.  

Aussi, il est important de se rappeler que, une fois que l'historique est sauvegardé dans la mémoire de Powershell, des conversations très longues peuvent provoquer un dépassement de capacité ou une forte consommation de mémoire de powershell.  
Vous pouvez réinitialiser les chats à tout moment en utilisant la commande `Reset-PowershaiCurrentChat`, qui effacera tout l'historique du chat actif.  
Utilisez-la avec précaution, car cela entraînera la perte de tout l'historique et le LLM ne se souviendra pas des particularités indiquées au cours de la conversation.  


## Pipeline  

L'une des fonctionnalités les plus puissantes des Chats de Powershai est l'intégration avec le pipeline de Powershell.  
En gros, vous pouvez jouer le résultat de n'importe quelle commande powershell et il sera utilisé comme contexte.  

PowershAI le fait en convertissant les objets en texte et en les envoyant dans l'invite.  
Ensuite, le message du chat est ajouté.  

Par exemple :

```
Get-Service | ia "Faites un résumé des services qui ne sont pas courants sous Windows"
```

Dans les paramètres par défaut de Powershai, la commande `ia`  (alias pour `Send-PowershaiChat`), va obtenir tous les objets retournés par `Get-Service` et les formater comme une seule chaîne de caractères géante.  
Ensuite, cette chaîne sera injectée dans l'invite du LLM, et il sera instruit de l'utiliser comme "contexte" pour l'invite de l'utilisateur.  

L'invite de l'utilisateur est ensuite concaténée.  

Cela crée un effet puissant : vous pouvez facilement intégrer les sorties des commandes à vos invites, en utilisant un simple pipe, qui est une opération courante dans Powershell.  
Le LLM a tendance à considérer cela comme étant bon.  

Bien qu'il possède une valeur par défaut, vous avez un contrôle total sur la façon dont ces objets sont envoyés.  
La première façon de contrôler est la façon dont l'objet est converti en texte.  Comme l'invite est une chaîne de caractères, il est nécessaire de convertir cet objet en texte.  
Par défaut, il convertit en une représentation standard de Powershell, selon le type (en utilisant la commande `Out-String`).  
Vous pouvez modifier cela en utilisant la commande `Set-PowershaiChatContextFormatter`. Vous pouvez définir, par exemple, JSON, une table, et même un script personnalisé pour avoir un contrôle total.  

L'autre façon de contrôler la façon dont le contexte est envoyé est d'utiliser le paramètre du chat `ContextFormat`.  
Ce paramètre contrôle tout le message qui sera injecté dans l'invite. Il s'agit d'un scriptblock.  
Vous devez renvoyer un tableau de chaînes de caractères, qui équivaut à l'invite envoyée.  
Ce script a accès à des paramètres tels que l'objet formaté qui est passé dans le pipeline, les valeurs des paramètres de la commande Send-PowershaiChat, etc.  
La valeur par défaut du script est codée en dur, et vous devez la consulter directement dans le code pour savoir comment il envoie (et pour un exemple de la façon d'implémenter le vôtre).  


###  Tools

L'une des grandes fonctionnalités implémentées est la prise en charge de Function Calling (ou Tool Calling).  
Cette fonctionnalité, disponible dans de nombreux LLMs, permet à l'IA de décider d'appeler des fonctions pour apporter des données supplémentaires à la réponse.  
En gros, vous décrivez une ou plusieurs fonctions et leurs paramètres, et le modèle peut décider de les appeler.  

**IMPORTANT : Vous ne pourrez utiliser cette fonctionnalité que sur les fournisseurs qui exposent function calling en utilisant la même spécification que OpenAI**

Pour plus de détails, consultez la documentation officielle d'OpenAI sur Function Calling : [Function Calling](https://platform.openai.com/docs/guides/function-calling).

Le modèle décide uniquement quelles fonctions appeler, quand les appeler et quels sont leurs paramètres. L'exécution de cet appel est effectuée par le client, dans notre cas, PowershAI.  
Les modèles attendent la définition des fonctions en décrivant ce qu'elles font, leurs paramètres, leurs retours, etc.  À l'origine, cela est fait en utilisant quelque chose comme OpenAPI Spec pour décrire les fonctions.  
Cependant, Powershell possède un puissant système d'aide utilisant des commentaires, qui permet de décrire les fonctions et leurs paramètres, ainsi que les types de données.  

PowershAI s'intègre à ce système d'aide, en le traduisant en une spécification OpenAPI. L'utilisateur peut écrire ses fonctions normalement, en utilisant des commentaires pour les documenter, et cela est envoyé au modèle.  

Pour démontrer cette fonctionnalité, allons à un simple tutoriel : créez un fichier appelé `MinhasFuncoes.ps1` avec le contenu suivant

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
        # Nombre minimal
        $Min = $null,
        
        # Nombre maximal
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**Notez l'utilisation des commentaires pour décrire les fonctions et les paramètres**.  
Il s'agit d'une syntaxe prise en charge par PowerShell, connue sous le nom de [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Maintenant, ajoutons ce fichier à PowershAI :

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #Configurez le jeton si vous ne l'avez pas déjà fait.


# Ajoutez le script comme outils !
# En supposant que le script est enregistré dans C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Confirmez que les outils ont été ajoutés 
Get-AiTool
```

Essayez de demander au modèle quelle est la date actuelle ou demandez-lui de générer un nombre aléatoire ! Vous verrez qu'il exécutera vos fonctions ! Cela ouvre des possibilités infinies, et votre créativité est la limite !

```powershell
ia "Quelle heure est-il ?"
```

Dans la commande ci-dessus, le modèle va appeler la fonction. À l'écran, vous verrez la fonction être appelée !  
Vous pouvez ajouter n'importe quelle commande ou script powershell comme outil.  
Utilisez la commande `Get-Help -Full Add-AiTol` pour plus de détails sur la façon d'utiliser cette puissante fonctionnalité.

PowershAI gère automatiquement l'exécution des commandes et l'envoi de la réponse au modèle.  
Si le modèle décide d'exécuter plusieurs fonctions en parallèle, ou insiste pour exécuter de nouvelles fonctions, PowershAI gérera cela automatiquement.  
Notez que, pour éviter une boucle infinie d'exécutions, PowershAI impose une limite avec le nombre maximum d'exécutions.  
Le paramètre qui contrôle ces interactions avec le modèle est `MaxInteractions`.  


### Invoke-AiChatTools et Get-AiChat 

Ces deux cmdlets sont à la base de la fonctionnalité de chat de Powershai.  
`Get-AiChat` est la commande qui vous permet de communiquer avec le LLM de la manière la plus primitive possible, presque aussi près que l'appel HTTP.  
Il s'agit, en gros, d'un wrapper standardisé pour l'API qui vous permet de générer du texte.  
Vous indiquez les paramètres, qui sont standardisés, et il renvoie une réponse, qui est également standardisée,
Indépendamment du fournisseur, la réponse doit suivre la même règle !

Le cmdlet `Invoke-AiChatTools` est un peu plus élaboré et un peu plus haut niveau.  
Il vous permet de spécifier des fonctions Powershell comme outils.  Ces fonctions sont converties en un format que le LLM comprend.  
Il utilise le système d'aide de Powershell pour obtenir tous les métadonnées possibles à envoyer au modèle.  
Il envoie les données au modèle en utilisant la commande `Get-Aichat`. En obtenant la réponse, il valide s'il y a un appel d'outil, et si c'est le cas, il exécute les fonctions équivalentes et renvoie la réponse.  
Il continue à faire ce cycle jusqu'à ce que le modèle termine la réponse ou que le nombre maximum d'interactions soit atteint.  
Une interaction est un appel d'API au modèle. En invoquant Invoke-AiChatTools avec des fonctions, plusieurs appels peuvent être nécessaires pour renvoyer les réponses au modèle.  

Le diagramme suivant explique ce flux :

```
	sequenceDiagram
		Invoke-AiChatTools->>modelo:prompt (INTERAÇÃO 1)
		modelo->>Invoke-AiChatTools:(response, 3 function call)
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 1
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 2
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 3
		Invoke-AiChatTools->>modelo:Resultado tool call + prompts anteriores prompt (INTERAÇÃO 2)
		modelo->>Invoke-AiChatTools:resposta final
```


#### Comment les commandes sont transformées et invoquées

La commande `Invoke-AiChatTools` attend dans le paramètre -Functions une liste de commandes powershell mappées sur des schémas OpenAPI.  
Elle attend un objet que nous appelons OpenaiTool, contenant les propriétés suivantes : (le nom OpenAiTool est dû au fait que nous utilisons le même format d'appel d'outil que OpenAI)

- tools  
Cette propriété contient le schéma d'appel de fonction qui sera envoyé au LLM (dans les paramètres qui attendent cette information)  

- map  
Il s'agit d'une méthode qui renvoie la commande powershell (fonction, alias, cmdlet, exe, etc.) à exécuter.  
Cette méthode doit renvoyer un objet avec la propriété appelée "func", qui doit être le nom d'une fonction, d'une commande exécutable ou d'un scriptblock.  
Il recevra en premier argument le nom de l'outil, et en second l'objet OpenAiTool lui-même (comme s'il s'agissait de this).

En plus de ces propriétés, toute autre est libre d'être ajoutée à l'objet OpenaiTool. Cela permet au script map d'accéder à toutes les données externes dont il a besoin.  

Lorsque le LLM renvoie la demande d'appel de fonction, le nom de la fonction à invoquer est passé à la méthode `map`, et elle doit renvoyer la commande à exécuter. 
Cela ouvre de nombreuses possibilités, permettant, en runtime, de déterminer la commande à exécuter à partir d'un nom.  
Grâce à ce mécanisme, l'utilisateur a un contrôle total et une flexibilité totale sur la façon dont il va répondre à l'appel d'outil du LLM.  

Ensuite, la commande sera invoquée et les paramètres et les valeurs envoyés par le modèle seront passés en tant qu'arguments liés.  
Autrement dit, la commande ou le script doit être capable de recevoir les paramètres (ou de les identifier dynamiquement) à partir de leur nom.


Tout cela est fait dans une boucle qui va itérer, séquentiellement, sur chaque appel d'outil retourné par le LLM.  
Il n'y a aucune garantie de l'ordre dans lequel les outils seront exécutées, par conséquent, il ne faut jamais présumer un ordre, à moins que le LLM n'envoie un outil en séquence.  
Cela signifie que, dans les implémentations futures, plusieurs appels d'outil peuvent être exécutés en même temps, en parallèle (dans des Jobs, par exemple).  

En interne, PowershAI crée un script map par défaut pour les commandes ajoutées en utilisant `Add-AiTool`.  

Pour un exemple de la façon d'implémenter des fonctions qui renvoient ce format, consultez le provider openai.ps1, les commandes qui commencent par Get-OpenaiTool*

Notez que cette fonctionnalité d'appel d'outil ne fonctionne qu'avec les modèles qui prennent en charge l'appel d'outil en suivant les mêmes spécifications qu'OpenAI (tant en entrée qu'en sortie).  


#### CONSIDÉRATIONS IMPORTANTES SUR L'UTILISATION DES OUTILS

La fonctionnalité d'appel de fonction est puissante car elle permet d'exécuter du code, mais elle est également dangereuse, TRÈS DANGEREUSE.  
Par conséquent, soyez extrêmement prudent avec ce que vous implémentez et exécutez.
N'oubliez pas que PowershAI exécutera ce que le modèle demandera. 

Quelques conseils de sécurité :

- Évitez d'exécuter le script avec un utilisateur Administrateur.
- Évitez d'implémenter du code qui supprime ou modifie des données importantes.
- Testez les fonctions avant de les utiliser.
- N'incluez pas de modules ou de scripts tiers que vous ne connaissez pas ou auxquels vous ne faites pas confiance.  


La mise en œuvre actuelle exécute la fonction dans la même session, et avec les mêmes identifiants, que l'utilisateur connecté.  
Cela signifie que, par exemple, si le modèle (intentionnellement ou par erreur) demande d'exécuter une commande dangereuse, vos données, ou même votre ordinateur, peuvent être endommagés ou compromis.  

Par conséquent, il est important de tenir compte de ce qui suit : Faites preuve de la plus grande prudence et n'ajoutez des outils avec des scripts que si vous leur faites entièrement confiance.  

Un plan est en place pour ajouter de futurs mécanismes pour aider à améliorer la sécurité, comme l'isolement dans d'autres runspaces, l'ouverture d'un processus séparé, avec moins de privilèges, et la possibilité pour l'utilisateur de configurer cela. 



<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
