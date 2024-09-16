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

PowershAI (PowerShell + AI) ist ein Modul, das KI-Dienste direkt in PowerShell integriert.  
Sie können die Befehle sowohl in Skripten als auch in der Befehlszeile aufrufen.  

Es gibt verschiedene Befehle, mit denen Sie mit LLMs konvertieren, Hugging Face Spaces, Gradio usw. aufrufen können.  
Sie können mit GPT-4o-mini, gemini flash, llama 3.1 usw. mithilfe Ihrer eigenen Token dieser Dienste chatten.  
Das heißt, Sie zahlen nichts für die Nutzung von PowershAI, außer den Kosten, die Sie normalerweise bei der Nutzung dieser Dienste haben.  

Dieses Modul ist ideal für die Integration von Powershell-Befehlen in Ihre bevorzugten LLMs, zum Testen von Aufrufen, PoCs usw.  
Es ist ideal für alle, die mit PowerShell vertraut sind und KI auf einfachere und einfachere Weise in ihre Skripte einbringen möchten!

Die folgenden Beispiele zeigen, wie Sie Powershai in gängigen Situationen verwenden können:

## Analyse von Windows-Protokollen 
```powershell 
import-module powershai 

Set-OpenaiToken # konfiguriert ein Token für OpenAI (nur 1x erforderlich)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Gibt es ein wichtiges Ereignis?"
```

## Beschreibung von Diensten 
```powershell 
import-module powershai 

Set-GoogleApiKey # konfiguriert ein Token für Google Gemini (nur 1x erforderlich)
Set-AiProvider google

Get-Service | ia "Fassen Sie zusammen, welche Dienste nicht nativ in Windows sind und ein Risiko darstellen könnten"
```

## Erklärung von Git-Commits 
```powershell 
import-module powershai 

Set-MaritalkToken # konfiguriert ein Token für Maritaca.AI (brasilianisches LLM)
Set-AiProvider maritalk

git log --oneline | ia "Fassen Sie diese Commits zusammen"
```


Die obigen Beispiele sind nur eine kleine Demonstration, wie einfach es ist, mit der Verwendung von KI in Ihrem Powershell zu beginnen und es in fast jeden Befehl zu integrieren!
[Weitere Informationen finden Sie in der vollständigen Dokumentation](/docs/de-DE)

## Installation

Die gesamte Funktionalität befindet sich im Verzeichnis `powershai`, das ein PowerShell-Modul ist.  
Die einfachste Installationsmöglichkeit ist der Befehl `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Nach der Installation müssen Sie es nur noch in Ihre Sitzung importieren:

```powershell
import-module powershai

# Zeigen Sie die verfügbaren Befehle an
Get-Command -mo powershai
```

Sie können dieses Projekt auch direkt klonen und das Verzeichnis powershai importieren:

```powershell
cd PATH

# Klonen
git clone ...

# Importieren Sie vom spezifischen Pfad!
Import-Module .\powershai
```

## Erkunden und Mitwirken

Es gibt noch viel zu dokumentieren und weiterzuentwickeln im PowershAI!  
Während ich Verbesserungen vornehme, hinterlasse ich Kommentare im Code, um denen zu helfen, die lernen wollen, wie ich es gemacht habe!  
Zögern Sie nicht, zu erkunden und mit Verbesserungsvorschlägen beizutragen.

## Weitere Projekte mit PowerShell

Hier sind einige weitere interessante Projekte, die PowerShell mit KI integrieren:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Erkunden, lernen und mitwirken!




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI_
<!--PowershaiAiDocBlockEnd-->
