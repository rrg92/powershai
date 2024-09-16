# PowershAI

# SOMMARIO <!--! @#Short --> 

PowershAI (Powershell + AI) è un modulo che aggiunge l'accesso all'IA tramite Powershell

# DETTAGLI  <!--! @#Long --> 

PowershAI è un modulo che aggiunge funzionalità AI alla tua sessione di Powershell.  
L'obiettivo è semplificare e incapsulare chiamate e trattamenti complessi per le API dei principali servizi AI esistenti.  

PowershAI definisce un set di standard che consentono all'utente di conversare con gli LLM, direttamente dal prompt, o di utilizzare il risultato dei comandi come contesto in un prompt.  
E, attraverso un set standardizzato di funzioni, è possibile utilizzare diversi provider: Ad esempio, puoi conversare con GPT-4o o Gemini Flash usando esattamente lo stesso codice.  

Oltre a questa standardizzazione, PowershAI espone anche le funzioni interne e specifiche per la connessione con i diversi provider di servizi AI.  
Con questo, puoi personalizzare e creare script che utilizzano funzionalità specifiche di queste API.  

L'architettura di PowershAI definisce il concetto di "provider" che sono file che implementano tutti i dettagli necessari per conversare con le rispettive API.  
Nuovi provider possono essere aggiunti, con nuove funzionalità, man mano che diventano disponibili.  

Alla fine, hai diverse opzioni per iniziare a usare l'IA nei tuoi script. 

Esempi di provider famosi che sono già implementati completa o parzialmente:

- OpenAI 
- Hugging Face 
- Gemini 
- Ollama
- Maritalk (LLM brasiliano)

Per iniziare a usare PowershAI è molto semplice: 

```powershell 
# Installa il modulo!
Install-Module -Scope CurrentUser powershai 

# Importa!
import-module powershai

# Lista di provider 
Get-AiProviders

# Devi consultare la documentazione di ogni provider per i dettagli su come usarlo!
# La documentazione è accessibile usando get-help 
Get-Help about_NomeProvider

# Esempio:
Get-Help about_huggingface
```

## Ottenere Aiuto  

Nonostante lo sforzo per documentare al massimo PowershAI, molto probabilmente non riusciremo in tempo a creare tutta la documentazione necessaria per chiarire i dubbi, o persino parlare di tutti i comandi disponibili.  Pertanto, è importante che tu sappia come fare le basi da solo. 

Puoi elencare tutti i comandi disponibili quando il comando `Get-Command -mo powershai`.  
Questo comando restituirà tutti i cmdlet, alias e funzioni esportate dal modulo powerhsai.  
È il punto di partenza più semplice per scoprire quali comandi. Molti comandi sono autoesplicativi, guardando solo il nome.  

E, per ogni comando, puoi ottenere maggiori dettagli usando `Get-Help -Full NomeComando`.
Se il comando non ha ancora una documentazione completa, o hai qualche dubbio che ti manca, puoi aprire una issue sul git chiedendo ulteriori integrazioni.  

Infine, puoi esplorare il codice sorgente di PowershAI, cercando commenti lasciati lungo il codice, che possono spiegare qualche funzionalità o architettura, in modo più tecnico.  

Aggiorneremo la documentazione man mano che vengono rilasciate nuove versioni.
Ti invitiamo a contribuire a PowershAI, inviando Pull Request o issue con miglioramenti alla documentazione se trovi qualcosa che potrebbe essere spiegato meglio, o che non è stato ancora spiegato.  


## Struttura dei comandi  

PowershAI esporta diversi comandi che possono essere utilizzati.  
La maggior parte di questi comandi ha "Ai" o "Powershai". 
Chiamiamo questi comandi `comandi globali` di Powershai, perché non sono comandi per un provider specifico.

