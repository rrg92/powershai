# Provider Hugging Face

Le Hugging Face est le plus grand dépôt de modèles d'IA au monde !  
Là, vous avez accès à une incroyable gamme de modèles, de jeux de données, de démonstrations avec Gradio, et bien plus encore !  

C'est le GitHub de l'intelligence artificielle, commercial et open source ! 

Le fournisseur Hugging Face de PowershAI connecte votre PowerShell à une gamme incroyable de services et de modèles.  

## Le Gradio

Gradio est un framework pour créer des démonstrations pour des modèles d'IA. Avec peu de code en Python, il est possible de déployer des interfaces qui acceptent divers inputs, comme du texte, des fichiers, etc.  
Et, en plus, il gère de nombreuses questions comme les files d'attente, les uploads, etc.  Et, pour couronner le tout, avec l'interface, il peut mettre à disposition une API afin que la fonctionnalité exposée via l'UI soit également accessible via des langages de programmation.  
PowershAI en bénéficie et expose les APIs de Gradio de manière plus simple, où il est possible d'invoquer une fonctionnalité de votre terminal et d'avoir pratiquement la même expérience !


## Hugging Face Hub  

Le Hugging Face Hub est la plateforme que vous accédez à https://huggingface.co  
Il est organisé en modèles (models), qui sont essentiellement le code source des modèles d'IA que d'autres personnes et entreprises créent à travers le monde.  
Il y a aussi les "Spaces", qui sont des endroits où vous pouvez télécharger un code pour publier des applications écrites en Python (en utilisant Gradio, par exemple) ou Docker.  

