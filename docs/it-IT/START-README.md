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

PowershAI (PowerShell + AI) è un modulo che integra i servizi di Intelligenza Artificiale direttamente in PowerShell.  
È possibile invocare i comandi sia negli script che nella riga di comando.  

Esistono diversi comandi che consentono conversazioni con LLMs, invocare spazi di Hugging Face, Gradio, ecc.  
È possibile conversare con GPT-4o-mini, gemini flash, llama 3.1, ecc., utilizzando i propri token di questi servizi.  
Questo significa che non si paga nulla per utilizzare PowershAI, oltre ai costi che si avrebbero normalmente utilizzando questi servizi.  

Questo modulo è ideale per integrare i comandi di PowerShell con i propri LLM preferiti, testare chiamate, pocs, ecc.  
È ideale per chi ha già familiarità con PowerShell e desidera portare l'IA nei propri script in modo più semplice e facile!

I seguenti esempi mostrano come è possibile utilizzare Powershai in situazioni comuni:

## Analisi dei log di Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configura un token per OpenAI (è necessario farlo solo 1x)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Qualche evento importante?"
```

## Descrizione dei servizi 
```powershell 
import-module powershai 

Set-GoogleApiKey # configura un token per Google Gemini (è necessario farlo solo 1x)
Set-AiProvider google

Get-Service | ia "Fai un riepilogo dei servizi che non sono nativi di Windows e che potrebbero rappresentare un rischio"
```

## Spiegazione dei commit di git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura un token per Maritaca.AI (LLM brasiliano)
Set-AiProvider maritalk

git log --oneline | ia "Fai un riepilogo di questi commit effettuati"
```


Gli esempi precedenti sono solo una piccola dimostrazione di quanto è facile iniziare a utilizzare l'IA nel proprio Powershell e integrarla con praticamente qualsiasi comando!
[Scopri di più nella documentazione completa](/docs/it-IT)

## Installazione

Tutta la funzionalità si trova nella directory `powershai`, che è un modulo PowerShell.  
L'opzione di installazione più semplice è con il comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Dopo l'installazione, è sufficiente importare nella sessione:

```powershell
import-module powershai

# Visualizza i comandi disponibili
Get-Command -mo powershai
```

È anche possibile clonare questo progetto direttamente e importare la directory powershai:

```powershell
cd PERCORSO

# Clona
git clone ...

# Importa dal percorso specifico!
Import-Module .\powershai
```

## Esplora e contribuisci

C'è ancora molto da documentare e far evolvere in PowershAI!  
Man mano che apporto miglioramenti, lascio commenti nel codice per aiutare coloro che vogliono imparare come ho fatto!  
Sentiti libero di esplorare e contribuire con suggerimenti di miglioramento.

## Altri progetti con PowerShell

Ecco alcuni altri progetti interessanti che integrano PowerShell con l'IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Esplora, impara e contribuisci!




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente utilizzando PowershAI e IA_
<!--PowershaiAiDocBlockEnd-->
