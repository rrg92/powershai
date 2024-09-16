---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Erstellt Funktionen, die Aufrufe an einen Gradio-Endpunkt (oder alle Endpunkte) kapseln.  
Dieses Cmdlet ist sehr nützlich, um PowerShell-Funktionen zu erstellen, die einen Gradio-API-Endpunkt kapseln, wobei die API-Parameter als Funktionsparameter erstellt werden.  
So können native PowerShell-Funktionen wie Autovervollständigung, Datentyp und Dokumentation verwendet werden, und es ist sehr einfach, jeden Endpunkt einer Sitzung aufzurufen.

Der Befehl ruft die Metadaten der Endpunkte und Parameter ab und erstellt die PowerShell-Funktionen im globalen Bereich.  
Dadurch kann der Benutzer die Funktionen direkt aufrufen, als wären sie normale Funktionen.  

Angenommen, eine Gradio-Anwendung unter der Adresse http://mydemo1.hf.space verfügt über einen Endpunkt namens /GenerateImage, um Bilder mit Stable Diffusion zu generieren.  
Nehmen Sie an, dass diese Anwendung zwei Parameter akzeptiert: Prompt (die Beschreibung des zu generierenden Bildes) und Steps (die Gesamtzahl der Schritte).

Normalerweise könnten Sie den Befehl Invoke-GradioSessionApi verwenden, so: 

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

Dies würde die API starten, und Sie könnten die Ergebnisse mit Update-GradioApiResult erhalten:

$ApiEvent | Update-GradioApiResult

Mit diesem Cmdlet können Sie diese Aufrufe etwas mehr einkapseln:

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

Der obige Befehl erstellt eine Funktion namens Invoke-GradioApiGenerateimage.
Dann können Sie sie auf einfache Weise verwenden, um das Bild zu generieren:

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100 

Standardmäßig würde der Befehl die Ereignisse ausführen und bereits die Ergebnisereignisse abrufen, die an die Pipeline geschrieben werden, sodass Sie sie in andere Befehle integrieren können.  
Es ist sogar sehr einfach, mehrere Spaces zu verbinden, siehe unten zu Pipeline.

NOMENKLATUR 

	Der Name der erstellten Funktionen folgt dem Format:  <Prefix><NomeOp>
		<Prefix> ist der Wert des Parameters -Prefix dieses Cmdlets. 
		<NomeOp> ist der Name der Operation, der nur Buchstaben und Zahlen enthält.
		
		Wenn die Operation beispielsweise /Op1 ist und der Präfix INvoke-GradioApi lautet, wird die folgende Funktion erstellt: Invoke-GradioApiOp1

	
PARAMETER
	Die erstellten Funktionen enthalten die notwendige Logik, um die übergebenen Parameter umzuwandeln und das Cmdlet Invoke-GradioSessionApi auszuführen.  
	Das heißt, das gleiche Ergebnis gilt, als würden Sie dieses Cmdlet direkt aufrufen.  (Das heißt, ein Ereignis wird zurückgegeben und der Liste der Ereignisse der aktuellen Sitzung hinzugefügt).
	
	Die Parameter der Funktionen können je nach Endpunkt der API variieren, da jeder Endpunkt über einen anderen Satz von Parametern und Datentypen verfügt.
	Parameter, die Dateien (oder eine Liste von Dateien) sind, haben einen zusätzlichen Schritt für den Upload. Die Datei kann lokal referenziert werden und der Upload erfolgt auf den Server.  
	Wenn eine URL oder ein FileData-Objekt angegeben wird, das von einem anderen Befehl empfangen wird, erfolgt kein zusätzlicher Upload, es wird nur ein entsprechendes FileData-Objekt zum Senden über die API generiert.

	Neben den Parametern des Endpunkts gibt es einen zusätzlichen Satz von Parametern, die der erstellten Funktion immer hinzugefügt werden.  
	Sie sind:
		- Manual  
		Wenn es verwendet wird, lässt das Cmdlet das von INvoke-GradioSessionApi generierte Ereignis zurückgeben.  
		In diesem Fall müssen Sie die Ergebnisse manuell mit Update-GradioSessionApiResult abrufen.
		
		- ApiResultMap 
		Macht die Ergebnisse anderer Befehle den Parametern zugeordnet. Weitere Informationen finden Sie im Abschnitt PIPELINE.
		
		- DebugData
		Für Debug-Zwecke durch die Entwickler.
		
UPLOAD 	
	Parameter, die Dateien akzeptieren, werden auf eine besondere Weise behandelt.  
	Vor dem Aufruf der API wird das Cmdlet Send-GradioSessionFiles verwendet, um diese Dateien in die jeweilige Gradio-App hochzuladen.  
	Dies ist ein weiterer großer Vorteil der Verwendung dieses Cmdlets, da dies transparent geschieht und der Benutzer sich nicht um Uploads kümmern muss.

