# Powershai

# RÉSUMÉ <!--! @#Short --> 

PowershAI (Powershell + IA) est un module qui ajoute l'accès à l'IA via Powershell

# DÉTAILS  <!--! @#Long --> 

PowershAI est un module qui ajoute des fonctionnalités d'IA à votre session Powershell.  
L'objectif est de faciliter et d'encapsuler les appels et traitements complexes pour les API des principaux services d'IA existants.  

PowershAI définit un ensemble de normes qui permettent à l'utilisateur de converser avec des LLMs, directement depuis l'invite, ou d'utiliser le résultat de commandes comme contexte dans un prompt.  
Et, grâce à un ensemble standardisé de fonctions, différents fournisseurs peuvent être utilisés : Par exemple, vous pouvez converser avec le GPT-4o ou le Gemini Flash en utilisant exactement le même code.  

En plus de cette standardisation, PowershAI expose également les fonctions internes et spécifiques pour se connecter aux différents fournisseurs de services d'IA.  
Ainsi, vous pouvez personnaliser et créer des scripts qui utilisent des fonctionnalités spécifiques de ces API.  

L'architecture de PowershAI définit le concept de "provider" qui sont des fichiers implémentant tous les détails nécessaires pour converser avec leurs API respectives.  
De nouveaux fournisseurs peuvent être ajoutés, avec de nouvelles fonctionnalités, au fur et à mesure qu'ils deviennent disponibles.  

En fin de compte, vous avez plusieurs options pour commencer à utiliser l'IA dans vos scripts.

Exemples de fournisseurs célèbres déjà implémentés totalement ou partiellement :

- OpenAI 
- Hugging Face 
- Gemini 
- Ollama
- Maritalk (LLM brésilien)

Pour commencer à utiliser PowershAI, c'est très simple : 

```powershell 
# Installez le module !
Install-Module -Scope CurrentUser powershai 

# Importez !
import-module powershai

# Liste des fournisseurs 
Get-AiProviders

# Vous devez consulter la documentation de chaque fournisseur pour des détails sur son utilisation !
# La documentation peut être consultée en utilisant get-help 
Get-Help about_NomProvider

# Exemple :
Get-Help about_huggingface
```

## Obtenir de l'aide  

Malgré les efforts pour documenter PowershAI au maximum, il est très probable que nous ne parvenions pas à créer toute la documentation nécessaire pour éclaircir les doutes, ou même pour parler de toutes les commandes disponibles.  C'est pourquoi il est important que vous sachiez faire un peu de cela par vous-même. 

Vous pouvez lister toutes les commandes disponibles avec la commande `Get-Command -mo powershai`.  
Cette commande retournera tous les cmdlets, alias et fonctions exportés du module powershai.  
C'est le point de départ le plus facile pour découvrir quelles commandes existent. Beaucoup de commandes sont auto-explicatives, rien qu'en regardant le nom.  

Et, pour chaque commande, vous pouvez obtenir plus de détails en utilisant `Get-Help -Full NomCommande`.  
Si la commande n'a toujours pas de documentation complète, ou si une question que vous avez est manquante, vous pouvez ouvrir un problème sur git en demandant plus de compléments.  

Enfin, vous pouvez explorer le code source de PowershAI, à la recherche de commentaires laissés tout au long du code, qui peuvent expliquer un fonctionnement ou une architecture, de manière plus technique.  

Nous mettrons à jour la documentation au fur et à mesure que de nouvelles versions seront publiées.  
Nous vous encourageons à contribuer à PowershAI, en soumettant des Pull Requests ou des problèmes avec des améliorations de la documentation si vous trouvez quelque chose qui pourrait être mieux expliqué, ou qui n'a pas encore été expliqué.  


## Structure des commandes  

PowershAI exporte plusieurs commandes qui peuvent être utilisées.  
La plupart de ces commandes contiennent "Ai" ou "Powershai". 
Nous appelons ces commandes des `commandes globales` de Powershai, car elles ne sont pas des commandes pour un fournisseur spécifique.

