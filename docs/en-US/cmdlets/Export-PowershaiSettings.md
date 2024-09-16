---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Exports the current session's settings to a file, encrypted by a password

## DESCRIPTION <!--!= @#Desc !-->
This cmdlet is useful for saving settings, such as Tokens, in a safe manner.  
It prompts for a password and uses it to create a hash and encrypt the session settings data in AES256.  

The exported settings are all those defined in the $POWERSHAI_SETTINGS variable.  
This variable is a hashtable containing all the data configured by the providers, which includes the tokens.  

By default, chats are not exported due to the amount of data involved, which can make the file very large!

The exported file is saved in a directory automatically created, by default, in the user's home ($HOME).  
The objects are exported via Serialization, which is the same method used by Export-CliXml.  

The data is exported in a proprietary format that can only be imported with Import-PowershaiSettings and providing the same password.  

Since PowershAI does not do an automatic export, it is recommended to invoke this command whenever there is a configuration change, such as the inclusion of new tokens.  

The export directory can be any valid path, including cloud drives like OneDrive, Dropbox, etc.  

This command was created to be interactive, meaning it requires user keyboard input.

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Exporting the default settings!
```powershell
Export-PowershaiSettings
```

### Exports everything, including chats!
```powershell
Export-PowershaiSettings -Chat
```

### Exporting to OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
Export directory 
By default, it is a directory called .powershai in the user's profile, but you can specify the environment variable POWERSHAI_EXPORT_DIR to change it.

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
If specified, includes chats in the export 
All chats will be exported

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
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
