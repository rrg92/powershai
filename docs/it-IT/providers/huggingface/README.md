# Provider Hugging Face

Hugging Face è il più grande repository di modelli di IA al mondo!  
Qui, hai accesso a una gamma incredibile di modelli, dataset, demo con Gradio e molto altro ancora!  

È il GitHub dell'Intelligenza Artificiale, commerciale e open source! 

Il provider Hugging Face di PowershAI collega il tuo powershell a una gamma incredibile di servizi e modelli.  

## Gradio

Gradio è un framework per creare demo per modelli di IA. Con poco codice in python, è possibile creare interfacce che accettano diversi input, come testo, file, ecc.  
Inoltre, gestisce molte questioni come code, upload, ecc. E, per finire, insieme all'interfaccia, può fornire una API per rendere accessibile la funzionalità esposta tramite UI anche attraverso linguaggi di programmazione.  
PowershAI ne trae beneficio e mette a disposizione le API di Gradio in modo più semplice, dove è possibile invocare una funzionalità dal terminale e avere praticamente la stessa esperienza!


## Hugging Face Hub  

Hugging Face Hub è la piattaforma a cui accedi su https://huggingface.co  
È organizzato in modelli (models), che sono essenzialmente il codice sorgente dei modelli di IA che altre persone e aziende creano in tutto il mondo.  
Ci sono anche gli "Spaces", dove è possibile caricare del codice per pubblicare applicazioni scritte in python (usando Gradio, ad esempio) o docker.  

