---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Import-PowershaiSettings

## SYNOPSIS
Imports a configuration exported with Export-PowershaiSettings

## SYNTAX

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is the pair of Export-PowershaiSettings, and as the name indicates, it imports the data that was exported.

You must ensure that the same password and the same file are provided.

IMPORTANT: This command will overwrite all data configured in the session. Only execute it if you are absolutely certain that no previously configured data will be lost. For example, a newly generated API Token.

If you had specified a different export path from the default, using the variable POWERSHAI_EXPORT_DIR, you must use the same here.

The import process validates some headers to ensure that the data has been decrypted correctly.

If the provided password is incorrect, the hashes will not match, and it will trigger the incorrect password error.

If, on the other hand, an invalid file format error is displayed, it means there was some corruption in the import process or it is a bug of this command.

In this case, you can open an issue on GitHub reporting the problem.

## EXAMPLES

### EXAMPLE 1
```
Import-PowershaiSettings
```

Imports the settings from the default directory.

### EXAMPLE 2
```
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
```

PS\> Import-PowershaiSettings

    Imports the settings that were exported to an alternative directory (OneDrive).

## PARAMETERS

### -ExportDir
{{ Fill ExportDir Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
