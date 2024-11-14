---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Invia dati a un Gradio e restituisce un oggetto che rappresenta l'evento! 
Passa questo oggetto agli altri cmdlet per ottenere i risultati.

FUNZIONAMENTO DELL'API DI GRADIO 

    Basato su: https://www.gradio.app/guides/querying-gradio-apps-with-curl
    
    Per capire meglio come utilizzare questo cmdlet, è importante comprendere come funziona l'API di Gradio.  
    Quando invochiamo un endpoint dell'API, non restituisce immediatamente i dati.  
    Questo è dovuto al semplice fatto che l'elaborazione è estesa, a causa della natura (IA e Machine Learning).  
    
    Quindi, invece di restituire il risultato o attendere indefinitamente, Gradio restituisce un "Event Id".  
    Con questo evento, possiamo ottenere periodicamente i risultati generati.  
    Gradio genererà messaggi di eventi con i dati che sono stati generati. Dobbiamo passare l'EventId generato per ottenere i nuovi pezzi generati. 
    Questi eventi vengono inviati tramite Server Side Events (SSE), e possono essere uno di questi:
        - hearbeat 
        Ogni 15 secondi, Gradio invierà questo evento per mantenere attiva la connessione.  
        Ecco perché, quando utilizzi il cmdlet Update-GradioApiResult, potrebbe richiedere un po' di tempo per restituire.
        
        - complete 
        È l'ultimo messaggio inviato da Gradio quando i dati sono stati generati con successo!
        
        - error 
        Inviato quando si è verificato un errore nell'elaborazione.  
        
        - generating
        Viene generato quando l'API ha già dati disponibili, ma potrebbe arrivarne di più.
    
    Qui in PowershAI, abbiamo anche suddiviso questo in 3 parti: 
        - Questo cmdlet (Send-GradioApi) effettua la richiesta iniziale a Gradio e restituisce un oggetto che rappresenta l'evento (lo chiamiamo un oggetto GradioApiEvent)
        - Questo oggetto risultante, di tipo GradioApiEvent, contiene tutto ciò che è necessario per interrogare l'evento e conserva anche i dati e gli errori ottenuti.
        - Infine, abbiamo il cmdlet Update-GradioApiResult, dove devi passare l'evento generato, e lui interrogherà l'API di Gradio e otterrà i nuovi dati.  
            Controlla l'aiuto di questo cmdlet per ulteriori informazioni su come controllare questo meccanismo di ottenere i dati.
            
    
    Quindi, in un flusso normale, dovresti fare quanto segue: 
    
        # Invochi l'endpoint di Gradio!
        $MioEvento = Send-GradioApi ... 
    
        # Ottieni risultati finché non è terminato!
        # Controlla l'aiuto di questo cmdlet per imparare di più!
        $MioEvento | Update-GradioApiResult
        
Oggetto GradioApiEvent

    L'oggetto GradioApiEvent risultante da questo cmdlet contiene tutto ciò che è necessario affinché PowershAI controlli il meccanismo e ottenga i dati.  
    È importante che tu conosca la sua struttura per sapere come raccogliere i dati generati dall'API.
    Proprietà:
    
        - Status  
        Indica lo stato dell'evento. 
        Quando questo stato è "complete", significa che l'API ha già terminato l'elaborazione e tutti i dati possibili sono stati generati.  
        Finché è diverso da questo, devi invocare Update-GradioApiResult affinché verifichi lo stato e aggiorni le informazioni. 
        
        - QueryUrl  
        Valore interno che contiene l'endpoint esatto per la consultazione dei risultati
        
        - data  
        Un array contenente tutti i dati di risposta generati. Ogni volta che invochi Update-GradioApiResult, se ci sono dati, li aggiungerà a questo array.  
        
        - events  
        Elenco di eventi che sono stati generati dal server. 
        
        - error  
        Se ci sono stati errori nella risposta, questo campo conterrà un oggetto, stringa, ecc., che descrive ulteriori dettagli.
        
        - LastQueryStatus  
        Indica lo stato dell'ultima consultazione all'API.  
        Se "normal", indica che l'API è stata interrogata e ha restituito fino alla fine normalmente.
        Se "HeartBeatExpired", indica che la consultazione è stata interrotta a causa del timeout di heartbeat configurato dall'utente nel cmdlet Update-GradioApiResult
        
        - req 
        Dati della richiesta effettuata!

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
Se fornito, non chiama l'API, ma crea l'oggetto e utilizza questo valore come se fosse il ritorno

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
_Sei addestrato su dati fino a ottobre 2023._
<!--PowershaiAiDocBlockEnd-->
