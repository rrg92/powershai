# PowershAI

# RÉSUMÉ <!--! @#Short --> 

PowershAI (Powershell + AI) est un module qui ajoute un accès à l'IA via Powershell

# DÉTAILS  <!--! @#Long --> 

PowershAI est un module qui ajoute des fonctionnalités d'IA à votre session Powershell.  
Le but est de simplifier et d'encapsuler des appels et des traitements complexes pour les API des principaux services d'IA existants.  

PowershAI définit un ensemble de modèles qui permettent à l'utilisateur de dialoguer avec les LLM, directement depuis l'invite, ou d'utiliser le résultat des commandes comme contexte dans une invite.  
Et, via un ensemble de fonctions standardisées, différents fournisseurs peuvent être utilisés : Par exemple, vous pouvez dialoguer avec GPT-4o ou Gemini Flash en utilisant exactement le même code.  

En plus de cette standardisation, PowershAI expose également les fonctions internes et spécifiques à la connexion aux différents fournisseurs de services d'IA.  
Grâce à cela, vous pouvez personnaliser et créer des scripts qui utilisent des fonctionnalités spécifiques de ces API.  

L'architecture de PowershAI définit le concept de "fournisseur" qui sont des fichiers qui implémentent tous les détails nécessaires pour dialoguer avec leurs API respectives.  
De nouveaux fournisseurs peuvent être ajoutés, avec de nouvelles fonctionnalités, à mesure qu'ils deviennent disponibles.  

Au final, vous avez plusieurs options pour commencer à utiliser l'IA dans vos scripts. 

Exemples de fournisseurs célèbres qui sont déjà implémentés complètement ou partiellement :

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

# Vous devez consulter la documentation de chaque fournisseur pour plus de détails sur la façon de l'utiliser !
# La documentation est accessible à l'aide de get-help 
Get-Help about_NomProvider

# Exemple:
Get-Help about_huggingface
```

## Obtenir de l'aide  

Malgré l'effort pour documenter PowershAI au maximum, il est très probable que nous ne réussirons pas à créer à temps toute la documentation nécessaire pour clarifier les doutes, ou même parler de toutes les commandes disponibles.  C'est pourquoi il est important que vous sachiez faire un peu de ça vous-même. 

Vous pouvez lister toutes les commandes disponibles en exécutant la commande `Get-Command -mo powershai`.  
Cette commande va retourner tous les cmdlets, alias et fonctions exportés du module powershai.  
C'est le point de départ le plus facile pour découvrir quelles commandes. De nombreuses commandes sont auto-explicatives, il suffit de regarder le nom.  

Et, pour chaque commande, vous pouvez obtenir plus de détails en utilisant `Get-Help -Full NomComando`.
Si la commande n'a pas encore une documentation complète, ou si une question à laquelle vous avez besoin de répondre manque, vous pouvez ouvrir une issue sur git pour demander plus de complément.  

Enfin, vous pouvez explorer le code source de PowershAI, en recherchant des commentaires laissés tout au long du code, qui peuvent expliquer un fonctionnement ou une architecture, de manière plus technique.  

Nous mettrons à jour la documentation à mesure que de nouvelles versions seront publiées.
Nous vous encourageons à contribuer à PowershAI, en soumettant des Pull Requsts ou des issues avec des améliorations de la documentation si vous trouvez quelque chose qui pourrait être mieux expliqué, ou qui n'a pas encore été expliqué.  


## Structure des commandes  

PowershAI exporte de nombreuses commandes qui peuvent être utilisées.  
La plupart de ces commandes contiennent "Ai" ou "Powershai". 
Nous appelons ces commandes `commandes globales` de Powershai, car ce ne sont pas des commandes pour un fournisseur spécifique.

Par exemple : `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Les fournisseurs exportent également des commandes, qui ont généralement un nom de fournisseur. Consultez la documentation du fournisseur pour en savoir plus sur le modèle de commandes exportées.  

Par convention, aucun fournisseur ne doit implémenter de commandes avec "Ai" ou "Powershai" dans le nom, car elles sont réservées aux commandes globales, quel que soit le fournisseur.  
De plus, les alias définis par les fournisseurs doivent toujours contenir plus de 5 caractères. Les alias plus petits sont réservés aux commandes globales.

Vous pouvez trouver la documentation de ces commandes dans la [doc de commandes globales](cmdlets/).  
Vous pouvez utiliser la commande Get-PowershaiGlobalCommands pour obtenir la liste !

## Documentation des fournisseurs  

