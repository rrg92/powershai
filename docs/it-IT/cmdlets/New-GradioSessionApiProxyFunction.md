---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Crea funzioni che incapsulano le chiamate di un endpoint Gradio (o tutti gli endpoint).  
Questo cmdlet è molto utile per creare funzioni powershell che incapsulano un endpoint API Gradio, dove i parametri dell'API sono creati come parametri della funzione.  
Così, le funzionalità native di powershell, come l'autocompletamento, il tipo di dati e la documentazione, possono essere utilizzate e diventa molto facile invocare qualsiasi endpoint di una sessione.

Il comando consulta i metadati degli endpoint e dei parametri e crea le funzioni powershell nello scope globale.  
Con ciò, l'utente può invocare le funzioni direttamente, come se fossero funzioni normali.  

Ad esempio, supponiamo che un'applicazione Gradio all'indirizzo http://mydemo1.hf.space abbia un endpoint chiamato /GenerateImage per generare immagini con Stable Diffusion.  
Assumiamo che questa applicazione accetti 2 parametri: Prompt (la descrizione dell'immagine da generare) e Steps (il numero totale di step).

Normalmente, potresti usare il comando Invoke-GradioSessionApi, così: 

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

Questo avvierebbe l'API e potresti ottenere i risultati usando Update-GradioApiResult:

$ApiEvent | Update-GradioApiResult

Con questo cmdlet, puoi incapsulare un po' di più queste chiamate:

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

Il comando precedente creerà una funzione chiamata Invoke-GradioApiGenerateimage.
Quindi, puoi usarla in modo semplice per generare l'immagine:

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100 

Per impostazione predefinita, il comando verrebbe eseguito e otterrebbe già gli eventi dei risultati, scrivendo nel pipeline in modo che tu possa integrarli con altri comandi.  
Anche connettere più spazi è molto semplice, vedi sotto sulla pipeline.

NOMENCLATURA 

	Il nome delle funzioni create segue il formato:  <Prefix><NomeOp>
		<Prefix> è il valore del parametro -Prefix di questo cmdlet. 
		<NomeOp> è il nome dell'operazione, mantenuto solo lettere e numeri
		
		Ad esempio, se l'operazione è /Op1 e il Prefisso INvoke-GradioApi, la seguente funzione verrà creata: Invoke-GradioApiOp1

	
PARAMETRI
	Le funzioni create contengono la logica necessaria per trasformare i parametri passati ed eseguire il cmdlet Invoke-GradioSessionApi.  
	Vale a dire, lo stesso ritorno si applica come se si stesse invocando questo cmdlet direttamente.  (Questo è, un evento verrà restituito e aggiunto alla lista degli eventi della sessione corrente).
	
	I parametri delle funzioni possono variare a seconda dell'endpoint dell'API, perché ogni endpoint ha un set diverso di parametri e tipi di dati.
	I parametri che sono file (o elenco di file) hanno un passaggio aggiuntivo di upload. Il file può essere referenziato localmente e il suo upload verrà fatto sul server.  
	Se viene fornita un'URL o un oggetto FileData ricevuto da un altro comando, non verrà eseguito alcun upload aggiuntivo, verrà semplicemente generato un oggetto FileData corrispondente per l'invio tramite API.

	Oltre ai parametri dell'endpoint, esiste un set aggiuntivo di parametri che verrà sempre aggiunto alla funzione creata.  
	Questi sono:
		- Manual  
		Se utilizzato, fa sì che il cmdlet restituisca l'evento generato da INvoke-GradioSessionApi.  
		In questo caso, dovrai ottenere manualmente i risultati usando Update-GradioSessionApiResult
		
		- ApiResultMap 
		Mappa i risultati di altri comandi ai parametri. Vedi di più nella sezione PIPELINE.
		
		- DebugData
		Per scopi di debug da parte degli sviluppatori.
		
UPLOAD 	
	I parametri che accettano file vengono trattati in modo speciale.  
	Prima dell'invocazione dell'API, il cmdlet Send-GradioSessionFiles viene usato per caricare questi file sul rispettivo app gradio.  
	Questo è un altro grande vantaggio dell'utilizzo di questo cmdlet, perché ciò è trasparente e l'utente non ha bisogno di gestire gli upload.

PIPELINE 
	
	Una delle funzionalità più potenti di powershell è la pipeline, dove è possibile collegare più comandi usando il pipe |.
	E questo cmdlet cerca anche di sfruttare al massimo questa funzionalità.  
	
	Tutte le funzioni create possono essere collegate con il |.
	Facendo ciò, ogni evento generato dal cmdlet precedente viene passato al successivo.  
	
	Considera due app gradio, App1 e App2.
	App1 ha l'endpoint Img, con un parametro chiamato Text, che genera immagini usando Diffusers, mostrando le parziali di ogni immagine man mano che vengono generate.
	App2 ha un endpoint Ascii, con un parametro chiamato Image, che trasforma un'immagine in una versione ascii in testo.
	
	Puoi collegare questi due comandi in modo molto semplice con la pipeline.  
	Innanzitutto, crea le sessioni

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator
		
	Crea le funzioni 
		$App1 | New-GradioSessionApiProxy -Prefix App # questo crea la funzione AppImg
		$App2 | New-GradioSessionApiProxy -Prefix App # questo crea la funzione AppAscii
		
	Genera l'immagine e connettila al generatore ascii:
	
	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data[0]; write-host $_.pipeline[0].data[0].url } 
	
	Ora scomponiamo la sequenza precedente.
	
	Prima del primo pipe, abbiamo il comando che genera l'immagine: AppImg -Text "A car" 
	Questa funzione sta chiamando l'endpoint /Img di App1. Questo endpoint produce un'uscita per ogni passo della generazione di immagini con la lib Diffusers di hugging face.  
	In questo caso, ogni uscita sarà un'immagine (abbastanza confusa), fino all'ultima uscita che sarà l'immagine finale.  
	Questo risultato si trova nella proproità data dell'oggetto del pipeline. È un array con i risultati.
	
	Subito dopo nel pipe, abbiamo il comando: AppAscii -Map ImageInput=0
	Questo comando riceverà ogni oggetto generato dal comando AppImg, che nel caso sono le immagini parziali del processo di diffusione.  
	
	A causa del fatto che i comandi possono generare un array di uscite, è necessario mappare esattamente quale dei risultati deve essere associato a quali parametri.  
	Pertanto, usiamo il parametro -Map (-Map è un Alias, in realtà il nome corretto è ApiResultMap)
	La sintassi è semplice: NomeParam=DataIndex,NomeParam=DataIndex  
	Nel comando precedente, stiamo dicendo: AppAscii, utilizza il primo valore della proproità data nel parametro ImageInput.  
	Ad esempio, se AppImg restituisse 4 valori e l'immagine fosse nell'ultima posizione, dovresti usare ImageInput=3 (0 è la prima).
	
	
	Infine, l'ultimo pipe solo evole il risultato di AppAscii, che ora si trova nell'oggetto del pipeline, $_, nella proproità .data (uguale al risultato di AppImg).  
	E, per completare, l'oggetto del pipeline ha una proproità speciale, chiamata pipeline. Con essa, puoi accedere a tutti i risultati dei comandi generati.  
	Ad esempio, $_.pipeline[0], contiene il risultato del primo comando (AppImg). 
	
	Grazie a questo meccanismo, diventa molto più facile collegare diverse app Gradio in un'unica pipeline.
	Nota che questa sequenza funziona solo tra comandi generati da New-GradioSessionApiProxy. Eseguire il pipe di altri comandi non produrrà lo stesso effetto (dovrai usare qualcosa come For-EachObject e associare i parametri direttamente)


SESSIONI 
	Quando la funzione viene creata, la sessione di origine viene cravata insieme alla funzione.  
	Se la sessione viene rimossa, il cmdlet genererà un errore. In questo caso, devi creare la funzione invocando nuovamente questo cmdlet.  


Il seguente diagramma riassume le dipendenze coinvolte:

	New-GradioSessionApiProxyFunction(Prefix)
		---> function <Prefix><OpName>
			---> Send-GradioSessionFiles (quando houer files)
			---> Invoke-GradioSessionApi | Update-GradioSessionApiResult

Una volta che Invoke-GradioSessionApi viene eseguito alla fine, tutte le sue regole si applicano.
Puoi usare Get-GradioSessionApiProxyFunction per ottenere un elenco di ciò che è stato craido e Remove-GradioSessionApiProxyFunction per rimuovere una o più funzioni create.  
Le funzioni vengono create con un modulo dinamico.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Crea solo per questo endpoint specifico

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -Prefix
Prefisso delle funzioni create

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Invoke-GradioApi
Accept pipeline input: false
Accept wildcard characters: false
```

### -Session
Sessione

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
Forza la creazione della funzione, anche se ne esiste già una con lo stesso nome!

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
