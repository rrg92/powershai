---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Importe une configuration exportée avec Export-PowershaiSettings

## DESCRIPTION <!--!= @#Desc !-->
Ce cmdlet est le pair de Export-PowershaiSettings, et comme son nom l'indique, il importe les données qui ont été exportées.  
Vous devez vous assurer que le même mot de passe et le même fichier sont passés.  

IMPORTANTE : Cette commande écrasera toutes les données configurées dans la session. N'exécutez-la que si vous êtes absolument certain qu'aucune donnée configurée précédemment ne peut être perdue.
Par exemple, un nouveau jeton d'API généré récemment.

Si vous aviez spécifié un chemin d'exportation différent de celui par défaut, en utilisant la variable POWERSHAI_EXPORT_DIR, vous devez l'utiliser ici aussi.

Le processus d'importation valide certains en-têtes pour garantir que les données ont été déchiffrées correctement.  
Si le mot de passe fourni est incorrect, les hachages ne seront pas identiques, et il déclenchera l'erreur de mot de passe incorrect.

Si, en revanche, une erreur de format de fichier invalide est affichée, cela signifie qu'il y a eu une corruption dans le processus d'importation ou qu'il s'agit d'un bogue de cette commande.  
Dans ce cas, vous pouvez ouvrir un problème sur github en signalant le problème.

À partir de la version 0.7.0, un nouveau fichier sera généré, appelé exportsession-v2.xml.  
L'ancien fichier sera conservé afin que l'utilisateur puisse récupérer d'éventuelles informations d'identification, si nécessaire.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [-v1] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Importation par défaut
```powershell
Import-PowershaiSettings
```

### Importation depuis OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Import-PowershaiSettings
```
Importe les configurations qui ont été exportées vers un répertoire alternatif (one drive).

## PARAMETERS <!--!= @#Params !-->

### -ExportDir

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

### -v1
Force l'importation de la version 1

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
