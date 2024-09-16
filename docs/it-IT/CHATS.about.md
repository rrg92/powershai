# Chat


# Introduzione <!--! @#Short --> 

PowershAi definisce il concetto di Chat, che aiutano a creare cronologia e contesto delle conversazioni!  

# Dettagli  <!--! @#Long --> 

PowershAi crea il concetto di Chat, che sono molto simili al concetto di Chat nella maggior parte dei servizi di LLM.  

I chat ti permettono di conversare con i servizi di LLM in un modo standard, indipendentemente dal provider attuale.  
Forniscono un modo standard per queste funzionalità:

- Cronologia dei chat 
- Contesto 
- Pipeline (utilizzare il risultato di altri comandi)
- Tool calling (eseguire comandi su richiesta di LLM)

Non tutti i provider implementano il supporto per i chat.  
Per sapere se un provider supporta i chat, utilizzare il cmdlet Get-AiProviders, e controllare la proprietà "Chat". Se è $true, allora i chat sono supportati.  
E, una volta che i chat sono supportati, non tutte le funzionalità potrebbero essere supportate, a causa di limitazioni del provider.  

## Avviare una nuova chat 

Il modo più semplice per iniziare una nuova chat è utilizzare il comando Send-PowershaiChat.  
Ovviamente, devi utilizzarlo dopo aver configurato il provider (usando `Set-AiProvider`) e le impostazioni iniziali, come l'autenticazione, se necessario.  

```powershell 
Send-PowershaiChat "Ciao, sto conversando con te da Powershai"
```

Per semplicità, il comando `Send-PowershaiChat` ha un alias chiamato `ia` (abbreviazione di Intelligenza Artificiale).  
Con esso, riduci notevolmente e ti concentri di più sul prompt:

```powershell 
ia "Ciao, sto conversando con te da Powershai"
```

Ogni messaggio viene inviato in una chat.  Se non crei una chat esplicitamente, verrà utilizzata la chat speciale chiamata `default`.  
Puoi creare una nuova chat usando `New-PowershaiChat`.  

Ogni chat ha la sua cronologia di conversazioni e le proprie impostazioni. Può contenere le proprie funzioni, ecc.
Creare chat aggiuntivi può essere utile se è necessario gestire più argomenti senza che si mescolino!


## Comandi di Chat  

I comandi che gestiscono i chat in qualche modo sono nel formato `*-Powershai*Chat*`.  
Generalmente, questi comandi accettano un parametro -ChatId, che consente di specificare il nome o l'oggetto della chat creato con `New-PowershaiChat`.  
Se non viene specificato, utilizzano la chat attiva.  

## Chat Attivo  

Il Chat attivo è la chat default usata dai comandi PowershaiChat.  
Quando esiste solo 1 chat creato, viene considerato come chat attivo.  
Se hai più di 1 chat attivo, puoi utilizzare il comando `Set-PowershaiActiveChat` per definire quale è. Puoi passare il nome o l'oggetto restituito da `New-PowershaiChat`.


## Parametri della chat  

Ogni chat ha alcuni parametri che controllano diversi aspetti.  
Ad esempio, il numero massimo di token da restituire da LLM.  

Possono essere aggiunti nuovi parametri a ogni versione di PowershAI.  
Il modo più semplice per ottenere i parametri e cosa fanno è usare il comando `Get-PowershaiChatParameter`;  
Questo comando mostrerà l'elenco dei parametri che possono essere configurati, insieme al valore corrente e una descrizione di come utilizzarlo.  
Puoi modificare i parametri usando il comando `Set-PowershaiChatParameter`.  

Alcuni parametri elencati sono i parametri diretti dell'API del provider. Verranno con una descrizione che indica questo.  

## Contesto e Cronologia  

Ogni Chat ha un contesto e una cronologia.  
La cronologia è tutta la cronologia dei messaggi inviati e ricevuti nella conversazione.
La dimensione del contesto è la quantità di cronologia che verrà inviata all'LLM, in modo che si ricordi delle risposte.  

Tieni presente che questa dimensione del contesto è un concetto di PowershAI e non è la stessa "Lunghezza del contesto" che sono definiti negli LLM.  
La dimensione del contesto influenza solo Powershai e, a seconda del valore, potrebbe superare la lunghezza del contesto del provider, il che potrebbe causare errori.  
È importante mantenere la dimensione del contesto bilanciata tra mantenere l'LLM aggiornato con ciò che è stato già detto e non superare il numero massimo di token dell'LLM.  

