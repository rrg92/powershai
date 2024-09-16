---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Fonction auxiliaire pour convertir un script .ps1 en un format de schéma attendu par OpenAI.
Essentiellement, ce que cette fonction fait est de lire un fichier .ps1 (ou une chaîne) avec sa documentation d'aide.  
Ensuite, il renvoie un objet au format spécifié par OpenAI afin que le modèle puisse l'appeler !

Renvoie un hashtable contenant les clés suivantes :
	functions - La liste des fonctions, avec leur code lu à partir du fichier.  
				Lorsque le modèle l'appelle, vous pouvez l'exécuter directement à partir d'ici.
				
	tools - Liste des outils, à envoyer lors de l'appel d'OpenAI.
	
Vous pouvez documenter vos fonctions et paramètres en suivant l'aide basée sur les commentaires de PowerShell :
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
