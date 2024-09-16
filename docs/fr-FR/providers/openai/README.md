# Fournisseur OpenAI  

# RÉSUMÉ <!--! @#Short --> 

Ceci est la documentation officielle du fournisseur OpenAI de PowershAI.

# DÉTAILS  <!--! @#Long --> 

Le fournisseur OpenAI fournit toutes les commandes pour communiquer avec les services d'OpenAI.  
Les cmdltets de ce fournisseur ont le format Verbo-OpenaiNoms.  
Le fournisseur implémente les appels HTTP comme documenté dans https://platform.openai.com/docs/api-reference

**Remarque**: Toutes les fonctionnalités de l'API ne sont pas encore implémentées


## Configuration initiale 

Utiliser le fournisseur OpenAI implique essentiellement de l'activer et de configurer le jeton.  
Vous devez générer un jeton API sur le site Web d'OpenAI. Autrement dit, vous devrez créer un compte et insérer des crédits.  
Consultez https://platform.openai.com/api-keys pour plus d'informations

Une fois que vous avez ces informations, vous pouvez exécuter le code suivant pour activer le fournisseur :

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

Si vous exécutez en arrière-plan (sans interactivité), le jeton peut être configuré en utilisant la variable d'environnement `OPENAI_API_KEY`.  

Avec le jeton configuré, vous êtes prêt à invoquer l'utilisation du Chat de Powershai :

```
ia "Bonjour, je vous parle depuis Powershai"
```

Et, bien sûr, vous pouvez appeler les commandes directement :

```
Get-OpenaiChat -prompt "s: Vous êtes un bot qui répond aux questions sur powershell","Comment afficher l'heure actuelle ?"
```




* Utilisez Set-AiProvider openai (c'est la valeur par défaut)
Vous pouvez éventuellement passer une URL alternative

* Utilisez Set-OpenaiToken pour configurer le jeton !


## Internes

OpenAI est un fournisseur important car, en plus de fournir divers services d'IA avancés et robustes, il sert également de guide de normalisation pour PowershAI.  
La plupart des normes définies dans PowershAI suivent les spécifications d'OpenAI, qui est le fournisseur le plus largement utilisé, et il est courant d'utiliser OpenAI comme base.  


Et, en raison du fait que d'autres fournisseurs ont tendance à suivre OpenAI, ce fournisseur est également préparé pour la réutilisation du code.  
Créer un nouveau fournisseur qui utilise les mêmes spécifications qu'OpenAI est très simple, il suffit de définir quelques variables de configuration !






<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