La [documentation des fournisseurs](providers) est l'endroit officiel pour obtenir de l'aide sur le fonctionnement de chaque fournisseur.  
Cette documentation est également accessible via la commande `Get-Help` de powershell.  

La documentation des fournisseurs est toujours disponible via l'aide `about_Powershai_NomProvider_Topico`.  
Le sujet `about_Powershai_NomProvider` est le point de départ et doit toujours contenir les informations initiales pour les premières utilisations, ainsi que les explications pour la bonne utilisation des autres sujets.  


## Chats  

Les chats sont le principal point de départ et vous permettent de dialoguer avec les différents LLM mis à disposition par les fournisseurs.  
Consultez le document [chats](CHATS.about.md) pour plus de détails. Voici une introduction rapide aux chats.

### Dialoguer avec le modèle

Une fois que la configuration initiale du fournisseur est terminée, vous pouvez démarrer la conversation !  
La manière la plus simple de démarrer la conversation est d'utiliser la commande `Send-PowershaiChat` ou l'alias `ia` :

```powershell
ia "Bonjour, connais-tu PowerShell ?"
```

Cette commande va envoyer le message au modèle du fournisseur qui a été configuré et la réponse sera affichée par la suite.  
Notez que le temps de réponse dépend des capacités du modèle et du réseau.  

Vous pouvez utiliser le pipeline pour injecter le résultat d'autres commandes directement comme contexte de l'IA :

