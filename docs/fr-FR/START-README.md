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

PowershAI (PowerShell + AI) est un module qui intègre les services d'intelligence artificielle directement dans PowerShell.  
Vous pouvez appeler les commandes à la fois dans les scripts et en ligne de commande.  

Il existe plusieurs commandes qui permettent de discuter avec les LLM, d'appeler les espaces Hugging Face, Gradio, etc.  
Vous pouvez discuter avec GPT-4o-mini, gemini flash, llama 3.1, etc., en utilisant vos propres jetons de ces services.  
Cela signifie que vous ne payez rien pour utiliser PowershAI, en plus des coûts que vous auriez normalement en utilisant ces services.  

Ce module est idéal pour intégrer des commandes PowerShell avec vos LLM préférés, tester des appels, des POC, etc.  
Il est idéal pour ceux qui sont déjà familiers avec PowerShell et qui veulent apporter l'IA à leurs scripts de manière plus simple et plus facile !

Les exemples suivants montrent comment vous pouvez utiliser Powershai dans des situations courantes :

## Analyse des journaux Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configure un jeton pour OpenAI (vous devez le faire une seule fois)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Y a-t-il un événement important ?"
```

## Description des services 
```powershell 
import-module powershai 

Set-GoogleApiKey # configure un jeton pour Google Gemini (vous devez le faire une seule fois)
Set-AiProvider google

Get-Service | ia "Faites un résumé des services qui ne sont pas natifs de Windows et qui peuvent présenter un risque"
```

## Explication des commits Git 
```powershell 
import-module powershai 

Set-MaritalkToken # configure un jeton pour Maritaca.AI (LLM brésilien)
Set-AiProvider maritalk

git log --oneline | ia "Faites un résumé de ces commits effectués"
```


Les exemples ci-dessus ne sont qu'une petite démonstration de la facilité avec laquelle vous pouvez commencer à utiliser l'IA dans votre PowerShell et l'intégrer à presque toutes les commandes !
[Découvrez plus dans la documentation](docs/pt-BR)

## Installation

Toutes les fonctionnalités se trouvent dans le répertoire `powershai`, qui est un module PowerShell.  
La manière la plus simple de l'installer est d'utiliser la commande `Install-Module` :

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Après l'installation, il vous suffit de l'importer dans votre session :

```powershell
import-module powershai

# Voir les commandes disponibles
Get-Command -mo powershai
```

Vous pouvez également cloner ce projet directement et importer le répertoire powershai :

```powershell
cd CAMINHO

# Cloner
git clone ...

# Importer à partir du chemin spécifique !
Import-Module .\powershai
```

## Explorez et contribuez

Il reste beaucoup à documenter et à faire évoluer dans PowershAI !  
Au fur et à mesure que j'apporte des améliorations, je laisse des commentaires dans le code pour aider ceux qui veulent apprendre comme moi !  
N'hésitez pas à explorer et à contribuer en suggérant des améliorations.

## Autres projets avec PowerShell

Voici quelques autres projets intéressants qui intègrent PowerShell avec l'IA :

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Explorez, apprenez et contribuez !




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
