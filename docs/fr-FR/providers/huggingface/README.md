# Provider Hugging Face

Hugging Face est le plus grand référentiel de modèles d'IA au monde !  
Là, vous avez accès à une gamme incroyable de modèles, de jeux de données, de démonstrations avec Gradio, et bien plus encore !  

C'est le GitHub de l'Intelligence Artificielle, commercial et open source ! 

Le fournisseur Hugging Face de PowershAI connecte votre PowerShell à une gamme incroyable de services et de modèles.  

## Le Gradio

Gradio est un cadre pour créer des démonstrations pour des modèles d'IA. Avec peu de code en python, il est possible de créer des interfaces qui acceptent divers inputs, comme du texte, des fichiers, etc.  
Et, en plus, il gère de nombreuses questions telles que les files d'attente, les téléchargements, etc. Et, pour couronner le tout, avec l'interface, il peut fournir une API pour que la fonctionnalité exposée via l'UI soit également accessible par le biais de langages de programmation.  
PowershAI en bénéficie et expose les API de Gradio de manière plus simple, où il est possible d'invoquer une fonctionnalité de votre terminal et d'avoir pratiquement la même expérience !

## Hugging Face Hub  

Le Hugging Face Hub est la plateforme que vous accédez à https://huggingface.co  
Il est organisé en modèles (models), qui sont essentiellement le code source des modèles d'IA que d'autres personnes et entreprises créent à travers le monde.  
Il y a aussi les "Spaces", qui sont des endroits où vous pouvez télécharger un code pour publier des applications écrites en python (en utilisant Gradio, par exemple) ou docker.  

