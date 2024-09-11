# Powershai

# RÉSUMÉ <!--! @#Short -->

PowershAI (Powershell + IA) est un module qui ajoute un accès à l'IA via Powershell

# DÉTAILS <!--! @#Long -->

Le PowershAI est un module qui ajoute des fonctionnalités d'IA à votre session Powershell.  
L'objectif est de faciliter et d'encapsuler des appels et traitements complexes pour les API des principaux services d'IA existants.

Le PowershAI définit un ensemble de normes qui permettent à l'utilisateur de converser avec des LLMs, directement depuis l'invite, ou d'utiliser le résultat de commandes comme contexte dans un prompt.  
Et, à travers un ensemble standardisé de fonctions, différents fournisseurs peuvent être utilisés : Par exemple, vous pouvez converser avec le GPT-4 ou le Gemini Flash en utilisant exactement le même code.

En plus de cette normalisation, le PowershAI expose également les fonctions internes et spécifiques pour se connecter aux différents fournisseurs de services d'IA.  
Ainsi, vous pouvez personnaliser et créer des scripts qui utilisent des fonctionnalités spécifiques de ces API.

L'architecture du PowershAI définit le concept de "provider" qui sont des fichiers qui implémentent tous les détails nécessaires pour converser avec leurs API respectives.  
De nouveaux fournisseurs peuvent être ajoutés, avec de nouvelles fonctionnalités, à mesure qu'ils deviennent disponibles.

Au final, vous avez plusieurs options pour commencer à utiliser l'IA dans vos scripts.

Exemples de fournisseurs célèbres qui sont déjà implémentés complètement ou partiellement :

- OpenAI
- Hugging Face
- Gemini
- Ollama
- Maritalk (LLM brésilien)

Pour commencer à utiliser le PowershAI, c'est très simple :

```powershell
# Installez le module !
Install-Module -Scope CurrentUser powershai

# Importez !
import-module powershai

# Liste des fournisseurs
Get-AiProviders

# Vous devez consulter la documentation de chaque fournisseur pour des détails sur son utilisation !
# La documentation peut être consultée en utilisant get-help
Get-Help about_NomeProvider

# Exemple :
Get-Help about_huggingface
```

## Obtenir de l'aide

Malgré tous les efforts pour documenter le PowershAI au maximum, il est très probable que nous ne parvenions pas à temps à créer toute la documentation nécessaire pour clarifier les doutes, ou même à parler de toutes les commandes disponibles. C'est pourquoi il est important que vous sachiez faire un peu de cela par vous-même.

Vous pouvez lister toutes les commandes disponibles en utilisant la commande `Get-Command -mo powershai`.  
Cette commande renverra tous les cmdlets, alias et fonctions exportées du module powershai.  
C'est le point de départ le plus simple pour découvrir quelles commandes existent. De nombreuses commandes sont auto-explicatives, il suffit de regarder le nom.

Et, pour chaque commande, vous pouvez obtenir plus de détails en utilisant `Get-Help -Full NomeComando`.  
Si la commande n'a toujours pas de documentation complète, ou si une question que vous avez est manquante, vous pouvez ouvrir un problème sur Git en demandant plus d'informations.

Enfin, vous pouvez explorer le code source du PowershAI, en cherchant des commentaires laissés tout au long du code, qui peuvent expliquer un fonctionnement ou une architecture, de manière plus technique.

Nous mettrons à jour la documentation à mesure que de nouvelles versions seront publiées.  
Nous vous encourageons à contribuer au PowershAI, en soumettant des Pull Requests ou des problèmes avec des améliorations de la documentation si vous trouvez quelque chose qui pourrait être mieux expliqué, ou qui n'a pas encore été expliqué.

## Structure des commandes

Le PowershAI exporte plusieurs commandes qui peuvent être utilisées.  
La plupart de ces commandes contiennent "Ai" ou "Powershai".  
Nous appelons ces commandes `commandes globales` du Powershai, car ce ne sont pas des commandes pour un fournisseur spécifique.

