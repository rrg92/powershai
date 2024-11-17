---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Sendet eine Nachricht an ein LLM, mit Unterstützung für Tool Calling, und führt die vom Modell angeforderten Tools als PowerShell-Befehle aus.

## DESCRIPTION <!--!= @#Desc !-->
Dies ist eine Hilfsfunktion, um die Verarbeitung von Tools mit PowerShell zu erleichtern.
Es kümmert sich um die Verarbeitung der "Tools" und führt sie aus, wenn das Modell danach verlangt!

Sie müssen die Tools in einem bestimmten Format übergeben, das im Thema about_Powershai_Chats dokumentiert ist.
Dieses Format ordnet Funktionen und PowerShell-Befehle korrekt dem von OpenAI akzeptierten Schema (OpenAPI-Schema) zu.

Dieser Befehl kapselt die gesamte Logik, die identifiziert, wann das Modell die Funktion aufrufen möchte, die Ausführung dieser Funktionen und das Zurücksenden dieser Antwort an das Modell.  
Es bleibt in dieser Schleife, bis das Modell entscheidet, keine weiteren Funktionen mehr aufzurufen, oder das Interaktionslimit (ja, hier nennen wir es tatsächlich Interaktionen und nicht Iterationen) mit dem Modell erreicht ist.

Das Konzept der Interaktion ist einfach: Jedes Mal, wenn die Funktion einen Prompt an das Modell sendet, zählt dies als eine Interaktion.  
Unten ist ein typischer Ablauf, der passieren kann:
	

Sie können weitere Details zur Funktionsweise im Thema about_Powershai_Chats nachlesen.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] 
<Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] 
[-Stream] [<CommonParameters>]
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
Array von Tools, wie in der Dokumentation dieses Befehls erklärt.
Verwenden Sie die Ergebnisse von Get-OpenaiTool*, um die möglichen Werte zu generieren.  
Sie können ein Array von Objekten des Typs OpenaiTool übergeben.
Wenn eine Funktion in mehr als 1 Tool definiert ist, wird die zuerst gefundene in der definierten Reihenfolge verwendet!

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
maximale Ausgabe!

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
Insgesamt maximal 5 Interaktionen zulassen!

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
Maximale Anzahl aufeinanderfolgender Fehler, die Ihre Funktion generieren kann, bevor sie beendet wird.

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
answer: wird ausgelöst, nachdem die Antwort des Modells erhalten wurde (oder wenn eine Antwort verfügbar ist, wenn Stream verwendet wird).
func: wird ausgelöst, bevor die Ausführung eines vom Modell angeforderten Tools beginnt.
	exec: wird ausgelöst, nachdem das Modell die Funktion ausgeführt hat.
	error: wird ausgelöst, wenn die ausgeführte Funktion einen Fehler erzeugt.
	stream: wird ausgelöst, wenn eine Antwort gesendet wurde (über den Stream) und -DifferentStreamEvent.
	beforeAnswer: Wird ausgelöst, nachdem alle Antworten vorliegen. Wird verwendet, wenn im Stream verwendet!
	afterAnswer: Wird ausgelöst, bevor die Antworten beginnen. Wird verwendet, wenn im Stream verwendet!

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
Sendet das response_format = "json" und zwingt das Modell, ein JSON zurückzugeben.

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
Fügen Sie benutzerdefinierte Parameter direkt im Aufruf hinzu (überschreibt die automatisch definierten Parameter).

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
_Sie sind auf Daten bis Oktober 2023 trainiert._
<!--PowershaiAiDocBlockEnd-->