Découvrez-en plus sur Hugging Face [dans ce post de blog Ia Talking](https://iatalk.ing/hugging-face/)  
Et, découvrez le Hugging Face Hub [dans la doc officielle](https://huggingface.co/docs/hub/en/index)

Avec PowershAI, vous pouvez lister des modèles et même interagir avec l'API de plusieurs espaces, exécutant les applications d'IA les plus variées à partir de votre terminal.  

# Usage de base

Le fournisseur Hugging Face de PowershAI dispose de nombreux cmdlets pour l'interaction.  
Il est organisé dans les commandes suivantes :

* Les commandes qui interagissent avec Hugging Face possèdent `HuggingFace` ou `Hf` dans le nom. Exemple : `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* Les commandes qui interagissent avec Gradio, qu'elles soient un Space de Hugging Face ou non, possèdent `Gradio` ou `GradioSession` dans le nom : `Send-GradioApi`, `Update-GradioSessionApiResult`  
* Vous pouvez utiliser cette commande pour obtenir la liste complète : `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

Vous n'avez pas besoin de vous authentifier pour accéder aux ressources publiques de Hugging Face.  
Il y a une infinité de modèles et d'espaces disponibles gratuitement sans besoin d'authentification.  
Par exemple, la commande suivante liste les 5 modèles les plus téléchargés de Meta (auteur : meta-llama) :

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

Le cmdlet Invoke-HuggingFaceHub est responsable de l'invocation des points de terminaison de l'API du Hub. Les paramètres sont les mêmes que ceux documentés à https://huggingface.co/docs/hub/en/api  
Cependant, vous aurez besoin d'un token si vous devez accéder à des ressources privées : `Set-HuggingFaceToken` (ou `Set-HfToken`) est le cmdlet pour insérer le token par défaut utilisé dans toutes les requêtes.  

# Structure des commandes du fournisseur Hugging Face  

Le fournisseur Hugging Face est organisé en 3 principaux groupes de commandes : Gradio, Gradio Session et Hugging Face.  

## Commandes Gradio*`

Les cmdlets du groupe "gradio" possèdent la structure Verbo-GradioNom. Ces commandes implémentent l'accès à l'API de Gradio.  
Ces commandes sont essentiellement des wrappers pour les API. Leur construction a été basée sur cette doc : https://www.gradio.app/guides/querying-gradio-apps-with-curl et également en observant le code source de Gradio (ex. : [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py))  
Ces commandes peuvent être utilisées avec n'importe quelle application Gradio, peu importe où elles sont hébergées : sur votre machine locale, dans un espace de Hugging Face, sur un serveur dans le cloud...  
Vous avez juste besoin de l'URL principale de l'application.  

Considérez cette application Gradio :

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="Duration, in, seconds", value=5);
    txtResults = gr.Text(label="Résultat");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

Essentiellement, cette application affiche 2 champs de texte, l'un d'eux étant où l'utilisateur tape un texte et l'autre est utilisé pour montrer la sortie.  
Un bouton, qui lorsqu'il est cliqué, déclenche la fonction Op1. La fonction fait une boucle pendant un certain nombre de secondes déterminées dans le paramètre.  
Chaque seconde, elle renvoie le temps écoulé.  

Supposons qu'au démarrage, cette application soit accessible à http://127.0.0.1:7860.  
Avec ce fournisseur, se connecter à cette application est simple :

```powershell
# installez powershai, si ce n'est pas déjà installé !
Install-Module powershai 

# Importez
import-module powershai 

# Vérifiez les points de terminaison de l'API !
Get-GradioInfo http://127.0.0.1:7860
```

Le cmdlet `Get-GradioInfo` est le plus simple. Il lit simplement le point de terminaison /info que toute application Gradio possède.  
Ce point de terminaison renvoie des informations précieuses, comme les points de terminaison de l'API disponibles :

```powershell
# Vérifiez les points de terminaison de l'API !
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# liste les paramètres du point de terminaison
$AppInfo.named_endpoints.'/op1'.parameters
```

Vous pouvez invoquer l'API en utilisant le cmdlet `Send-GradioApi`.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Notez que nous devons passer l'URL, le nom du point de terminaison sans la barre et le tableau avec la liste des paramètres.  
Le résultat de cette requête est un événement qui pourra être utilisé pour consulter le résultat de l'API.  
Pour obtenir les résultats, vous devez utiliser `Update-GradioApiResult`  

```powershell
$Event | Update-GradioApiResult
```

Le cmdlet `Update-GradioApiResult` écrira les événements générés par l'API dans le pipeline.  
Un objet sera renvoyé pour chaque événement généré par le serveur. La propriété `data` de cet objet contient les données renvoyées, s'il y en a.  

Il y a aussi la commande `Send-GradioFile`, qui permet de faire des téléchargements. Elle renvoie un tableau d'objets FileData, qui représentent le fichier sur le serveur.  

Notez comment ces cmdlets sont assez primitifs : Vous devez manuellement tout faire. Obtenir les points de terminaison, invoquer l'API, envoyer les paramètres sous forme de tableau, faire le téléchargement des fichiers.  
Bien que ces commandes abstraient les appels HTTP directs de Gradio, elles exigent encore beaucoup de l'utilisateur.  
C'est pourquoi un groupe de commandes GradioSession a été créé, qui aide à encore plus abstraire et à rendre la vie de l'utilisateur plus facile !


## Commandes GradioSession*  

Les commandes du groupe GradioSession aident à encore plus abstraire l'accès à une application Gradio.  
Avec elles, vous êtes plus proche de PowerShell lors de l'interaction avec une application Gradio et plus loin des appels natifs.  

Utilisons le propre exemple de l'application précédente pour faire quelques comparaisons :

```powershell```powershell
# crée une nouvelle session 
New-GradioSession http://127.0.0.1:7860
```

Le cmdlet `New-GradioSession` crée une nouvelle session avec Gradio. Cette nouvelle session a des éléments uniques tels qu'un SessionId, une liste de fichiers téléchargés, des configurations, etc.  
La commande retourne l'objet qui représente cette session, et vous pouvez obtenir toutes les sessions créées en utilisant `Get-GradioSession`.  
Imaginez qu'une GradioSession est comme un onglet de navigateur ouvert avec votre application Gradio ouverte.  

Les commandes GradioSession fonctionnent, par défaut, sur la session par défaut. S'il n'y a qu'une seule session, elle est la session par défaut.  
S'il y a plus d'une session, l'utilisateur doit choisir laquelle est la par défaut en utilisant la commande `Set-GradioSession`

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

L'une des commandes les plus puissantes est `New-GradioSessionApiProxyFunction` (ou alias GradioApiFunction).  
Cette commande transforme les API de la session Gradio en fonctions PowerShell, c'est-à-dire que vous pouvez invoquer l'API comme si c'était une fonction PowerShell.  
Revenons à l'exemple précédent

```powershell
# d'abord, ouvrant la session !
New-GradioSession http://127.0.0.1:7860

# Maintenant, créons les fonctions !
New-GradioSessionApiProxyFunction
```

Le code ci-dessus va générer une fonction PowerShell appelée Invoke-GradioApiOp1.  
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
Mais, remarquez combien il a été plus simple d'invoquer l'API Gradio et de recevoir le résultat !

Les applications qui définissent des fichiers, comme des musiques, des images, etc., génèrent des fonctions qui téléchargent automatiquement ces fichiers.  
L'utilisateur doit simplement spécifier le chemin local.  

Éventuellement, il peut exister un ou plusieurs types de données non pris en charge dans la conversion, et, si vous en rencontrez, ouvrez une issue (ou soumettez un PR) pour que nous puissions évaluer et mettre en œuvre !

## Commandes HuggingFace* (ou Hf*)  

Les commandes de ce groupe ont été créées pour fonctionner avec l'API de Hugging Face.  
Fondamentalement, elles encapsulent les appels HTTP vers les divers points de terminaison de Hugging Face.  

Un exemple :

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

Cette commande retourne un objet qui contient diverses informations sur l'espace diffusers-labs, de l'utilisateur rrg92.  
Comme c'est un espace Gradio, vous pouvez le connecter avec les autres cmdlets (les cmdlets GradioSession peuvent comprendre lorsqu'un objet retourné par Get-HuggingFaceSpace lui est passé !)

```
# Connecter à l'espace (et, automatiquement, crée une session Gradio)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

# Par défaut
Set-GradioSession -Default $diff

# Crée des fonctions !
New-GradioSessionApiProxyFunction

# invoque !
Invoke-GradioApiGenerateimage -Prompt "une voiture volant"
```

**IMPORTANT : N'oubliez pas que l'accès à certains espaces peut nécessiter une authentification, dans ces cas, vous devez utiliser Set-HuggingFaceToken et spécifier un jeton d'accès.**


_Traduit automatiquement en utilisant PowershAI et IA._
