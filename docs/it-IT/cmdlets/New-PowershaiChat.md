---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Crea un nuovo Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
PowershaAI introduce il concetto di "chat", simili alle chat che vedi su OpenAI, o le "thread" dell'API di Assistants.  
Ogni chat creata ha il suo insieme di parametri, contesto e cronologia.  
Quando usi il cmdlet Send-PowershaiChat (alias ia), stai inviando messaggi al modello, e la cronologia di questa conversazione con il modello rimane nella chat creata qui da PowershAI.  
In altre parole, tutta la cronologia della tua conversazione con il modello è mantenuta qui nella tua sessione di PowershAI, e non lì nel modello o nell'API.  
Con ciò PowershAI mantiene il completo controllo di cosa inviare all'LLM e non dipende da meccanismi di diverse API di diversi provider per gestire la cronologia. 


Ogni Chat ha un set di parametri che, una volta modificati, influenzano solo quella chat.  
Certi parametri di PowershAI sono globali, come ad esempio il provider utilizzato. Quando cambi il provider, la Chat inizia a utilizzare il nuovo provider, ma mantiene la stessa cronologia.  
Questo ti permette di conversare con diversi modelli, mantenendo la stessa cronologia.  

Oltre a questi parametri, ogni Chat ha una cronologia.  
La cronologia contiene tutte le conversazioni e le interazioni effettuate con i modelli, salvando le risposte restituite dalle API.

Una Chat ha anche un contesto, che non è altro che tutte le messaggi inviate.  
Ogni volta che un nuovo messaggio viene inviato in una chat, Powershai aggiunge questo messaggio al contesto.  
Al ricevimento della risposta del modello, questa risposta viene aggiunta al contesto.  
Nel messaggio successivo inviato, tutta questa cronologia di messaggi del contesto viene inviata, facendo sì che il modello, indipendentemente dal provider, abbia la memoria della conversazione.  

Il fatto che il contesto sia mantenuto qui nella tua sessione di Powershell consente funzionalità come salvare la tua cronologia su disco, implementare un provider esclusivo per salvare la tua cronologia sul cloud, mantenere solo sul tuo PC, ecc. Future funzionalità possono trarre beneficio da questo.

Tutti i comandi *-PowershaiChat ruotano attorno alla chat attiva o alla chat che specifichi esplicitamente nel parametro (generalmente con il nome -ChatId).  
La ChatAttiva è la chat in cui i messaggi verranno inviati, se non viene specificato ChatId  (o se il comando non consente di specificare una chat esplicita).  

Esiste una chat speciale chiamata "default" che è la chat creata ogni volta che usi Send-PowershaiChat senza specificare una chat e se non esiste una chat attiva definita.  

Se chiudi la tua sessione di Powershell, tutta questa cronologia di Chat viene persa.  
Puoi salvare su disco, usando il comando Export-PowershaiSettings. Il contenuto viene salvato crittografato da una password che specifichi.

Quando invii messaggi, PowershAI mantiene un meccanismo interno che pulisce il contesto della chat, per evitare di inviare più del necessario.
Le dimensioni del contesto locale (qui nella tua sessione di Powershai, e non dell'LLM), sono controllate da un parametro (usa Get-PowershaiChatParameter per vedere l'elenco dei parametri)

Nota che, a causa di questo modo di funzionare di Powershai, a seconda della quantità di informazioni inviate e restituite, più le configurazioni dei parametri, potresti far consumare molta memoria al tuo Powershell. Puoi pulire il contesto e la cronologia manualmente dalla tua chat usando Reset-PowershaiCurrentChat

Scopri di più sul argomento about_Powershai_Chats,

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id della chat. Se non specificato, verrà generato uno standard 
Alcuni modelli di id sono riservati per uso interno. Se li usi potresti causare instabilità in PowershAI.
I seguenti valori sono riservati:
 default 
 _pwshai_*

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

### -IfNotExists
Crea solo se non esiste una chat con lo stesso nome

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

### -Recreate
Forza la ricreazione della chat se è già stata creata!

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

### -Tools
Crea la chat e include questi strumenti!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
