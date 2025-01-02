# Provider Azure OpenAI

Le provider Azure OpenAI implémente toutes les fonctions nécessaires pour se connecter à l'API des modèles qui peuvent être configurés dans votre abonnement Azure.  
Les modèles suivent le même standard que l'OpenAI, et la plupart des commandes fonctionnent exactement comme l'openai.  

# Démarrage rapide  

Utiliser le provider Azure implique les étapes suivantes :

- Créer les ressources dans le portail Azure, ou Azure AI Studio.  
	- Cela vous donnera les URL et les clés API nécessaires pour l'authentification.  
- Utiliser `Set-AiProvider azure` pour changer le provider actuel en azure.  
- Définir les informations de l'URL de l'API en utilisant la commande `Set-AiAzureApiUrl`. Le paramètre `-ChangeToken` vous permet de définir le token en même temps.  

Une fois que vous avez suivi ces étapes, vous pouvez discuter normalement en utilisant des commandes avec `ia`.  


## APIs et URL  

Pour utiliser le provider azure, activez-le en utilisant `Set-AiProvider azure`.  
Fondamentalement, azure fournit les API suivantes pour discuter avec LLM :

- API Azure OpenAI   
Cette API vous permet de discuter avec les modèles de l'OpenAI qui sont dans l'infrastructure Azure ou qui ont été provisionnés exclusivement pour vous.  

- API d'Inference  
Cette API vous permet de discuter avec d'autres modèles, comme Phi3, Llama3.1, divers modèles de hugging face, etc.  
Ces modèles peuvent être provisionnés de manière sans serveur (vous avez une API fonctionnelle, indépendamment de l'endroit où elle s'exécute, avec qui elle est partagée, etc.) ou de manière exclusive (où le modèle est mis à disposition exclusivement sur une machine pour vous). 

En fin de compte, pour vous, en tant qu'utilisateur de powershell, vous devez simplement savoir que ce provider peut ajuster correctement les appels de l'API.  
Et ils sont tous compatibles avec le même format de l'API de l'OpenAI (mais toutes les fonctionnalités peuvent ne pas être disponibles pour certains modèles, comme l'appel d'outil).  

Il est important de savoir qu'il existe ces deux types, car cela vous guidera dans la configuration initiale.  
Vous devez utiliser la commande `Set-AiAzureApiUrl` pour définir l'URL de votre API.  

Ce cmdlet est assez flexible.  
Vous pouvez spécifier une URL de l'Azure OpenAI. Ex.:

```powershell
Set-AiAzureApiUrl -ChangeToken https://iatalking.openai.azure.com/openai/deployments/gpt-4o-mini/chat/completions?api-version=2023-03-15-preview 
```

Avec la commande ci-dessus, il identifiera quelle API doit être utilisée et les paramètres corrects.  
De plus, il identifie les URL relatives à l'API d'inférence :

```powershell
Set-AiAzureApiUrl -ChangeToken https://test-powershai.eastus2.models.ai.azure.com
```

Notez l'utilisation du paramètre `-ChangeToken`.  
Ce paramètre vous oblige à insérer à nouveau le token. Il est utile lorsque vous changez, ou configurez pour la première fois.

Vous pouvez changer la clé API par la suite, si nécessaire, en utilisant la commande `Set-AiAzureApiKey`


## Liens utiles  

Les liens suivants peuvent vous aider à configurer votre Azure OpenAI et à obtenir vos identifiants.


- Vue d'ensemble de l'Azure OpenAI  
https://learn.microsoft.com/en-us/azure/ai-services/openai/overview- Création de la ressource dans le portail  
https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/create-resource?pivots=web-portal

- À propos de l'Azure AI Studio  
https://learn.microsoft.com/en-us/azure/ai-studio/what-is-ai-studio

- Référence de l'API  
https://learn.microsoft.com/en-us/azure/ai-services/openai/reference


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
