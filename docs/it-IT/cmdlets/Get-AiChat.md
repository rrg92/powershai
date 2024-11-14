---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Invia messaggi a un LLM e restituisce la risposta

## DESCRIPTION <!--!= @#Desc !-->
Questa è la forma più basilare di Chat promossa da PowershAI.  
Con questa funzione, puoi inviare un messaggio a un LLM del provider attuale.  

Questa funzione è a basso livello, in modo standardizzato, per accedere a un LLM che PowershAI mette a disposizione.  
Non gestisce la cronologia o il contesto. È utile per invocare prompt semplici, che non richiedono più interazioni come in una Chat. 
Nonostante supporti il Functon Calling, non esegue alcun codice e restituisce solo la risposta del modello.



** INFORMAZIONI PER I PROVIDER
	Il provider deve implementare la funzione Chat affinché questa funzionalità sia disponibile. 
	La funzione chat deve restituire un oggetto con la risposta secondo la stessa specifica di OpenAI, funzione Chat Completion.
	I seguenti link servono come riferimento:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (risposta senza streaming)
	Il provider deve implementare i parametri di questa funzione. 
	Consulta la documentazione di ciascun parametro per dettagli e come mappare per un provider;
	
	Quando il modello non supporta uno dei parametri forniti (cioè, non esiste una funzionalità equivalente o che possa essere implementata in modo equivalente) deve essere restituito un errore.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] 
[[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Il prompt da inviare. Deve essere nel formato descritto dalla funzione ConvertTo-OpenaiMessage

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

### -temperature
Temperatura del modello

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Nome del modello. Se non specificato, utilizza il default del provider.

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
Massimo numero di token da restituire

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
Formato della risposta 
I formati accettabili e il comportamento devono seguire gli stessi di OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Scorciatoie:
	"json"|"json_object", equivale a {"type": "json_object"}
	l'oggetto deve specificare uno schema come se fosse passato direttamente all'API di OpenAI, nel campo response_format.json_schema

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

### -Functions
Elenco di strumenti che devono essere invocati!
Puoi usare comandi come Get-OpenaiTool*, per trasformare funzioni PowerShell facilmente nel formato atteso!
Se il modello invoca la funzione, la risposta, sia in streaming che normale, deve seguire anche il modello di tool calling di OpenAI.
Questo parametro deve seguire lo stesso schema del Function Calling di OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Specifica parametri diretti dell'API del provider.
Questo sovrascriverà i valori che sono stati calcolati e generati in base agli altri parametri.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback
Abilita il modello Stream 
Devi specificare un ScriptBlock che verrà invocato per ogni testo generato dal LLM.
Lo script deve ricevere un parametro che rappresenta ciascun pezzo, nello stesso formato di streaming restituito
	Questo parametro è un oggetto che conterrà la proprietà choices, che è lo stesso schema restituito dallo streaming di OpenAI:
		https://platform.openai.com/docs/api-reference/chat/streaming

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

### -IncludeRawResp
Includere la risposta dell'API in un campo chiamato IncludeRawResp

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
