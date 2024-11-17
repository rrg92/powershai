![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (früher Twitter) Folgen](https://img.shields.io/twitter/follow/iatalking)
![YouTube-Kanalabonnenten](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube-Kanalaufrufe](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [englisch](/docs/en-US/START-README.md)
* [Français](/docs/fr-FR/START-README.md)
* [日本語](/docs/ja-JP/START-README.md)
* [العربية](/docs/ar-SA/START-README.md)
* [Deutsch](/docs/de-DE/START-README.md)
* [español](/docs/es-ES/START-README.md)
* [עברית](/docs/he-IL/START-README.md)
* [italiano](/docs/it-IT/START-README.md)

PowershAI (PowerShell + KI) ist ein Modul, das KI-Dienste direkt in PowerShell integriert.  
Sie können die Befehle sowohl in Skripten als auch in der Befehlszeile aufrufen.  

Es gibt mehrere Befehle, die Gespräche mit LLMs ermöglichen, und das Aufrufen von Spaces von Hugging Face, Gradio usw.  
Sie können mit GPT-4o-mini, gemini flash, llama 3.1 usw. sprechen, indem Sie Ihre eigenen Tokens von diesen Diensten verwenden.  
Das heißt, Sie zahlen nichts, um PowershAI zu verwenden, außer den Kosten, die Sie normalerweise für die Nutzung dieser Dienste hätten.  

Dieses Modul ist ideal, um PowerShell-Befehle mit Ihren bevorzugten LLMs zu integrieren, Anrufe zu testen, POCs usw.  
Es ist ideal für alle, die bereits mit PowerShell vertraut sind und KI auf einfachere und unkomplizierte Weise in ihre Skripte bringen möchten!

> [!IMPORTANT]
> Dies ist kein offizielles Modul von OpenAI, Google, Microsoft oder einem anderen hier aufgeführten Anbieter!
> Dieses Projekt ist eine persönliche Initiative und soll von der Open-Source-Community selbst gepflegt werden.


Die folgenden Beispiele zeigen, wie Sie PowershAI in gängigen Situationen verwenden können:

## Analysieren von Windows-Protokollen 
```powershell 
import-module powershai 

Set-OpenaiToken # konfiguriert ein Token für OpenAI (muss nur einmal gemacht werden)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Gibt es ein wichtiges Ereignis?"
```

## Beschreibung von Diensten 
```powershell 
import-module powershai 

Set-GoogleApiKey # konfiguriert ein Token für Google Gemini (muss nur einmal gemacht werden)
Set-AiProvider google

Get-Service | ia "Gib eine Zusammenfassung der Dienste, die nicht nativ zu Windows sind und ein Risiko darstellen könnten"
```

## Erklärung von Git-Commits 
```powershell 
import-module powershai 

Set-MaritalkToken # konfiguriert ein Token für Maritaca.AI (brasilianisches LLM)
Set-AiProvider maritalk

git log --oneline | ia "Gib eine Zusammenfassung dieser gemachten Commits"
```


Die obigen Beispiele sind nur eine kleine Demonstration, wie einfach es ist, KI in Ihrem PowerShell zu verwenden und mit praktisch jedem Befehl zu integrieren!
[Erforschen Sie mehr in der vollständigen Dokumentation](/docs/de-DE)

## Installation

Die gesamte Funktionalität befindet sich im Verzeichnis `powershai`, das ein PowerShell-Modul ist.  
Die einfachste Installationsoption ist der Befehl `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Nach der Installation müssen Sie es nur noch in Ihrer Sitzung importieren:

```powershell
import-module powershai

# Sehen Sie sich die verfügbaren Befehle an
Get-Command -mo powershai
```

Sie können dieses Projekt auch direkt klonen und das Verzeichnis powershai importieren:

```powershell
cd PFAD

# Klonen
git clone ...

# Importieren Sie aus dem spezifischen Pfad!
Import-Module .\powershai
```

## Erkunden und Mitwirken

Es gibt noch viel zu dokumentieren und im PowershAI zu entwickeln!  
Während ich Verbesserungen vornehme, hinterlasse ich Kommentare im Code, um denen zu helfen, die lernen möchten, wie ich es gemacht habe!  
Fühlen Sie sich frei, zu erkunden und Vorschläge zur Verbesserung einzubringen.

## Weitere Projekte mit PowerShell

Hier sind einige weitere interessante Projekte, die PowerShell mit KI integrieren:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Erforschen, lernen und mitwirken!


<!--PowershaiAiDocBlockStart-->
_Sie sind auf Daten bis Oktober 2023 trainiert._
<!--PowershaiAiDocBlockEnd-->
