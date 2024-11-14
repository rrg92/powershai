![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [english](/docs/en-US/START-README.md)
* [Français](/docs/fr-FR/START-README.md)
* [日本語](/docs/ja-JP/START-README.md)
* [العربية](/docs/ar-SA/START-README.md)
* [Deutsch](/docs/de-DE/START-README.md)
* [español](/docs/es-ES/START-README.md)
* [עברית](/docs/he-IL/START-README.md)
* [italiano](/docs/it-IT/START-README.md)

PowershAI (PowerShell + AI) è un modulo che integra servizi di Intelligenza Artificiale direttamente in PowerShell.  
Puoi invocare i comandi sia negli script che nella riga di comando.  

Esistono vari comandi che consentono conversazioni con LLM, invocare spazi di Hugging Face, Gradio, ecc.  
Puoi conversare con il GPT-4o-mini, gemini flash, llama 3.1, ecc, utilizzando i tuoi token di questi servizi.  
Cioè, non paghi nulla per usare il PowershAI, oltre ai costi che avresti normalmente utilizzando questi servizi.  

Questo modulo è ideale per integrare comandi PowerShell con i tuoi LLM preferiti, testare chiamate, pocs, ecc.  
È ideale per chi è già abituato a PowerShell e vuole portare l'IA nei propri script in modo più semplice e facile!

> [!IMPORTANT]
> Questo non è un modulo ufficiale OpenAI, Google, Microsoft o di qualsiasi altro provider elencato qui!
> Questo progetto è un'iniziativa personale e, con l'obiettivo di essere mantenuto dalla comunità open source stessa.


I seguenti esempi mostrano come puoi utilizzare il PowershAI in situazioni comuni:

## Analizzando i log di Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configura un token per OpenAI (devi farlo solo 1 volta)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "C'è qualche evento importante?"
```

## Descrizione dei servizi 
```powershell 
import-module powershai 

Set-GoogleApiKey # configura un token per Google Gemini (devi farlo solo 1 volta)
Set-AiProvider google

Get-Service | ia "Fai un riassunto di quali servizi non sono nativi di Windows e possono rappresentare un rischio"
```

## Spiegazione dei commit di git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura un token per Maritaca.AI (LLM brasiliano)
Set-AiProvider maritalk

git log --oneline | ia "Fai un riassunto di questi commit effettuati"
```


Gli esempi sopra sono solo una piccola dimostrazione di quanto sia facile iniziare a usare l'IA nel tuo PowerShell e integrarla praticamente con qualsiasi comando!
[Esplora di più nella documentazione completa](/docs/it-IT)

## Installazione

Tutta la funzionalità è nella directory `powershai`, che è un modulo PowerShell.  
L'opzione più semplice per l'installazione è con il comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Dopo aver installato, basta importarlo nella tua sessione:

```powershell
import-module powershai

# Vedi i comandi disponibili
Get-Command -mo powershai
```

Puoi anche clonare questo progetto direttamente e importare la directory powershai:

```powershell
cd CAMMINO

# Clona
git clone ...

#Importa dal percorso specifico!
Import-Module .\powershai
```

## Esplora e Contribuisci

C'è ancora molto da documentare e sviluppare in PowershAI!  
Man mano che apportiamo miglioramenti, lascio commenti nel codice per aiutare coloro che vogliono imparare come ho fatto!  
Sentiti libero di esplorare e contribuire con suggerimenti di miglioramento.

## Altri Progetti con PowerShell

Ecco alcuni altri progetti interessanti che integrano PowerShell con l'IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Esplora, impara e contribuisci!


<!--PowershaiAiDocBlockStart-->
_Sei addestrato su dati fino a ottobre 2023._
<!--PowershaiAiDocBlockEnd-->