Puoi controllare la dimensione del contesto tramite il parametro della chat, ovvero usando `Set-PowershaiChatParameter`.

nota che la cronologia e il contesto sono memorizzati nella memoria della sessione, ovvero se chiudi la sessione di Powershell, andranno persi.  
In futuro, potremmo avere meccanismi che consentano all'utente di salvare automaticamente e recuperare tra le sessioni.  

Inoltre, è importante ricordare che, poiché la cronologia è salvata nella memoria di Powershell, le conversazioni molto lunghe possono causare il superamento o un elevato consumo di memoria di Powershell.  
Puoi ripristinare i chat in qualsiasi momento usando il comando `Reset-PowershaiCurrentChat`, che cancellerà tutta la cronologia del chat attivo.  
Usa con cautela, poiché ciò farà perdere tutta la cronologia e l'LLM non si ricorderà delle peculiarità fornite durante la conversazione.  


## Pipeline  

Una delle funzionalità più potenti dei Chat di Powershai è l'integrazione con la pipeline di Powershell.  
In sostanza, puoi inserire il risultato di qualsiasi comando powershell e verrà utilizzato come contesto.  

PowershAI fa ciò convertendo gli oggetti in testo e inviandoli nel prompt.  
Quindi, il messaggio della chat viene aggiunto in seguito.  

Ad esempio:

```
Get-Service | ia "Fai un riassunto su quali servizi non sono comuni in Windows"
```

Nelle impostazioni predefinite di Powershai, il comando `ia`  (alias per `Send-PowershaiChat`), otterrà tutti gli oggetti restituiti da `Get-Service` e li formatterà come un'unica stringa gigante.  
Quindi, questa stringa verrà iniettata nel prompt dell'LLM e gli verrà detto di usare questo risultato come "contesto" per il prompt dell'utente.  

Il prompt dell'utente viene concatenato subito dopo.  

Con ciò, si crea un potente effetto: puoi facilmente integrare gli output dei comandi con i tuoi prompt, usando un semplice pipe, che è un'operazione comune in Powershell.  
L'LLM tende a considerarlo bene.  

Sebbene abbia un valore predefinito, hai il pieno controllo su come questi oggetti vengono inviati.  
Il primo modo per controllare è come l'oggetto viene convertito in testo.  Poiché il prompt è una stringa, è necessario convertire questo oggetto in testo.  
Per impostazione predefinita, converte in una rappresentazione standard di Powershell, in base al tipo (usando il comando `Out-String`).  
Puoi cambiare questo usando il comando `Set-PowershaiChatContextFormatter`. Puoi definire, ad esempio, JSON, tabella e persino uno script personalizzato per avere il pieno controllo.  

L'altro modo per controllare come viene inviato il contesto è usare il parametro della chat `ContextFormat`.  
Questo parametro controlla l'intero messaggio che verrà iniettato nel prompt. È uno scriptblock.  
Devi restituire un array di stringhe, che equivale al prompt inviato.  
Questo script ha accesso a parametri come l'oggetto formattato che viene passato nella pipeline, i valori dei parametri del comando Send-PowershaiChat, ecc.  
Il valore predefinito dello script è hard-coded e devi controllare direttamente nel codice per sapere come invia (e per un esempio di come implementare il tuo).  


###  Tools

Una delle grandi funzionalità implementate è il supporto a Function Calling (o Tool Calling).  
Questa funzionalità, disponibile in diversi LLM, consente all'IA di decidere di invocare funzioni per portare dati aggiuntivi nella risposta.  
In sostanza, descrivi una o più funzioni e i loro parametri, e il modello può decidere di invocarle.  

**IMPORTANTE: sarai in grado di utilizzare questa funzionalità solo su provider che espongono function calling utilizzando la stessa specifica di OpenAI**

Per maggiori dettagli, consulta la documentazione ufficiale di OpenAI su Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling).

