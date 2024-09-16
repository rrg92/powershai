---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Crea un nuovo oggetto che rappresenta i parametri di un PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
Crea un oggetto standard contenente tutti i possibili parametri che possono essere utilizzati nella chat!
L'utente può usare un get-help New-PowershaiParameters per ottenere la documentazione dei parametri.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] 
<Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Quando true, usa la modalità stream, cioè i messaggi vengono mostrati non appena il modello li produce

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Abilita la modalità JSON. In questa modalità, il modello è forzato a restituire una risposta con JSON.  
Quando attivato, i messaggi generati via stream non vengono mostrati non appena vengono prodotti, e solo il risultato finale viene restituito.

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Nome del modello da usare  
Se null, usa il modello definito con Set-AiDefaultModel

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
Massimo di token da restituire dal modello

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 2048
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowFullSend
Stampa il prompt intero che sta per essere inviato all'LLM

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowTokenStats
Al termine di ogni messaggio, mostra le statistiche di consumo, in token, restituite dall'API

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
Massimo di interazioni da eseguire in una sola volta 
Ogni volta che un messaggio viene inviato, il modello esegue 1 iterazione (invia il messaggio e riceve una risposta).  
Se il modello richiede una function calling, la risposta generata viene nuovamente inviata al modello. Questo conta come un'altra interazione.  
Questo parametro controlla il massimo di interazioni che possono esistere in ogni chiamata.
Ciò aiuta a prevenire loop infiniti inaspettati.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 50
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Massimo di errori in sequenza generato da Tool Calling.  
Quando si utilizza il tool calling, questo parametro limita il numero di tool senza sequenza che hanno restituito un errore che possono essere chiamati.  
L'errore considerato è l'eccezione generata dallo script o dal comando configurato.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 5
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxContextSize
Dimensione massima del contesto, in caratteri 
In futuro, sarà in token 
Controlla la quantità di messaggi nel contesto attuale della chat. Quando questo numero viene superato, il Powershai cancella automaticamente i messaggi più vecchi.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: 8192
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterFunc
Funzione usata per la formattazione degli oggetti passati tramite pipeline

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: ConvertTo-PowershaiContextOutString
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterParams
Argomenti da passare a ContextFormatterFunc

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowArgs
Se true, mostra gli argomenti delle funzioni quando il Tool Calling è attivato per eseguire una funzione

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolsResults
Mostra i risultati delle tool quando vengono eseguite dal PowershAI in risposta al tool calling del modello

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 13
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -SystemMessageFixed
System Message che è garantito essere inviato sempre, indipendentemente dalla cronologia e dalla pulizia della chat!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 14
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Parametri da passare direttamente all'API che invoca il modello.  
Il provider deve implementare il supporto a questo.  
Per utilizzarlo devi conoscere i dettagli di implementazione del provider e come funziona la sua API!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormat
Controlla il template utilizzato quando si iniettano i dati di contesto!
Questo parametro è uno scriptblock che deve restituire una stringa con il contesto da iniettare nel prompt!
I parametri dello scriptblock sono:
	FormattedObject 	- L'oggetto che rappresenta la chat attiva, già formattato con il Formatter configurato
	CmdParams 			- I parametri passati a Send-PowershaAIChat. È lo stesso oggetto restituito da GetMyParams
	Chat 				- La chat in cui i dati vengono inviati.
Se nullo, genererà un default. Controlla il cmdlet Send-PowershaiChat per i dettagli

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 16
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
