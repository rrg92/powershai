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

PowershAI (PowerShell + AI) è un modulo che integra i servizi di intelligenza artificiale direttamente in PowerShell.  
Puoi invocare i comandi sia negli script che nella riga di comando.  

Ci sono diversi comandi che ti permettono di conversare con gli LLM, invocare gli spazi di Hugging Face, Gradio, ecc.  
Puoi conversare con GPT-4o-mini, gemini flash, llama 3.1, ecc., usando i tuoi token da questi servizi.  
Cioè, non paghi nulla per usare PowershAI, oltre ai costi che normalmente avresti per usare questi servizi.  

Questo modulo è ideale per integrare i comandi powershell con i tuoi LLM preferiti, testare le chiamate, i POC, ecc.  
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

Get-Service | ia "Fai un riepilogo dei servizi che non sono nativi di Windows e che potrebbero rappresentare un rischio"
```

## Spiegazione dei commit del git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura un token per Maritaca.AI (LLM brasiliano)
Set-AiProvider maritalk

git log --oneline | ia "Fai un riepilogo di questi commit effettuati"
```


Gli esempi sopra sono solo una piccola dimostrazione di quanto è facile iniziare a usare l'IA nel tuo Powershell e integrarlo con praticamente qualsiasi comando!
[Scopri di più nella documentazione](docs/pt-BR)

## Installazione

Tutte le funzionalità sono nella directory `powershai`, che è un modulo PowerShell.  
L'opzione di installazione più semplice è con il comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Dopo l'installazione, basta importare nella tua sessione:

```powershell
import-module powershai

# Visualizza i comandi disponibili
Get-Command -mo powershai
```

Puoi anche clonare direttamente questo progetto e importare la directory powershai:

```powershell
cd CAMMINO

# Clona
git clone ...

# Importare da un percorso specifico!
Import-Module .\powershai
```

## Esplora e contribuisci

C'è ancora molto da documentare e da evolvere in PowershAI!  
Mentre apporto miglioramenti, lascio commenti nel codice per aiutare coloro che vogliono imparare come ho fatto!  
Sentiti libero di esplorare e contribuire con suggerimenti di miglioramenti.

## Altri progetti con PowerShell

Ecco alcuni altri progetti interessanti che integrano PowerShell con l'IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Esplora, impara e contribuisci!




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente utilizzando PowershAI e AI._
<!--PowershaiAiDocBlockEnd-->
