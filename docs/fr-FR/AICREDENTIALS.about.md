# Ai Credentials 


# Introduction <!--! @#Short --> 

AI Credentials est un mécanisme de powershai qui permet de configurer des identifiants et des tokens d'accès aux API des fournisseurs. 

# Détails  <!--! @#Long --> 

La plupart des fournisseurs disponibles dans powershai nécessitent un certain type d'authentification.  
Que ce soit via API Token, JWT, oauth, etc., il peut être nécessaire de fournir un certain type d'identifiant.

Les premières versions de Powershai laissaient libre à chaque fournisseur d'implémenter ses propres commandes d'authentification.  
Mais, étant donné que c'est un processus commun à presque tous les fournisseurs, nous avons compris qu'il était important de normaliser la façon dont ces identifiants sont créés et accessibles.  
Ainsi, les utilisateurs ont un moyen standard de s'authentifier, en utilisant toujours les mêmes commandes, ce qui est plus facile, même pour obtenir de l'aide.

C'est ainsi qu'est né l'AI Credentials : un mécanisme standard de powershai pour gérer les identifiants des fournisseurs.  

## Définir des identifiants 

Pour créer un nouvel identifiant, utilisez Set-AiCredential :

```powershell 
Set-AiCredential
```

Set-AiCredential est un alias pour la commande définitive définie par le fournisseur actuel.  
Chaque fournisseur peut fournir une implémentation spécifique, qui contient son propre code et ses paramètres.  

Le PowershAI gère vers où cet alias pointe, selon le fournisseur qui est changé.  

Le fournisseur peut fournir des paramètres supplémentaires, donc `Set-AiCredential` peut contenir des paramètres différents, selon le fournisseur.  
Une autre façon de définir des identifiants est d'utiliser des variables d'environnement. Chaque fournisseur peut définir la liste des variables possibles.

Utilisez `get-help Set-AiCredential` ou consultez la documentation du fournisseur pour plus de détails et d'orientations sur la façon de fournir les paramètres et les variables d'environnement.

En option, vous pouvez définir un nom et une description pour l'identifiant, en utilisant les paramètres `-Name` `-Description`.  
Si le nom n'est pas spécifié, il utilisera un nom par défaut.  

Si un identifiant avec le même nom existe déjà, il demande si vous voulez le remplacer. Vous pouvez utiliser -force pour sauter la confirmation.  


## Utiliser des identifiants 

Les fournisseurs interagissent avec l'AI Credentials via la commande `Get-AiDefaultCredential`.  
Vous pouvez utiliser la commande pour vérifier quel identifiant sera utilisé par le fournisseur actif.  

Pour éviter d'utiliser des tokens incorrects, le powershai adopte maintenant la stratégie de ne pas utiliser un identifiant s'il n'y a pas de garantie que c'est l'intention de l'utilisateur de l'utiliser.

Basé sur cela, cette commande retourne l'identifiant par défaut. Le powershai définit un identifiant par défaut en suivant ces règles :

* S'il existe seulement 1 identifiant, il est par défaut  
* Sinon, l'utilisateur doit explicitement définir l'identifiant par défaut en utilisant Set-AiDefaultCredential

Les identifiants définis via des variables d'environnement sont traités comme par défaut.  
Cependant, si un identifiant a été défini via une variable d'environnement et qu'il existe un identifiant défini comme par défaut explicitement, alors le powershai retourne une erreur.<!--!-->
Grâce à ce mécanisme, tous les fournisseurs peuvent, de manière standard, obtenir des informations d'identification définies par l'utilisateur, selon les mêmes mécanismes de validation, tout en conservant les informations différentes qui peuvent être nécessaires. 

N'oubliez pas que pour obtenir plus d'informations et d'aide, vous pouvez utiliser la commande Get-Help `Comando`. Les commandes de AiCredential ont tendance à contenir de nombreux détails de fonctionnement non documentés dans ce sujet.
<!--!-->


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