Par exemple : `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Les fournisseurs exportent également des commandes, qui auront généralement un nom de fournisseur. Consultez la documentation du fournisseur pour en savoir plus sur le standard des commandes exportées.  

Par convention, aucun fournisseur ne doit implémenter de commandes avec "Ai" ou "Powershai" dans le nom, car elles sont réservées aux commandes globales, indépendamment du fournisseur.  
De plus, les alias définis par les fournisseurs doivent toujours contenir plus de 5 caractères. Les alias plus courts sont réservés aux commandes globales.

Vous pouvez trouver la documentation de ces commandes dans la [doc de commandes globales](cmdlets/).  
Vous pouvez également utiliser la commande Get-PowershaiGlobalCommands pour obtenir la liste !

## Documentation des Providers  

La [documentation des fournisseurs](providers) est le lieu officiel pour obtenir de l'aide sur le fonctionnement de chaque fournisseur.  
Cette documentation peut également être consultée via la commande `Get-Help` de Powershell.  

La documentation des fournisseurs est toujours disponible via l'aide `about_Powershai_NomProvider_Sujet`.  
Le sujet `about_Powershai_NomProvider` est le point de départ et doit toujours contenir les informations initiales pour les premières utilisations, ainsi que les explications pour le bon usage des autres sujets.  


## Chats  

Les Chats sont le principal point de départ et vous permettent de converser avec les différents LLM mis à disposition par les fournisseurs.  
Voir le document [chats](CHATS.about.md) pour plus de détails. Voici une introduction rapide aux chats.

### Converser avec le modèle

Une fois que la configuration initiale du fournisseur est faite, vous pouvez commencer la conversation !  
La manière la plus simple de commencer la conversation est d'utiliser la commande `Send-PowershaiChat` ou l'alias `ia` :

```powershell
ia "Bonjour, connaissez-vous PowerShell ?"
```

Cette commande enverra le message au modèle du fournisseur qui a été configuré et la réponse sera affichée ensuite.  
Notez que le temps de réponse dépend de la capacité du modèle et du réseau.  

Vous pouvez utiliser le pipeline pour passer le résultat d'autres commandes directement comme contexte pour l'ia :

```powershell
1..100 | Get-Random -count 10 | ia "Parle-moi des curiosités concernant ces nombres"
```  
La commande ci-dessus générera une séquence de 1 à 100 et passera chaque nombre dans le pipeline de PowerShell.  
Ensuite, la commande Get-Random filtrera seulement 10 de ces nombres, aléatoirement.  
Et enfin, cette séquence sera envoyée (toute d'un coup) à l'ia avec le message que vous avez mis dans le paramètre.  

Vous pouvez utiliser le paramètre `-ForEach` pour que l'ia traite chaque entrée une par une, par exemple :

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Parle-moi des curiosités concernant ces nombres"
```  

La différence avec cette commande ci-dessus est que l'IA sera appelée 10 fois, une pour chaque nombre.  
Dans l'exemple précédent, elle sera appelée seulement une fois, avec les 10 nombres.  
L'avantage d'utiliser cette méthode est de réduire le contexte, mais cela peut prendre plus de temps, car plus de requêtes seront faites.  
Testez selon vos besoins !

### Mode objet  

Par défaut, la commande `ia` ne retourne rien. Mais vous pouvez modifier ce comportement en utilisant le paramètre `-Object`.  
Lorsque ce paramètre est activé, il demande au LLM de générer le résultat en JSON et écrit le retour dans le pipeline.  
Cela signifie que vous pouvez faire quelque chose comme :

```powershell
ia -Obj "5 nombres aléatoires, avec leur valeur écrite en toutes lettres"

# ou en utilisant l'alias, io/powershellgallery/dt/powershai

io "5 nombres aléatoires, avec leur valeur écrite en toutes lettres"
```  

**IMPORTANT : Notez que tous les fournisseurs ne peuvent pas prendre en charge ce mode, car le modèle doit être capable de supporter JSON ! Si vous recevez des erreurs, confirmez si la même commande fonctionne avec un modèle d'OpenAI. Vous pouvez également ouvrir un problème**


## Sauvegarde des configurations  L'outil PowershAI permet d'ajuster un certain nombre de configurations, telles que des paramètres de chat, des jetons d'authentification, etc.  
Chaque fois que vous modifiez une configuration, celle-ci est enregistrée uniquement en mémoire de votre session Powershell.  
Si vous fermez et rouvrez, toutes les configurations effectuées seront perdues.  

Pour que vous n'ayez pas à générer des jetons à chaque fois, par exemple, PowershAI fournit 2 commandes pour exporter et importer des configurations.  
La commande `Export-PowershaiSettings` exporte les configurations vers un fichier dans le répertoire de profil de l'utilisateur connecté.  
En raison du fait que les données exportées peuvent être sensibles, vous devez fournir un mot de passe, qui sera utilisé pour générer une clé de cryptage.  
Les données exportées sont cryptées en utilisant AES-256.  
Vous pouvez importer en utilisant `Import-PowershaiSettings`. Vous devrez fournir le mot de passe que vous avez utilisé pour exporter.  

Notez que ce mot de passe n'est stocké nulle part, donc vous êtes responsable de le mémoriser ou de le conserver dans un coffre de votre choix.