Ad esempio: `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
I provider esportano anche comandi, che generalmente avranno un nome del provider. Consulta la documentazione del provider per saperne di più sullo standard dei comandi esportati.  

Per convenzione, nessun provider dovrebbe implementare comandi con "Ai" o "Powershai" nel nome, poiché sono riservati ai comandi globali, indipendentemente dal provider.  
Inoltre, gli alias definiti dai provider devono sempre contenere più di 5 caratteri. Gli alias più piccoli sono riservati ai comandi globali.

Puoi trovare la documentazione di questi comandi nella [doc dei comandi globali](cmdlets/).  
Puoi utilizzare il comando Get-PowershaiGlobalCommands per ottenere l'elenco!

## Documentazione dei Provider  

La [documentazione dei provider](providers) è il luogo ufficiale per ottenere aiuto sul funzionamento di ogni provider.  
Questa documentazione è anche accessibile tramite il comando `Get-Help` di powershell.  

La documentazione dei provider è sempre disponibile tramite l'help `about_Powershai_NomeProvider_Topico`.  
L'argomento `about_Powershai_NomeProvider` è il punto di partenza e dovrebbe sempre contenere le informazioni iniziali per i primi usi, nonché le spiegazioni per il corretto utilizzo degli altri argomenti.  


## Chat  

Le Chat sono il punto di partenza principale e consentono di conversare con i vari LLM resi disponibili dai provider.  
Vedi il documento [chat](CHATS.about.md) per maggiori dettagli. Di seguito, una rapida introduzione ai chat.

### Conversare con il modello

Una volta che la configurazione iniziale del provider è stata completata, puoi iniziare la conversazione!  
Il modo più semplice per iniziare la conversazione è usare il comando `Send-PowershaiChat` o l'alias `ia`:

```powershell
ia "Ciao, conosci PowerShell?"
```

Questo comando invierà il messaggio al modello del provider che è stato configurato e la risposta verrà visualizzata in seguito.  
Nota che il tempo di risposta dipende dalla capacità del modello e dalla rete.  

Puoi usare il pipeline per inserire il risultato di altri comandi direttamente come contesto dell'ia:

```powershell
1..100 | Get-Random -count 10 | ia "Dimmi curiosità su questi numeri"
```  
Il comando precedente genererà una sequenza da 1 a 100 e inserirà ogni numero nel pipeline di PowerShell.  
Quindi, il comando Get-Random filtrerà solo 10 di questi numeri, in modo casuale.  
E infine, questa sequenza verrà inserita (tutta in una volta) nell'ia e verrà inviata con il messaggio che hai inserito nel parametro.  

Puoi usare il parametro `-ForEach` in modo che l'ia elabori ogni input alla volta, ad esempio:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Dimmi curiosità su questi numeri"
```  

La differenza di questo comando sopra è che l'IA verrà chiamata 10 volte, una per ogni numero.  
Nell'esempio precedente, verrà chiamato solo 1x, con tutti i 10 numeri.  
Il vantaggio di utilizzare questo metodo è ridurre il contesto, ma potrebbe richiedere più tempo, poiché vengono effettuate più richieste.  
Test in base alle tue esigenze!

### Modalità oggetto  

Per impostazione predefinita, il comando `ia` non restituisce nulla. Ma puoi modificare questo comportamento utilizzando il parametro `-Object`.  
Quando questo parametro è attivato, chiede all'LLM di generare il risultato in JSON e scrive la restituzione di nuovo nel pipeline.  
Questo significa che puoi fare qualcosa del genere:

```powershell
ia -Obj "5 numeri casuali, con il loro valore scritto per esteso"

#o usando l'alias, io/powershellgallery/dt/powershai

io "5 numeri casuali, con il loro valore scritto per esteso"
```  

**IMPORTANTE: Nota che non tutti i provider possono supportare questa modalità, poiché il modello deve essere in grado di supportare JSON! Se ricevi errori, conferma se lo stesso comando funziona con un modello di OpenAI. Puoi anche aprire un'issue**


## Salvataggio delle configurazioni  

PowershAI consente di regolare una serie di configurazioni, come i parametri delle chat, i token di autenticazione, ecc.  
Ogni volta che modifichi una configurazione, questa configurazione viene salvata solo nella memoria della tua sessione di Powershell.  
Se chiudi e apri di nuovo, tutte le configurazioni apportate andranno perse.  

Per non dover generare token ogni volta, ad esempio, Powershai fornisce 2 comandi per esportare e importare le configurazioni.  
Il comando `Export-PowershaiSettings` esporta le configurazioni in un file nella directory del profilo dell'utente connesso.  
A causa del fatto che i dati esportati possono essere sensibili, devi fornire una password, che verrà utilizzata per generare una chiave di crittografia.  
I dati esportati sono crittografati utilizzando AES-256.  
Puoi importare usando `Import-PowershaiSettings`. Dovrai fornire la password che hai utilizzato per esportare.  

