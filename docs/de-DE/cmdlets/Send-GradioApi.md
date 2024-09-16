---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Sendet Daten an eine Gradio-API und gibt ein Objekt zurück, das das Ereignis darstellt!
Geben Sie dieses Objekt an andere Cmdlets weiter, um die Ergebnisse zu erhalten.

GRADIO-API-FUNKTION

	Basierend auf: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	Um besser zu verstehen, wie dieses Cmdlet verwendet wird, ist es wichtig, zu verstehen, wie die Gradio-API funktioniert.
	Wenn wir einen API-Endpunkt aufrufen, werden die Daten nicht sofort zurückgegeben.
	Dies liegt einfach daran, dass die Verarbeitung aufgrund der Art (KI und maschinelles Lernen) umfangreich ist.
	
	Anstatt das Ergebnis zurückzugeben oder unbegrenzt zu warten, gibt Gradio eine "Ereignis-ID" zurück.
	Mit diesem Ereignis können wir die erzeugten Ergebnisse regelmäßig abrufen.
	Gradio generiert Ereignismeldungen mit den generierten Daten. Wir müssen die generierte Ereignis-ID übergeben, um die neuen generierten Teile abzurufen.
	Diese Ereignisse werden über Server-Side Events (SSE) gesendet und können eines der folgenden sein:
		- hearbeat 
		Alle 15 Sekunden sendet Gradio dieses Ereignis, um die Verbindung aktiv zu halten.
		Daher kann es beim Aufrufen des Cmdlets Update-GradioApiResult etwas dauern, bis es zurückgegeben wird.
		
		- complete 
		Ist die letzte Nachricht, die von Gradio gesendet wird, wenn die Daten erfolgreich generiert wurden!
		
		- error 
		Gesendet, wenn bei der Verarbeitung ein Fehler aufgetreten ist.
		
		- generating
		Wird generiert, wenn die API bereits Daten verfügbar hat, aber möglicherweise noch weitere folgen.
	
	Hier in PowershAI haben wir das auch in drei Teile geteilt: 
		- Dieses Cmdlet (Send-GradioApi) führt die anfängliche Anforderung an Gradio aus und gibt ein Objekt zurück, das das Ereignis darstellt (nennen wir es ein GradioApiEvent-Objekt)
		- Dieses resultierende Objekt vom Typ GradioApiEvent enthält alles, was zum Abfragen des Ereignisses erforderlich ist, und es speichert auch die erhaltenen Daten und Fehler.
		- Schließlich haben wir das Cmdlet Update-GradioApiResult, in dem Sie das generierte Ereignis übergeben müssen, und es wird die Gradio-API abfragen und die neuen Daten abrufen.
			Weitere Informationen zum Steuern dieses Mechanismus zum Abrufen der Daten finden Sie in der Hilfe zu diesem Cmdlet.
			
	
	In einem normalen Workflow müssen Sie also Folgendes tun:
	
		# Rufen Sie den Gradio-Endpunkt auf!
		$MeuEvento = SEnd-GradioApi ... 
	
		# Rufen Sie Ergebnisse ab, bis sie abgeschlossen sind!
		# Weitere Informationen finden Sie in der Hilfe zu diesem Cmdlet!
		$MeuEvento | Update-GradioApiResult
		
GradioApiEvent-Objekt

	Das resultierende GradioApiEvent-Objekt dieses Cmdlets enthält alles, was PowershAI benötigt, um den Mechanismus zu steuern und die Daten abzurufen.
	Es ist wichtig, dass Sie seine Struktur kennen, damit Sie wissen, wie Sie die von der API generierten Daten sammeln.
	Eigenschaften:
	
		- Status  
		Gibt den Status des Ereignisses an.
		Wenn dieser Status "complete" ist, bedeutet dies, dass die API die Verarbeitung abgeschlossen hat und alle möglichen Daten bereits generiert wurden.
		Solange dies nicht der Fall ist, müssen Sie Update-GradioApiResult aufrufen, damit es den Status überprüft und die Informationen aktualisiert.
		
		- QueryUrl  
		Interner Wert, der den genauen Endpunkt für die Abfrage der Ergebnisse enthält
		
		- data  
		Ein Array, das alle generierten Antwortdaten enthält. Jedes Mal, wenn Sie Update-GradioApiResult aufrufen, werden Daten hinzugefügt, falls vorhanden, zu diesem Array.
		
		- events  
		Liste der vom Server generierten Ereignisse.
		
		- error  
		Wenn Fehler in der Antwort aufgetreten sind, enthält dieses Feld ein Objekt, eine Zeichenkette usw. mit weiteren Details.
		
		- LastQueryStatus  
		Gibt den Status der letzten Abfrage an der API an.
		Wenn "normal", bedeutet dies, dass die API abgefragt wurde und bis zum Ende normal zurückgegeben wurde.
		Wenn "HeartBeatExpired", bedeutet dies, dass die Abfrage aufgrund des vom Benutzer im Cmdlet Update-GradioApiResult konfigurierten Heartbeat-Timeouts unterbrochen wurde.
		
		- req 
		Daten der gestellten Anfrage!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] [[-token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

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

### -ApiName

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

### -Params

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

### -SessionHash

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -EventId
Wenn angegeben, wird die API nicht aufgerufen, sondern das Objekt erstellt und dieser Wert wird wie die Rückgabe verwendet

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

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