Scopri di più su Hugging Face [in questo post del blog Ia Talking](https://iatalk.ing/hugging-face/)
E, scopri Hugging Face Hub [nella documentazione ufficiale](https://huggingface.co/docs/hub/en/index)

Con PowershaAI, puoi elencare i modelli e persino interagire con l'API di diversi spazi, eseguendo le più diverse app di IA dal tuo terminale.  


# Utilizzo di base

Il provider Hugging Face di PowershAI ha molti cmdlet per l'interazione.  
È organizzato nei seguenti comandi:

* i comandi che interagiscono con Hugging Face possiedono `HuggingFace` o `Hf` nel nome. Esempio: `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* i comandi che interagiscono con Gradio, indipendentemente dal fatto che si trovino in uno Space di Hugging Face o meno, hanno `Gradio` o `GradioSession'  nel nome: `Send-GradioApi`, `Update-GradioSessionApiResult`
* Puoi utilizzare questo comando per ottenere l'elenco completo: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

Non è necessario autenticarsi per accedere alle risorse pubbliche di Hugging Face.  
C'è un'infinità di modelli e spazi disponibili gratuitamente senza bisogno di autenticazione.  
Ad esempio, il seguente comando elenca i primi 5 modelli più scaricati da Meta (autore: meta-llama):

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

Il cmdlet Invoke-HuggingFaceHub è responsabile dell'invocazione degli endpoint dell'API di Hub.  I parametri sono gli stessi documentati in https://huggingface.co/docs/hub/en/api
Tuttavia, avrai bisogno di un token se hai bisogno di accedere a risorse private: `Set-HuggingFaceToken` (o `Set-HfToken`)  è il cmdlet per inserire il token predefinito utilizzato in tutte le richieste.  



# Struttura dei comandi del provider Hugging Face  
 
Il provider di Hugging Face è organizzato in 3 principali gruppi di comandi: Gradio, Gradio Session e Hugging Face.  


## Comandi Gradio*`

I cmdlet del gruppo "gradio" hanno la struttura Verbo-GradioNome.  Questi comandi implementano l'accesso all'API di Gradio.  
Questi comandi sono essenzialmente wrapper per le API. La loro costruzione è stata basata su questa documentazione: https://www.gradio.app/guides/querying-gradio-apps-with-curl  e osservando anche il codice sorgente di Gradio (ad es.: [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
Questi comandi possono essere utilizzati con qualsiasi app gradio, indipendentemente da dove si trovino: sulla tua macchina locale, in uno spazio di Hugging Face, su un server nel cloud... 
Hai solo bisogno dell'URL principale dell'applicazione.  


Considera questa app gradio:

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="Duration, in, seconds", value=5);
    txtResults = gr.Text(label="Resultado");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

Sostanzialmente, questa app visualizza 2 campi di testo, uno dei quali è quello in cui l'utente digita un testo e l'altro è utilizzato per mostrare l'output.  
Un pulsante, che, quando viene cliccato, attiva la funzione Op1. La funzione esegue un ciclo per un determinato numero di secondi specificato nel parametro.  
Ogni secondo, restituisce quanto è passato.  

Supponiamo che all'avvio, questa app sia accessibile su http://127.0.0.1:7860.
Con questo provider, connettersi a questa app è semplice:

```powershell
# installa powershai, se non è installato!
Install-Module powershai 

# Importa
import-module powershai 

# Verifica gli endpoint dell'api!
Get-GradioInfo http://127.0.0.1:7860
```

Il cmdlet `Get-GradioInfo` è il più semplice. Legge semplicemente l'endpoint /info che ogni app gradio possiede.  
Questo endpoint restituisce informazioni preziose, come gli endpoint dell'API disponibili:

```powershell
# Verifica gli endpoint dell'api!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# elenca i parametri dell'endpoint
$AppInfo.named_endpoints.'/op1'.parameters
```

Puoi invocare l'API utilizzando il cmdlet `Send-GradioApi`.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Nota che dobbiamo passare l'URL, il nome dell'endpoint senza la barra e l'array con l'elenco dei parametri.
Il risultato di questa richiesta è un evento che può essere utilizzato per consultare il risultato dell'API.
Per ottenere i risultati, devi utilizzare `Update-GradioApiResult' 

```powershell
$Event | Update-GradioApiResult
```

Il cmdlet `Update-GradioApiResult` scriverà gli eventi generati dall'API nel pipeline.  
Verrà restituito un oggetto per ogni evento generato dal server. La proprietà `data` di questo oggetto contiene i dati restituiti, se presenti.  


C'è anche il comando `Send-GradioFile`, che consente di effettuare upload.  Restituisce un array di oggetti FileData, che rappresentano il file sul server.  

Nota come questi cmdlet siano molto primitivi: devi fare tutto manualmente. Ottenere gli endpoint, invocare l'api, inviare i parametri come array, effettuare l'upload dei file.  
Sebbene questi comandi astratte le chiamate HTTP dirette di Gradio, richiedono ancora molto all'utente.  
Ecco perché è stato creato il gruppo di comandi GradioSession, che aiutano a astrarre ulteriormente e rendere la vita dell'utente più facile!


## Comandi GradioSession*  

I comandi del gruppo GradioSession aiutano ad astrarre ulteriormente l'accesso a un'app Gradio.  
Con loro, sei più vicino al powershell quando interagisci con un'app gradio e più lontano dalle chiamate native.  

Utilizzeremo lo stesso esempio dell'app precedente per fare alcuni confronti:

```powershell
# crea una nuova session 
New-GradioSession http://127.0.0.1:7860
```

Il cmdlet `New-GradioSession` crea una nuova sessione con Gradio.  Questa nuova sessione ha elementi unici come un SessionId, un elenco di file caricati, configurazioni, ecc.  
Il comando restituisce l'oggetto che rappresenta questa sessione e puoi ottenere tutte le sessioni create utilizzando `Get-GradioSession`.  
Immagina una GradoSession come una scheda del browser aperta con la tua app gradio aperta.  

I comandi GradioSession operano, per impostazione predefinita, nella sessione predefinita. Se esiste una sola sessione, questa è la sessione predefinita.  
Se ne esistono più di una, l'utente deve scegliere quale è quella predefinita utilizzando il comando `Set-GradioSession`

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

Uno dei comandi più potenti è `New-GradioSessionApiProxyFunction` (o alias GradioApiFunction).  
Questo comando trasforma le API di Gradio della sessione in funzioni powershell, ovvero puoi invocare l'API come se fosse una funzione powershell.  
Torniamo all'esempio precedente


```powershell
# primo, apri la sessione!
New-GradioSession http://127.0.0.1:7860

# Ora, creiamo le funzioni!
New-GradioSessionApiProxyFunction
```

Il codice sopra creerà una funzione powershell chiamata Invoke-GradioApiOp1.  
Questa funzione ha gli stessi parametri dell'endpoint '/op1' e puoi utilizzare get-help per ulteriori informazioni:  

```powershell
get-help -full Invoke-GradioApiOp1
```

Per eseguire, basta invocare:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Nota come il parametro `Duration` definito nell'app gradio è diventato un parametro powershell.  
Sotto il cofano, Invoke-GradioApiOp1 sta eseguendo `Update-GradioApiResult`, ovvero la restituzione è lo stesso oggetto!
Ma nota quanto è stato più semplice invocare l'API di Gradio e ricevere il risultato!

Le app che definiscono i file, come musica, immagini, ecc., generano funzioni che effettuano automaticamente l'upload di questi file.  
L'utente deve solo specificare il percorso locale.  

Eventualmente, potrebbero esserci alcuni altri tipi di dati non supportati nella conversione e, se li incontri, apri un'issue (o invia un PR) per valutare e implementare!



## Comandi HuggingFace* (o Hf*)  

I comandi di questo gruppo sono stati creati per operare con l'API di Hugging Face.  
Sostanzialmente, incapsulano le chiamate HTTP ai diversi endpoint di Hugging Face.  

Un esempio:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

Questo comando restituisce un oggetto che contiene diverse informazioni sullo spazio diffusers-labs, dell'utente rrg92.  
Poiché è uno spazio gradio, puoi connetterti con gli altri cmdlet (i cmdlet GradioSession sono in grado di capire quando un oggetto restituito da Get-HuggingFaceSpace viene passato a loro!)

```
# Connetti allo spazio (e, automaticamente, crea una sessione gradio)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

#Predefinito
Set-GradioSession -Default $diff

# Crea funzioni!
New-GradioSessionApiProxyFunction

# invoca!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**IMPORTANTE: Ricorda che l'accesso a determinati spazi può essere effettuato solo con l'autenticazione, in questi casi, devi utilizzare Set-HuggingFaceToken e specificare un token di accesso.;**



<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
