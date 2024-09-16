---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioApiResult

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Aktualisiert ein Ereignis, das von Send-GradioApi zurückgegeben wird, mit neuen Ergebnissen vom Server und gibt standardmäßig die Ereignisse in der Pipeline zurück.

Die Ergebnisse der Gradio-Apis werden nicht sofort generiert, wie dies bei den meisten HTTP-REST-Diensten der Fall ist.  
Die Hilfe zum Befehl Send-GradioApi erklärt im Detail, wie der Prozess funktioniert.  

Dieser Befehl sollte verwendet werden, um das GradioApiEvent-Objekt zu aktualisieren, das von Send-GradioApi zurückgegeben wird.
Dieses Objekt stellt die Antwort jedes Aufrufs dar, den Sie an die API richten, es enthält alles, was zum Abrufen des Ergebnisses erforderlich ist, einschließlich Daten und Verlauf.

Im Wesentlichen funktioniert dieses Cmdlet, indem es den Endpunkt zur Abfrage des Status des Api-Aufrufs aufruft.
Die für die Abfrage erforderlichen Parameter sind im Objekt selbst verfügbar, das an den Parameter -ApiEvent übergeben wird (der vom Cmdlet Send-GradioApi erstellt und zurückgegeben wird).

Jedes Mal, wenn dieses Cmdlet ausgeführt wird, kommuniziert es über eine persistente HTTP-Verbindung mit dem Server und wartet auf Ereignisse.  
Wenn der Server die Daten sendet, aktualisiert er das Objekt, das an den Parameter -ApiEvent übergeben wird, und schreibt standardmäßig das zurückgegebene Ereignis in die Pipeline.

Das zurückgegebene Ereignis ist ein Objekt vom Typ GradioApiEventResult und stellt ein Ereignis dar, das durch die Antwort der Ausführung der API generiert wird.  

Wenn der Parameter -History angegeben ist, bleiben alle generierten Ereignisse in der Eigenschaft events des in -ApiEvent bereitgestellten Objekts sowie die zurückgegebenen Daten erhalten.

Im Wesentlichen können die generierten Ereignisse einen Hearbeat oder Daten senden.

OBJEKT GradioApiEventResult
	num 	= fortlaufende Nummer des Ereignisses. beginnt bei 1.
	ts 		= Datum, an dem das Ereignis erstellt wurde (lokales Datum, nicht des Servers).
	event 	= Name des Ereignisses
	data 	= Daten, die in diesem Ereignis zurückgegeben werden

DATEN (DATA)

	Um die Daten von Gradio abzurufen, müssen Sie im Wesentlichen die von diesem Cmdlet zurückgegebenen Ereignisse lesen und in der Eigenschaft data von GradioApiEventResult nachsehen.
	Normalerweise überschreibt die Gradio-Schnittstelle das Feld mit dem zuletzt empfangenen Ereignis.  
	
	Wenn -History verwendet wird, speichert das Cmdlet neben dem Schreiben in die Pipeline auch die Daten im Feld data, sodass Sie Zugriff auf den vollständigen Verlauf der vom Server generierten Daten haben.  
	Beachten Sie, dass dies zu einem zusätzlichen Speicherverbrauch führen kann, wenn viele Daten zurückgegeben werden.
	
	Es gibt einen bekannten "problematischen" Fall: Möglicherweise gibt Gradio die beiden letzten Ereignisse mit denselben Daten aus (ein Ereignis wird den Namen "generating" haben und das letzte wird complete sein).  
	Wir haben noch keine sichere Lösung, um dies zu trennen, daher muss der Benutzer entscheiden, wie er dies am besten handhabt.  
	Wenn Sie immer das letzte empfangene Ereignis verwenden, ist dies kein Problem.
	Wenn Sie alle Ereignisse verwenden müssen, sobald sie generiert werden, müssen Sie diese Fälle behandeln.
	Ein einfaches Beispiel wäre der Kauf des Inhalts, wenn er gleich wäre, nicht wiederholen. Es kann jedoch Szenarien geben, in denen zwei Ereignisse mit demselben Inhalt logisch dennoch unterschiedliche Ereignisse sind.
	
	

