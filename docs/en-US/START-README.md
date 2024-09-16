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

PowershAI (PowerShell + AI) is a module that integrates Artificial Intelligence services directly into PowerShell.  
You can invoke the commands both in scripts and on the command line.  

There are several commands that allow conversations with LLMs, invoke spaces from Hugging Face, Gradio, etc.  
You can chat with GPT-4o-mini, gemini flash, llama 3.1, etc, using your own tokens from these services.  
That is, you don't pay anything to use PowershAI, besides the costs you would normally have when using these services.  

This module is ideal for integrating powershell commands with your favorite LLMs, testing calls, pocs, etc.  
It is ideal for those who are already familiar with PowerShell and want to bring AI to their scripts in a simpler and easier way!

The following examples show how you can use Powershai in common situations:

## Analyzing Windows logs 
```powershell 
import-module powershai 

Set-OpenaiToken # configures a token for OpenAI (you only need to do this once)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Is there any important event?"
```

## Description of services 
```powershell 
import-module powershai 

Set-GoogleApiKey # configures a token for Google Gemini (you only need to do this once)
Set-AiProvider google

Get-Service | ia "Summarize which services are not native to Windows and may pose a risk"
```

## Explaining git commits 
```powershell 
import-module powershai 

Set-MaritalkToken # configures a token for Maritaca.AI (Brazilian LLM)
Set-AiProvider maritalk

git log --oneline | ia "Summarize these commits made"
```


The examples above are just a small demonstration of how easy it is to start using AI in your Powershell and integrate with virtually any command!
[Explore more in the documentation](docs/pt-BR)

## Installation

All functionality is in the `powershai` directory, which is a PowerShell module.  
The simplest installation option is with the `Install-Module` command:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

After installing, just import it into your session:

```powershell
import-module powershai

# See the available commands
Get-Command -mo powershai
```

You can also clone this project directly and import the powershai directory:

```powershell
cd PATH

# Clone
git clone ...

#Import from the specific path!
Import-Module .\powershai
```

## Explore and Contribute

There is still much to document and evolve in PowershAI!  
As I make improvements, I leave comments in the code to help those who want to learn how I did it!  
Feel free to explore and contribute with suggestions for improvements.

## Other Projects with PowerShell

Here are some other interesting projects that integrate PowerShell with AI:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Explore, learn and contribute!




<!--PowershaiAiDocBlockStart-->
_Translated automatically using PowershAI and AI 
_
<!--PowershaiAiDocBlockEnd-->
