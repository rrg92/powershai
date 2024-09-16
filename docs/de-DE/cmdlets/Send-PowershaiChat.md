---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Sendet eine Nachricht in einem Powershai-Chat

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet ermöglicht es Ihnen, eine neue Nachricht an das LLM des aktuellen Providers zu senden.
Standardmäßig wird sie in den aktiven Chat gesendet. Sie können den Chat mit dem Parameter -Chat überschreiben. Wenn es keinen aktiven Chat gibt, wird der Standardchat verwendet.

Verschiedene Chat-Parameter beeinflussen, wie dieser Befehl funktioniert. Weitere Informationen zu Chat-Parametern finden Sie im Befehl Get-PowershaiChatParameter.
Zusätzlich zu den Chat-Parametern können die Parameter des Befehls selbst das Verhalten überschreiben. Weitere Einzelheiten finden Sie in der Dokumentation zu den einzelnen Parametern dieses Cmdlets mit get-help.

Aus Gründen der Einfachheit und um die Befehlszeile sauber zu halten, ermöglicht es dem Benutzer, sich mehr auf die Eingabeaufforderung und die Daten zu konzentrieren, werden einige Aliase zur Verfügung gestellt.
Diese Aliase können bestimmte Parameter aktivieren.
Sie sind:
	ia|ai
		Abkürzung für "Künstliche Intelligenz" auf Deutsch. Dies ist ein einfacher Alias und ändert keinen Parameter. Er hilft, die Befehlszeile erheblich zu verkürzen.
	
	iat|ait
		Das gleiche wie Send-PowershaAIChat -Temporary
		
	io|ao
		Das gleiche wie Send-PowershaAIChat -Object

Der Benutzer kann seine eigenen Aliase erstellen. Zum Beispiel:
	Set-Alias ki ia # DEfine den Alias für Deutsch!
	Set-Alias kit iat # DEfine den Alias kit für iat, so dass das Verhalten beim Verwenden von kit dem von iat entspricht (temporärer Chat)!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] 
[-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
die Eingabeaufforderung, die an das Modell gesendet werden soll

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

### -SystemMessages
Systemnachricht, die eingefügt werden soll

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
Der Kontext
Dieser Parameter ist vorzugsweise für die Pipeline bestimmt.
Er sorgt dafür, dass der Befehl die Daten in Tags <contexto></contexto> einfügt und diese zusammen mit der Eingabeaufforderung einfügt.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
Zwingt das Cmdlet, für jedes Objekt in der Pipeline ausgeführt zu werden
Standardmäßig werden alle Objekte in einem Array gesammelt, das Array in eine Zeichenkette umgewandelt und als Ganzes an das LLM gesendet.

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

### -Json
Aktiviert den JSON-Modus
In diesem Modus sind die zurückgegebenen Ergebnisse immer ein JSON.
Das aktuelle Modell muss dies unterstützen!

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

### -Object
Objektmodus!
In diesem Modus wird der JSON-Modus automatisch aktiviert!
Der Befehl schreibt nichts auf den Bildschirm und gibt die Ergebnisse als Objekt zurück!
Die Ergebnisse werden dann wieder in die Pipeline eingefügt!

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

### -PrintContext
Zeigt die an das LLM gesendeten Kontextdaten vor der Antwort an!
Hilft beim Debuggen dessen, was in die Eingabeaufforderung eingefügt wird.

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

### -Forget
Sendet nicht die vorherigen Konversationen (den Kontexthistorien), sondern fügt die Eingabeaufforderung und die Antwort in den Kontexthistorien ein.

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

### -Snub
Ignoriere die Antwort des LLM und füge die Eingabeaufforderung nicht in den Kontexthistorien ein.

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

### -Temporary
Sendet weder den Verlauf noch fügt die Antwort und Eingabeaufforderung ein.
Das ist dasselbe wie -Forget und -Snub zusammen zu übergeben.

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

### -DisableTools
Deaktiviert den Funktionsaufruf nur für diese Ausführung!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
Ändert den Kontextformatierung für diese
Weitere Informationen finden Sie in Format-PowershaiContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterParams
Parameter des geänderten Kontextformatiers.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PassThru
Gibt die Nachrichten wieder in die Pipeline zurück, ohne direkt auf den Bildschirm zu schreiben!
Diese Option geht davon aus, dass der Benutzer für die korrekte Weiterleitung der Nachricht verantwortlich ist!
Das an die Pipeline übergebene Objekt hat die folgenden Eigenschaften:
	text 			- Der Text (oder Textabschnitt) der vom Modell zurückgegebenen Antwort
	formatted		- Der formatierte Text, einschließlich der Eingabeaufforderung, so wie er direkt auf dem Bildschirm ausgegeben wird (ohne die Farben)
	event			- Das Ereignis. Gibt das Ereignis an, das den Ursprung darstellt. Es sind die gleichen Ereignisse, die in Invoke-AiChatTools dokumentiert sind.
	interaction 	- Das von Invoke-AiChatTools generierte Interaction-Objekt

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

### -Lines
Gibt ein Array von Zeilen zurück
Wenn der Stream-Modus aktiviert ist, wird eine Zeile nach der anderen zurückgegeben!

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
