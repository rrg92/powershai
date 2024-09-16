---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Exportiert die Einstellungen der aktuellen Sitzung in eine Datei, verschlüsselt mit einem Passwort

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet ist nützlich, um Einstellungen wie Tokens auf sichere Weise zu speichern.  
Es fordert ein Passwort an und verwendet es, um einen Hash zu erstellen und die Sitzungs-Konfigurationsdaten in AES256 zu verschlüsseln.  

Die exportierten Einstellungen sind alle, die in der Variablen $POWERSHAI_SETTINGS definiert sind.  
Diese Variable ist eine Hash-Tabelle, die alle Daten enthält, die von den Providern konfiguriert wurden, einschließlich der Tokens.  

Standardmäßig werden Chats nicht exportiert, da dies aufgrund der großen Datenmenge zu einer sehr großen Datei führen kann!

Die exportierte Datei wird in einem automatisch erstellten Verzeichnis gespeichert, standardmäßig im Home-Verzeichnis des Benutzers ($HOME).  
Die Objekte werden über Serialisierung exportiert, dem gleichen Verfahren, das von Export-CliXml verwendet wird.  

Die Daten werden in einem eigenen Format exportiert, das nur mit Import-PowershaiSettings und der Angabe desselben Passworts importiert werden kann.  

Da PowershAI keine automatische Exportierung durchführt, wird empfohlen, diesen Befehl auszuführen, wenn Konfigurationsänderungen vorgenommen wurden, z. B. das Hinzufügen neuer Tokens.  

Das Exportverzeichnis kann ein beliebiger gültiger Pfad sein, einschließlich Cloud-Laufwerken wie OneDrive, Dropbox usw.  

Dieser Befehl wurde mit dem Ziel entwickelt, interaktiv zu sein, d. h. er benötigt eine Benutzereingabe über die Tastatur.

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Exportieren der Standardeinstellungen!
```powershell
Export-PowershaiSettings
```

### Alles exportieren, einschließlich Chats!
```powershell
Export-PowershaiSettings -Chat
```

### Export nach OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
Exportverzeichnis
Standardmäßig ist es ein Verzeichnis namens .powershai im Benutzerprofil, aber Sie können die Umgebungsvariable POWERSHAI_EXPORT_DIR festlegen, um es zu ändern.

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
Wenn angegeben, werden die Chats in den Export aufgenommen
Alle Chats werden exportiert

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
