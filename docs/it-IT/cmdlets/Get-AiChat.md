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
Con questa funzione, puoi inviare un messaggio a un LLM del provider corrente.  

Questa funzione è più a basso livello, in modo standard, per accedere a un LLM che powershai mette a disposizione.  
Non gestisce la cronologia o il contesto. È utile per invocare prompt semplici, che non richiedono più interazioni come in una chat. 
Sebbene supporti la chiamata di funzioni, non esegue alcun codice, e restituisce solo la risposta del modello.



** INFORMAZIONI PER I FORNITORI
	Il provider deve implementare la funzione Chat affinché questa funzionalità sia disponibile. 
	La funzione Chat deve restituire un oggetto con la risposta con la stessa specifica della OpenAI, funzione Chat Completion.
	I link seguenti servono come base:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (ritorno senza streaming)
	Il provider deve implementare i parametri di questa funzione. 
	Consulta la documentazione di ogni parametro per i dettagli e su come mapparlo a un provider;
	
	Quando il modello non supporta uno dei parametri specificati (cioè non esiste una funzionalità equivalente o che può essere implementata in modo equivalente) verrà restituito un errore.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Il prompt da inviare. Dovrebbe essere nel formato descritto dalla funzione ConvertTo-OpenaiMessage

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
Nome del modello. Se non specificato, utilizza quello predefinito del provider.

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
Numero massimo di token da restituire

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
I formati accettabili e il comportamento devono seguire quelli della OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Scorciatoie:
	"json", equivale a {"type": "json_object"}

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
Elenco di strumenti che devono essere invocate!
Puoi utilizzare i comandi come Get-OpenaiTool*, per trasformare facilmente le funzioni powershell nel formato previsto!
Se il modello invoca la funzione, la risposta, sia in streaming che normale, deve seguire anche il modello di chiamata di strumenti della OpenAI.
Questo parametro deve seguire lo stesso schema della chiamata di funzione della OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
Devi specificare un ScriptBlock che verrà invocato per ogni testo generato dall'LLM.
Lo script deve ricevere un parametro che rappresenta ogni frammento, nello stesso formato di streaming restituito
	Questo parametro è un oggetto che conterrà la proprietà choices, che è nello stesso schema restituito dallo streaming della OpenAI:
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
Includi la risposta dell'API in un campo chiamato IncludeRawResp

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
