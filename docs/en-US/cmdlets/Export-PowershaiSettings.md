---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Export-PowershaiSettings

## SYNOPSIS
Exports the current session settings to a file, encrypted with a password.

## SYNTAX

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is useful for securely saving settings, such as Tokens.

It prompts for a password and uses it to create a hash and encrypt the session configuration data in AES256.

The exported settings are all those defined in the variable $POWERSHAI_SETTINGS.

This variable is a hashtable containing all the data configured by the providers, which includes the tokens.

By default, chats are not exported due to the amount of data involved, which can make the file very large!

The exported file is saved in a directory automatically created, by default, in the user's home ($HOME).

Objects are exported via Serialization, which is the same method used by Export-CliXml.

The data is exported in a specific format that can only be imported with Import-PowershaiSettings and providing the same password.

Since PowershAI does not perform an automatic export, it is recommended to invoke this command whenever there is a configuration change, such as the addition of new tokens.

The export directory can be any valid path, including cloud drives like OneDrive, Dropbox, etc.

This command was created to be interactive, that is, it requires user input from the keyboard.

## EXAMPLES

### EXAMPLE 1
```
Export-PowershaiSettings
```

Exports with the default settings!

### EXAMPLE 2
```
Export-PowershaiSettings -Chat
```

Exports including the chats!

### EXAMPLE 3
```
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
```

PS\> Export-PowershaiSettings

	Exports to a directory in OneDrive.

## PARAMETERS

### -ExportDir
Export directory 
By default, it is a directory named .powershai in the user's profile, but you can specify the environment variable POWERSHAI_EXPORT_DIR to change it.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: False
Accept wildcard characters: False
```

### -Chats
If specified, includes the chats in the export 
All chats will be exported.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



_Automatically translated using PowershAI and AI._
