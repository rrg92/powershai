# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Aggiunto groq ai test automatici

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Corretto errore nel provider groq, relativo ai messaggi di sistema
- **COHERE PROVIDER**: Corretto errore relativo ai messaggi del modello quando avevano risposte di tool calls.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Le chat venivano ricreate ogni volta, impedendo di mantenere correttamente la cronologia quando si utilizzavano più chat!
- **OPENAI PROVIDER**: Corretto il risultato di `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corretti errori del provider Hugging Face a causa di reindirizzamenti.
- Corretta l'installazione di moduli per i test usando Docker Compose.
- Corretti problemi di prestazioni nella conversione di strumenti a causa di un possibile grande numero di comandi in una sessione. Ora usa moduli dinamici. Vedi `ConvertTo-OpenaiTool`.
- Corretti problemi di incompatibilità tra l'API GROQ e OpenAI. `message.refusal` non è più accettato.
- Corretti piccoli bug in PowerShell Core per Linux.
- **OPENAI PROVIDER**: Risolto il codice di eccezione causato dall'assenza di un modello predefinito.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NUOVO PROVIDER**: Benvenuto Azure 🎉
- **NUOVO PROVIDER**: Benvenuto Cohere 🎉
- Aggiunto il feature `AI Credentials` — un nuovo modo standard per gli utenti di definire le credenziali, consentendo ai provider di richiedere dati di credenziali dagli utenti.
- Provider migrati per usare `AI Credentials`, mantenendo la compatibilità con comandi più vecchi.
- Nuovo cmdlet `Confirm-PowershaiObjectSchema`, per validare schemi usando OpenAPI con una sintassi più "PowerShellizzata".
- Aggiunto supporto per reindirizzamenti HTTP nella HTTP lib
- Aggiunti diversi nuovi test con Pester, variando da test unitari di base a casi più complessi, come chiamate di strumenti LLM reali.
- Nuovo cmdlet `Switch-PowershaiSettings` permette di alternare configurazioni e creare chat, provider predefiniti, modelli ecc., come se fossero profili distinti.
- **Retry Logic**: Aggiunto `Enter-PowershaiRetry` per rieseguire script in base a condizioni.
- **Retry Logic**: Aggiunto retry logic in `Get-AiChat` per eseguire facilmente il prompt all'LLM di nuovo nel caso in cui la risposta precedente non sia in accordo con quanto desiderato.
- Nuovo cmdlet `Enter-AiProvider` ora permette di eseguire codice sotto un provider specifico. I cmdlet che dipendono da un provider, useranno sempre il provider in cui si è "entrati" più di recente al posto del current provider.
- Stack di Provider (Push/Pop): Così come in `Push-Location` e `Pop-Location`, ora puoi inserire e rimuovere provider per cambiamenti più rapidi quando esegui codice in un altro provider.
- Nuovo cmdlet `Get-AiEmbeddings`: Aggiunti cmdlet standard per ottenere embeddings da un testo, permettendo ai provider di esporre la generazione di embeddings e che l'utente abbia un meccanismo standard per generarli.
- Nuovo cmdlet `Reset-AiDefaultModel` per deselezionare il modello predefinito.
- Aggiunti i parametri `ProviderRawParams` a `Get-AiChat` e `Invoke-AiChat` per sovrascrivere i parametri specifici nell'API, per provider.
- **HUGGINGFACE PROVIDER**: Aggiunti nuovi test usando uno space Hugging Face esclusivo reale mantenuto come un sottomodulo di questo progetto. Questo permette di testare diversi aspetti allo stesso tempo: sessioni Gradio e integrazione Hugging Face.
- **HUGGINGFACE PROVIDER**: Nuovo cmdlet: Find-HuggingFaceModel, per cercare modelli nell'hub basato su alcuni filtri!
- **OPENAI PROVIDER**: Aggiunto un nuovo cmdlet per generare chiamate di strumenti: `ConvertTo-OpenaiTool`, supportando strumenti definiti in blocchi di script.
- **OLLAMA PROVIDER**: Nuovo cmdlet `Get-OllamaEmbeddings` per restituire embeddings usando Ollama.
- **OLLAMA PROVIDER**: Nuovo cmdlet `Update-OllamaModel` per scaricare models ollama (pull) direttamente da powershai
- **OLLAMA PROVIDER**: Rilevamento automatico di tools usando i metadati di ollama
- **OLLAMA PROVIDER**: Cache dei metadados di models e nuovo cmdlet `Reset-OllamaPowershaiCache` per pulire la cache, permettendo di consultare molti dettagli dei modelli ollama, mantenendo le prestazioni per l'uso ripetuto del comando

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Il parametro della Chat `ContextFormatter` è stato rinominato in `PromptBuilder`.
- Modificata la visualizzazione predefinita (formats.ps1xml) di alcuni cmdlet come `Get-AiModels`.
- Miglioramento nel log dettagliato quando si rimuove la cronologia vecchia a causa di `MaxContextSize` nelle chat.
- Nuovo modo in cui le configurazioni di PowershAI sono archiviate, introducendo un concetto di "Archiviazione di Configurazioni", permettendo lo scambio di configurazione (per esempio, per test).
- Aggiornati gli emoji visualizzati insieme al nome del modello quando si usa il comando Send-PowershaiChat
- Miglioramenti nella crittografia dell'export/import di configurazioni (Export=-PowershaiSettings). Ora usa come derivazione di chiave e salt.
- Miglioramento nel ritorno dell'interfaccia *_Chat, affinché sia più fedele allo standard di OpenAI.
- Aggiunta l'opzione `IsOpenaiCompatible` per i provider. I provider che desiderano riutilizzare i cmdlet OpenAI devono definire questo flag come `true` per funzionare correttamente.
- Miglioramento nella gestione degli errori di `Invoke-AiChatTools` nell'elaborazione di tool calling.
- **GOOGLE PROVIDER**: Aggiunto il cmdlet `Invoke-GoogleApi` per permettere chiamate di API dirette dagli utenti.
- **HUGGING FACE PROVIDER**: Piccoli aggiustamenti nella forma di inserire il token nelle richieste dell'API.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` e `Get-OpenaiToolFromScript` ora usano `ConvertTo-OpenaiTool` per centralizzare la conversione di comando in strumento OpenAI.
- **GROQ PROVIDER**: Aggiornato il modello predefinito da `llama-3.1-70b-versatile` a `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels ora include modelli che supportano tools, poiché il provider usa l'endpoint /api/show per ottenere maggiori dettagli dei modelli, il che permette di verificare il supporto per i tools

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corretto bug nella funzione `New-GradioSessionApiProxyFunction`, relativo ad alcune funzioni interne.
- Aggiunto supporto a Gradio 5, che è necessario a causa di modifiche negli endpoint dell'API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Supporto per immagini in `Send-PowershaiChat` per i provider OpenAI e Google.
- Un comando sperimentale, `Invoke-AiScreenshots`, che aggiunge supporto per fare screenshot e analizzarli!
- Supporto per chiamata di strumenti nel provider Google.
- CHANGELOG è stato iniziato.
- Supporto al TAB per Set-AiProvider.
- Aggiunto supporto base per l'output strutturato al parametro `ResponseFormat` del cmdlet `Get-AiChat`. Questo permette di passare un hashtable che descrive lo schema OpenAPI del risultato.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: La proprietà `content` dei messaggi OpenAI ora è inviata come un array per allinearsi alle specifiche per altri tipi di media. Questo richiede l'aggiornamento di script che dipendono dal formato di stringa singola precedente e da versioni vecchie di provider che non supportano questa sintassi.
- Parametro `RawParams` di `Get-AiChat` è stato corretto. Ora puoi passare parametri dell'API al provider in questione per avere uno stretto controllo sul risultato
- Aggiornamenti di DOC: Nuovi documenti tradotti con AiDoc e aggiornamenti. Piccola correzione in AiDoc.ps1 per non tradurre alcuni comandi di sintassi markdown.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Le impostazioni di sicurezza sono state modificate e la gestione di maiuscole e minuscole è stata migliorata. Questo non veniva validato, il che risultava in un errore.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2



<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente utilizzando PowershAI e IA_
<!--PowershaiAiDocBlockEnd-->
