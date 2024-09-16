![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [english](docs/en-US/START-README.md)
* [Français](docs/fr-FR/START-README.md)
* [日本語](docs/ja-JP/START-README.md)
* [العربية](docs/ar-SA/START-README.md)
* [Deutsch](docs/de-DE/START-README.md)
* [español](docs/es-ES/START-README.md)
* [עברית](docs/he-IL/START-README.md)
* [italiano](docs/it-IT/START-README.md)

PowershAI (PowerShell + AI) è un modulo che integra i servizi di intelligenza artificiale direttamente in PowerShell.  
Puoi invocare i comandi sia negli script che nella riga di comando.  

Esistono diversi comandi che consentono conversazioni con LLMs, invocazione di spazi di Hugging Face, Gradio, ecc.  
Puoi conversare con GPT-4o-mini, gemini flash, llama 3.1, ecc. usando i tuoi token di questi servizi.  
Cioè, non paghi nulla per usare PowershAI, oltre ai costi che normalmente avresti usando questi servizi.  

Questo modulo è ideale per integrare i comandi di PowerShell con i tuoi LLM preferiti, testare chiamate, poc, ecc.  
È ideale per chi ha già familiarità con PowerShell e vuole portare l'IA nei suoi script in modo più semplice e facile!

I seguenti esempi mostrano come puoi usare Powershai in situazioni comuni:

## Analisi dei log di Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configura un token per OpenAI (devi farlo solo 1x)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Qualche evento importante?"
```

## Descrizione dei servizi 
```powershell 
import-module powershai 

Set-GoogleApiKey # configura un token per Google Gemini (devi farlo solo 1x)
Set-AiProvider google

Get-Service | ia "Fai un riepilogo di quali servizi non sono nativi di Windows e potrebbero rappresentare un rischio"
```

## Spiegazione dei commit di git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura un token per Maritaca.AI (LLM brasiliano)
Set-AiProvider maritalk

git log --oneline | ia "Fai un riepilogo di questi commit effettuati"
```


Gli esempi sopra sono solo una piccola dimostrazione di quanto è facile iniziare a usare l'IA nel tuo Powershell e integrarla con praticamente qualsiasi comando!
[Esplora di più nella documentazione](docs/pt-BR)

## Installazione

Tutta la funzionalità si trova nella directory `powershai`, che è un modulo PowerShell.  
L'opzione più semplice di installazione è con il comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Dopo l'installazione, basta importarlo nella tua sessione:

```powershell
import-module powershai

# Guarda i comandi disponibili
Get-Command -mo powershai
```

Puoi anche clonare questo progetto direttamente e importare la directory powershai:

```powershell
cd PATH

# Clona
git clone ...

#Importa dal percorso specifico!
Import-Module .\powershai
```

## Esplora e Contribuisci

C'è ancora molto da documentare e far evolvere in PowershAI!  
Mentre apporto miglioramenti, lascio commenti nel codice per aiutare coloro che vogliono imparare come ho fatto!  
Sentiti libero di esplorare e contribuire con suggerimenti di miglioramento.

## Altri Progetti con PowerShell

Ecco alcuni altri progetti interessanti che integrano PowerShell con l'IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Esplora, impara e contribuisci!




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
