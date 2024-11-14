---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Sendet eine Nachricht in einen Powershai-Chat

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet ermöglicht es Ihnen, eine neue Nachricht an das LLM des aktuellen Providers zu senden.  
Standardmäßig wird es im aktiven Chat gesendet. Sie können den Chat mit dem Parameter -Chat überschreiben. Wenn kein aktiver Chat vorhanden ist, wird der Standard verwendet.  

Verschiedene Chat-Parameter beeinflussen, wie dieser Befehl funktioniert. Sehen Sie sich den Befehl Get-PowershaiChatParameter für weitere Informationen zu den Chat-Parametern an.  
Neben den Chat-Parametern können auch die Parameter des Befehls das Verhalten überschreiben. Für weitere Details konsultieren Sie die Dokumentation zu jedem Parameter dieses Cmdlets mit get-help.  

Zur Vereinfachung und um die Befehlszeile sauber zu halten, sodass der Benutzer sich mehr auf die Eingabeaufforderung und die Daten konzentrieren kann, sind einige Aliase verfügbar.  
Diese Aliase können bestimmte Parameter aktivieren.
Sie sind:
	ia|ai
		Abkürzung für "Künstliche Intelligenz" auf Portugiesisch. Dies ist ein einfacher Alias und ändert keinen Parameter. Er hilft, die Befehlszeile erheblich zu verkürzen.
	
	iat|ait
		Dasselbe wie Send-PowershaAIChat -Temporary
		
	io|ao
		Dasselbe wie Send-PowershaAIChat -Object
		
	iam|aim 
		Dasselbe wie Send-PowershaaiChat -Screenshot 

Der Benutzer kann seine eigenen Aliase erstellen. Zum Beispiel:
	Set-Alias ki ia # Definiert den Alias für das Deutsche!
	Set-Alias kit iat # Definiert den Alias kit für iat, wodurch das Verhalten dem von iat (temporärer Chat) entspricht, wenn kit verwendet wird!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] 
[-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] 
[-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
der Prompt, der an das Modell gesendet werden soll

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
Systemnachricht, die einbezogen werden soll

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
Dieser Parameter sollte vorzugsweise über die Pipeline verwendet werden.  
Er sorgt dafür, dass der Befehl die Daten in <contexto></contexto>-Tags einfügt und zusammen mit dem Prompt injiziert.

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
Zwingt das Cmdlet, für jedes Objekt der Pipeline auszuführen  
Standardmäßig werden alle Objekte in einem Array gesammelt, das Array wird in einen einzigen String konvertiert und einmal an das LLM gesendet.

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
In diesem Modus werden die zurückgegebenen Ergebnisse immer ein JSON sein.  
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
Der Befehl wird nichts auf dem Bildschirm ausgeben und die Ergebnisse als Objekt zurückgeben!  
Diese werden zurück in die Pipeline geleitet!

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
Zeigt die Kontextdaten an, die vor der Antwort an das LLM gesendet wurden!  
Nützlich, um zu debuggen, welche Daten in den Prompt injiziert werden.

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
Sendet die vorherigen Gespräche (den Kontextverlauf) nicht, schließt aber den Prompt und die Antwort im historischen Kontext ein.

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
Ignoriert die Antwort des LLM und schließt den Prompt nicht im historischen Kontext ein.

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
Sendet den Verlauf und schließt weder die Antwort noch den Prompt ein.  
Es ist dasselbe wie das gleichzeitige Verwenden von -Forget und -Snub.

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
Ändert den Kontext-Formatter auf diesen  
Erfahren Sie mehr in Format-PowershaiContext

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
Parameter des geänderten Kontext-Formatters.

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
Gibt die Nachrichten zurück in die Pipeline, ohne direkt auf dem Bildschirm zu schreiben!  
Diese Option geht davon aus, dass der Benutzer für die korrekte Zielrichtung der Nachricht verantwortlich ist!  
Das Objekt, das an die Pipeline übergeben wird, hat die folgenden Eigenschaften:
	text 			- Der Text (oder Abschnitt) des vom Modell zurückgegebenen Textes 
	formatted		- Der formatierte Text, einschließlich des Prompts, als ob er direkt auf dem Bildschirm geschrieben worden wäre (ohne Farben)
	event			- Das Ereignis. Gibt das Ursprungsereignis an. Dies sind die gleichen Ereignisse, die in Invoke-AiChatTools dokumentiert sind
	interaction 	- Das durch Invoke-AiChatTools generierte Interaktionsobjekt

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
Wenn der Streaming-Modus aktiviert ist, wird eine Zeile nach der anderen zurückgegeben!

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

### -ChatParamsOverride
Überschreibt die Chat-Parameter!  
Geben Sie jede Option in Hashtables an!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Gibt den Wert des Chat-Parameters RawParams direkt an!  
Wenn auch in ChatParamOverride angegeben, wird eine Zusammenführung durchgeführt, wobei die hier angegebenen Parameter Vorrang haben.  
Der RawParams ist ein Chat-Parameter, der Parameter definiert, die direkt an die API des Modells gesendet werden!  
Diese Parameter überschreiben die standardmäßig vom Powershai berechneten Werte!  
Damit hat der Benutzer die volle Kontrolle über die Parameter, muss jedoch jeden Provider kennen!  
Außerdem ist jeder Provider verantwortlich für die Bereitstellung dieser Implementierung und die Nutzung dieser Parameter in seiner API.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
Macht einen Screenshot des Bildschirms hinter dem PowerShell-Fenster und sendet ihn zusammen mit dem Prompt.  
Beachten Sie, dass das aktuelle Modell Bilder (Vision Language Models) unterstützen muss.

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
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
