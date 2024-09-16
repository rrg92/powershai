---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Imports a configuration exported with Export-PowershaiSettings

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet is the pair of Export-PowershaiSettings, and as the name indicates, it imports the data that was exported.  
You must ensure that the same password and the same file are passed.  

IMPORTANT: This command will overwrite all configured data in the session. Only run it if you are absolutely sure that no previously configured data can be lost.
For example, some newly generated API Token.

If you were specified a different export path than the default, using the POWERSHAI_EXPORT_DIR variable, you should use the same here.

The import process validates some headers to ensure that the data was decrypted correctly.  
If the password provided is incorrect, the hashes will not be equal, and it will trigger the incorrect password error.

If, on the other hand, an invalid file format error is displayed, it means that there was some corruption in the import process or it is a bug in this command.  
In this case, you can open an issue on github reporting the problem.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Default import
```powershell
Import-PowershaiSettings
```

### Importing from OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Import-PowershaiSettings
```
Imports the settings that were exported to an alternative directory (one drive).

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
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
