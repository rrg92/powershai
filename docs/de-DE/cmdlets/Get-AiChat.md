---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Sendet Nachrichten an ein LLM und gibt die Antwort zurück

## DESCRIPTION <!--!= @#Desc !-->
Dies ist die grundlegendste Form des Chats, die von PowershAI angeboten wird.  
Mit dieser Funktion können Sie eine Nachricht an ein LLM des aktuellen Anbieters senden.  

Diese Funktion ist eine niedrigere Ebene, standardisierte Art des Zugriffs auf ein LLM, die PowershAI bereitstellt.  
Sie verwaltet keinen Verlauf oder Kontext. Sie ist nützlich, um einfache Prompts zu invokieren, die keine mehreren Interaktionen wie in einem Chat erfordern. 
Obwohl sie das Functon Calling unterstützt, führt sie keinen Code aus und gibt lediglich die Antwort des Modells zurück.



** INFORMATIONEN FÜR ANBIETER
	Der Anbieter muss die Funktion Chat implementieren, damit diese Funktionalität verfügbar ist. 
	Die Funktion Chat muss ein Objekt mit der Antwort zurückgeben, das die gleiche Spezifikation wie OpenAI, Funktion Chat Completion, hat.
	Die folgenden Links dienen als Grundlage:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (Rückgabe ohne Streaming)
	Der Anbieter muss die Parameter dieser Funktion implementieren. 
	Bitte beachten Sie die Dokumentation zu jedem Parameter für Details und wie sie auf einen Anbieter abgebildet werden;
	
	Wenn das Modell einen der angegebenen Parameter nicht unterstützt (d.h. keine gleichwertige Funktionalität vorhanden ist oder gleichwertig implementiert werden kann), muss ein Fehler zurückgegeben werden.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] 
[[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Der Prompt, der gesendet werden soll. Muss im Format beschrieben werden, das von der Funktion ConvertTo-OpenaiMessage erwartet wird.

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

### -temperature
Temperatur des Modells

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Name des Modells. Wenn nicht angegeben, wird das Standardmodell des Anbieters verwendet.

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
Maximale Anzahl von Tokens, die zurückgegeben werden sollen

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
Format der Antwort 
Die akzeptablen Formate und das Verhalten müssen dem von OpenAI folgen: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Abkürzungen:
	"json"|"json_object", entspricht {"type": "json_object"}
	Das Objekt muss ein Schema angeben, als wäre es direkt an die OpenAI-API im Feld response_format.json_schema übergeben worden.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Functions
Liste der Tools, die aufgerufen werden sollen!
Sie können Befehle wie Get-OpenaiTool* verwenden, um PowerShell-Funktionen leicht in das erwartete Format zu transformieren!
Wenn das Modell die Funktion aufruft, muss die Antwort, sowohl im Stream als auch normal, ebenfalls dem Tool Calling-Modell von OpenAI folgen.
Dieser Parameter muss dem gleichen Schema des Function Calling von OpenAI folgen: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Geben Sie direkte Parameter der API des Anbieters an.
Dies überschreibt die Werte, die basierend auf den anderen Parametern berechnet und generiert wurden.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback
Aktiviert das Modell Stream 
Sie müssen einen ScriptBlock angeben, der für jeden vom LLM generierten Text aufgerufen wird.
Das Skript muss einen Parameter empfangen, der jeden Abschnitt im gleichen Format darstellt, das zurückgegeben wird
	Dieser Parameter ist ein Objekt, das die Eigenschaft choices enthält, die dem gleichen Schema entspricht, das von OpenAI im Streaming zurückgegeben wird:
		https://platform.openai.com/docs/api-reference/chat/streaming

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

### -IncludeRawResp
Die Antwort der API in einem Feld namens IncludeRawResp einfügen

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
