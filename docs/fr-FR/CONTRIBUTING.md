# Contribuant au PowershAI  

Merci beaucoup pour votre intérêt à contribuer au PowershAI !  
L'un des principaux objectifs de ce projet est qu'il soit construit à partir de l'expérience de plusieurs personnes, le rendant ainsi plus stable, robuste et unique !

Ce guide vous aidera avec tout ce dont vous avez besoin pour configurer et nos normes afin que vous puissiez modifier le projet et soumettre des modifications.


# Pré-Requis  

PowershAI est un module PowerShell relativement simple : vous avez seulement besoin d'un ordinateur avec PowerShell et d'un éditeur de texte pour le modifier.  
Sous Windows, j'aime beaucoup utiliser Notepad++, mais vous pouvez utiliser n'importe quel éditeur de votre choix, comme Visual Studio Code.

En outre, les outils dont vous aurez besoin sont pour interagir avec Git et quelques autres modules PowerShell pour exécuter des tests et/ou générer de la documentation. 

Voici une liste résumée des logiciels dont vous avez besoin :

- Un éditeur de texte de votre choix
- PowerShell installé, cela peut être Windows ou Linux.
- Git, évidemment, pour cloner le dépôt et faire des pushes
- Module Pester, si vous souhaitez exécuter des tests. Installez avec `Install-Module Pester` (vous devez le faire seulement 1x)
- Module PlatyPS, si vous souhaitez générer de la documentation. Installez avec `Install-Module PlatyPs` (vous devez le faire seulement 1x)


Une fois que vous avez tout ce dont vous avez besoin, clonez ce dépôt dans un répertoire de votre choix.  
Pour les exemples de cet article, je supposerai que vous avez cloné dans `C:\temp\powershai`, mais vous pouvez choisir n'importe quel répertoire de votre choix. 

Avant de commencer à modifier PowershAI, il est très important que vous compreniez son fonctionnement et ses commandes de base.  
Je recommande que vous consultiez la section [exemples](examples/) et que vous essayiez d'utiliser PowershAI afin de pouvoir le modifier.

Fondamentalement, vous devez être familiarisé avec la syntaxe de PowerShell, comprendre les concepts introduits par PowershAI, comme les providers, et, évidemment, avoir des notions de base sur les LLMs, les APIs et HTTP REST.


# Workflow de développement 

Ajouter ou modifier quelque chose dans PowershAI est un processus relativement simple.  
Le flux de base est le suivant :

* Créez une issue décrivant le problème, s'il n'existe pas
* Clonez le dépôt de PowershAI dans un répertoire de votre choix
* Apportez les modifications nécessaires et testez (ici incluez les modifications de code et de documentation, y compris la traduction automatique)
* Exécutez les scripts de test dans votre environnement et assurez-vous que tous les tests passent
* Générez un PR et envoyez-le en détaillant le maximum d'informations possible, toujours avec clarté. Maintenez la communication en anglais ou en portugais brésilien.
* Ajoutez dans le CHANGELOG, dans la section unreleased
* Un mainteneur devra examiner vos modifications et les approuver ou non.
* Une fois approuvé, il sera fusionné dans la branche de la prochaine version, qui sera contrôlée par un mainteneur

Connaître la structure des fichiers et des répertoires est essentiel pour déterminer ce que vous allez modifier. Voyez ci-dessous.

# Structure des Fichiers et Répertoires 

En clonant le projet, vous verrez plusieurs répertoires et fichiers, expliqués brièvement ci-dessous :|Item				| Description													|
|-------------------|---------------------------------------------------------------|
|docs				| Contient la documentation de PowershAI 						|
|powershai 			| Contient le code source de PowershAI							|
|tests 				| Contient les scripts de test de PowershAI 					|
|util 				| Contient des scripts auxiliaires de développement				|


## powershai 

Le répertoire [powershai] est le module en lui-même, c'est-à-dire, le code source de PowershAI.  
Tout comme n'importe quel module PowerShell, il contient un fichier .psm1 et un fichier .psd1.  
Le fichier [powershai.psm1] est la racine du module, c'est-à-dire, c'est le fichier qui est exécuté lorsque vous exécutez un `Import-Module powershai`.  
Le fichier [powershai.psd1] est le manifest du module, qui contient des métadonnées importantes sur le module, telles que la version, les dépendances et le copyright.

