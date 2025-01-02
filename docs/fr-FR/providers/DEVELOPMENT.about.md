# Développement de Providers  

Ceci est un guide et une référence pour le fonctionnement et le développement de providers.  
Utilisez-le comme base si vous souhaitez contribuer à un provider existant ou en créer un nouveau.  

Comme vous avez peut-être déjà lu dans une introduction sur le PowershAI, les providers sont ceux qui contiennent réellement la logique pour invoquer leurs API respectives et retourner le résultat.  
Ils agissent comme un traducteur entre le PowershAI et l'API d'un service d'IA.  
Vous pourriez les imaginer comme les pilotes sous Windows, ou des plugins d'un WordPress, par exemple.  

L'objectif d'un provider est qu'il implémente tout ce dont le PowershAI a besoin pour son fonctionnement de manière transparente.  

# Comment les providers sont chargés  

Lorsque vous importez le powershai, l'une des dernières étapes qu'il effectue est de charger les providers.  
Il le fait en lisant le répertoire de providers, qui est une valeur hard-code et se trouve dans le répertoire [providers](/powershai/providers).  

Ce répertoire doit contenir un script .ps1 pour chaque provider existant.  
Le nom du fichier est traité par le powershai comme le nom du provider.  

Ce nom est important, car c'est à travers lui, par exemple, que vous activez le provider avec la commande `Set-AiProvider`.  
En raison du fait qu'il s'agit d'un fichier dans un répertoire, cela évite naturellement les doublons et le rend unique.  

Le powershai va lire le répertoire de providers, et pour chaque fichier .ps1, il va invoquer le fichier.  
Le powershell utilise l'opérateur ".", c'est-à-dire que le fichier est exécuté dans le même contexte que le cœur du Powershai (powershai.psm1).  
Cela signifie que des bugs dans un provider vont empêcher tout le powershai d'être importé.  
C'est intentionnel : s'il y a quelque chose d'incorrect dans un fichier, il est important que cela soit traité et résolu.  

Le script du provider est comme n'importe quel script powershell.  
Vous pouvez définir des fonctions, utiliser Export-ModuleMember, etc.  

La seule exigence que le powershai impose est que le script retourne une hashtable avec certaines clés obligatoires (voir ci-dessous).  

Le powershai obtient alors ce retour et crée un objet en mémoire de la session qui représente ce provider et garde ces clés retournées.  
En plus des clés par défaut exigées par le powershai, d'autres peuvent être définies, selon les besoins de chaque provider, tant qu'elles ne sont pas les mêmes clés réservées.

Optionnellement, les providers doivent implémenter des interfaces créées par le Powershai.  
Le Powershell n'a pas de concept natif d'interface orientée objet, mais ici dans le powershai, nous réutilisons ce concept car c'est pratiquement le même objectif : le powershai définit certaines opérations qui, si elles sont implémentées par le provider, activent certaines fonctionnalités. Par exemple, l'interface GetModels doit être implémentée pour que la commande `Get-AiModels` retourne correctement.  

Chaque interface définit ses règles, entrées et retours que le provider doit traiter. La section ci-dessous sur les interfaces documente toutes les interfaces.  

## Nom des commandes  Os providers doivent suivre un standard dans le nom de leurs commandes.  
Les commandes exportées du module doivent être : `Verbo`-`NomeProvider``NomeComando`.  
* Verbo doit être l'un des verbes approuvés de PowerShell.  
* NomeProvider doit être un nom valide du provider.  
Les noms valides pour le provider sont le propre nom du fichier (sans extension), ou "Ai" + nom du fichier, sans extension.  
* NomeComando est le nom commun à donner à la commande !

Pour les commandes internes, le modèle suivant doit être adopté : `NomeProvider_NomeComando`.  
notez que ce modèle est le même que celui des interfaces, donc vous ne devez pas utiliser d'interfaces.

  
# Clés du Provider  

Chaque provider doit retourner une hashtable avec une liste de clés exigées par PowerShell (appelées liste de clés réservées).  
Optionnellement, le provider peut définir d'autres clés pour un usage personnel.  

## Liste de Clés Réservées  

* DefaultModel  
Nom du modèle par défaut. C'est là que la commande `Set-aiDefaultModel` enregistre.  

* info  
Une hashtable contenant des informations sur le provider.  

* info.desc  
Brève description du provider   

* info.url  
URL pour la documentation ou la page principale sur le provider.  

* ToolsModels  
Nom de modèles (accepte regex), qui supportent l'appel de fonctions.  
Cette liste sert d'indice, si un modèle est dans celle-ci, PowerShell n'a pas besoin d'invoquer Get-AiModels pour déterminer.  

* CredentialEnvName  
Noms des variables d'environnement qui peuvent contenir des credentials par défaut !  
Array ou chaîne.  
Le format de la valeur des credentials est exclusif à chaque provider. La documentation doit clarifier comment définir.  

* DefaultEmbeddingsModel  
Modèle par défaut utilisé pour obtenir des embeddings  

* EmbeddingsModels  
Nom de modèles (accepte regex), qui supportent la génération d'embeddings.  

* IsOpenaiCompatible  
Indique que le modèle est compatible avec OpenAI. Cela permettra au provider OpenAI de déterminer correctement le provider actif actuel lorsque les fonctions dépendant du provider actuel seront invoquées. Tout provider qui réutilise les fonctions de OpenAI doit définir cette clé comme true.  

  
# Interfaces  

Les interfaces de PowerShell définissent des standards d'opérations que les providers doivent suivre.  
Grâce à ces interfaces, PowerShell peut être dynamique.  

Le provider doit implémenter une interface sous la forme d'une fonction, d'un cmdlet ou d'un alias.  
Le nom de la commande doit suivre ce modèle pour être identifié correctement : nomprovider_NomeInterface.  
`nomprovider` est le nom du fichier du provider, sans extension.  
`NomeInterface` est le nom de l'interface (conformément à la liste ci-dessous).  

  
## Liste des Interfaces  

### Chat  
Cette interface est invoquée par PowerShell chaque fois qu'il veut que le modèle LLM complète un texte.  
Elle est invoquée par Get-Aichat.  

### FormatPrompt  

Cette interface est invoquée lors de l'écriture de la réponse du LLM à l'écran.  
Elle doit retourner une chaîne avec le texte.  

### GetModels  
Invoquée lors de la liste des modèles.  
Elle ne reçoit aucun paramètre et doit retourner un tableau avec la liste des modèles.  
Chaque élément du tableau doit être un objet contenant, au minimum, les propriétés suivantes :- name  
Nom du modèle IA

- tools  
Vrai s'il prend en charge l'appel d'outil d'openai.  
Sinon, il suppose qu'il ne prend pas en charge !  
Seuls les modèles dont la valeur est vraie pourront invoquer un outil AI.

### SetCredential  
Invoquée lorsque l'utilisateur demande à définir une nouvelle crédential (token, clé API).  
Les crédentials sont le mécanisme standard de powershell pour stocker les informations sensibles dont le fournisseur peut avoir besoin pour l'authentification.  
Tous les paramètres définis en plus du premier, qui est AiCredential, seront inclus dans la fonction AiCredential.  
Chaque fois que le fournisseur est changé, la fonction sera mise à jour avec les paramètres !

### GetEmbeddings  
Invoquée lorsque l'utilisateur exécute Get-AiEmbeddings, pour obtenir les embeddings d'un ou plusieurs extraits de texte.  
Consultez Get-AiEmbeddings pour les détails des paramètres à traiter et le résultat.


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
