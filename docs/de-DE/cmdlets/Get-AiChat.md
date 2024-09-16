---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Sendet Nachrichten an einen LLM und gibt die Antwort zurück

## DESCRIPTION <!--!= @#Desc !-->
Dies ist die grundlegendste Chat-Form, die von PowershAI bereitgestellt wird.  
Mit dieser Funktion können Sie eine Nachricht an einen LLM des aktuellen Providers senden.  

Diese Funktion ist ein niedrigeres, standardisiertes Mittel für den Zugriff auf einen LLM, den PowershAI bereitstellt.  
Sie verwaltet keinen Verlauf oder Kontext. Sie ist nützlich, um einfache Eingabeaufforderungen aufzurufen, die keine Mehrfachinteraktionen wie in einem Chat erfordern. 
Obwohl sie das Funktionsaufrufen unterstützt, führt sie keinen Code aus und gibt nur die Antwort des Modells zurück.



** INFORMATIONEN FÜR ANBIETER
	Der Anbieter muss die Chat-Funktion implementieren, damit diese Funktionalität verfügbar ist. 
	Die Chat-Funktion muss ein Objekt mit der Antwort mit derselben Spezifikation wie die OpenAI-Funktion Chat Completion zurückgeben.
	Die folgenden Links dienen als Grundlage:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (Rückgabe ohne Streaming)
	Der Anbieter muss die Parameter dieser Funktion implementieren. 
	Informationen zu Details und zur Zuordnung zu einem Anbieter finden Sie in der Dokumentation zu jedem Parameter;
	
	Wenn das Modell einen der angegebenen Parameter nicht unterstützt (d. h. keine entsprechende Funktionalität vorhanden ist oder auf äquivalente Weise implementiert werden kann), muss ein Fehler zurückgegeben werden.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Die zu sendende Eingabeaufforderung. Muss im Format sein, das von der Funktion ConvertTo-OpenaiMessage beschrieben wird.

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
Name des Modells. Wenn nicht angegeben, wird der Standard des Providers verwendet.

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
Maximale Anzahl der zurückzugebenden Token

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
Die akzeptablen Formate und das Verhalten müssen mit denen von OpenAI übereinstimmen: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Abkürzungen:
	"json" entspricht {"type": "json_object"}

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
Sie können Befehle wie Get-OpenaiTool* verwenden, um Powershell-Funktionen einfach in das gewünschte Format zu transformieren!
Wenn das Modell die Funktion aufruft, muss die Antwort, sowohl im Stream als auch normal, auch dem Modell für das Funktionsaufrufen von OpenAI entsprechen.
Dieser Parameter muss dem gleichen Schema wie das Funktionsaufrufen von OpenAI entsprechen: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
Geben Sie direkte Parameter der API des Providers an.
Dadurch werden die Werte überschrieben, die auf der Grundlage anderer Parameter berechnet und generiert wurden.

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
Sie müssen ein ScriptBlock angeben, das für jeden vom LLM generierten Text aufgerufen wird.
Das Skript muss einen Parameter empfangen, der jeden Abschnitt im selben Streaming-Format darstellt, das zurückgegeben wird
	Dieser Parameter ist ein Objekt, das die Eigenschaft choices enthält, die dem Schema entspricht, das vom Streaming von OpenAI zurückgegeben wird:
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
Die Antwort der API in einem Feld namens IncludeRawResp einschließen

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