Les autres fichiers sont chargés par [powershai.psm1], automatiquement ou lorsque certains commandes sont exécutées.  
Au début, tout le code source de PowershAI se trouvait dans le fichier [powershai.psm1], mais, au fur et à mesure qu'il grandit, il est préférable pour le développement de le séparer en fichiers plus petits, regroupés par fonctionnalités. À mesure que de nouvelles versions sont publiées, de nouvelles structures et fichiers peuvent apparaître pour une meilleure organisation. 

Voici un bref résumé des fichiers et/ou répertoires les plus importants :

- [lib](/powershai/lib)  
Contient divers scripts auxiliaires avec des fonctions génériques et des utilitaires qui seront utilisés par d'autres composants de PowershAI.

- [chats.ps1](/powershai/chats.ps1)  
Contient tous les cmdlets et fonctions qui implémentent la fonctionnalité de PowershAI Chats

- [AiCredentials.ps1](/powershai/AiCredentials.ps1)  
Contient tous les cmdlets et fonctions qui implémentent la fonctionnalité de AiCredential

- [providers](/powershai/providers)  
Contient 1 fichier pour chaque fournisseur, avec le nom du fournisseur.  
Le PowershAI.psm1 chargera ces fichiers lors de son importation.  
Pour plus d'informations sur la façon de développer des fournisseurs, consultez [la documentation de développement de fournisseurs](providers/DEVELOPMENT.about.md)


Voici un résumé du flux de base de ce qui se passe lorsque vous importez le module PowershAI :

- Le fichier `powershai.psm1` définit une série de fonctions et de variables
- Il charge les fonctions définies dans les libs
- Enfin, les fournisseurs dans [providers](/powershai/providers) sont chargés


Le moyen le plus rapide de découvrir où est défini la commande que vous souhaitez modifier est de faire une recherche simple en utilisant des commandes PowerShell (ou par la recherche Git)  
Voici quelques exemples :

```powershell 
# Où se trouve la fonction Get-Aichat ?
gci -rec powershai | sls 'function Get-AiChat' -SimpleMatch

# où y a-t-il une fonction avec 'Encryption' dans le nom ?
gci -rec powershai | sls 'function.+Encryption'

#Astuce : sls est un alias pour Select-String, une commande native de PowerShell qui effectue des recherches dans le fichier en utilisant RegEx ou un match simple. Semblable à Grep sous Linux.
```

Une fois que vous avez déterminé le fichier, vous pouvez l'ouvrir dans votre éditeur préféré et commencer à l'ajuster.  Rappelez-vous de tester et de configurer les identifiants pour les fournisseurs, si vous devez invoquer une commande qui interagira avec un LLM nécessitant une authentification.

### Importation du module en développement

Normalement, vous importez le module avec la commande `Import-Module powershai`.  
Cette commande recherche le module dans le chemin des modules par défaut de PowerShell.  
Pendant le développement, vous devez l'importer depuis le chemin où vous l'avez cloné :

```
cd C:\temp\
git clone https://github.com/rrg92/powershai
cd powershai
Import-Module -force ./powershai
```

Notez que la commande spécifie `./powershai`. Cela fait en sorte que PowerShell recherche le module dans le répertoire `powershai` du répertoire actuel.  
Ainsi, vous vous assurez que vous importez le module du répertoire cloné actuellement, et non le module installé dans l'un des répertoires de modules par défaut.

> [!NOTE]
> Chaque fois que vous apportez une modification aux sources de PowershAI, vous devez importer à nouveau le module.


## tests 

Le répertoire `tests` contient tout ce qui est nécessaire pour tester le PowershAI.  
La base des tests est faite avec le module Pester, qui est un module PowerShell facilitant la création et l'exécution de tests.  

Les fichiers contenant les définitions des tests se trouvent dans le répertoire [tests/pester](/tests/pester).  
Un script appelé [tests/test.ps1](/tests/test.ps1) vous permet d'invoquer facilement Pester et gère quelques filtres afin que vous puissiez sauter des tests spécifiques pendant le développement.  

### Exécution des tests 

Le moyen le plus simple de démarrer les tests de PowershAI est d'invoquer le script :

```
tests/test.ps1
```

Sans aucun paramètre, ce script va invoquer une série de tests considérés comme "basiques".  
Pour effectuer tous les tests, passez la valeur "production" en premier argument :

```
tests/test.ps1 production
```

