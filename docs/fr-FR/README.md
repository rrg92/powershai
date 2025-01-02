# Powershai

# RESUMÉ <!--! @#Short --> 

PowershAI (Powershell + AI) est un module qui ajoute l'accès à l'IA via Powershell

# DÉTAILS  <!--! @#Long --> 

PowershAI (PowerShell + AI) est un module qui intègre des services d'Intelligence Artificielle directement dans PowerShell.  
Vous pouvez invoquer les commandes tant dans des scripts que dans la ligne de commande.  

Il existe plusieurs commandes qui permettent des conversations avec des LLMs, invoquer des espaces de Hugging Face, Gradio, etc.  
Vous pouvez discuter avec le GPT-4o-mini, gemini flash, llama 3.3, etc., en utilisant vos propres tokens de ces services.  
C'est-à-dire que vous ne payez rien pour utiliser PowershAI, en dehors des coûts que vous auriez normalement en utilisant ces services payants ou en les exécutant localement.

Ce module est idéal pour intégrer des commandes PowerShell avec vos LLM préférés, tester des appels, des POCs, etc.  
Il est idéal pour ceux qui sont déjà familiarisés avec PowerShell et qui souhaitent apporter l'IA à leurs scripts de manière plus simple et facile !

> [!IMPORTANT]
> Ce n'est pas un module officiel OpenAI, Google, Microsoft ou de tout autre fournisseur énuméré ici !
> Ce projet est une initiative personnelle et, avec l'objectif d'être maintenu par la propre communauté open source.

Les exemples suivants montrent comment vous pouvez utiliser PowershAI.

## Par où commencer 