## Coûts  

Il est important de se rappeler que certains fournisseurs peuvent facturer pour les services utilisés.  
PowershAI ne gère aucun coût. Il peut injecter des données dans des invites, des paramètres, etc.  
Vous devez faire le suivi en utilisant les outils que le site du fournisseur fournit à cet effet.  

Les futures versions peuvent inclure des commandes ou des paramètres qui aident à mieux contrôler, mais pour l'instant, l'utilisateur doit surveiller.  

### Export et Import de Configurations et de Jetons

Pour faciliter la réutilisation des données (jetons, modèles par défaut, historique des chats, etc.), PowershAI vous permet d'exporter la session.  
Pour cela, utilisez la commande `Export-PowershaiSettings`. Vous devrez fournir un mot de passe, qui sera utilisé pour créer une clé et chiffrer ce fichier.  
Ce n'est qu'avec ce mot de passe que vous pourrez l'importer à nouveau. Pour importer, utilisez la commande `Import-PowershaiSettings`.  
Par défaut, les Chats ne sont pas exportés. Pour les exporter, vous pouvez ajouter le paramètre -Chats : `Export-PowershaiSettings -Chats`.  
Notez que cela peut rendre le fichier plus volumineux, en plus d'augmenter le temps d'export/import. L'avantage est que vous pouvez continuer la conversation entre différentes sessions.  
Cette fonctionnalité a été créée à l'origine dans le but d'éviter d'avoir à générer une clé API à chaque fois que vous deviez utiliser PowershAI. Avec elle, vous générez une fois vos clés API chez chaque fournisseur, et vous les exportez au fur et à mesure que vous les mettez à jour. Comme cela est protégé par mot de passe, vous pouvez le conserver en toute sécurité dans un fichier sur votre ordinateur.  
Utilisez l'aide sur la commande pour obtenir plus d'informations sur son utilisation.

# EXEMPLES <!--! @#Ex -->

## Utilisation de base 

Utiliser PowershAI est très simple. L'exemple ci-dessous montre comment vous pouvez utiliser avec OpenAI :

```powershell 
# Changez le fournisseur actuel pour OpenAI
Set-AiProvider openai 

# Configurez le jeton d'authentification (Vous devez générer le jeton sur le site platform.openai.com)
Set-OpenaiToken 

# Utilisez l'une des commandes pour démarrer un chat ! ia est un alias pour Send-PowershaiChat, qui envoie un message dans le chat par défaut !
ia "Bonjour, je parle de PowershAI avec vous !"
```

## Exporter des configurations 

```powershell 
# définissez un jeton, par exemple 
Set-OpenaiToken 

# Après que la commande ci-dessus ait été exécutée, il suffit d'exporter !
Export-PowershaiSettings

# Vous devrez fournir le mot de passe !
```

## Importer des configurations 

```powershell 
import-module powershai 

# Importez les configurations 
Import-PowershaiSettings # La commande demandera le mot de passe utilisé lors de l'exportation
```

# Informations Importantes <!--! @#Note -->

PowershAI dispose d'une gamme de commandes disponibles.  
Chaque fournisseur fournit une série de commandes avec un modèle de nomenclature.  
Vous devez toujours lire la documentation du fournisseur pour obtenir plus de détails sur son utilisation.  

# Résolution de problèmes <!--! @#Troub -->

Bien qu'il dispose d'un code assez conséquent et ait déjà de nombreuses fonctionnalités, PowershAI est un projet nouveau, en développement.  
Certains bugs peuvent être rencontrés et, à ce stade, il est important que vous aidiez toujours en rapportant, via des issues, dans le dépôt officiel à https://github.com/rrg92/powershai  

Si vous souhaitez résoudre un problème, je vous recommande de suivre ces étapes :

- Utilisez le débogage pour vous aider. Des commandes comme Set-PSBreakpoint sont simples à invoquer en ligne de commande et peuvent vous faire gagner du temps.
- Certaines fonctions n'affichent pas l'erreur complète. Vous pouvez utiliser la variable $error, et accéder à la dernière. Par exemple :  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # Cela aide à trouver la ligne exacte où l'exception s'est produite !
```

# Voir aussi <!--! @#Also -->

- Vidéo sur Comment utiliser le fournisseur Hugging Face : https://www.youtube.com/watch?v=DOWb8MTS5iU
- Consultez la documentation de chaque fournisseur pour plus de détails sur l'utilisation de ses cmdlets.

# Tags <!--! @#Kw -->

- Intelligence Artificielle
- IA


_Traduit automatiquement en utilisant PowershAI et IA._