C'est l'option utilisée lors du test final pour une nouvelle version de PowershAI.  
Si vous avez Docker installé, vous pouvez utiliser `docker compose up --build` pour démarrer le même ensemble de tests en production qui sera effectué sur Git.  
Par défaut, une image de PowerShell Core sur Linux est utilisée. Le fichier `docker-compose.yml` et `Dockerfile` à la racine du dépôt contiennent toutes les options utilisées.

Passer le test de production est l'un des prérequis pour que vos modifications soient acceptées. Par conséquent, avant de soumettre votre PR, exécutez les tests locaux pour vous assurer que tout fonctionne comme prévu. 


### Définition des tests 

Vous devez également définir et ajuster les tests pour les modifications que vous apportez.  
Un des objectifs que nous avons pour le PowershAI est que toutes les commandes aient un test unitaire défini, en plus des tests qui valident des fonctionnalités plus complexes.  
Comme le PowershAI a commencé sans tests, il est probable qu'il existe encore de nombreuses commandes sans tests.  
Mais, au fur et à mesure que ces commandes sont modifiées, ou que de nouvelles sont ajoutées, il est obligatoire que les tests soient définis et ajustés.  

Pour créer un test, vous devez utiliser la [syntaxe du module Pester 5](https://pester.dev/docs/quick-start).  Le répertoire dans lequel le script de test va chercher est `tests/pester`, donc vous devez placer les fichiers là.  
Seuls les fichiers avec l'extension `.tests.ps1` seront chargés.  



## docs  

Le répertoire `docs` contient toute la documentation de PowershAI. Chaque sous-répertoire est spécifique à une langue et doit être identifié par le code BCP 47 (format aa-BB).  
Vous pouvez créer des fichiers Markdown directement dans le répertoire de la langue souhaitée et commencer l'édition dans la langue.  

Certains fichiers inclus ne seront accessibles que dans ce dépôt Git, cependant certains seront utilisés pour constituer une documentation accessible via la commande `Get-Help` de PowerShell.  
Le processus de publication de PowershAI générera les fichiers nécessaires avec toute la documentation, selon les langues. Ainsi, l'utilisateur pourra utiliser la commande `Get-Help`, qui déterminera la documentation correcte selon la langue et la localisation de la machine où PowershAI est exécuté.

Pour que cela fonctionne correctement, le répertoire `docs/` possède une organisation minimale qui doit être suivie afin que le processus automatique fonctionne, et, en même temps, il soit possible d'avoir une documentation minimale accessible directement ici par le dépôt Git.

### Règles du répertoire docs
Le répertoire `docs` a quelques règles simples pour mieux organiser et permettre la création des fichiers d'aide dans PowerShell :

#### Utiliser l'extension .md (Markdown) ou .about.md
Vous devez créer la documentation en utilisant des fichiers Markdown (extension `.md`).
Les fichiers ayant l'extension `.about.md` seront convertis en un sujet d'aide de PowerShell. Par exemple, le fichier `CHATS.about.md` deviendra le sujet d'aide `powershai_CHATS`.  
Pour chaque sous-répertoire où un fichier `.about.md` est trouvé, le nom du répertoire est préfixé dans le sujet d'aide. `README.md` est considéré comme le sujet d'aide du propre répertoire.
Par exemple, un fichier dans `docs/pt-BR/providers/openai/README.md` deviendra le sujet d'aide `powershai_providers_openai`.  
Le fichier `docs/pt-BR/providers/openai/INTERNALS.about.md` deviendra le sujet d'aide `powershai_providers_openai_internals`.

#### Répertoire docs/`lang`/cmdlets
Ce répertoire contient un fichier Markdown pour chaque cmdlet qui doit être documenté.  
Le contenu de ces fichiers doit suivre le format accepté par PlatyPS.  
Vous pouvez utiliser le script auxiliaire `util\Cmdlets2Markdown.ps1` pour générer les fichiers Markdown à partir de la documentation réalisée via des commentaires.

#### Répertoire docs/`lang`/providers
Contient un sous-répertoire pour chaque provider et à l'intérieur de ce sous-répertoire toute la documentation pertinente au provider doit être documentée.  
La documentation sur les providers, qui n'est pas spécifique à un provider, doit rester à la racine `docs/lang/providers`.

#### Répertoire docs/`lang`/examples
Ce répertoire contient les exemples d'utilisation de PowershAI.  
Le nom des fichiers doit suivre le format `NNNN.md`, où NNNN est un numéro de 0000 à 9999, toujours avec des zéros à gauche.

### Traduction  

La traduction de la documentation peut être effectuée de deux manières : manuellement ou avec IA en utilisant le propre PowershAI.  Pour traduire avec PowershAI, vous pouvez utiliser le script `util\aidoc.ps1`. Ce script a été créé pour permettre de rendre la documentation de PowershAI disponible dans d'autres langues rapidement. 

#### Traduction manuelle 

La traduction manuelle est très simple : copiez le fichier de la langue à partir de laquelle vous souhaitez traduire vers le même chemin dans le répertoire de la langue vers laquelle vous allez traduire.  
Ensuite, éditez le fichier, faites les révisions et faites le commit.

Les fichiers traduits manuellement ne seront pas traduits par le processus automatique décrit ci-dessous.

#### Traduction automatique 
Le processus de traduction automatique est le suivant :
- Vous écrivez la documentation dans la langue originale, générant le fichier Markdown conformément aux règles ci-dessus
- Importez le module PowershAI dans la session et assurez-vous que les identifiants sont correctement configurés
- Vous utilisez le script `util\aidoc.ps1` en passant comme origine la langue dans laquelle vous écrivez et la langue cible souhaitée. Je recommande d'utiliser Google Gemini.
- Le script générera les fichiers. Vous pouvez les réviser. Si tout est bon, alors faites un commit Git. Sinon, supprimez les fichiers indésirables ou utilisez `git restore` ou `git clean`.

Le script `AiDoc.ps1` maintient un fichier de contrôle dans chaque répertoire appelé `AiTranslations.json`. Ce fichier est utilisé pour contrôler quels fichiers ont été traduits automatiquement dans chaque langue et avec celui-ci, `AiDoc.ps1` peut déterminer quand un fichier source a été modifié, évitant les traductions de fichiers qui n'ont pas été modifiés. 

De plus, si vous éditez manuellement l'un des fichiers dans le répertoire de destination, ce fichier ne sera plus traduit automatiquement, pour éviter d'écraser une révision que vous avez faite. Ainsi, si vous modifiez les fichiers, même la plus petite modification peut empêcher la traduction automatique de se produire. Si vous souhaitez que la traduction soit effectuée malgré tout, supprimez le fichier de destination ou utilisez le paramètre `-Force` de `AiDoc.ps1`.

Voici quelques exemples d'utilisation :

```powershell 
Import-Module -force ./powershai # Importer powershai (en utilisant le propre module dans le répertoire actuel pour utiliser les dernières fonctionnalités implémentées !)
Set-AiProvider google # utilise google comme fournisseur 
Set-AiCredential # Configure les identifiants du fournisseur google (cela vous devez le faire une seule fois)

# Exemple : Traduction simple 
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US  

# Exemple : Filtrant des fichiers spécifiques 
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US  -FileFilter CHANGELOG.md

# Exemple : Traduire dans toutes les langues disponibles 
gci docs | %{ util\aidoc.ps1 -SrcLang pt-BR -TargetLang $_.name   }

```

# Versionnage dans PowershAI 

PowershAI suit le versionnement sémantique (ou un sous-ensemble de celui-ci).  

La version actuelle est contrôlée de la manière suivante :

1. Via une balise git au format vX.Y.Z
2. fichier [powershai.psd1]

Lorsqu'une nouvelle version est créée, une balise doit être attribuée au dernier commit de cette version.  
Tous les commits effectués depuis la dernière balise sont considérés comme faisant partie de cette version.  No fichier [powershai.psd1], vous devez maintenir la version compatible avec ce qui a été défini dans la balise.  
Si ce n'est pas correct, le build automatique échouera.

Un mainteneur de powershai est responsable d'approuver et/ou d'exécuter le flux de nouvelle version.  

Actuellement, PowershAI est en version `0.`, car certaines choses peuvent changer.  
Mais, nous le rendons de plus en plus stable et la tendance est que les prochaines versions soient beaucoup plus compatibles.  

La version `1.0.0` sera publiée officiellement lorsqu'il y aura suffisamment de tests par une partie de la communauté.


[powershai]: /powershai/powershai
[powershai.psm1]: /powershai/powershai.psm1
[powershai.psd1]: /powershai/powershai.psd1


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
