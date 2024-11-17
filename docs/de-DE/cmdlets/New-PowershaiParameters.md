---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Erstellt ein neues Objekt, das die Parameter eines PowershaiChat darstellt

## DESCRIPTION <!--!= @#Desc !-->
Erstellt ein Standardobjekt, das alle möglichen Parameter enthält, die im Chat verwendet werden können!
Der Benutzer kann ein get-help New-PowershaiParameters verwenden, um die Dokumentation der Parameter zu erhalten.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] 
<Boolean>] [[-ShowTokenStats] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] 
[[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] 
[[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Wenn true, wird der Stream-Modus verwendet, d.h. die Nachrichten werden angezeigt, während das Modell sie produziert.

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
Aktiviert den JSON-Modus. In diesem Modus wird das Modell gezwungen, eine Antwort im JSON-Format zurückzugeben.  
Wenn aktiviert, werden die über den Stream generierten Nachrichten nicht angezeigt, während sie produziert werden, und nur das Endergebnis wird zurückgegeben.

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
Wenn null, wird das Modell verwendet, das mit Set-AiDefaultModel definiert wurde.

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
Maximalanzahl von Tokens, die vom Modell zurückgegeben werden sollen.

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
Gibt den gesamten Prompt aus, der an das LLM gesendet wird.

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
Zeigt am Ende jeder Nachricht die Verbrauchsstatistiken in Tokens an, die von der API zurückgegeben werden.

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
Maximalanzahl von Interaktionen, die auf einmal durchgeführt werden können.  
Jedes Mal, wenn eine Nachricht gesendet wird, führt das Modell 1 Iteration aus (sendet die Nachricht und erhält eine Antwort).  
Wenn das Modell einen Funktionsaufruf anfordert, wird die generierte Antwort erneut an das Modell gesendet. Dies zählt als eine weitere Interaktion.  
Dieser Parameter steuert die maximale Anzahl von Interaktionen, die in jedem Aufruf vorhanden sein können.
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
Maximalanzahl von aufeinanderfolgenden Fehlern, die durch Tool Calling erzeugt werden.  
Beim Einsatz von Tool Calling begrenzt dieser Parameter, wie viele aufeinanderfolgende Tools, die einen Fehler verursacht haben, aufgerufen werden können.  
Der als Fehler betrachtete ist die Ausnahme, die vom Skript oder dem konfigurierten Befehl ausgelöst wird.

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
Maximale Größe des Kontexts in Zeichen.  
Zukünftig wird dies in Tokens sein.  
Steuert die Anzahl der Nachrichten im aktuellen Kontext des Chats. Wenn diese Zahl überschritten wird, löscht Powershai automatisch die ältesten Nachrichten.

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
Funktion, die zur Formatierung der über die Pipeline übergebenen Objekte verwendet wird.

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
Argumente, die an die ContextFormatterFunc übergeben werden sollen.

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
Wenn true, werden die Argumente der Funktionen angezeigt, wenn Tool Calling aktiviert ist, um eine Funktion auszuführen.

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
Zeigt die Ergebnisse der Tools an, wenn sie von PowershAI als Antwort auf den Tool Calling des Modells ausgeführt werden.

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
Systemnachricht, die garantiert immer gesendet wird, unabhängig von der Historie und dem Cleanup des Chats!

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
Parameter, die direkt an die API übergeben werden, die das Modell aufruft.  
Der Provider muss die Unterstützung dafür implementieren.  
Um es zu verwenden, müssen Sie die Implementierungsdetails des Providers und wie seine API funktioniert, kennen!

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
Steuert die Vorlage, die beim Injektieren von Kontextdaten verwendet wird!  
Dieser Parameter ist ein Scriptblock, der eine Zeichenfolge mit dem Kontext zurückgeben muss, die in den Prompt injiziert werden soll!  
Die Parameter des Scriptblocks sind:
	FormattedObject 	- Das Objekt, das den aktiven Chat darstellt, bereits mit dem konfigurierten Formatter formatiert.
	CmdParams 			- Die Parameter, die an Send-PowershaAIChat übergeben werden. Es ist dasselbe Objekt, das von GetMyParams zurückgegeben wird.
	Chat 				- Der Chat, in den die Daten gesendet werden.
Wenn null, wird eine Standardvorlage generiert. Überprüfen Sie das Cmdlet Send-PowershaiChat für Details.

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
_Sie sind auf Daten bis Oktober 2023 trainiert._
<!--PowershaiAiDocBlockEnd-->