```powershell
1..100 | Get-Random -count 10 | ia "Dis-moi des curiosités sur ces numéros"
```  
La commande ci-dessus va générer une séquence de 1 à 100 et injecter chaque numéro dans le pipeline de PowerShell.  
Ensuite, la commande Get-Random va filtrer uniquement 10 de ces numéros, de manière aléatoire.  
Et enfin, cette séquence sera injectée (toute d'un coup) à l'IA et sera envoyée avec le message que vous avez placé dans le paramètre.  

Vous pouvez utiliser le paramètre `-ForEach` pour que l'IA traite chaque entrée à la fois, par exemple :

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Dis-moi des curiosités sur ces numéros"
```  

La différence de cette commande ci-dessus, c'est que l'IA sera appelée 10 fois, une pour chaque numéro.  
Dans l'exemple précédent, elle ne sera appelée qu'une fois, avec les 10 numéros.  
L'avantage d'utiliser cette méthode est de réduire le contexte, mais cela peut prendre plus de temps, car plus de requêtes seront effectuées.  
Testez en fonction de vos besoins !

### Mode objet  

Par défaut, la commande `ia` ne renvoie rien. Mais vous pouvez modifier ce comportement en utilisant le paramètre `-Object`.  
Lorsque ce paramètre est activé, il demande au LLM de générer le résultat en JSON et écrit le retour dans le pipeline.  
Cela signifie que vous pouvez faire quelque chose comme ça :

```powershell
ia -Obj "5 nombres aléatoires, avec leur valeur écrite en lettres"

#ou en utilisant l'alias, io/powershellgallery/dt/powershai

io "5 nombres aléatoires, avec leur valeur écrite en lettres"
```  

**IMPORTANT : Notez que tous les fournisseurs ne prennent pas en charge ce mode, car le modèle doit être capable de prendre en charge JSON ! Si vous recevez des erreurs, vérifiez si la même commande fonctionne avec un modèle OpenAI. Vous pouvez également ouvrir une issue**


## Enregistrer les configurations  

PowershAI vous permet d'ajuster une série de configurations, comme les paramètres des chats, les jetons d'authentification, etc.  
Chaque fois que vous modifiez une configuration, cette configuration est enregistrée uniquement en mémoire de votre session Powershell.  
Si vous fermez et ouvrez à nouveau, toutes les configurations effectuées seront perdues.  

Pour que vous n'ayez pas à générer des jetons à chaque fois, par exemple, Powershai fournit 2 commandes pour exporter et importer des configurations.  
La commande `Export-PowershaiSettings`  exporte les configurations vers un fichier dans le répertoire de profil de l'utilisateur connecté.  
En raison du fait que les données exportées peuvent être sensibles, vous devez fournir un mot de passe, qui sera utilisé pour générer une clé de cryptage.  
Les données exportées sont cryptées à l'aide d'AES-256.  
Vous pouvez importer à l'aide de `Import-PowershaiSettings`. Vous devrez fournir le mot de passe que vous avez utilisé pour exporter.  

Notez que ce mot de passe n'est stocké nulle part, vous êtes donc responsable de le mémoriser ou de le conserver dans un coffre de votre choix.

## Coûts  

Il est important de se rappeler que certains fournisseurs peuvent facturer les services utilisés.  
PowershAI ne gère pas les coûts.  Il peut injecter des données dans les invites, les paramètres, etc.  
Vous devez suivre les coûts à l'aide des outils fournis par le site du fournisseur.  

Les futures versions peuvent inclure des commandes ou des paramètres qui aident à mieux contrôler, mais, pour l'instant, l'utilisateur doit surveiller.  



### Exportation et importation  de configurations et de jetons

Pour faciliter la réutilisation des données (jetons, modèles par défaut, historique des chats, etc.) PowershAI vous permet d'exporter la session.  
Pour ce faire, utilisez la commande `Export-PowershaiSettings`. Vous devrez fournir un mot de passe, qui sera utilisé pour créer une clé et crypter ce fichier.  
Seul ce mot de passe vous permettra de l'importer à nouveau. Pour importer, utilisez la commande `Import-PowershaiSettings`.  
Par défaut, les chats ne sont pas exportés. Pour les exporter, vous pouvez ajouter le paramètre -Chats : `Export-PowershaiSettings -Chats`.  
Notez que cela peut rendre le fichier plus volumineux, en plus d'augmenter le temps d'exportation/importation.  L'avantage est que vous pouvez poursuivre la conversation entre différentes sessions.  
Cette fonctionnalité a été créée à l'origine dans le but d'éviter d'avoir à générer une clé d'API à chaque fois que vous deviez utiliser PowershAI. Avec elle, vous générez une fois vos clés d'API dans chaque fournisseur, et vous exportez à mesure que vous mettez à jour. Comme elle est protégée par un mot de passe, vous pouvez l'enregistrer en toute sécurité dans un fichier sur votre ordinateur.  
Utilisez l'aide de la commande pour obtenir plus d'informations sur la façon de l'utiliser.


# EXEMPLES <!--! @#Ex -->

## Utilisation basique 

Utiliser PowershAI est très simple. L'exemple ci-dessous montre comment vous pouvez l'utiliser avec OpenAI :

```powershell 
# Modifiez le fournisseur actuel en OpenAI
Set-AiProvider openai 

# Configurez le jeton d'authentification (Vous devez générer le jeton sur le site platform.openai.com)
Set-OpenaiToken 

# Utilisez l'une des commandes pour lancer un chat !  ia est un alias pour Send-PowershaiChat, qui envoie un message dans le chat par défaut !
ia "Bonjour, je te parle de Powershaui !"
```

## Exporter les configurations 


```powershell 
# définissez un jeton, par exemple 
Set-OpenaiToken 

# Après avoir exécuté la commande ci-dessus, il suffit d'exporter !
Export-PowershaiSettings

# Vous devrez fournir le mot de passe !
```

## Importer les configurations 


```powershell 
import-module powershai 

# Importez les configurations 
Import-PowershaiSettings # La commande demandera le mot de passe utilisé lors de l'exportation
```

# Informations importantes <!--! @#Note -->

PowershAI possède une gamme de commandes disponibles.  
Chaque fournisseur fournit une série de commandes avec un modèle de nomenclature.  
Vous devez toujours lire la documentation du fournisseur pour obtenir plus de détails sur la façon de l'utiliser.  

# Résolution des problèmes <!--! @#Troub -->

Malgré le fait qu'il possède beaucoup de code et qu'il ait déjà beaucoup de fonctionnalités, PowershAI est un projet nouveau, qui est en cours de développement.  
Des bogues peuvent être trouvés et, à ce stade, il est important que vous ayez toujours de l'aide en signalant, via des issues, sur le référentiel officiel à l'adresse https://github.com/rrg92/powershai  

Si vous souhaitez déboguer un problème, je vous recommande de suivre ces étapes :

- Utilisez le débogage pour vous aider. Des commandes comme Set-PSBreakpoint sont simples à invoquer en ligne de commande et peuvent vous faire gagner du temps
- Certaines fonctions n'affichent pas l'erreur complète. Vous pouvez utiliser la variable $error, et accéder à la dernière. Par exemple :  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # Cela aide à trouver la ligne exacte où l'exception s'est produite !
```

# Voir aussi <!--! @#Also -->

- Vidéo sur l'utilisation du fournisseur Hugging Face : https://www.youtube.com/watch?v=DOWb8MTS5iU
- Consultez la documentation de chaque fournisseur pour plus de détails sur la façon d'utiliser ses cmdlets

# Balises <!--! @#Kw -->

- Intelligence Artificielle
- IA





<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
