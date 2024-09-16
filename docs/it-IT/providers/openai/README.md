# Provider OpenAI  

# SOMMARIO <!--! @#Short --> 

Questa è la documentazione ufficiale del provider OpenAI di PowershAI.

# DETTAGLI  <!--! @#Long --> 

Il provider OpenAI fornisce tutti i comandi per comunicare con i servizi di OpenAI.  
I cmdlet di questo provider hanno il formato Verbo-OpenaiNomi.  
Il provider implementa le chiamate HTTP come documentato su https://platform.openai.com/docs/api-reference

**Nota**: Non tutte le funzionalità dell'API sono ancora implementate


## Configurazione iniziale 

Usare il provider OpenAI consiste essenzialmente nell'abilitarlo e configurare il token.  
È necessario generare un token API sul sito Web di OpenAI. In altre parole, dovrai creare un account e inserire crediti.  
Controlla di più su https://platform.openai.com/api-keys 

Una volta che hai queste informazioni, puoi eseguire il seguente codice per abilitare il provider:

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

Se stai eseguendo in background (senza interattività), il token può essere configurato usando la variabile di ambiente `OPENAI_API_KEY`.  

Con il token configurato, puoi iniziare a utilizzare la chat di Powershai:

```
ia "Ciao, ti sto parlando da Powershai"
```

E, ovviamente, puoi invocare i comandi direttamente:

```
Get-OpenaiChat -prompt "s: Sei un bot che risponde alle domande su powershell","Come visualizzare l'ora corrente?"
```




* Usa Set-AiProvider openai (è il valore predefinito)
Opzionalmente puoi passare un URL alternativo

* Usa Set-OpenaiToken per configurare il token!


## Interni

OpenAI è un provider importante, perché oltre a fornire numerosi servizi avanzati e robusti di IA, funge anche da guida per la standardizzazione di PowershAI.  
La maggior parte degli standard definiti in PowershAI seguono le specifiche di OpenAI, che è il provider più ampiamente utilizzato ed è pratica comune usare OpenAI come base.  


E, a causa del fatto che altri provider tendono a seguire OpenAI, questo provider è anche preparato per il riutilizzo del codice.  
Creare un nuovo provider che utilizza le stesse specifiche di OpenAI è molto semplice, basta definire alcune variabili di configurazione!






<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
