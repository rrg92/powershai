# Fournisseur Hugging Face

Hugging Face est le plus grand référentiel de modèles d'IA au monde !  
Là, vous avez accès à une incroyable variété de modèles, de jeux de données, de démonstrations avec Gradio, et bien plus encore !  

C'est le GitHub de l'Intelligence Artificielle, commercial et open source !

Le fournisseur Hugging Face de PowershAI connecte votre powershell à une incroyable variété de services et de modèles.  

## Gradio

Gradio est un framework pour créer des démonstrations pour les modèles d'IA. Avec peu de code en python, il est possible de monter des interfaces qui acceptent divers inputs, comme du texte, des fichiers, etc.  
Et, de plus, il gère de nombreuses questions comme les files d'attente, les uploads, etc.  Et, pour compléter, avec l'interface, il peut mettre à disposition une API pour que la fonctionnalité exposée via l'UI soit également accessible via des langages de programmation.  
PowershAI en profite et expose les API de Gradio d'une manière plus facile, où il est possible d'invoquer une fonctionnalité depuis votre terminal et d'avoir pratiquement la même expérience !


## Hugging Face Hub  

Le Hugging Face Hub est la plateforme à laquelle vous accédez sur https://huggingface.co  
Il est organisé en modèles (models), qui sont essentiellement le code source des modèles d'IA que d'autres personnes et entreprises créent dans le monde entier.  
Il y a aussi les "Spaces", qui sont l'endroit où vous pouvez monter un code pour publier des applications écrites en python (en utilisant Gradio, par exemple) ou en docker.  

