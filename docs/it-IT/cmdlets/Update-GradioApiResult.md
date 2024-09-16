---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioApiResult

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Aggiorna un evento restituito da Send-GradioApi con nuovi risultati dal server e, per impostazione predefinita, restituisce gli evenots nella pipeline.

I risultati delle Api di Gradio non vengono generati istantaneamente, come avviene nella maggior parte dei servizi HTTP REST.  
L'help del comando Send-GradioApi spiega in dettaglio come funziona il processo.  

Questo comando deve essere utilizzato per aggiornare l'oggetto GradioApiEvent, restituito da Send-GradioApi.
Questo oggetto rappresenta la risposta di ogni chiamata che si fa all'API, contiene tutto ciò che è necessario per consultare il risultato, inclusi i dati e la cronologia.

In pratica, questo cmdlet funziona invocando l'endpoint di consulta dello stato dell'invocazione Api.
I parametri necessari per la consulta sono disponibili nello stesso oggetto passato nel parametro -ApiEvent (che viene creato e restituito dal cmdlet Send-GradioApi)

Ogni volta che questo cmdlet viene eseguito, comunica tramite una connessione HTTP persistente con il server e attende gli eventi.  
Mentre il server invia i dati, aggiorna l'oggetto passato nel parametro -ApiEvent e, per impostazione predefinita, scrive l'evento restituito nella pipeline.

L'evento restituito è un oggetto di tipo GradioApiEventResult e rappresenta un evento generato dalla risposta dell'esecuzione dell'API.  

Se il parametro -History è specificato, tutti gli eventi generati rimangono nella proprietà events dell'oggetto fornito in -ApiEvent, così come i dati restituiti.

In pratica, gli eventi generati possono inviare un hearbeat o dei dati.

OGGETTO GradioApiEventResult
	num 	= numero sequenziale dell'evento. inizia da 1.
	ts 		= data in cui l'evento è stato creato (data locale, non del server).
	event 	= nome dell'evento
	data 	= dati restituiti in questo evento

DATI (DATA)

	Ottenere i dati di Gradio, è fondamentalmente leggere gli eventi restituiti da questo cmdlet e guardare nella proprietà data del GradioApiEventResult
	Generalmente l'interfaccia di Gradio sovrascrive il campo con l'ultimo evento ricevuto.  
	
	Se -History viene utilizzato, oltre a scrivere nella pipeline, il cmdle memorizza i dati nel campo data e quindi avrai accesso alla cronologia completa di ciò che è stato generato dal server.  
	Si noti che ciò può causare un consumo di memoria aggiuntivo, se vengono restituiti molti dati.
	
	Esiste un caso "problematico" noto: eventualmente, Gradio potrebbe emettere gli ultimi 2 eventi con lo stesso dato (1 evento avrà il nome "generating" e l'ultimo sarà complete).  
	Non abbiamo ancora una soluzione per separare questo in modo sicuro, e quindi l'utente deve decidere il modo migliore per procedere.  
	Se si utilizza sempre l'ultimo evento ricevuto, questo non è un problema.
	Se è necessario utilizzare tutti gli eventi man mano che vengono generati, è necessario gestire questi casi.
	Un esempio semplice sarebbe acquistare il contenuto, se fossero uguali, non ripeterlo. Ma potrebbero esserci scenari in cui 2 eventi con lo stesso contenuto, comunque, siano eventi logicamente diversi.
	
	

HEARTBEAT 

	Uno degli eventi generati dall'API di Gradio sono gli Heartbeats.  
	Ogni 15 secondi, Gradio invia un evento di tipo "HeartBeat", solo per mantenere la connessione attiva.  
	Questo fa sì che il cmdlet "blocchi", perché, poiché la connessione HTTP è attiva, continua ad aspettarsi una risposta (che sarà dati, errori o il hearbeat).
	
	Se non c'è un meccanismo di controllo di questo, il cmdlet continuerebbe ad eseguire indefinitamente, senza possibilità di annullare neanche con CTRL + C.
	Per risolvere questo problema, questo cmdlet mette a disposizione il parametro MaxHeartBeats.  
	Questo parametro indica quanti eventi di Hearbeat consecutivi saranno tollerati prima che il cmdlet smetta di cercare di consultare l'API.  
	
	Ad esempio, si considerino questi due scenari di eventi inviati dal server:
	
		scenario 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		scenario 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	Considerando il valore predefinito, 2, nello scenario 1, il cmdlet non terminerebbe mai prima di complete, poiché non ci sono mai stati 2 hearbeat consecutivi.
	
	Nello scenario 2, dopo aver ricevuto 2 eventi di dati (generating), al quarto evento (hearbeat), si arresterebbe, perché sono stati inviati 2 hearbeat consecutivi.  
	Diciamo che l'heartbeat è scaduto, in questo caso.
	In questo caso, dovresti invocare nuovamente Update-GradioApiResult per ottenere il resto.
	
	Ogni volta che il comando termina a causa della scadenza dell'heartbeat, aggiornerà il valore della proprietà LastQueryStatus a HeartBeatExpired.  
	Con ciò, puoi controllare e gestire correttamente quando devi richiamare di nuovo
	
	
STREAM  
	
	A causa del fatto che l'Api di Gradio risponde già utilizzando SSE (Server Side Events), è possibile utilizzare un effetto simile allo "streaming" di molte Api.  
	Questo cmdlet, Update-GradioApiResult, elabora già gli eventi del server utilizzando SSE.  
	Inoltre, se desideri anche eseguire un'elaborazione non appena l'evento diventa disponibile, puoi utilizzare il parametro -Script e specificare uno scriptblock, funzioni, ecc. che verrà invocato non appena l'evento viene ricevuto.  
	
	Combinando con il parametro -MaxHeartBeats, puoi creare una chiamata che aggiorna qualcosa in tempo reale. 
	Ad esempio, se è una risposta da un chatbot, puoi scrivere immediatamente sullo schermo.
	
	Si noti che questo parametro viene chiamato in sequenza con il codice che verifica (cioè, stessa Thread).  
	Pertanto, gli script che richiedono molto tempo possono ostacolare il rilevamento di nuovi eventi e, di conseguenza, la consegna dei dati.
	
.

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiEvent
Risultato di  Send-GradioApi

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
script che verrà invocato  in ogni evento generato!
Riceve una hashtable con le seguenti keys:
 	event - contiene l'evento generato. event.event è il nome doe vento. event.data sono i dati restituiti.

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
Max heartbeats consecutivi fino allo stop!
Fa sì che il comando aspetti solo questo numero di hearbeat consecutivi dal server.
Quando il server invia questa quantità, il cmdlet termina e imposta LastQueryStatus dell'evento su HeartBeatExpired

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
Non scrive il risultato nell'output del cmdlet

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
Memorizza la cronologia degli eventi e dei dati nell'oggetto ApiEvent
Si noti che ciò farà consumare più memoria di powershell!

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