Découvrez-en plus sur Hugging Face [dans cet article de blog Ia Talking](https://iatalk.ing/hugging-face/)
Et, découvrez le Hugging Face Hub [dans la doc officielle](https://huggingface.co/docs/hub/en/index)

Avec PowershAI, vous pouvez lister des modèles et même interagir avec l'API de plusieurs espaces, exécutant les applications d'IA les plus variées à partir de votre terminal.  


# Utilisation de base

Le fournisseur Hugging Face de PowershAI possède de nombreux cmdlets pour l'interaction.  
Il est organisé dans les commandes suivantes :

* les commandes qui interagissent avec Hugging Face possèdent `HuggingFace` ou `Hf` dans le nom. Exemple : `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* les commandes qui interagissent avec Gradio, qu'elles soient un Space de Hugging Face ou non, possèdent `Gradio` ou `GradioSession` dans le nom : `Send-GradioApi`, `Update-GradioSessionApiResult`
* Vous pouvez utiliser cette commande pour obtenir la liste complète : `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

Vous n'avez pas besoin de vous authentifier pour accéder aux ressources publiques de Hugging Face.  
Il y a une infinité de modèles et d'espaces disponibles gratuitement sans nécessiter d'authentification.  
Par exemple, la commande suivante liste les 5 modèles les plus téléchargés de Meta (auteur : meta-llama) :

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

Le cmdlet Invoke-HuggingFaceHub est responsable de l'invocation des endpoints de l'API du Hub.  Les paramètres sont les mêmes que ceux documentés sur https://huggingface.co/docs/hub/en/api
Cependant, vous aurez besoin d'un token si vous devez accéder à des ressources privées : `Set-HuggingFaceToken` (ou `Set-HfToken`) est le cmdlet pour insérer le token par défaut utilisé dans toutes les requêtes.  



# Structure des commandes du fournisseur Hugging Face  
 
Le fournisseur Hugging Face est organisé en 3 principaux groupes de commandes : Gradio, Gradio Session et Hugging Face.  


## Commandes Gradio*`

Les cmdlets du groupe "gradio" possèdent la structure Verbe-GradioNom.  Ces commandes implémentent l'accès à l'API de Gradio.  
Ces commandes sont essentiellement des wrappers pour les APIs. La construction de celles-ci a été basée sur cette doc : https://www.gradio.app/guides/querying-gradio-apps-with-curl  et également en observant le code source de Gradio (ex. : [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
Ces commandes peuvent être utilisées avec n'importe quelle app GradioPour obtenir les résultats, vous devez utiliser `Update-GradioApiResult' 

```powershell
$Event | Update-GradioApiResult
```

Le cmdlet `Update-GradioApiResult` écrira les événements générés par l'API dans le pipeline.  
Un objet sera renvoyé pour chaque événement généré par le serveur. La propriété `data` de cet objet contient les données renvoyées, s'il y en a.  

Il y a également la commande `Send-GradioFile`, qui permet de faire des téléchargements. Elle renvoie un tableau d'objets FileData, qui représentent le fichier sur le serveur.  

Notez comment ces cmdlets sont assez primitifs : Vous devez tout faire manuellement. Obtenir les points de terminaison, invoquer l'API, envoyer les paramètres sous forme de tableau, télécharger les fichiers.  
Bien que ces commandes abstraient les appels HTTP directs de Gradio, elles exigent encore beaucoup de l'utilisateur.  
C'est pourquoi le groupe de commandes GradioSession a été créé, pour aider à abstraire encore plus et rendre la vie de l'utilisateur plus facile !


## Commandes GradioSession*  

Les commandes du groupe GradioSession aident à abstraire encore plus l'accès à une application Gradio.  
Avec elles, vous êtes plus proche de PowerShell lorsque vous interagissez avec une application Gradio et plus éloigné des appels natifs.  

Utilisons l'exemple de l'application précédente pour faire quelques comparaisons :

```powershell
# crée une nouvelle session 
New-GradioSession http://127.0.0.1:7860
```

Le cmdlet `New-GradioSession` crée une nouvelle session avec Gradio. Cette nouvelle session a des éléments uniques comme un SessionId, une liste de fichiers téléchargés, des configurations, etc.  
La commande renvoie l'objet qui représente cette session, et vous pouvez obtenir toutes les sessions créées en utilisant `Get-GradioSession`.  
Imaginez une GradioSession comme un onglet de navigateur ouvert avec votre application Gradio ouverte.  

Les commandes GradioSession opèrent, par défaut, sur la session par défaut. S'il n'y a qu'une seule session, elle est la session par défaut.  
S'il y a plus d'une, l'utilisateur doit choisir laquelle est la session par défaut en utilisant la commande `Set-GradioSession`

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

Une des commandes les plus puissantes est `New-GradioSessionApiProxyFunction` (ou alias GradioApiFunction).  
Cette commande transforme les API de la session Gradio en fonctions PowerShell, c'est-à-dire que vous pouvez invoquer l'API comme si c'était une fonction PowerShell.  
Revenons à l'exemple précédent


```powershell
# d'abord, ouvrant la session !
New-GradioSession http://127.0.0.1:7860

# Maintenant, créons les fonctions !
New-GradioSessionApiProxyFunction
```

Le code ci-dessus générera une fonction PowerShell appelée Invoke-GradioApiOp1.  
Cette fonction a les mêmes paramètres que le point de terminaison '/op1', et vous pouvez utiliser get-help pour plus d'informations :  

```powershell
get-help -full Invoke-GradioApiOp1
```

Pour exécuter, il suffit d'invoquer :

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Notez comment le paramètre `Duration` défini dans l'application Gradio est devenu un paramètre PowerShell.  
Sous le capot, Invoke-GradioApiOp1 exécute `Update-GradioApiResult`, c'est-à-dire que le retour est le même objet !  
Mais, remarquez combien il a été plus simple d'invoquer l'API de Gradio et de recevoir le résultat !

Les applications qui définissent des fichiers, comme des musiques, des images, etc., génèrent des fonctions qui téléchargent automatiquement ces fichiers.  
L'utilisateur doit simplement spécifier le chemin local.  

Éventuellement, il peut exister un ou deux types de données non pris en charge dans la conversion, et, si vous en trouvez, ouvrez un problème (ou soumettez un PR) pour que nous puissions évaluer et implémenter !



## Commandes HuggingFace* (ou Hf*)  

Les commandes de ce groupe ont été créées pour fonctionner avec l'API de Hugging Face.  
Fondamentalement, elles encapsulent les appels HTTP