Apprenez-en plus sur Hugging Face [dans cet article du blog Ia Talking](https://iatalk.ing/hugging-face/)
Et, découvrez le Hugging Face Hub [dans la documentation officielle](https://huggingface.co/docs/hub/en/index)

Avec PowershaAI, vous pouvez lister des modèles et même interagir avec l'API de plusieurs spaces, exécutant les applications d'IA les plus variées à partir de votre terminal.  


# Utilisation de base

Le fournisseur Hugging Face de PowershAI possède de nombreux cmdlets pour l'interaction.  
Il est organisé selon les commandes suivantes :

* les commandes qui interagissent avec Hugging Face possèdent `HuggingFace` ou `Hf` dans le nom. Exemple : `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* les commandes qui interagissent avec Gradio, qu'elles soient un Space de Hugging Face ou non, possèdent `Gradio` ou `GradioSession'  dans le nom : `Send-GradioApi`, `Update-GradioSessionApiResult`
* Vous pouvez utiliser cette commande pour obtenir la liste complète : `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

Vous n'avez pas besoin de vous authentifier pour accéder aux ressources publiques de Hugging Face.  
Il existe une infinité de modèles et de spaces disponibles gratuitement sans avoir besoin de s'authentifier.  
Par exemple, la commande suivante liste les 5 modèles les plus téléchargés de Meta (auteur : meta-llama) :

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

Le cmdlet Invoke-HuggingFaceHub est chargé d'appeler les endpoints de l'API du Hub.  Les paramètres sont les mêmes que ceux documentés sur https://huggingface.co/docs/hub/en/api
Cependant, vous aurez besoin d'un jeton si vous avez besoin d'accéder à des ressources privées : `Set-HuggingFaceToken` (ou `Set-HfToken`)  est le cmdlet pour insérer le jeton par défaut utilisé dans toutes les requêtes.  



# Structure des commandes du fournisseur Hugging Face  
 
Le fournisseur Hugging Face est organisé en 3 principaux groupes de commandes : Gradio, Gradio Session et Hugging Face.  


## Commandes Gradio*`

Les cmdlets du groupe "gradio" possèdent la structure Verbe-GradioNom.  Ces commandes implémentent l'accès à l'API de Gradio.  
Ces commandes sont essentiellement des wrappers pour les API. Leur construction a été basée sur cette doc : https://www.gradio.app/guides/querying-gradio-apps-with-curl  et en observant également le code source de Gradio (ex. : [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
Ces commandes peuvent être utilisées avec n'importe quelle application gradio, indépendamment de l'endroit où elles sont hébergées : sur votre machine locale, dans un space de Hugging Face, sur un serveur dans le cloud... 
Vous n'avez besoin que de l'URL principale de l'application.  


Considérez cette application gradio :

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
    txtResults = gr.Text(label="Resultado");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

Essentiellement, cette application affiche 2 champs de texte, l'un étant celui où l'utilisateur tape un texte et l'autre étant utilisé pour afficher la sortie.  
Un bouton, qui, lorsqu'il est cliqué, déclenche la fonction Op1. La fonction fait une boucle pendant un certain nombre de secondes indiqué dans le paramètre.  
Chaque seconde, elle retourne le temps écoulé.  

Supposons qu'au démarrage, cette application soit accessible sur http://127.0.0.1:7860.
Avec ce fournisseur, se connecter à cette application est simple :

```powershell
# installez powershai, si ce n'est pas déjà fait !
Install-Module powershai 

# Importer
import-module powershai 

# Vérifiez les endpoints de l'api !
Get-GradioInfo http://127.0.0.1:7860
```

Le cmdlet `Get-GradioInfo` est le plus simple. Il lit simplement l'endpoint /info que toute application gradio possède.  
Cet endpoint renvoie des informations précieuses, comme les endpoints de l'API disponibles :

```powershell
# Vérifiez les endpoints de l'api !
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# liste les paramètres de l'endpoint
$AppInfo.named_endpoints.'/op1'.parameters
```

Vous pouvez appeler l'API en utilisant le cmdlet `Send-GradioApi`.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Notez que nous devons passer l'URL, le nom de l'endpoint sans la barre oblique et le tableau avec la liste des paramètres.
Le résultat de cette requête est un événement qui pourra être utilisé pour consulter le résultat de l'API.
Pour obtenir les résultats, vous devez utiliser `Update-GradioApiResult' 

```powershell
$Event | Update-GradioApiResult
```

Le cmdlet `Update-GradioApiResult` va écrire les événements générés par l'API dans le pipeline.  
Un objet sera retourné pour chaque événement généré par le serveur. La propriété `data` de cet objet contient les données retournées, s'il y en a.  


Il existe également la commande `Send-GradioFile`, qui permet de faire des uploads.  Elle retourne un tableau d'objets FileData, qui représentent le fichier sur le serveur.  

Notez à quel point ces cmdlets sont primitifs : vous devez tout faire manuellement. Obtenir les endpoints, appeler l'API, envoyer les paramètres sous forme de tableau, faire l'upload des fichiers.  
Bien que ces commandes abstraient les appels HTTP directs de Gradio, elles exigent encore beaucoup de l'utilisateur.  
C'est pourquoi le groupe de commandes GradioSession a été créé, pour aider à abstraire davantage et à rendre la vie de l'utilisateur plus facile !


## Commandes GradioSession*  

Les commandes du groupe GradioSession aident à abstraire davantage l'accès à une application Gradio.  
Avec elles, vous êtes plus proche du powershell lorsque vous interagissez avec une application gradio et plus loin des appels natifs.  

Prenons l'exemple de l'application précédente pour faire quelques comparaisons :

```powershell
# crée une nouvelle session 
New-GradioSession http://127.0.0.1:7860
```

Le comdlet `New-GradioSession` crée une nouvelle session avec Gradio.  Cette nouvelle session possède des éléments uniques comme un SessionId, une liste de fichiers téléchargés, des configurations, etc.  
La commande retourne l'objet qui représente cette session, et vous pouvez obtenir toutes les sessions créées en utilisant `Get-GradioSession`.  
Imaginez une GradoSession comme un onglet du navigateur ouvert avec votre application gradio ouverte.  

Les commandes GradioSession opèrent, par défaut, sur la session par défaut. S'il n'existe qu'une seule session, elle est la session par défaut.  
S'il existe plusieurs sessions, l'utilisateur doit choisir laquelle est la session par défaut en utilisant la commande `Set-GradioSession`

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

L'une des commandes les plus puissantes est `New-GradioSessionApiProxyFunction` (ou alias GradioApiFunction).  
Cette commande transforme les API de Gradio de la session en fonctions powershell, c'est-à-dire que vous pouvez appeler l'API comme s'il s'agissait d'une fonction powershell.  
Retournons à l'exemple précédent


```powershell
# d'abord, ouvrir la session !
New-GradioSession http://127.0.0.1:7860

# Maintenant, créons les fonctions !
New-GradioSessionApiProxyFunction
```

Le code ci-dessus va générer une fonction powershell appelée Invoke-GradioApiOp1.  
Cette fonction possède les mêmes paramètres que l'endpoint '/op1', et vous pouvez utiliser get-help pour plus d'informations :  

```powershell
get-help -full Invoke-GradioApiOp1
```

Pour exécuter, il suffit d'appeler :

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Notez comment le paramètre `Duration` défini dans l'application gradio est devenu un paramètre powershell.  
Dans les coulisses, Invoke-GradioApiOp1 exécute `Update-GradioApiResult`, c'est-à-dire que le retour est le même objet !
Mais, remarquez à quel point il était plus simple d'appeler l'API de Gradio et de recevoir le résultat !

Les applications qui définissent des fichiers, comme des musiques, des images, etc., génèrent des fonctions qui effectuent automatiquement l'upload de ces fichiers.  
L'utilisateur n'a qu'à spécifier le chemin local.  

Finalement, il peut y avoir un ou deux types de données non pris en charge lors de la conversion, et si vous en rencontrez, ouvrez une issue (ou soumettez un PR) pour que nous les examinions et les implémentions !



## Commandes HuggingFace* (ou Hf*)  

Les commandes de ce groupe ont été créées pour fonctionner avec l'API de Hugging Face.  
Essentiellement, elles encapsulent les appels HTTP vers les différents endpoints de Hugging Face.  

Un exemple :

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

Cette commande retourne un objet qui contient diverses informations sur le space diffusers-labs, de l'utilisateur rrg92.  
Comme il s'agit d'un space gradio, vous pouvez le connecter avec les autres cmdlets (les cmdlets GradioSession comprennent quand un objet retourné par Get-HuggingFaceSpace leur est passé !)

```
# Se connecter au space (et, automatiquement, créer une session gradio)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

#Default
Set-GradioSession -Default $diff

# Créer des fonctions !
New-GradioSessionApiProxyFunction

# Appeler !
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**IMPORTANT : N'oubliez pas que l'accès à certains espaces ne peut être effectué qu'avec une authentification, dans ces cas, vous devez utiliser Set-HuggingFaceToken et spécifier un jeton d'accès ;**



<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
