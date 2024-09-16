![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [english](docs/en-US/START-README.md)
* [Français](docs/fr-FR/START-README.md)
* [日本語](docs/ja-JP/START-README.md)
* [العربية](docs/sa-SA/START-README.md)

PowershAI (PowerShell + AI) è un modulo che integra i servizi di intelligenza artificiale direttamente in PowerShell.  
Puoi invocare i comandi sia negli script che nella riga di comando.  

Esistono diversi comandi che consentono conversazioni con LLMs, invocando gli spazi di Hugging Face, Gradio, ecc.  
Puoi conversare con GPT-4o-mini, gemini flash, llama 3.1, ecc., utilizzando i tuoi token di questi servizi.  
Cioè, non paghi nulla per utilizzare PowershAI, oltre ai costi che avresti normalmente utilizzando questi servizi.  

Questo modulo è ideale per integrare i comandi powershell con i tuoi LLM preferiti, testare le chiamate, pocs, ecc.  
È ideale per chi ha già familiarità con PowerShell e vuole portare l'IA nei propri script in modo più semplice e facile!

I seguenti esempi mostrano come puoi utilizzare Powershai in situazioni comuni:

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

Get-Service | ia "Fai un riepilogo di quali servizi non sono nativi di Windows e possono rappresentare un rischio"
```

## Spiegazione dei commit di git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura un token per Maritaca.AI (LLM brasiliano)
Set-AiProvider maritalk

git log --oneline | ia "Fai un riepilogo di questi commit eseguiti"
```


Gli esempi precedenti sono solo una piccola dimostrazione di quanto sia facile iniziare a utilizzare l'IA nel tuo Powershell e integrarla con praticamente qualsiasi comando!
[Scopri di più nella documentazione](docs/pt-BR)

## Installazione

Tutte le funzionalità si trovano nella directory `powershai`, che è un modulo PowerShell.  
L'opzione di installazione più semplice è con il comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Dopo l'installazione, è sufficiente importarlo nella sessione:

```powershell
import-module powershai

# Guarda i comandi disponibili
Get-Command -mo powershai
```

Puoi anche clonare questo progetto direttamente e importare la directory powershai:

```powershell
cd CAMMINO

# Clona
git clone ...

#Importare da un percorso specifico!
Import-Module .\powershai
```

## Esplora e contribuisci

C'è ancora molto da documentare e far evolvere in PowershAI!  
Man mano che apporto miglioramenti, lascio commenti nel codice per aiutare coloro che vogliono imparare come ho fatto!  
Sentiti libero di esplorare e contribuire con suggerimenti per miglioramenti.

## Altri progetti con PowerShell

Ecco alcuni altri progetti interessanti che integrano PowerShell con l'IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Esplora, impara e contribuisci!




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
