---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Sendet eine Nachricht an einen LLM, mit Unterstützung für Tool Calling, und führt die vom Modell angeforderten Tools als Powershell-Befehle aus.

## DESCRIPTION <!--!= @#Desc !-->
Dies ist eine Hilfsfunktion, um das Tool-Processing mit Powershell zu vereinfachen.
Es kümmert sich um die Verarbeitung der "Tools" und führt sie aus, wenn das Modell sie anfordert!

Sie müssen die Tools in einem bestimmten Format übergeben, das im Thema about_Powershai_Chats dokumentiert ist.
Dieses Format ordnet Funktionen und Powershell-Befehle korrekt dem von OpenAI akzeptierten Schema zu (OpenAPI Schema).  

Dieser Befehl kapselt die gesamte Logik, die erkennt, wann das Modell die Funktion aufrufen möchte, die Ausführung dieser Funktionen und das Senden der Antwort zurück an das Modell.  
Er befindet sich in dieser Schleife, bis das Modell keine Funktionen mehr aufrufen möchte oder der Grenzwert für die Interaktionen (ja, hier nennen wir sie Interaktionen und nicht Iterationen) mit dem Modell erreicht ist.

Das Konzept der Interaktion ist einfach: Jedes Mal, wenn die Funktion einen Prompt an das Modell sendet, zählt dies als eine Interaktion.  
Im Folgenden ist ein typischer Ablauf dargestellt, der auftreten kann:
	

Weitere Informationen zur Funktionsweise finden Sie im Thema about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] 
[[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt

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

### -Tools
Array von Tools, wie in der Dokumentation zu diesem Befehl erklärt.
Verwenden Sie die Ergebnisse von Get-OpenaiTool* , um die möglichen Werte zu generieren.  
Sie können ein Array von Objekten vom Typ OpenaiTool übergeben.
Wenn eine Funktion in mehr als einem Tool definiert ist, wird die erste, die in der angegebenen Reihenfolge gefunden wird, verwendet!

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

### -PrevContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
max. Ausgabe!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 500
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
Insgesamt maximal 5 Iterationen zulassen!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Maximale Anzahl aufeinanderfolgender Fehler, die Ihre Funktion auslösen kann, bevor sie beendet wird.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 2
Accept pipeline input: false
Accept wildcard characters: false
```

### -temperature

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -on
Ereignis-Handler
Jeder Schlüssel ist ein Ereignis, das zu einem bestimmten Zeitpunkt von diesem Befehl ausgelöst wird!
Ereignisse:
answer: wird ausgelöst, nachdem die Antwort vom Modell erhalten wurde (oder wenn eine Antwort bei Verwendung von Stream verfügbar wird).
func: wird ausgelöst, bevor die Ausführung eines vom Modell angeforderten Tools gestartet wird.
	exec: wird ausgelöst, nachdem das Modell die Funktion ausgeführt hat.
	error: wird ausgelöst, wenn die ausgeführte Funktion einen Fehler erzeugt.
	stream: wird ausgelöst, wenn eine Antwort gesendet wurde (über Stream) und -DifferentStreamEvent
	beforeAnswer: Wird nach allen Antworten ausgelöst. Nützlich bei Verwendung von Stream!
	afterAnswer: Wird vor dem Start der Antworten ausgelöst. Nützlich bei Verwendung von Stream!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Sendet das response_format = "json" und zwingt das Modell, einen JSON zurückzugeben.

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

### -RawParams
Fügen Sie benutzerdefinierte Parameter direkt zum Aufruf hinzu (überschreibt die automatisch definierten Parameter).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Stream

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