Il modello decide solo quali funzioni invocare, quando invocarle e i loro parametri. L'esecuzione di questa invocazione viene eseguita dal client, nel nostro caso, PowershAI.  
I modelli si aspettano la definizione delle funzioni descrivendo cosa fanno, i loro parametri, i ritorni, ecc.  Originariamente questo viene fatto usando qualcosa come OpenAPI Spec per descrivere le funzioni.  
Tuttavia, Powershell ha un potente sistema di Help usando i commenti, che consente di descrivere le funzioni e i loro parametri, oltre ai tipi dati.  

PowershAI si integra con questo sistema di help, traducendolo in una specifica OpenAPI. L'utente può scrivere le sue funzioni normalmente, usando i commenti per documentarle e questo viene inviato al modello.  

Per dimostrare questa funzionalità, ecco un semplice tutorial: crea un file chiamato `MinhasFuncoes.ps1` con il seguente contenuto

```powershell
# File MinhasFuncoes.ps1, salvalo in una directory a tua scelta!

<#
    .DESCRIPTION
    Elenca l'ora corrente
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    Ottiene un numero casuale!
#>
function NumeroAleatorio {
    param(
        # Numero minimo
        $Min = $null,
        
        # Numero massimo
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**Nota l'utilizzo dei commenti per descrivere le funzioni e i parametri**.  
Questa è una sintassi supportata da PowerShell, nota come [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Ora, aggiungiamo questo file a PowershAI:

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #configura il token se non l'hai ancora configurato.


# Aggiungi lo script come tools!
# Supponendo che lo script sia stato salvato in C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Conferma che gli strumenti sono stati aggiunti 
Get-AiTool
```

Prova a chiedere al modello qual è la data corrente o chiedigli di generare un numero casuale! Vedrai che eseguirà le tue funzioni! Questo apre infinite possibilità, e la tua creatività è il limite!

```powershell
ia "Quante ore?"
```

Nel comando precedente, il modello invocherà la funzione. sullo schermo vedrai la funzione chiamata!  
Puoi aggiungere qualsiasi comando o script powershell come strumento.  
Utilizza il comando `Get-Help -Full Add-AiTol` per maggiori dettagli su come utilizzare questa potente funzionalità.

PowershAI si occupa automaticamente di eseguire i comandi e di inviare la risposta al modello.  
Se il modello decide di eseguire diverse funzioni in parallelo o insiste nell'eseguire nuove funzioni, PowershAI gestirà automaticamente tutto ciò.  
Nota che, per evitare un loop infinito di esecuzioni, PowershAI forza un limite con il numero massimo di esecuzioni.  
Il parametro che controlla queste interazioni con il modello è `MaxInteractions`.  


### Invoke-AiChatTools e Get-AiChat 

Questi due cmdlet sono alla base della funzione di chat di Powershai.  
`Get-AiChat` è il comando che consente di comunicare con l'LLM nel modo più primitivo possibile, quasi vicino alla chiamata HTTP.  
È, in sostanza, un wrapper standardizzato per l'API che consentono di generare testo.  
Invii i parametri, che sono standardizzati e restituisce una risposta, che è anche standardizzata,
Indipendentemente dal provider, la risposta deve seguire la stessa regola!

Mentre il cmdlet `Invoke-AiChatTools` è un po' più elaborato e un po' più di alto livello.  
Consente di specificare le funzioni di Powershell come strumenti. Queste funzioni vengono convertite in un formato comprensibile all'LLM.  
Utilizza il sistema di help di Powershell per ottenere tutti i metadati possibili da inviare al modello.  
Invia i dati al modello usando il comando `Get-Aichat`. Quando ottiene la risposta, convalida se ci sono tool calling, e se ce ne sono, esegue le funzioni equivalenti e restituisce la risposta.  
Continua a fare questo ciclo fino a quando il modello non termina la risposta o fino a quando non viene raggiunto il numero massimo di interazioni.  
Un'interazione è una chiamata API al modello. Quando si invoca Invoke-AiChatTools con funzioni, potrebbero essere necessarie diverse chiamate per restituire le risposte al modello.  

Il seguente diagramma spiega questo flusso:

```
	sequenceDiagram
		Invoke-AiChatTools->>modelo:prompt (INTERAZIONE 1)
		modelo->>Invoke-AiChatTools:(response, 3 function call)
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 1
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 2
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 3
		Invoke-AiChatTools->>modelo:Resultado tool call + prompts anteriores prompt (INTERAZIONE 2)
		modelo->>Invoke-AiChatTools:resposta final
```


