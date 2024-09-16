---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Crea una nuova chiamata per un endpoint nella sessione corrente.

## DESCRIPTION <!--!= @#Desc !-->
Effettua una chiamata utilizzando l'API di Gradio, su un endpoint specifico e passando i parametri desiderati.  
Questa chiamata genererà un GradioApiEvent (vedi Send-GradioApi), che verrà salvato internamente nelle impostazioni della sessione.  
Questo oggetto contiene tutto ciò che è necessario per ottenere il risultato dell'API.  

Il cmdlet restituirà un oggetto di tipo SessionApiEvent contenente le seguenti proprietà:
	id - Id interno dell'evento generato.
	event - L'evento interno generato. Può essere utilizzato direttamente con i cmdlet che gestiscono gli eventi.
	
Le sessioni hanno un limite di chiamate definite.
Lo scopo è impedire di creare chiamate indefinite in modo da perdere il controllo.

Ci sono due opzioni della sessione che influenzano la chiamata (possono essere modificate con Set-GradioSession):
	- MaxCalls 
	Controlla il numero massimo di chiamate che possono essere create.
	
	- MaxCallsPolicy 
	Controlla cosa fare quando viene raggiunto il Max.
	Valori possibili:
		- Error 	= si traduce in errore!
		- Remove 	= rimuove il più vecchio 
		- Warning 	= Visualizza un avviso, ma consente di superare il limite.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Nome dell'endpoint (senza la barra iniziale)

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

### -Params
Elenco di parametri 
Se è un array, passa direttamente all'Api di Gradio 
Se è una hashtable, monta l'array in base alla posizione dei parametri restituiti da /info

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

### -EventId
SE specificato, crea con un id evento già esistente (potrebbe essere stato generato al di fuori del modulo).

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

### -session
Sessione

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
Forza l'utilizzo di un nuovo token. Se "pubblico", allora non usa alcun token!

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




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
