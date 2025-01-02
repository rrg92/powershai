---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Fonction auxiliaire pour convertir un script .ps1, ou un bloc de script, dans un format de schéma attendu par OpenAI.
Fondamentalement, ce que cette fonction fait est d'exécuter le script et d'obtenir l'aide de toutes les commandes définies.
Ensuite, elle retourne un objet au format spécifié par OpenAI afin que le modèle puisse l'invoquer !

Retourne un hashtable contenant les clés suivantes :
	functions - La liste des fonctions, avec leur code lu à partir du fichier.  
				Lorsque le modèle invoque, vous pouvez exécuter directement à partir d'ici.
				
	tools - Liste des outils, à envoyer dans l'appel à OpenAI.
	
Vous pouvez documenter vos fonctions et paramètres en suivant le Comment Based Help de PowerShell :
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-Script] <Object>] [[-Vars] <Object>] [[-JsonSchema] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Script
Fichier .ps1 ou bloc de script !
Le script sera chargé dans votre propre espace (comme s'il s'agissait d'un module).
Ainsi, vous ne pourrez peut-être pas accéder à certaines variables en fonction de l'espace.
Utilisez -Vars pour spécifier quelles variables vous devez rendre disponibles dans le script !

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

### -Vars
Spécifiez des variables et leurs valeurs pour les rendre disponibles dans l'espace du script !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -JsonSchema
Spécifiez un schéma json personnalisé pour chaque fonction retournée par le script.
Vous devez spécifier une clé avec le nom de chaque commande. La valeur est une autre hashtable où chaque clé est le nom du paramètre et la valeur est le schéma json de ce paramètre

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
