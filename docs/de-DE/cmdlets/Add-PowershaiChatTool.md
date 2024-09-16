---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Fügt Funktionen, Skripte, ausführbare Dateien als ein vom LLM im aktuellen Chat aufrufbares Tool hinzu (oder standardmäßig für alle).

## DESCRIPTION <!--!= @#Desc !-->
Fügt Funktionen in der aktuellen Sitzung zur Liste der zulässigen Tool-Aufrufe hinzu!
Wenn ein Befehl hinzugefügt wird, wird er an das aktuelle Modell als Option für den Tool-Aufruf gesendet.
Die verfügbare Hilfe der Funktion wird verwendet, um sie zu beschreiben, einschließlich der Parameter.
Auf diese Weise können Sie zur Laufzeit neue Fähigkeiten in der KI hinzufügen, die vom LLM aufgerufen und von PowershAI ausgeführt werden können.  

Beim Hinzufügen von Skripten werden alle Funktionen innerhalb des Skripts auf einmal hinzugefügt.

Weitere Informationen zu Tools finden Sie im Thema about_Powershai_Chats

WICHTIG: 
FÜGEN SIE NIEMALS BEFEHLE HINZU, DIE SIE NICHT KENNEN ODER DIE IHREN COMPUTER GEFÄHRDEN KÖNNTEN.  
POWERSHELL FÜHRT IHN AUF ANFRAGE DES LLMS AUS UND MIT DEN PARAMETERN, DIE DAS LLM AUFRUFT, UND MIT DEN ANMELDEDATEN DES AKTUELLEN BENUTZERS.  
WENN SIE MIT EINEM PRIVILEGIERTEN KONTO, Z. B. ALS ADMINISTRATOR, ANGE MELDET SIND, BEACHTEN SIE, DASS SIE JEGLICHE AKTION AUF ANFRAGE EINES FERNEN SERVERS (DES LLMS) AUSFÜHREN KÖNNEN.

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
Name des Befehls, Pfad des Skripts oder ausführbare Datei
Kann ein Array von Strings mit diesen Elementen gemischt sein.
Wenn ein Name mit .ps1 endet, wird er als Skript behandelt (d. h. die Funktionen des Skripts werden geladen)
Wenn Sie es mit einem Befehl behandeln möchten (Skript ausführen), geben Sie den Parameter -Command an, um es als Befehl zu erzwingen!

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

### -description
Beschreibung für dieses Tool, die an das LLM übergeben werden soll.  
Der Befehl verwendet die Hilfe und sendet auch den beschriebenen Inhalt
Wenn dieser Parameter hinzugefügt wird, wird er zusammen mit der Hilfe gesendet.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ForceCommand
Erzwingt die Behandlung als Befehl. Nützlich, wenn Sie möchten, dass ein Skript als Befehl ausgeführt wird.
Nützlich nur, wenn Sie einen mehrdeutigen Dateinamen übergeben, der mit dem Namen eines Befehls übereinstimmt!

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

### -ChatId
Chat, in dem das Tool erstellt werden soll

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
Erstellt das Tool global, d. h. es ist in allen Chats verfügbar

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