#### Come i comandi vengono trasformati e invocati

Il comando `Invoke-AiChatTools` si aspetta nel parametro -Functions un elenco di comandi powershell mappati su schemi OpenAPI.  
Si aspetta un oggetto che chiamiamo OpenaiTool, contenente le seguenti proprietà: (il nome OpenAiTool è dovuto al fatto che utilizziamo lo stesso formato di tool calling di OpenAI)

- tools  
Questa proprietà contiene lo schema di function calling che verrà inviato all'LLM (nei parametri che si aspettano queste informazioni)  

- map  
Questo è un metodo che restituisce il comando powershell (function,alias,cmdlet,exe, ecc.) da eseguire.  
Questo metodo deve restituire un oggetto con la proprietà chiamata "func", che deve essere il nome di una funzione, un comando eseguibile o uno scriptblock.  
Riceverà nel primo argomento il nome dello strumento e nel secondo il proprio oggetto OpenAiTool (come se fosse this).

Oltre a queste proprietà, qualsiasi altra è libera di essere aggiunta all'oggetto OpenaiTool. Ciò consente allo script map di accedere a qualsiasi dato esterno di cui ha bisogno.  

Quando l'LLM restituisce la richiesta di function calling, il nome della funzione da invocare viene passato al metodo `map`, e deve restituire quale comando deve eseguire. 
Questo apre diverse possibilità, consentendo che, in runtime, il comando da eseguire possa essere determinato a partire da un nome.  
Grazie a questo meccanismo l'utente ha il pieno controllo e flessibilità su come risponderà al tool calling dell'LLM.  

Quindi, il comando verrà invocato e i parametri e i valori inviati dal modello verranno passati come argomenti vincolati.  
In altre parole, il comando o lo script deve essere in grado di ricevere i parametri (o identificarli dinamicamente) a partire dal loro nome.


Tutto ciò viene fatto in un loop che itererà, sequenzialmente, su ogni Tool Calling restituito dall'LLM.  
Non c'è alcuna garanzia dell'ordine in cui gli strumenti verranno eseguiti, quindi, non si dovrebbe mai presumere l'ordine, a meno che l'LLM non invii uno strumento in sequenza.  
Ciò significa che, nelle implementazioni future, diverse tool calling possono essere eseguite contemporaneamente, in parallelo (in Job, ad esempio).  

Internalmente, PowershAI crea uno script map predefinito per i comandi aggiunti usando `Add-AiTool`.  

Per un esempio di come implementare funzioni che restituiscano questo formato, guarda nel provider openai.ps1, i comandi che iniziano con Get-OpenaiTool*

Nota che questa funzionalità di Tool Calling funziona solo con modelli che supportano il Tool Calling seguendo le stesse specifiche di OpenAI (sia in entrata che in uscita).  


#### CONSIDERAZIONI IMPORTANTI SULL'UTILIZZO DEGLI STRUMENTI

La funzionalità di Function Calling è potente perché consente l'esecuzione del codice, ma è anche pericolosa, MOLTO PERICOLOSA.  
Pertanto, fai molta attenzione a ciò che implementi ed esegui.
Ricorda che PowershAI eseguirà secondo le indicazioni del modello. 

Alcuni consigli di sicurezza:

- Evita di eseguire lo script con un utente amministratore.
- Evita di implementare codice che elimina o modifica dati importanti.
- Testa le funzioni prima.
- Non includere moduli o script di terze parti che non conosci o di cui non ti fidi.  

L'implementazione attuale esegue la funzione nella stessa sessione e con le stesse credenziali dell'utente connesso.  
Ciò significa che, ad esempio, se il modello (intenzionalmente o erroneamente) chiede di eseguire un comando pericoloso, i tuoi dati, o anche il tuo computer, potrebbero essere danneggiati o compromessi.  

Pertanto, vale questa avvertenza: fai molta attenzione e aggiungi solo strumenti con script di cui hai piena fiducia.  

C'è un piano per aggiungere futuri meccanismi per aiutare ad aumentare la sicurezza, come isolare in altri runspace, aprire un processo separato, con meno privilegi e consentire all'utente di configurare ciò.






<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