Nota che questa password non viene archiviata in nessun luogo, quindi sei responsabile di memorizzarla o di salvarla in un caveau a tua scelta.

## Costi  

È importante ricordare che alcuni provider potrebbero addebitare i servizi utilizzati.  
PowershAI non gestisce alcun costo.  Può inserire dati in prompt, parametri, ecc.  
Dovresti effettuare il monitoraggio utilizzando gli strumenti forniti dal sito Web del provider per tale scopo.  

Le versioni future potrebbero includere comandi o parametri che aiutano a controllare meglio, ma, per ora, l'utente deve monitorare.  



### Esportazione e importazione di configurazioni e token

Per facilitare il riutilizzo dei dati (token, modelli predefiniti, cronologia delle chat, ecc.) PowershAI consente di esportare la sessione.  
Per fare ciò, usa il comando `Export-PowershaiSettings`. Dovrai fornire una password, che verrà utilizzata per creare una chiave e crittografare questo file.  
Solo con questa password puoi importarlo di nuovo. Per importare, usa il comando `Import-PowershaiSettings`.  
Per impostazione predefinita, le Chat non vengono esportate. Per esportarle, puoi aggiungere il parametro -Chats: `Export-PowershaiSettings -Chats`.  
Nota che questo potrebbe aumentare le dimensioni del file, oltre ad aumentare il tempo di esportazione/importazione.  Il vantaggio è che puoi continuare la conversazione tra diverse sessioni.  
Questa funzionalità è stata creata originariamente con l'intento di evitare di dover generare Api Key ogni volta che era necessario utilizzare PowershAI. Con essa, generi 1 volta le tue Api Key in ogni provider ed esporta man mano che aggiorni. Poiché è protetto da password, puoi salvarlo tranquillamente in un file sul tuo computer.  
Utilizza l'aiuto nel comando per ottenere maggiori informazioni su come usarlo.


# ESEMPI <!--! @#Ex -->

## Utilizzo di base 

Usare PowershAI è molto semplice. L'esempio seguente mostra come puoi usarlo con OpenAI:

```powershell 
# Modifica il provider corrente in OpenAI
Set-AiProvider openai 

# Configura il token di autenticazione (Devi generare il token sul sito platform.openai.com)
Set-OpenaiToken 

# Usa uno dei comandi per avviare una chat!  ia è un alias per Send-PowershaiChat, che invia un messaggio nella chat predefinita!
ia "Ciao, ti sto parlando da Powershaui!"
```

## Esportazione delle configurazioni 


```powershell 
# definisci un token, ad esempio 
Set-OpenaiToken 

# Dopo aver eseguito il comando precedente, basta esportare!
Export-PowershaiSettings

# Dovrai fornire la password!
```

## Importazione delle configurazioni 


```powershell 
import-module powershai 

# Importa le configurazioni 
Import-PowershaiSettings # Il comando chiederà la password utilizzata durante l'esportazione
```

# Informazioni importanti <!--! @#Note -->

PowershAI ha una vasta gamma di comandi disponibili.  
Ogni provider fornisce una serie di comandi con uno standard di denominazione.  
Dovresti sempre leggere la documentazione del provider per ottenere maggiori dettagli su come usarlo.  

# Risoluzione dei problemi <!--! @#Troub -->

Sebbene abbia un sacco di codice e abbia già molte funzionalità, PowershAI è un progetto nuovo, che è in fase di sviluppo.  
Potrebbero essere riscontrati alcuni bug e, in questa fase, è importante che tu aiuti sempre segnalando, tramite issue, nel repository ufficiale su https://github.com/rrg92/powershai  

Se vuoi eseguire il debug di un problema, ti consiglio di seguire questi passaggi:

- Utilizza il Debug per aiutarti. I comandi come Set-PSBreakpoint sono semplici da invocare sulla riga di comando e possono aiutarti a risparmiare tempo
- Alcune funzioni non visualizzano l'errore completo. Puoi usare la variabile $error e accedere all'ultima. Ad esempio:  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # Questo aiuta a trovare la riga esatta in cui si è verificata l'eccezione!
```

# Vedi anche <!--! @#Also -->

- Video su come usare il Provider di Hugging Face: https://www.youtube.com/watch?v=DOWb8MTS5iU
- Consulta la documentazione di ogni provider per maggiori dettagli su come utilizzare i suoi cmdlet

# Tag <!--! @#Kw -->

- Intelligenza Artificiale
- IA





<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
