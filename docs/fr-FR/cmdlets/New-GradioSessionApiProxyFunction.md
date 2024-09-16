---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Crée des fonctions qui encapsulent les appels d'un endpoint Gradio (ou de tous les endpoints).  
Ce cmdlet est très utile pour créer des fonctions powershell qui encapsulent un endpoint API Gradio, où les paramètres de l'API sont créés comme des paramètres de la fonction.  
Ainsi, les fonctionnalités natives de powershell, telles que l'auto-complétion, le type de données et la documentation, peuvent être utilisées et il devient très facile d'appeler n'importe quel endpoint d'une session.

La commande consulte les métadonnées des endpoints et des paramètres et crée les fonctions powershell dans la portée globale.  
Ainsi, l'utilisateur peut appeler les fonctions directement, comme s'il s'agissait de fonctions normales.  

Par exemple, supposons qu'une application Gradio à l'adresse http://mydemo1.hf.space ait un endpoint appelé /GenerateImage pour générer des images avec Stable Diffusion.  
Supposons que cette application accepte 2 paramètres : Prompt (la description de l'image à générer) et Steps (le nombre total d'étapes).

Normalement, vous pourriez utiliser la commande Invoke-GradioSessionApi, comme ceci :

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

Cela lancerait l'API, et vous pourriez obtenir les résultats en utilisant Update-GradioApiResult :

$ApiEvent | Update-GradioApiResult

Avec ce cmdlet, vous pouvez encapsuler un peu plus ces appels :

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

La commande ci-dessus créera une fonction appelée Invoke-GradioApiGenerateimage.
Ensuite, vous pouvez l'utiliser de manière simple pour générer l'image :

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100 

Par défaut, la commande s'exécuterait et obtiendrait déjà les événements de résultats, en les écrivant dans le pipeline afin que vous puissiez les intégrer à d'autres commandes.  
De plus, connecter plusieurs espaces est très simple, voir ci-dessous sur le pipeline.

NOMENCLATURE

	Le nom des fonctions créées suit le format :  <Prefix><NomOp>
		<Prefix> est la valeur du paramètre -Prefix de ce cmdlet.
		<NomOp> est le nom de l'opération, maintenu uniquement en lettres et en chiffres
		
		Par exemplei, si l'opération est /Op1, et le préfixe INvoke-GradioApi, la fonction suivante sera créée : Invoke-GradioApiOp1

	
PARAMETRES
	Les fonctions créées contiennent la logique nécessaire pour transformer les paramètres passés et exécuter le cmdlet Invoke-GradioSessionApi.  
	En d'autres termes, le même retour s'applique comme si vous invoquiez ce cmdlet directement.  (C'est-à-dire qu'un événement sera retourné et ajouté à la liste des événements de la session actuelle).
	
	Les paramètres des fonctions peuvent varier en fonction de l'endpoint de l'API, car chaque endpoint possède un ensemble différent de paramètres et de types de données.
	Les paramètres qui sont des fichiers (ou une liste de fichiers) ont une étape de téléchargement supplémentaire. Le fichier peut être référencé localement et son téléchargement sera effectué sur le serveur.  
	Si une URL ou un objet FileData reçu d'une autre commande est fourni, aucun téléchargement supplémentaire ne sera effectué, seul un objet FileData correspondant sera généré pour l'envoi via l'API.

	En plus des paramètres de l'endpoint, il existe un ensemble supplémentaire de paramètres qui seront toujours ajoutés à la fonction créée.  
	Ce sont :
		- Manual  
		S'il est utilisé, le cmdlet retourne l'événement généré par INvoke-GradioSessionApi.  
		Dans ce cas, vous devrez obtenir manuellement les résultats en utilisant Update-GradioSessionApiResult
		
		- ApiResultMap 
		Mappe les résultats d'autres commandes aux paramètres. Voir plus dans la section PIPELINE.
		
		- DebugData
		Pour des fins de débogage par les développeurs.
		
UPLOAD 	
	Les paramètres qui acceptent des fichiers sont traités d'une manière spéciale.  
	Avant l'invocation de l'API, le cmdlet Send-GradioSessionFiles est utilisé pour télécharger ces fichiers vers l'application Gradio correspondante.  
	C'est un autre grand avantage d'utiliser ce cmdlet, car cela devient transparent, et l'utilisateur n'a pas besoin de gérer les téléchargements.

