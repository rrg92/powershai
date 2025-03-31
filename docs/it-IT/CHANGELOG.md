# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.3]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVIDER**: Aggiunto parametro -DisableRetry a Get-GradioInfo
- **HUGGINGFACE PROVIDER**: Aggiunti parametri GradioServerRoot in Get-HuggingFaceSpace e ServerRoot in Connect-HuggingFaceSpaceGradio
- **HUGGINGFACE PROVIDER**: Aggiunta logica per rilevare se lo space di hugging face usa Gradio 5 e regolare il server root
- **HUGGINGFACE PROVIDER**: Aggiunti spaces privati ai test del provider

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: Risolto problema di autenticazione in spaces privati


## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Aggiunto groq ai test automatici

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Risolto errore nel provider groq, relativo a system messages 
- **COHERE PROVIDER**: Risolto errore relativo ai messaggi del modello quando avevano risposte di tool calls.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Le chat venivano ricreate ogni volta, impedendo di mantenere correttamente la cronologia utilizzando più chat! 
- **OPENAI PROVIDER**: Risolto risultato di `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Risolti errori del provider Hugging Face a causa di reindirizzamenti.
- Risolta l'installazione di moduli per test utilizzando Docker Compose.
- Risolti problemi di prestazioni nella conversione di strumenti a causa di un possibile grande numero di comandi in una sessione. Ora utilizza moduli dinamici. Vedi `ConvertTo-OpenaiTool`.
- Risolti problemi di incompatibilità tra l'API GROQ e OpenAI. `message.refusal` non è più accettato.
- Risolti piccoli bug nel PowerShell Core per Linux.
- **OPENAI PROVIDER**: Risolto codice di eccezione causato dall'assenza di un modello predefinito.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOVO PROVIDER**: Benvenuto Azure 🎉
- **NOVO PROVIDER**: Benvenuto Cohere 🎉
- Aggiunta la funzionalità `AI Credentials` — un nuovo modo standard per gli utenti di definire credenziali, consentendo ai provider di richiedere dati di credenziali dagli utenti.
- Provider migrati per utilizzare `AI Credentials`, mantenendo la compatibilità con comandi più vecchi.
- Nuovo cmdlet `Confirm-PowershaiObjectSchema`, per convalidare schemi utilizzando OpenAPI con una sintassi più "PowerShellizzata".
- Aggiunto supporto per reindirizzamenti HTTP nella libreria HTTP
- Aggiunti diversi nuovi test con Pester, variando da test unitari di base a casi più complessi, come chiamate a strumenti LLM reali.
- Nuovo cmdlet `Switch-PowershaiSettings` consente di alternare configurazioni e creare chat, provider predefiniti, modelli ecc., come se fossero profili distinti.
- **Retry Logic**: Aggiunto `Enter-PowershaiRetry` per rieseguire script in base a condizioni.
- **Retry Logic**: Aggiunta logica di retry in `Get-AiChat` per eseguire facilmente nuovamente il prompt al LLM nel caso in cui la risposta precedente non fosse conforme a quanto desiderato.- Nuovo cmdlet `Enter-AiProvider` ora consente di eseguire codice sotto un provider specifico. I cmdlet che dipendono da un provider utilizzeranno sempre il provider in cui è stato "entrato" più recentemente invece del current provider.
- Stack di Provider (Push/Pop): Proprio come in `Push-Location` e `Pop-Location`, ora puoi inserire e rimuovere provider per cambiamenti più rapidi durante l'esecuzione di codice in un altro provider.
- Nuovo cmdlet `Get-AiEmbeddings`: Aggiunti cmdlet standard per ottenere embeddings da un testo, consentendo ai provider di esporre la generazione di embeddings e agli utenti di avere un meccanismo standard per generarli.
- Nuovo cmdlet `Reset-AiDefaultModel` per deselezionare il modello predefinito.
- Aggiunti i parametri `ProviderRawParams` a `Get-AiChat` e `Invoke-AiChat` per sovrascrivere i parametri specifici nell'API, per provider.
- **HUGGINGFACE PROVIDER**: Aggiunti nuovi test utilizzando uno space Hugging Face esclusivo reale mantenuto come un sottogruppo di questo progetto. Questo consente di testare vari aspetti contemporaneamente: sessioni Gradio e integrazione Hugging Face.
- **HUGGINGFACE PROVIDER**: Nuovo cmdlet: Find-HuggingFaceModel, per cercare modelli nel hub basato su alcuni filtri!
- **OPENAI PROVIDER**: Aggiunto un nuovo cmdlet per generare chiamate a strumenti: `ConvertTo-OpenaiTool`, supportando strumenti definiti in blocchi di script.
- **OLLAMA PROVIDER**: Nuovo cmdlet `Get-OllamaEmbeddings` per restituire embeddings utilizzando Ollama.
- **OLLAMA PROVIDER**: Nuovo cmdlet `Update-OllamaModel` per scaricare modelli ollama (pull) direttamente dal powershai
- **OLLAMA PROVIDER**: Rilevamento automatico di strumenti utilizzando i metadati di ollama
- **OLLAMA PROVIDER**: Cache di metadati di modelli e nuovo cmdlet `Reset-OllamaPowershaiCache` per pulire la cache, consentendo di consultare molti dettagli dei modelli ollama, mantenendo al contempo le prestazioni per l'uso ripetuto del comando

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Il parametro del Chat `ContextFormatter` è stato rinominato in `PromptBuilder`.
- Modificata la visualizzazione predefinita (formats.ps1xml) di alcuni cmdlet come `Get-AiModels`.
- Miglioramento del log dettagliato durante la rimozione della cronologia antica a causa di `MaxContextSize` nelle chat.
- Nuovo modo in cui le impostazioni di PowershAI vengono memorizzate, introducendo un concetto di "Archiviazione delle Impostazioni", consentendo il cambio di configurazione (ad esempio, per test).
- Aggiornati gli emoji visualizzati insieme al nome del modello quando utilizzato il comando Send-PowershaiChat
- Miglioramenti nella crittografia dell'export/import delle impostazioni (Export=-PowershaiSettings). Ora utilizza come derivazione di chiave e salt.
- Miglioramento nel ritorno dell'interfaccia *_Chat, affinché sia più fedele allo standard di OpenAI.
- Aggiunta l'opzione `IsOpenaiCompatible` per i provider. I provider che desiderano riutilizzare i cmdlet OpenAI devono impostare questo flag su `true` per funzionare correttamente.
- Miglioramento nella gestione degli errori di `Invoke-AiChatTools` durante l'elaborazione delle chiamate agli strumenti.- **GOOGLE PROVIDER**: Aggiunto il cmdlet `Invoke-GoogleApi` per consentire chiamate API dirette dagli utenti.
- **HUGGING FACE PROVIDER**: Piccole modifiche nel modo di inserire il token nelle richieste API.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` e `Get-OpenaiToolFromScript` ora utilizzano `ConvertTo-OpenaiTool` per centralizzare la conversione da comando a strumento OpenAI.
- **GROQ PROVIDER**: Aggiornato il modello predefinito da `llama-3.1-70b-versatile` a `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels ora include modelli che supportano tools, poiché il provider utilizza l'endpoint /api/show per ottenere ulteriori dettagli sui modelli, il che consente di controllare il supporto per i tools.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corretto bug nella funzione `New-GradioSessionApiProxyFunction`, relativo ad alcune funzioni interne.
- Aggiunto supporto per Gradio 5, necessario a causa delle modifiche agli endpoint dell'API.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Supporto per immagini in `Send-PowershaiChat` per i provider OpenAI e Google.
- Un comando sperimentale, `Invoke-AiScreenshots`, che aggiunge supporto per catturare screenshot e analizzarli!
- Supporto per chiamate di strumenti nel provider Google.
- CHANGELOG è stato avviato.
- Supporto per TAB per Set-AiProvider. 
- Aggiunto supporto di base per output strutturato al parametro `ResponseFormat` del cmdlet `Get-AiChat`. Questo consente di passare un hashtable che descrive lo schema OpenAPI del risultato.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: La proprietà `content` dei messaggi OpenAI è ora inviata come un array per allinearsi alle specifiche per altri tipi di media. Ciò richiede l'aggiornamento degli script che dipendono dal formato di stringa singola precedente e da versioni precedenti di provider che non supportano questa sintassi.
- Il parametro `RawParams` di `Get-AiChat` è stato corretto. Ora puoi passare parametri dell'API al provider in questione per avere un controllo rigoroso sul risultato.
- Aggiornamenti di DOC: Nuovi documenti tradotti con AiDoc e aggiornamenti. Piccola correzione in AiDoc.ps1 per non tradurre alcuni comandi di sintassi markdown.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Le impostazioni di sicurezza sono state modificate e la gestione delle maiuscole e minuscole è stata migliorata. Questo non veniva validato, causando un errore.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2


<!--PowershaiAiDocBlockStart-->
_Sei stato addestrato su dati fino a ottobre 2023._
<!--PowershaiAiDocBlockEnd-->
