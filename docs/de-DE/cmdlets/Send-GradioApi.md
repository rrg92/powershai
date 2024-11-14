---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Sendet Daten an ein Gradio und gibt ein Objekt zurück, das das Ereignis darstellt! 
Übergeben Sie dieses Objekt an die anderen Cmdlets, um die Ergebnisse zu erhalten.

FUNKTIONSWEISE DER GRADIO-API 

    Basierend auf: https://www.gradio.app/guides/querying-gradio-apps-with-curl
    
    Um besser zu verstehen, wie man dieses Cmdlet verwendet, ist es wichtig zu verstehen, wie die Gradio-API funktioniert.  
    Wenn wir einen Endpunkt der API aufrufen, gibt er die Daten nicht sofort zurück.  
    Dies liegt einfach daran, dass die Verarbeitung umfangreich ist, aufgrund der Natur (KI und maschinelles Lernen).  
    
    Anstatt das Ergebnis zurückzugeben oder unbegrenzt zu warten, gibt Gradio eine "Event-ID" zurück.  
    Mit diesem Ereignis können wir periodisch die generierten Ergebnisse abrufen.  
    Gradio wird Ereignisnachrichten mit den generierten Daten senden. Wir müssen die generierte EventId übergeben, um die neuen generierten Teile abzurufen.
    Diese Ereignisse werden über Server Side Events (SSE) gesendet und können eine dieser Optionen sein:
        - heartbeat 
        Alle 15 Sekunden sendet Gradio dieses Ereignis, um die Verbindung aktiv zu halten.  
        Daher kann es beim Verwenden des Cmdlets Update-GradioApiResult etwas dauern, bis eine Rückmeldung erfolgt.
        
        - complete 
        Dies ist die letzte Nachricht, die von Gradio gesendet wird, wenn die Daten erfolgreich generiert wurden!
        
        - error 
        Wird gesendet, wenn ein Fehler bei der Verarbeitung aufgetreten ist.  
        
        - generating
        Wird generiert, wenn die API bereits verfügbare Daten hat, aber möglicherweise noch mehr kommen.
    
    Hier in PowershAI haben wir das auch in 3 Teile unterteilt: 
        - Dieses Cmdlet (Send-GradioApi) führt die anfängliche Anfrage an Gradio durch und gibt ein Objekt zurück, das das Ereignis darstellt (wir nennen es ein GradioApiEvent-Objekt).
        - Dieses resultierende Objekt vom Typ GradioApiEvent enthält alles, was erforderlich ist, um das Ereignis abzufragen, und es speichert auch die erhaltenen Daten und Fehler.
        - Schließlich haben wir das Cmdlet Update-GradioApiResult, bei dem Sie das generierte Ereignis übergeben müssen, und es wird die Gradio-API abfragen und die neuen Daten abrufen.  
          Überprüfen Sie die Hilfe dieses Cmdlets für weitere Informationen zur Steuerung dieses Mechanismus zur Abrufung der Daten.
          
    In einem normalen Ablauf sollten Sie Folgendes tun: 
    
        #Rufen Sie den Endpunkt von Gradio auf!
        $MeinEreignis = Send-GradioApi ... 
    
        #Erhalten Sie Ergebnisse, bis sie abgeschlossen sind!
        #Überprüfen Sie die Hilfe dieses Cmdlets, um mehr zu lernen!
        $MeinEreignis | Update-GradioApiResult
        
GradioApiEvent-Objekt

    Das GradioApiEvent-Objekt, das aus diesem Cmdlet resultiert, enthält alles, was erforderlich ist, damit PowershAI den Mechanismus steuert und die Daten abruft.  
    Es ist wichtig, dass Sie seine Struktur kennen, um zu wissen, wie Sie die von der API generierten Daten sammeln können.
    Eigenschaften:
    
        - Status  
        Gibt den Status des Ereignisses an. 
        Wenn dieser Status "complete" ist, bedeutet dies, dass die API die Verarbeitung abgeschlossen hat und alle möglichen Daten generiert wurden.  
        Solange es anders ist, sollten Sie Update-GradioApiResult aufrufen, damit es den Status überprüft und die Informationen aktualisiert. 
        
        - QueryUrl  
        Interner Wert, der den genauen Endpunkt für die Abfrage der Ergebnisse enthält.
        
        - data  
        Ein Array, das alle generierten Antwortdaten enthält. Jedes Mal, wenn Sie Update-GradioApiResult aufrufen, wird, falls Daten vorhanden sind, diese dem Array hinzugefügt.  
        
        - events  
        Liste von Ereignissen, die vom Server generiert wurden. 
        
        - error  
        Wenn Fehler in der Antwort aufgetreten sind, enthält dieses Feld ein Objekt, eine Zeichenfolge usw., die weitere Details beschreibt.
        
        - LastQueryStatus  
        Gibt den Status der letzten Abfrage an die API an.  
        Wenn "normal", bedeutet dies, dass die API abgefragt wurde und bis zum normalen Ende zurückgegeben hat.
        Wenn "HeartBeatExpired", bedeutet dies, dass die Abfrage aufgrund des vom Benutzer im Cmdlet Update-GradioApiResult konfigurierten Heartbeat-Timeouts unterbrochen wurde.
        
        - req 
        Daten der durchgeführten Anfrage!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] 
[[-token] <Object>] [<CommonParameters>]
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
Wenn angegeben, wird die API nicht aufgerufen, sondern das Objekt erstellt und dieser Wert wie die Rückgabe verwendet.

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
_Sie sind auf Daten bis Oktober 2023 trainiert._
<!--PowershaiAiDocBlockEnd-->