PIPELINE 
	
	Eine der leistungsstärksten Funktionen von PowerShell ist die Pipeline, mit der mehrere Befehle mit dem Pipe-Symbol | verbunden werden können.
	Und dieses Cmdlet versucht auch, dieses Feature maximal zu nutzen.  
	
	Alle erstellten Funktionen können mit dem | verbunden werden.
	Wenn Sie dies tun, wird jedes Ereignis, das vom vorherigen Cmdlet generiert wird, an das nächste weitergegeben.  
	
	Betrachten Sie zwei Gradio-Apps, App1 und App2.
	App1 verfügt über den Endpunkt Img mit einem Parameter namens Text, der Bilder mit Diffusers generiert und die Zwischenergebnisse jedes Bildes während der Generierung anzeigt.
	App2 verfügt über einen Endpunkt Ascii mit einem Parameter namens Image, der ein Bild in eine ASCII-Textversion umwandelt.
	
	Sie können diese beiden Befehle auf sehr einfache Weise mit der Pipeline verbinden.  
	Erstellen Sie zunächst die Sitzungen

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator
		
	Erstellen Sie die Funktionen 
		$App1 | New-GradioSessionApiProxy -Prefix App # dies erstellt die Funktion AppImg
		$App2 | New-GradioSessionApiProxy -Prefix App # dies erstellt die Funktion AppAscii
		
	Generieren Sie das Bild und verbinden Sie es mit dem ASCII-Generator:
	
	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data[0]; write-host $_.pipeline[0].data[0].url } 
	
	Lassen Sie uns nun die obige Sequenz aufschlüsseln.
	
	Vor dem ersten Pipe-Symbol haben wir den Befehl, der das Bild generiert: AppImg -Text "A car" 
	Diese Funktion ruft den Endpunkt /Img von App1 auf. Dieser Endpunkt gibt einen Ausgang für die Stufe der Bildgenerierung mit der Diffusers-Bibliothek von Hugging Face aus.  
	In diesem Fall ist jeder Ausgang ein (ziemlich verschwommenes) Bild, bis zum letzten Ausgang, der das endgültige Bild ist.  
	Dieses Ergebnis befindet sich in der data-Eigenschaft des Pipeline-Objekts. Es ist ein Array mit den Ergebnissen.
	
	Gleich danach im Pipe-Symbol haben wir den Befehl: AppAscii -Map ImageInput=0
	Dieser Befehl empfängt jedes Objekt, das vom Befehl AppImg generiert wird, in diesem Fall die partiellen Bilder des Diffusionsprozesses.  
	
	Da die Befehle ein Array von Ausgängen generieren können, müssen Sie genau zuordnen, welches der Ergebnisse mit welchen Parametern verknüpft werden soll.  
	Daher verwenden wir den Parameter -Map (-Map ist ein Alias, der richtige Name ist eigentlich ApiResultMap).
	Die Syntax ist einfach: NameParam=DataIndex,NameParam=DataIndex  
	Im obigen Befehl sagen wir: AppAscii, verwende den ersten Wert der data-Eigenschaft im Parameter ImageInput.  
	Wenn AppImg beispielsweise 4 Werte zurückgibt und das Bild an der letzten Position steht, müssten Sie ImageInput=3 verwenden (0 ist die erste).
	
	
	Schließlich gibt das letzte Pipe-Symbol nur das Ergebnis von AppAscii aus, das sich jetzt im Pipeline-Objekt befindet, $_, in der data-Eigenschaft (wie das Ergebnis von AppImg).  
	Und um dies zu ergänzen, hat das Pipeline-Objekt eine spezielle Eigenschaft namens pipeline. Mit ihr können Sie auf alle Ergebnisse der generierten Befehle zugreifen.  
	Wenn Sie beispielsweise $_.pipeline[0] eingeben, erhalten Sie das Ergebnis des ersten Befehls (AppImg). 
	
	Dank dieses Mechanismus ist es viel einfacher, verschiedene Gradio-Apps in einer einzigen Pipeline zu verbinden.
	Beachten Sie, dass diese Sequenz nur zwischen Befehlen funktioniert, die von New-GradioSessionApiProxy generiert werden. Wenn Sie andere Befehle mit dem Pipe-Symbol verbinden, wird dieser Effekt nicht erzielt (Sie müssen etwas wie For-EachObject verwenden und die Parameter direkt zuordnen).


SITZUNGEN 
	Wenn die Funktion erstellt wird, wird die Originalsitzung zusammen mit der Funktion gespeichert.  
	Wenn die Sitzung entfernt wird, gibt das Cmdlet einen Fehler aus. In diesem Fall müssen Sie die Funktion erneut erstellen, indem Sie dieses Cmdlet aufrufen.  


Das folgende Diagramm fasst die beteiligten Abhängigkeiten zusammen:

	New-GradioSessionApiProxyFunction(Prefix)
		---> function <Prefix><OpName>
			---> Send-GradioSessionFiles (wenn es Dateien gibt)
			---> Invoke-GradioSessionApi | Update-GradioSessionApiResult

Da Invoke-GradioSessionApi am Ende ausgeführt wird, gelten alle Regeln für sie.
Sie können Get-GradioSessionApiProxyFunction verwenden, um eine Liste der erstellten Funktionen zu erhalten, und Remove-GradioSessionApiProxyFunction, um eine oder mehrere erstellte Funktionen zu entfernen.  
Die Funktionen werden mit einem dynamischen Modul erstellt.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Erstellen Sie nur für diesen bestimmten Endpunkt

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -Prefix
Präfix der erstellten Funktionen

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Invoke-GradioApi
Accept pipeline input: false
Accept wildcard characters: false
```

### -Session
Sitzung

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
Erzwingt die Erstellung der Funktion, auch wenn bereits eine mit demselben Namen existiert!

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