Par exemple : `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Les fournisseurs exportent également des commandes, qui auront généralement un nom du fournisseur. Consultez la documentation du fournisseur pour en savoir plus sur le modèle de commandes exportées.

Par convention, aucun fournisseur ne doit implémenter de commandes avec "Ai" ou "Powershai" dans le nom, car elles sont réservées aux commandes globales, indépendamment du fournisseur.  
De plus, les alias définis par les fournisseurs doivent toujours contenir plus de 5 caractères. Les alias plus courts sont réservés aux commandes globales.

Vous pouvez trouver la documentation de ces commandes dans la [doc des commandes globales](cmdlets/).  
Vous pouvez utiliser la commande Get-P```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Parlez-moi de curiosités sur ces nombres"
```  

La différence avec la commande ci-dessus est que l'IA sera appelée 10 fois, une pour chaque nombre.  
Dans l'exemple précédent, elle sera appelée une seule fois, avec les 10 nombres.  
L'avantage d'utiliser cette méthode est de réduire le contexte, mais cela peut prendre plus de temps, car plus de requêtes seront effectuées.  
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

**IMPORTANT : Notez que tous les fournisseurs ne peuvent pas prendre en charge ce mode, car le modèle doit être capable de supporter JSON ! Si vous recevez des erreurs, vérifiez si la même commande fonctionne avec un modèle d'OpenAI. Vous pouvez également ouvrir un problème**


## Sauvegarde des configurations  

PowershAI permet d'ajuster un certain nombre de configurations, telles que les paramètres de chat, les tokens d'authentification, etc.  
Chaque fois que vous modifiez une configuration, celle-ci est sauvegardée uniquement en mémoire de votre session Powershell.  
Si vous fermez et ouvrez à nouveau, toutes les configurations effectuées seront perdues.  

Pour ne pas avoir à générer des tokens à chaque fois, par exemple, PowershAI fournit 2 commandes pour exporter et importer des configurations.  
La commande `Export-PowershaiSettings` exporte les configurations vers un fichier dans le répertoire de profil de l'utilisateur connecté.  
En raison du fait que les données exportées peuvent être sensibles, vous devez fournir un mot de passe, qui sera utilisé pour générer une clé de cryptage.  
Les données exportées sont cryptées à l'aide de l'AES-256.  
Vous pouvez importer en utilisant `Import-PowershaiSettings`. Vous devrez fournir le mot de passe que vous avez utilisé pour l'exportation.  

Notez que ce mot de passe n'est stocké nulle part, donc vous êtes responsable de le mémoriser ou de le garder dans un coffre de votre choix.

## Coûts  

Il est important de se rappeler que certains fournisseurs peuvent facturer pour les services utilisés.  
PowershAI ne gère aucun coût. Il peut injecter des données dans des prompts, des paramètres, etc.  
Vous devez suivre les coûts en utilisant les outils fournis par le site du fournisseur pour cela.  

Les futures versions peuvent inclure des commandes ou des paramètres qui aident à mieux contrôler, mais pour l'instant, l'utilisateur doit surveiller.  



### Export et Import de Configurations et Tokens

Pour faciliter la réutilisation des données (tokens, modèles par défaut, historique des chats, etc.), PowershAI vous permet d'exporter la session.  
Pour cela, utilisez la commande `Export-PowershaiSettings`. Vous devrez fournir un mot de passe, qui sera utilisé pour créer une clé et crypter ce fichier.  
Ce n'est qu'avec ce mot de passe que vous pourrez l'importer à nouveau. Pour importer, utilisez la commande `Import-PowershaiSettings`.  
Par défaut, les Chats ne sont pas exportés. Pour les exporter, vous pouvez ajouter le paramètre -Chats : `Export-PowershaiSettings -Chats`.  
Notez que cela peut rendre le fichier plus grand, en plus d'augmenter le temps d'export/import. L'avantage est que vous pouvez continuer la conversation entre différentes sessions.  
Cette fonctionnalité a été créée à l'origine dans le but d'éviter d'avoir à générer une clé API chaque fois que vous deviez utiliser PowershAI. Avec cela, vous générez une fois vos clés API dans chaque fournisseur et les exportez au fur et à mesure que vous les mettez à jour. Comme cela est protégé par un mot de passe, vous pouvez le sauvegarder tranquillement dans un fichier sur votre ordinateur.  
Utilisez l'aide sur la commande pour obtenir plus d'informations sur son utilisation.


# EXEMPLES <!--! @#Ex -->

## Utilisation de base 

Utiliser PowershAI est très simple. L'exemple ci-dessous montre comment vous pouvez l'utiliser avec OpenAI :

```powershell
