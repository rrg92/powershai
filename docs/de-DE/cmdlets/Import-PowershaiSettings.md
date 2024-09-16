---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Importiert eine exportierte Konfiguration mit Export-PowershaiSettings

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet ist das Gegenstück zu Export-PowershaiSettings und importiert, wie der Name schon sagt, die Daten, die exportiert wurden.
Sie müssen sicherstellen, dass dasselbe Passwort und dieselbe Datei übergeben werden.

WICHTIG: Dieser Befehl überschreibt alle konfigurierten Daten in der Sitzung. Führen Sie ihn nur aus, wenn Sie absolut sicher sind, dass keine zuvor konfigurierten Daten verloren gehen.
Zum Beispiel ein neuer API-Token, der kürzlich generiert wurde.

Wenn Sie einen anderen Exportpfad als den Standard angegeben haben, indem Sie die Variable POWERSHAI_EXPORT_DIR verwenden, müssen Sie sie hier ebenfalls verwenden.

Der Importvorgang validiert einige Header, um sicherzustellen, dass die Daten korrekt entschlüsselt wurden.
Wenn das eingegebene Passwort falsch ist, stimmen die Hashes nicht überein und es wird ein Fehler wegen falschem Passwort ausgegeben.

Wenn andererseits ein Fehler mit ungültigem Dateiformat angezeigt wird, bedeutet dies, dass beim Importprozess eine Beschädigung aufgetreten ist oder es sich um einen Fehler dieses Befehls handelt.
In diesem Fall können Sie eine Issue auf GitHub einreichen und das Problem melden.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Standard-Import
```powershell
Import-PowershaiSettings
```

### Importieren aus OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Import-PowershaiSettings
```
Importiert die Einstellungen, die in ein alternatives Verzeichnis (OneDrive) exportiert wurden.

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
