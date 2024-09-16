---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Exporte les paramètres de la session actuelle vers un fichier, chiffré par un mot de passe

## DESCRIPTION <!--!= @#Desc !-->
Cette cmdlet est utile pour enregistrer les paramètres, tels que les jetons, de manière sécurisée.  
Elle demande un mot de passe et l'utilise pour créer un hachage et chiffrer les données de configuration de la session en AES256.  

Les paramètres exportés sont tous ceux définis dans la variable $POWERSHAI_SETTINGS.  
Cette variable est une table de hachage contenant toutes les données configurées par les fournisseurs, ce qui inclut les jetons.  

Par défaut, les chats ne sont pas exportés en raison de la quantité de données impliquées, ce qui peut rendre le fichier trop volumineux !

Le fichier exporté est enregistré dans un répertoire créé automatiquement, par défaut, dans l'accueil de l'utilisateur ($HOME).  
Les objets sont exportés via la sérialisation, qui est la même méthode utilisée par Export-CliXml.  

Les données sont exportées dans un format propriétaire qui ne peut être importé qu'avec Import-PowershaiSettings et en fournissant le même mot de passe.  

Étant donné que PowershAI ne réalise pas une exportation automatique, il est recommandé d'appeler cette commande chaque fois qu'une modification de configuration est apportée, comme l'ajout de nouveaux jetons.  

Le répertoire d'exportation peut être n'importe quel chemin valide, y compris les lecteurs cloud tels que OneDrive, Dropbox, etc.  

Cette commande a été créée dans l'intention d'être interactive, c'est-à-dire qu'elle nécessite l'entrée de l'utilisateur au clavier.

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Exportation des paramètres par défaut !
```powershell
Export-PowershaiSettings
```

### Exporte tout, y compris les chats !
```powershell
Export-PowershaiSettings -Chat
```

### Exportation vers OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
Répertoire d'exportation
Par défaut, il s'agit d'un répertoire nommé .powershai dans le profil de l'utilisateur, mais vous pouvez spécifier la variable d'environnement POWERSHAI_EXPORT_DIR pour la modifier.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -Chats
Si spécifié, inclut les chats dans l'exportation
Tous les chats seront exportés

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
