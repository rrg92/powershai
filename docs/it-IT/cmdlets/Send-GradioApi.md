---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Invia dati a un'app Gradio e restituisce un oggetto che rappresenta l'evento!
Passa questo oggetto agli altri cmdlet per ottenere i risultati.

FUNZIONAMENTO DELL'API GRADIO 

	Basato su: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	Per comprendere meglio come utilizzare questo cmdlet, è importante comprendere come funziona l'API Gradio.  
	Quando invochiamo un endpoint dell'API, non restituisce i dati immediatamente.  
	Ciò è dovuto al semplice fatto che l'elaborazione è lunga, a causa della natura (IA e Machine Learning).  
	
	Quindi, invece di restituire il risultato, o attendere indefinitamente, Gradio restituisce un "Event Id".  
	Con questo evento, riusciamo periodicamente ad ottenere i risultati generati.  
	Gradio genererà messaggi di eventi con i dati che sono stati generati. Dobbiamo passare l'EventId generato per ottenere i nuovi frammenti generati.
	Questi eventi vengono inviati tramite Server Side Events (SSE), e possono essere uno di questi:
		- hearbeat 
		Ogni 15 secondi, Gradio invierà questo evento per mantenere la connessione attiva.  
		Ecco perché, quando si utilizza il cmdlet Update-GradioApiResult, potrebbe richiedere un po' di tempo per restituire.
		
		- complete 
		È l'ultimo messaggio inviato da Gradio quando i dati sono stati generati correttamente!
		
		- error 
		Inviato quando si è verificato un errore durante l'elaborazione.  
		
		- generating
		Viene generato quando l'API ha già dati disponibili, ma potrebbero essercene altri.
	
	Qui in PowershAI, li separiamo anche in 3 parti: 
		- Questo cmdlet (Send-GradioApi) esegue la richiesta iniziale a Gradio e restituisce un oggetto che rappresenta l'evento (chiamalo oggetto GradioApiEvent)
		- Questo oggetto risultante, di tipo GradioApiEvent, contiene tutto ciò che è necessario per consultare l'evento e conserva anche i dati e gli errori ottenuti.
		- Infine, abbiamo il cmdlet Update-GradioApiResult, in cui è necessario passare l'evento generato, e consulterà l'API Gradio e otterrà i nuovi dati.  
			Verifica l'help di questo cmdlet per ulteriori informazioni su come controllare questo meccanismo per ottenere i dati.
			
	
	Quindi, in un flusso normale, dovresti fare quanto segue: 
	
		# Invocare l'endpoint di Gradio!
		$MeuEvento = SEnd-GradioApi ... 
	
		# Ottieni i risultati finché non è terminato!
		# Verifica l'help di questo cmdlet per saperne di più!
		$MeuEvento | Update-GradioApiResult
		
Oggetto GradioApiEvent

	L'oggetto GradioApiEvent risultante da questo cmdlet contiene tutto ciò che è necessario affinché PowershAI controlli il meccanismo e ottenga i dati.  
	È importante conoscere la sua struttura per sapere come raccogliere i dati generati dall'API.
	Proprietà:
	
		- Status  
		Indica lo stato dell'evento. 
		Quando questo stato è "completo", significa che l'API ha già terminato l'elaborazione e tutti i dati possibili sono stati generati.  
		Fintanto che è diverso da questo, è necessario invocare Update-GradioApiResult affinché controlli lo stato e aggiorni le informazioni. 
		
		- QueryUrl  
		Valore interno che contiene l'endpoint esatto per la consulta dei risultati
		
		- data  
		Un array che contiene tutti i dati di risposta generati. Ogni volta che si invoca Update-GradioApiResult, se ci sono dati, li aggiungerà a questo array.  
		
		- events  
		Elenco degli eventi che sono stati generati dal server. 
		
		- error  
		Se si sono verificati errori nella risposta, questo campo conterrà un oggetto, una stringa, ecc., che descrive maggiori dettagli.
		
		- LastQueryStatus  
		Indica lo stato dell'ultima query all'API.  
		Se "normale", indica che l'API è stata consultata e ha restituito tutto correttamente.
		Se "HeartBeatExpired", indica che la query è stata interrotta a causa del timeout di heartbeat configurato dall'utente nel cmdlet Update-GradioApiResult
		
		- req 
		Dati della richiesta effettuata!

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
Se specificato, non chiama l'API, ma crea l'oggetto e usa questo valore come se fosse il ritorno

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