PIPELINE 
	
	L'une des fonctionnalités les plus puissantes de powershell est le pipeline, qui permet de connecter plusieurs commandes en utilisant le pipe |.
	Et ce cmdlet essaie également de tirer le meilleur parti de cette fonctionnalité.  
	
	Toutes les fonctions créées peuvent être connectées avec le |.
	En faisant cela, chaque événement généré par le cmdlet précédent est passé au suivant.  
	
	Considérez deux applications Gradio, App1 et App2.
	App1 possède l'endpoint Img, avec un paramètre appelé Text, qui génère des images en utilisant Diffusers, en affichant les images partielles au fur et à mesure qu'elles sont générées.
	App2 possède un endpoint Ascii, avec un paramètre appelé Image, qui transforme une image en une version ascii en texte.
	
	Vous pouvez connecter ces deux commandes de manière très simple avec le pipeline.  
	Tout d'abord, créez les sessions

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator
		
	Créez les fonctions 
		$App1 | New-GradioSessionApiProxy -Prefix App # cela crée la fonction AppImg
		$App2 | New-GradioSessionApiProxy -Prefix App # cela crée la fonction AppAscii
		
	Générez l'image et connectez-la au générateur ascii :
	
	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data[0]; write-host $_.pipeline[0].data[0].url } 
	
	Maintenant, analysons la séquence ci-dessus.
	
	Avant le premier pipe, nous avons la commande qui génère l'image : AppImg -Text "A car" 
	Cette fonction appelle l'endpoint /Img de App1. Cet endpoint produit une sortie pour l'étape de la génération d'images avec la lib Diffusers de hugging face.  
	Dans ce cas, chaque sortie sera une image (assez floue), jusqu'à la dernière sortie qui sera l'image finale.  
	Ce résultat se trouve dans la propriété data de l'objet du pipeline. C'est un tableau avec les résultats.
	
	Juste après dans le pipe, nous avons la commande : AppAscii -Map ImageInput=0
	Cette commande recevra chaque objet généré par la commande AppImg, qui sont dans ce cas les images partielles du processus de diffusion.  
	
	Étant donné que les commandes peuvent générer un tableau de sorties, il est nécessaire de mapper exactement lequel des résultats doit être associé à quels paramètres.  
	C'est pourquoi nous utilisons le paramètre -Map (-Map est un alias, en réalité, le nom correct est ApiResultMap)
	La syntaxe est simple : NomeParam=DataIndex,NomeParam=DataIndex  
	Dans la commande ci-dessus, nous disons : AppAscii, utilisez la première valeur de la propriété data dans le paramètre ImageInput.  
	Par exemple, si AppImg retournait 4 valeurs, et que l'image était à la dernière position, vous devriez utiliser ImageInput=3 (0 est la première).
	
	
	Enfin, le dernier pipe évole simplement le résultat de AppAscii, qui se trouve maintenant dans l'objet du pipeline, $_, dans la propriété .data (comme le résultat de AppImg).  
	Et, pour compléter, l'objet du pipeline possède une propriété spéciale, appelée pipeline. Grâce à elle, vous pouvez accéder à tous les résultats des commandes générées.  
	Par exemple, $_.pipeline[0], contient le résultat de la première commande (AppImg). 
	
	Grâce à ce mécanisme, il devient beaucoup plus facile de connecter différentes applications Gradio dans un seul pipeline.
	Notez que cette séquence ne fonctionne qu'entre les commandes générées par New-GradioSessionApiProxy. Faire passer d'autres commandes dans le pipe ne produira pas le même effet (il faudra utiliser quelque chose comme For-EachObject et associer les paramètres directement)


SESSIONS 
	Lorsque la fonction est créée, la session d'origine est gravée avec la fonction.  
	Si la session est supprimée, le cmdlet générera une erreur. Dans ce cas, vous devez créer la fonction en invoquant à nouveau ce cmdlet.  


Le diagramme suivant résume les dépendances impliquées :

	New-GradioSessionApiProxyFunction(Prefix)
		---> function <Prefix><OpName>
			---> Send-GradioSessionFiles (lorsqu'il y a des fichiers)
			---> Invoke-GradioSessionApi | Update-GradioSessionApiResult

Une fois que Invoke-GradioSessionApi est exécuté en fin de compte, toutes ses règles s'appliquent.
Vous pouvez utiliser Get-GradioSessionApiProxyFunction pour obtenir une liste de ce qui a été créé et Remove-GradioSessionApiProxyFunction pour supprimer une ou plusieurs fonctions créées.  
Les fonctions sont créées avec un module dynamique.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Créer uniquement pour cet endpoint en particulier

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -Prefix
Préfixe des fonctions créées

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Invoke-GradioApi
Accept pipeline input: false
Accept wildcard characters: false
```

### -Session
Session

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
Force la création de la fonction, même si une fonction portant le même nom existe déjà !

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
