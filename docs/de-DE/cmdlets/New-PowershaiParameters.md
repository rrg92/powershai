---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Erstellt ein neues Objekt, das die Parameter eines PowershaiChats darstellt

## DESCRIPTION <!--!= @#Desc !-->
Erstellt ein Standardobjekt, das alle möglichen Parameter enthält, die im Chat verwendet werden können!
Der Benutzer kann einen get-help New-PowershaiParameters verwenden, um die Dokumentation der Parameter zu erhalten.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] 
<Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Wenn true, wird der Stream-Modus verwendet, d. h. die Nachrichten werden angezeigt, sobald das Modell sie erstellt

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Aktiviert den JSON-Modus. In diesem Modus wird das Modell gezwungen, eine Antwort mit JSON zurückzugeben.  
Wenn aktiviert, werden die über den Stream generierten Nachrichten nicht angezeigt, sobald sie erstellt werden, und es wird nur das Endergebnis zurückgegeben.

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Name des zu verwendenden Modells  
Wenn null, wird das mit Set-AiDefaultModel definierte Modell verwendet

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
Maximale Anzahl an Token, die vom Modell zurückgegeben werden sollen

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 2048
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowFullSend
Gibt den gesamten Prompt aus, der an das LLM gesendet wird

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowTokenStats
Zeigt am Ende jeder Nachricht die von der API zurückgegebene Verbrauchsstatistik in Token an

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
Maximale Anzahl an Interaktionen, die gleichzeitig ausgeführt werden sollen 
Jedes Mal, wenn eine Nachricht gesendet wird, führt das Modell 1 Iteration aus (sendet die Nachricht und empfängt eine Antwort).  
Wenn das Modell nach einem Function Calling fragt, wird die generierte Antwort erneut an das Modell gesendet. Dies zählt als weitere Interaktion.  
Dieser Parameter steuert die maximale Anzahl an Interaktionen, die bei jedem Aufruf vorhanden sein können.
Dies hilft, unerwartete Endlosschleifen zu verhindern.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 50
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Maximale Anzahl von sequenziellen Fehlern, die durch Tool Calling erzeugt werden.  
Bei Verwendung von Tool Calling begrenzt dieser Parameter, wie viele Tools ohne Sequenz, die zu einem Fehler geführt haben, aufgerufen werden können.  
Der als Fehler betrachtete Fehler ist die Ausnahme, die vom konfigurierten Skript oder Befehl ausgelöst wird.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 5
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxContextSize
Maximale Kontextgröße in Zeichen 
In Zukunft in Token
Steuert die Anzahl der Nachrichten im aktuellen Kontext des Chats. Wenn diese Anzahl überschritten wird, bereinigt Powershai automatisch die ältesten Nachrichten.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: 8192
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterFunc
Funktion, die zum Formatieren der über die Pipeline übergebenen Objekte verwendet wird

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: ConvertTo-PowershaiContextOutString
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterParams
Argumente, die an ContextFormatterFunc übergeben werden sollen

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowArgs
Wenn true, werden die Argumente der Funktionen angezeigt, wenn das Tool Calling aktiviert ist, um eine Funktion auszuführen

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolsResults
Zeigt die Ergebnisse der Tools an, wenn sie vom PowershAI als Antwort auf das Tool Calling des Modells ausgeführt werden

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 13
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -SystemMessageFixed
System Message, die garantiert immer gesendet wird, unabhängig vom Verlauf und der Bereinigung des Chats!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 14
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Parameter, die direkt an die API übergeben werden sollen, die das Modell aufruft.  
Der Provider muss dies unterstützen.  
Um es zu verwenden, müssen Sie die Details der Provider-Implementierung und die Funktionsweise seiner API kennen!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormat
Steuert die Vorlage, die beim Injizieren von Kontextdaten verwendet wird!
Dieser Parameter ist ein Scriptblock, der eine Zeichenkette mit dem Kontext zurückgeben muss, der in den Prompt eingefügt werden soll!
Die Parameter des Scriptblocks sind:
	FormattedObject 	- Das Objekt, das den aktiven Chat darstellt, bereits mit dem konfigurierten Formatierungsprogramm formatiert
	CmdParams 			- Die an Send-PowershaAIChat übergebenen Parameter. Das ist das gleiche Objekt, das von GetMyParams zurückgegeben wird
	Chat 				- Der Chat, in den die Daten gesendet werden.
Wenn null, wird ein Standardwert generiert. Weitere Informationen finden Sie im Cmdlet Send-PowershaAIChat

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 16
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
