# Fournisseur OpenAI  

# RÉSUMÉ <!--! @#Short -->  

Ceci est la documentation officielle du fournisseur OpenAI de PowershAI.

# DÉTAILS <!--! @#Long -->  

Le fournisseur OpenAI fournit toutes les commandes pour communiquer avec les services d'OpenAI.  
Les cmdlets de ce fournisseur ont le format Verbe-OpenaiNoms.  
Le fournisseur implémente les appels HTTP comme documenté sur https://platform.openai.com/docs/api-reference

**Remarque** : Toutes les fonctionnalités de l'API ne sont pas encore implémentées.

## Configurations initiales  

Utiliser le fournisseur OpenAI implique essentiellement de l'activer et de configurer le token.  
Vous devez générer un token API sur le site d'OpenAI. Autrement dit, vous devrez créer un compte et insérer des crédits.  
Vérifiez-en plus sur https://platform.openai.com/api-keys  

Une fois que vous avez ces informations, vous pouvez exécuter le code suivant pour activer le fournisseur :

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

Si vous exécutez en arrière-plan (sans interactivité), le token peut être configuré en utilisant la variable d'environnement `OPENAI_API_KEY`.  

Avec le token configuré, vous êtes prêt à invoquer le Chat de PowershAI :

```
ia "Bonjour, je parle avec vous depuis PowershAI"
```

Et, évidemment, vous pouvez invoquer les commandes directement :

```
Get-OpenaiChat -prompt "s: Vous êtes un bot qui répond aux questions sur powershell","Comment afficher l'heure actuelle ?"
```

* Utilisez Set-AiProvider openai (c'est le standard)  
Vous pouvez éventuellement passer une URL alternative.

* Utilisez Set-OpenaiToken pour configurer le token !


## Internes  

OpenAI est un fournisseur important, car en plus de fournir divers services avancés et robustes d'IA, il sert également de guide de normalisation pour PowershAI.  
La plupart des normes définies dans PowershAI suivent les spécifications d'OpenAI, qui est le fournisseur le plus largement utilisé et il est courant d'utiliser OpenAI comme base.  

Et, en raison du fait que d'autres fournisseurs ont tendance à suivre OpenAI, ce fournisseur est également préparé pour le réemploi de code.  
Créer un nouveau fournisseur qui utilise les mêmes spécifications qu'OpenAI est très simple, il suffit de définir quelques variables de configuration !


_Traduit automatiquement en utilisant PowershAI et IA._