La [doc d'exemples](examples/) contient divers exemples pratiques sur la façon de l'utiliser.  
Commencez par [l'exemple 0001], et avancez un à un, pour apprendre progressivement à utiliser PowershAI du basique à l'avancé.

Voici quelques exemples simples et rapides pour vous faire comprendre ce que PowershAI est capable de faire :

```powershell 
import-module powershai 

#  Interpréter les journaux de Windows en utilisant le GPT d'OpenAI
Set-AiProvider openai 
Set-AiCredential 
Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Y a-t-il un événement important ?"

# Décrire les services Windows en utilisant Google Gemini
Set-AiProvider google
Set-AiCredential
Get-Service | ia "Faites un résumé des services qui ne sont pas natifs de Windows et qui peuvent représenter un risque"

# Expliquer les commits de GitHub en utilisant Sabia, LLM brésilien de Maritaca AI 
Set-AiProvider maritalk
Set-AiCredential # configure un token pour Maritaca.AI (LLM brésilien)
git log --oneline | ia "Faites un résumé de ces commits effectués"
```

### Installation

Toute la fonctionnalité se trouve dans le répertoire `powershai`, qui est un module PowerShell.  
L'option la plus simple d'installation est avec la commande `Install-Module`:

```powershell
Install-Module powershai -Scope CurrentUser
```

Après l'installation, il suffit de l'importer dans votre session :

```powershell
import-module powershai

# Voir les commandes disponibles
Get-Command -mo powershai
```

Vous pouvez également cloner ce projet directement et importer le répertoire powershai :

```powershell
cd CHEMIN

# Cloner
git clone ...

# Importer à partir du chemin spécifique !
Import-Module .\powershai
```

### Prochaines étapes 

Après avoir installé PowershAI, vous pouvez déjà commencer à l'utiliser.  
Pour commencer à utiliser, vous devez choisir un fournisseur et configurer les authentifications pour celui-ci.  Um provider est ce qui connecte le powershai à une API d'un modèle. Il en existe plusieurs implémentés.  
Voir l'[exemple 0001] pour comprendre comment utiliser les providers.  
Consultez la [doc de providers](providers/) pour en savoir plus sur l'architecture et le fonctionnement.

Voici un script simple pour lister les providers :
```powershell 
import-module powershai

# Liste des providers 
Get-AiProviders

# Vous devez consulter la documentation de chaque provider pour des détails sur son utilisation !
# La documentation peut être consultée en utilisant get-help 
Get-Help about_NomeProvider

# Exemple :
Get-Help about_huggingface
```

### Obtention d'aide  

Malgré les efforts pour documenter le PowershAI au maximum, il est très probable que nous ne parvenions pas à temps à créer toute la documentation nécessaire pour clarifier les doutes, ou même à parler de toutes les commandes disponibles.  C'est pourquoi il est important que vous sachiez faire un peu de cela par vous-même. 

Vous pouvez lister toutes les commandes disponibles en exécutant la commande `Get-Command -mo powershai`.  
Cette commande renverra tous les cmdlets, alias et fonctions exportés du module powerhsai.  
C'est le point de départ le plus facile pour découvrir quelles commandes existent. Beaucoup de commandes sont auto-explicatives, rien qu'en regardant le nom.  

Et, pour chaque commande, vous pouvez obtenir plus de détails en utilisant `Get-Help -Full NomeComando`.
Si la commande n'a toujours pas une documentation complète, ou si une question que vous avez est manquante, vous pouvez ouvrir une issue sur git demandant plus de complément.  

Enfin, vous pouvez explorer le code source de PowershAI, en cherchant des commentaires laissés tout au long du code, qui peuvent expliquer un fonctionnement ou une architecture, de manière plus technique.  

Nous mettrons à jour la documentation au fur et à mesure que de nouvelles versions seront publiées.
Nous vous encourageons à contribuer à PowershAI, en soumettant des Pull Requests ou des issues avec des améliorations de la documentation si vous trouvez quelque chose qui pourrait être mieux expliqué, ou qui n'a pas encore été expliqué.  


## Architecture de base de PowershAI 

Cette section fournit un aperçu général de PowershAI.  
Je recommande de lire cela après avoir suivi au moins l'[exemple 0001], afin que vous soyez plus familiarisé avec l'utilisation. 


## Structure des commandes  

PowershAI exporte diverses commandes qui peuvent être utilisées.  
La plupart de ces commandes contiennent "Ai" ou "Powershai". 
Nous appelons ces commandes `commandes globales` de Powershai, car ce ne sont pas des commandes pour un provider spécifique.

Par exemple : `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Les providers exportent également des commandes, qui auront généralement un nom de provider. Consultez la documentation du provider pour en savoir plus sur le schéma des commandes exportées.  

Par convention, aucun provider ne doit implémenter des commandes avec "Ai" ou "Powershai" dans le nom, car elles sont réservées aux commandes globales, indépendamment du provider.  
Cependant, les noms Ai + NomeProvider peuvent encore être utilisés par ceux-ci (ex. : AiHuggingFace*, AiOpenai*, AiAzure*, AiGoogle*) et sont réservés uniquement au provider.```markdown
Aussi, les alias définis par les fournisseurs doivent toujours contenir plus de 5 caractères. Les alias plus courts sont réservés aux commandes globales.

Vous pouvez trouver la documentation de ces commandes dans la [doc de commandes globales](cmdlets/).  
Vous pouvez utiliser la commande Get-PowershaiGlobalCommands pour obtenir la liste !

### Fournisseurs  

Les fournisseurs sont des scripts qui connectent le powershai aux divers fournisseurs d'IA à travers le monde.  
La [documentation des fournisseurs](providers) est le lieu officiel pour obtenir de l'aide sur le fonctionnement de chaque fournisseur.  
Cette documentation peut également être consultée via la commande `Get-Help` de PowerShell.  

La documentation des fournisseurs est toujours disponible via l'aide `about_Powershai_NomeProvider_Topico`.  
Le sujet `about_Powershai_NomeProvider` est le point de départ et doit toujours contenir les informations initiales pour les premiers usages, ainsi que les explications pour le bon usage des autres sujets.  


### Chats  

Les Chats sont le principal point de départ et vous permettent de discuter avec les différents LLM proposés par les fournisseurs.  
Voir le document [chats](CHATS.about.md) pour plus de détails. Voici une introduction rapide aux chats.

#### Conversation avec le modèle

Une fois que la configuration initiale du fournisseur est faite, vous pouvez commencer la conversation !  
Le moyen le plus simple de commencer la conversation est d'utiliser la commande `Send-PowershaiChat` ou l'alias `ia` :

```powershell
ia "Bonjour, connaissez-vous PowerShell ?"
```

Cette commande enverra le message au modèle du fournisseur qui a été configuré et la réponse sera affichée ensuite.  
Notez que le temps de réponse dépend de la capacité du modèle et du réseau.  

Vous pouvez utiliser le pipeline pour transmettre le résultat d'autres commandes directement comme contexte de l'ia :

```powershell
1..100 | Get-Random -count 10 | ia "Parlez-moi des curiosités sur ces numéros"
```  
La commande ci-dessus générera une séquence de 1 à 100 et enverra chaque numéro dans le pipeline de PowerShell.  
Ensuite, la commande Get-Random filtrera seulement 10 de ces numéros, aléatoirement.  
Et enfin, cette séquence sera envoyée (toute d'un coup) à l'ia et sera envoyée avec le message que vous avez mis dans le paramètre.  

Vous pouvez utiliser le paramètre `-ForEach` pour que l'ia traite chaque entrée une par une, par exemple :

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Parlez-moi des curiosités sur ces numéros"
```  

La différence avec la commande ci-dessus est que l'IA sera appelée 10 fois, une fois pour chaque numéro.  
Dans l'exemple précédent, elle sera appelée seulement une fois, avec les 10 numéros.  
L'avantage d'utiliser cette méthode est de réduire le contexte, mais cela peut prendre plus de temps, car plus de requêtes seront effectuées.  
Testez selon vos besoins !

#### Mode objet  

Par défaut, la commande `ia` ne retourne rien. Mais vous pouvez modifier ce comportement en utilisant le paramètre `-Object`.  
Lorsque ce paramètre est activé, il demande au LLM de générer le résultat en JSON et écrit le retour dans le pipeline.  
Cela signifie que vous pouvez faire quelque chose comme ceci :

```powershell
```ia -Obj "5 nombres aléatoires, avec leur valeur écrite en toutes lettres"

#ou en utilisant l'alias, io/powershellgallery/dt/powershai

io "5 nombres aléatoires, avec leur valeur écrite en toutes lettres"
```  

**IMPORTANT : Notez que tous les fournisseurs ne peuvent pas prendre en charge ce mode, car le modèle doit être capable de prendre en charge JSON ! Si vous recevez des erreurs, confirmez si la même commande fonctionne avec un modèle de OpenAI. Vous pouvez également ouvrir une issue**


### Sauvegarde des configurations  

Le PowershAI permet d'ajuster une série de configurations, telles que les paramètres de chat, les jetons d'authentification, etc.  
Chaque fois que vous modifiez une configuration, celle-ci est enregistrée uniquement en mémoire de votre session Powershell.  
Si vous fermez et ouvrez à nouveau, toutes les configurations effectuées seront perdues.  

Pour que vous n'ayez pas à générer des jetons à chaque fois, par exemple, le Powershai fournit 2 commandes pour exporter et importer des configurations.  
La commande `Export-PowershaiSettings` exporte les configurations vers un fichier dans le répertoire profile de l'utilisateur connecté.  
En raison du fait que les données exportées peuvent être sensibles, vous devez fournir un mot de passe, qui sera utilisé pour générer une clé de cryptage.  
Les données exportées sont cryptées à l'aide de AES-256.  
Vous pouvez importer en utilisant `Import-PowershaiSettings`. Vous devrez fournir le mot de passe que vous avez utilisé pour exporter.  

Notez que ce mot de passe n'est stocké nulle part, donc vous êtes responsable de le mémoriser ou de le conserver dans un coffre de votre choix.

### Coûts  

Il est important de rappeler que certains fournisseurs peuvent facturer les services utilisés.  
Le PowershAI ne gère aucun coût. Il peut injecter des données dans des invites, des paramètres, etc.  
Vous devez suivre à l'aide des outils que le site du fournisseur fournit à cet effet.  

De futures versions pourraient inclure des commandes ou des paramètres qui aident à mieux contrôler, mais pour l'instant, l'utilisateur doit surveiller.  



### Export et Import des Configurations et Tokens

Pour faciliter la réutilisation des données (jetons, modèles par défaut, historique des chats, etc.), le PowershAI vous permet d'exporter la session.  
Pour cela, utilisez la commande `Export-PowershaiSettings`. Vous devrez fournir un mot de passe, qui sera utilisé pour créer une clé et crypter ce fichier.  
Ce n'est qu'avec ce mot de passe que vous pourrez l'importer à nouveau. Pour importer, utilisez la commande `Import-PowershaiSettings`.  
Par défaut, les Chats ne sont pas exportés. Pour les exporter, vous pouvez ajouter le paramètre -Chats : `Export-PowershaiSettings -Chats`.  
Notez que cela peut rendre le fichier plus volumineux, en plus d'augmenter le temps d'export/import. L'avantage est que vous pouvez continuer la conversation entre différentes sessions.  
Cette fonctionnalité a été créée à l'origine dans le but d'éviter d'avoir à générer une clé API chaque fois que vous avez besoin d'utiliser le PowershAI. Avec elle, vous générez une fois vos clés API dans chaque fournisseur et exportez au fur et à mesure que vous mettez à jour. Comme cela est protégé par un mot de passe, vous pouvez le conserver tranquillement dans un fichier sur votre ordinateur.  Utilisez l'aide de la commande pour obtenir plus d'informations sur son utilisation.

#  NOTES 

## Autres Projets avec PowerShell

Voici quelques autres projets intéressants qui intègrent PowerShell avec l'IA :

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

# EXEMPLES <!--! @#Ex -->

## Utilisation de base 

Utiliser le PowershAI est très simple. L'exemple ci-dessous montre comment vous pouvez l'utiliser avec OpenAI :

```powershell 
# Changez le fournisseur actuel pour OpenAI
Set-AiProvider openai 

# Configurez le token d'authentification (Vous devez générer le token sur le site platform.openai.com)
Set-OpenaiToken 

# Utilisez l'une des commandes pour démarrer un chat ! ia est un alias pour Send-PowershaiChat, qui envoie un message dans le chat par défaut !
ia "Bonjour, je parle de Powershaui avec vous !"
```

## Exporter des configurations 


```powershell 
# définissez un token, par exemple 
Set-OpenaiToken 

# Après avoir exécuté la commande ci-dessus, il suffit d'exporter !
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

Le PowershAI dispose d'une gamme de commandes disponibles.  
Chaque fournisseur fournit une série de commandes avec un schéma de nomenclature.  
Vous devez toujours lire la documentation du fournisseur pour obtenir plus de détails sur son utilisation.  

# Dépannage <!--! @#Troub -->

Bien qu'il possède beaucoup de code et ait déjà beaucoup de fonctionnalités, le PowershAI est un projet nouveau, qui est en cours de développement.  
Certains bugs peuvent être rencontrés et, à ce stade, il est important que vous aidiez toujours en rapportant, via des problèmes, dans le dépôt officiel à https://github.com/rrg92/powershai  

Si vous souhaitez dépanner un problème, je vous recommande de suivre ces étapes :

- Utilisez le Débogage pour vous aider. Des commandes comme Set-PSBreakpoint sont simples à invoquer dans la ligne de commande et peuvent vous faire gagner du temps.
- Certaines fonctions n'affichent pas l'erreur complète. Vous pouvez utiliser la variable $error, et accéder à la dernière. Par exemple :  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # Cela aide à trouver la ligne exacte où l'exception s'est produite !
```

# Voir aussi <!--! @#Also -->

- Vidéo sur Comment utiliser le fournisseur Hugging Face : https://www.youtube.com/watch?v=DOWb8MTS5iU
- Consultez la documentation de chaque fournisseur pour plus de détails sur l'utilisation de ses cmdlets

# Tags <!--! @#Kw -->

- Intelligence Artificielle
- IA



[exemple 0001]: examples/0001.md


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
