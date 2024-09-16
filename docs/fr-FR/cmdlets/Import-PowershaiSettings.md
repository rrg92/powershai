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

IMPORTANT : Cette commande écrasera toutes les données configurées dans la session. Ne l'exécutez que si vous êtes absolument sûr qu'aucune donnée configurée précédemment ne peut être perdue.
Par exemple, un nouveau jeton API récemment généré.

Si vous avez spécifié un chemin d'export différent du chemin par défaut, en utilisant la variable POWERSHAI_EXPORT_DIR, vous devez utiliser le même ici.

Le processus d'importation valide certains en-têtes pour s'assurer que les données ont été correctement décryptées.  
Si le mot de passe fourni est incorrect, les hachages ne seront pas identiques, et il déclenchera l'erreur de mot de passe incorrect.

Si, d'un autre côté, une erreur de format de fichier invalide est affichée, cela signifie qu'il y a eu une corruption lors du processus d'importation ou que c'est un bug de cette commande.  
Dans ce cas, vous pouvez ouvrir un problème sur github pour signaler le problème.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
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
Importe les configurations qui ont été exportées vers un répertoire alternatif (OneDrive).

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



<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