HEARTBEAT 

	Eines der von der Gradio-API generierten Ereignisse sind die Heartbeats.  
	Alle 15 Sekunden sendet Gradio ein Ereignis vom Typ "HeartBeat", nur um die Verbindung aktiv zu halten.  
	Dies führt dazu, dass das Cmdlet "hängt", da das Cmdlet aufgrund der aktiven HTTP-Verbindung auf eine Antwort wartet (die Daten, Fehler oder den Hearbeat sein werden).
	
	Wenn es keinen Mechanismus zur Steuerung gibt, würde das Cmdlet unbegrenzt ausgeführt werden, ohne dass es mit STRG + C abgebrochen werden könnte.
	Um dies zu lösen, stellt dieses Cmdlet den Parameter MaxHeartBeats zur Verfügung.  
	Dieser Parameter gibt an, wie viele aufeinanderfolgende Heartbeat-Ereignisse toleriert werden, bevor das Cmdlet versucht, die API abzufragen.  
	
	Betrachten Sie zum Beispiel diese beiden Szenarien für Ereignisse, die vom Server gesendet werden:
	
		Szenario 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		Szenario 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	Unter Berücksichtigung des Standardwerts 2 würde das Cmdlet im Szenario 1 nie vor complete enden, da es nie zwei aufeinanderfolgende Heartbeats gab.
	
	Im Szenario 2 hingegen würde das Cmdlet nach dem Empfang von zwei Datenereignissen (generating) beim vierten Ereignis (hearbeat) enden, da zwei aufeinanderfolgende Heartbeats gesendet wurden.  
	Wir sagen, dass der Heartbeat in diesem Fall abgelaufen ist.
	In diesem Fall sollten Sie Update-GradioApiResult erneut aufrufen, um den Rest abzurufen.
	
	Jedes Mal, wenn der Befehl aufgrund eines abgelaufenen Heartbeats beendet wird, aktualisiert er den Wert der Eigenschaft LastQueryStatus auf HeartBeatExpired.  
	Dadurch können Sie überprüfen und richtig behandeln, wann Sie erneut anrufen müssen.
	
	
STREAM  
	
	Da die Gradio-Api bereits mit SSE (Server Side Events) antwortet, ist es möglich, einen Effekt zu erzielen, der dem "Stream" vieler Apis ähnelt.  
	Dieses Cmdlet, Update-GradioApiResult, verarbeitet die Ereignisse des Servers bereits mit SSE.  
	Wenn Sie zusätzlich auch eine Verarbeitung durchführen möchten, sobald das Ereignis verfügbar ist, können Sie den Parameter -Script verwenden und einen Scriptblock, Funktionen usw. angeben, der aufgerufen wird, sobald das Ereignis empfangen wird.  
	
	In Kombination mit dem Parameter -MaxHeartBeats können Sie einen Aufruf erstellen, der etwas in Echtzeit aktualisiert. 
	Wenn es sich beispielsweise um eine Antwort eines Chatbots handelt, können Sie diese sofort auf dem Bildschirm ausgeben.
	
	Beachten Sie, dass dieser Parameter sequenziell mit dem Code aufgerufen wird, der überprüft (d. h. derselbe Thread).  
	Daher können Skripte, die lange dauern, die Erkennung neuer Ereignisse und damit die Bereitstellung der Daten beeinträchtigen.
	
.

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiEvent
Ergebnis von  Send-GradioApi

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Script
Skript, das bei jedem generierten Ereignis aufgerufen wird!
Erhält eine Hashtabelle mit den folgenden Schlüsseln:
 	event - enthält das generierte Ereignis. event.event ist der Name des Ereignisses. event.data sind die zurückgegebenen Daten.

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

### -MaxHeartBeats
Maximale Anzahl aufeinanderfolgender Heartbeats bis zum Stopp!
Dadurch wird das Cmdlet nur diese Anzahl aufeinanderfolgender Heartbeats vom Server abwarten.
Wenn der Server diese Menge sendet, beendet sich das Cmdlet und setzt LastQueryStatus des Ereignisses auf HeartBeatExpired

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

### -NoOutput
Schreibt das Ergebnis nicht in die Ausgabe des Cmdlets

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

### -History
Speichert den Verlauf der Ereignisse und Daten im ApiEvent-Objekt
Beachten Sie, dass dies zu einem höheren Speicherverbrauch in PowerShell führt!

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
