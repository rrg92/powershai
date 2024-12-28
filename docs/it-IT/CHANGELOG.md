# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corretti errori del provider Hugging Face dovuti a reindirizzamenti.
- Corretta l'installazione dei moduli per i test usando Docker Compose.
- Corretti problemi di prestazioni nella conversione degli strumenti dovuti a un possibile numero elevato di comandi in una sessione. Ora usa moduli dinamici. Vedi `ConvertTo-OpenaiTool`.
- Corretti problemi di incompatibilità tra l'API GROQ e OpenAI. `message.refusal` non è più accettato.
- Corretti piccoli bug in PowerShell Core per Linux.
- **PROVIDER OPENAI**: Risolto codice di eccezione causato dall'assenza di un modello predefinito.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NUOVO PROVIDER**: Benvenuto Azure 🎉
- **NUOVO PROVIDER**: Benvenuto Cohere 🎉
- Aggiunta la funzionalità `AI Credentials` — un nuovo modo standard per gli utenti di definire le credenziali, consentendo ai provider di richiedere dati di credenziali dagli utenti.
- Provider migrati per utilizzare `AI Credentials`, mantenendo la compatibilità con i comandi precedenti.
- Nuovo cmdlet `Confirm-PowershaiObjectSchema`, per convalidare gli schemi usando OpenAPI con una sintassi più "PowerShellzzata".
- Aggiunto supporto per i reindirizzamenti HTTP nella libreria HTTP
- Aggiunti diversi nuovi test con Pester, che vanno da test unitari di base a casi più complessi, come le chiamate di strumenti LLM reali.
- Nuovo cmdlet `Switch-PowershaiSettings` consente di alternare le impostazioni e creare chat, provider predefiniti, modelli, ecc., come se fossero profili distinti.
- **Logica di retry**: Aggiunto `Enter-PowershaiRetry` per rieseguire gli script in base alle condizioni.
- **Logica di retry**: Aggiunta logica di retry in `Get-AiChat` per eseguire facilmente il prompt all'LLM di nuovo se la risposta precedente non è conforme al desiderato.
- Il nuovo cmdlet `Enter-AiProvider` ora consente di eseguire codice sotto un provider specifico. I cmdlet che dipendono da un provider, utilizzeranno sempre il provider in cui è stato "inserito" più recentemente invece del provider corrente.
- Stack di Provider (Push/Pop): Come in `Push-Location` e `Pop-Location`, ora è possibile inserire e rimuovere provider per cambiamenti più rapidi durante l'esecuzione di codice in un altro provider.
- Nuovo cmdlet `Get-AiEmbeddings`: Aggiunti cmdlet standard per ottenere gli embedding da un testo, consentendo ai provider di esporre la generazione di embedding e agli utenti di avere un meccanismo standard per generarli.
- Nuovo cmdlet `Reset-AiDefaultModel` per deselezionare il modello predefinito.
- Aggiunti i parametri `ProviderRawParams` a `Get-AiChat` e `Invoke-AiChat` per sovrascrivere i parametri specifici nell'API, per provider.
- **PROVIDER HUGGINGFACE**: Aggiunti nuovi test usando uno spazio Hugging Face reale esclusivo mantenuto come sottomodulo di questo progetto. Ciò consente di testare contemporaneamente diversi aspetti: sessioni Gradio e integrazione Hugging Face.
- **PROVIDER OPENAI**: Aggiunto un nuovo cmdlet per generare chiamate di strumenti: `ConvertTo-OpenaiTool`, supportando strumenti definiti in blocchi di script.
- **PROVIDER OLLAMA**: Nuovo cmdlet `Get-OllamaEmbeddings` per restituire gli embedding usando Ollama.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Il parametro della chat `ContextFormatter` è stato rinominato in `PromptBuilder`.
- Modificata la visualizzazione predefinita (formats.ps1xml) di alcuni cmdlet come `Get-AiModels`.
- Miglioramento del log dettagliato durante la rimozione della cronologia precedente a causa di `MaxContextSize` nelle chat.
- Nuovo modo in cui vengono memorizzate le impostazioni di PowershAI, introducendo un concetto di "Archiviazione delle impostazioni", consentendo la commutazione delle impostazioni (ad esempio, per i test).
- Aggiornati gli emoji visualizzati insieme al nome del modello quando si utilizza il comando Send-PowershaiChat
- Miglioramenti nella crittografia dell'esportazione/importazione delle impostazioni (Export=-PowershaiSettings). Ora usa come derivazione di chiave e salt.
- Miglioramento del ritorno dell'interfaccia *_Chat, per renderlo più fedele allo standard OpenAI.
- Aggiunta l'opzione `IsOpenaiCompatible` per i provider. I provider che desiderano riutilizzare i cmdlet OpenAI devono impostare questo flag su `true` per funzionare correttamente.
- Miglioramento nella gestione degli errori di `Invoke-AiChatTools` nell'elaborazione delle chiamate di strumenti.
- **PROVIDER GOOGLE**: Aggiunto il cmdlet `Invoke-GoogleApi` per consentire agli utenti di effettuare chiamate dirette all'API.
- **PROVIDER HUGGING FACE**: Piccoli aggiustamenti nel modo di inserire il token nelle richieste dell'API.
- **PROVIDER OPENAI**: `Get-OpenaiToolFromCommand` e `Get-OpenaiToolFromScript` ora usano `ConvertTo-OpenaiTool` per centralizzare la conversione del comando nello strumento OpenAI.
- **PROVIDER GROQ**: Aggiornato il modello predefinito da `llama-3.1-70b-versatile` a `llama-3.2-70b-versatile`.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corretto un bug nella funzione `New-GradioSessionApiProxyFunction`, relativo ad alcune funzioni interne.
- Aggiunto supporto a Gradio 5, necessario a causa delle modifiche agli endpoint dell'API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Supporto per le immagini in `Send-PowershaiChat` per i provider OpenAI e Google.
- Un comando sperimentale, `Invoke-AiScreenshots`, che aggiunge il supporto per acquisire screenshot e analizzarli!
- Supporto per la chiamata di strumenti nel provider Google.
- Il CHANGELOG è stato avviato.
- Supporto alla TAB per Set-AiProvider. 
- Aggiunto supporto di base per l'output strutturato al parametro `ResponseFormat` del cmdlet `Get-AiChat`. Ciò consente di passare una hashtable che descrive lo schema OpenAPI del risultato.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: La proprietà `content` dei messaggi OpenAI ora viene inviata come array per allinearsi alle specifiche per altri tipi di media. Ciò richiede l'aggiornamento degli script che dipendono dal formato di stringa singola precedente e dalle versioni precedenti dei provider che non supportano questa sintassi.
- Il parametro `RawParams` di `Get-AiChat` è stato corretto. Ora è possibile passare i parametri dell'API al provider in questione per avere uno stretto controllo sul risultato
- Aggiornamenti di DOC: Nuovi documenti tradotti con AiDoc e aggiornamenti. Piccola correzione in AiDoc.ps1 per non tradurre alcuni comandi di sintassi markdown.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Le impostazioni di sicurezza sono state modificate e la gestione di maiuscole e minuscole è stata migliorata. Questo non veniva validato, causando un errore.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0


<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente usando PowerShell e IA
_
<!--PowershaiAiDocBlockEnd-->
