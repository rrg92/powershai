---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Invia un messaggio a un LLM, con supporto a Tool Calling, ed esegue gli strumenti richiesti dal modello come comandi powershell.

## DESCRIPTION <!--!= @#Desc !-->
Questa è una funzione ausiliaria per aiutare a rendere più facile il processing degli strumenti con powershell.
Gestisce l'elaborazione degli "Strumenti", eseguendoli quando il modello lo richiede!

Dovresti passare gli strumenti in un formato specifico, documentato nel topic about_Powershai_Chats
Questo formato mappa correttamente funzioni e comandi powershell allo schema accettabile da OpenAI (OpenAPI Schema).  

Questo comando incapsula tutta la logica che identifica quando il modello vuole invocare la funzione, l'esecuzione di queste funzioni e l'invio di questa risposta al modello.  
Rimane in questo loop finché il modello non decide di invocare più funzioni o finché il limite di interazioni (sì, qui le chiamiamo interazioni, non iterazioni) con il modello non è terminato.

Il concetto di interazione è semplice: ogni volta che la funzione invia un prompt al modello, conta come un'integrazione.  
Di seguito è riportato un tipico flusso che può verificarsi:
	

Puoi ottenere maggiori dettagli sul funzionamento consultando il topic about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] 
[[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
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
Array di strumenti, come spiegato nella doc di questo comando
Usa i risultati di Get-OpenaiTool* per generare i valori possibili.  
Puoi passare un array di oggetti di tipo OpenaiTool.
Se una stessa funzione è definita in più di uno strumento, verrà utilizzata la prima trovata nell'ordine definito!

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
max output!

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
In totale, consentire al massimo 5 iterazioni!

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
Quantità massima di errori consecutivi che la tua funzione può generare prima che termini.

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
Ogni chiave è un evento che verrà attivato in un determinato momento da questo comando!
eventi:
answer: attivato dopo aver ottenuto la risposta dal modello (o quando una risposta diventa disponibile usando lo stream).
func: attivato prima di iniziare l'esecuzione di uno strumento richiesto dal modello.
	exec: attivato dopo che il modello ha eseguito la funzione.
	error: attivato quando la funzione eseguita genera un errore
	stream: attivato quando una risposta è stata inviata (tramite lo stream) e -DifferentStreamEvent
	beforeAnswer: Attivato dopo tutte le risposte. Utile quando usato in streaming!
	afterAnswer: Attivato prima di iniziare le risposte. Utile quando usato in streaming!

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
Aggiungi parametri personalizzati direttamente alla chiamata (sovrascriverà i parametri definiti automaticamente).

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
