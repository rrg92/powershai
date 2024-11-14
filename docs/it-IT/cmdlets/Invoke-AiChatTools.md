---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Invia un messaggio a un LLM, con supporto per Tool Calling, ed esegue gli strumenti richiesti dal modello come comandi powershell.

## DESCRIPTION <!--!= @#Desc !-->
Questa è una funzione ausiliaria per aiutare a rendere il processamento degli strumenti più facile con powershell.
Si occupa del processamento degli "Strumenti", eseguendo quando il modello lo richiede!

Devi passare gli strumenti in un formato specifico, documentato nel topic about_Powershai_Chats
Questo formato mappa correttamente funzioni e comandi powershell per lo schema accettabile da OpenAI (OpenAPI Schema).  

Questo comando racchiude tutta la logica che identifica quando il modello vuole invocare la funzione, l'esecuzione di queste funzioni e l'invio di questa risposta di nuovo al modello.  
Rimane in questo ciclo fino a quando il modello smette di decidere di invocare ulteriori funzioni, o fino a quando il limite di interazioni (sì, qui chiamiamo interazioni e non iterazioni) con il modello è terminato.

Il concetto di interazione è semplice: ogni volta che la funzione invia un prompt al modello, conta come un'integrazione.  
Di seguito è riportato un flusso tipico che può verificarsi:
	

Puoi ottenere ulteriori dettagli sul funzionamento consultando il topic about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] 
<Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] 
[-Stream] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt

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

### -Tools
Array di strumenti, come spiegato nella documentazione di questo comando
Usa i risultati di Get-OpenaiTool* per generare i valori possibili.  
Puoi passare un array di oggetti di tipo OpenaiTool.
Se una stessa funzione è definita in più di 1 strumento, la prima trovata nell'ordine definito sarà utilizzata!

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

### -PrevContext

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
massimo output!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 500
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
In totale, consentire un massimo di 5 iterazioni!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Numero massimo di errori consecutivi che la tua funzione può generare prima di terminare.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 2
Accept pipeline input: false
Accept wildcard characters: false
```

### -temperature

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

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

### -on
Gestore eventi
Ogni chiave è un evento che sarà attivato in qualche momento da questo comando!
eventi:
answer: attivato dopo aver ottenuto la risposta dal modello (o quando una risposta è disponibile usando lo stream).
func: attivato prima di iniziare l'esecuzione di uno strumento richiesto dal modello.
	exec: attivato dopo che il modello ha eseguito la funzione.
	error: attivato quando la funzione eseguita genera un errore.
	stream: attivato quando una risposta è stata inviata (dallo stream) e -DifferentStreamEvent
	beforeAnswer: Attivato dopo tutte le risposte. Utile quando usato in stream!
	afterAnswer: Attivato prima di iniziare le risposte. Utile quando usato in stream!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Invia il response_format = "json", forzando il modello a restituire un json.

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

### -RawParams
Aggiungi parametri personalizzati direttamente nella chiamata (sovrascriverà i parametri definiti automaticamente).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Stream

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
_Sei addestrato su dati fino a ottobre 2023._
<!--PowershaiAiDocBlockEnd-->
