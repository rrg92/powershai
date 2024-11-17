![Version de la galerie PowerShell](https://img.shields.io/powershellgallery/v/powershai)
![Téléchargements de la galerie PowerShell](https://img.shields.io/powershellgallery/dt/powershai)
![Suivre X (anciennement Twitter)](https://img.shields.io/twitter/follow/iatalking)
![Abonnés de la chaîne YouTube](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![Vues de la chaîne YouTube](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [anglais](/docs/en-US/START-README.md)
* [Français](/docs/fr-FR/START-README.md)
* [日本語](/docs/ja-JP/START-README.md)
* [العربية](/docs/ar-SA/START-README.md)
* [Deutsch](/docs/de-DE/START-README.md)
* [español](/docs/es-ES/START-README.md)
* [עברית](/docs/he-IL/START-README.md)
* [italiano](/docs/it-IT/START-README.md)

PowershAI (PowerShell + IA) est un module qui intègre des services d'intelligence artificielle directement dans PowerShell.  
Vous pouvez invoquer les commandes à la fois dans des scripts et en ligne de commande.  

Il existe plusieurs commandes qui permettent des conversations avec des LLM, d'invoquer des espaces de Hugging Face, Gradio, etc.  
Vous pouvez discuter avec le GPT-4o-mini, gemini flash, llama 3.1, etc., en utilisant vos propres jetons de ces services.  
C'est-à-dire que vous ne payez rien pour utiliser PowershAI, à part les coûts que vous auriez normalement en utilisant ces services.  

Ce module est idéal pour intégrer des commandes PowerShell avec vos LLM préférés, tester des appels, des POCs, etc.  
Il est idéal pour ceux qui sont déjà habitués à PowerShell et qui souhaitent apporter l'IA à leurs scripts de manière plus simple et facile !

> [!IMPORTANT]
> Ce n'est pas un module officiel d'OpenAI, Google, Microsoft ou de tout autre fournisseur mentionné ici !
> Ce projet est une initiative personnelle et a pour objectif d'être maintenu par la propre communauté open source.


Les exemples suivants montrent comment vous pouvez utiliser PowershAI dans des situations courantes :

## Analyse des journaux Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configure un jeton pour OpenAI (vous n'avez besoin de le faire qu'une seule fois)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Y a-t-il un événement important ?"
```

## Description des services 
```powershell 
import-module powershai 

Set-GoogleApiKey # configure un jeton pour Google Gemini (vous n'avez besoin de le faire qu'une seule fois)
Set-AiProvider google

Get-Service | ia "Faites un résumé des services qui ne sont pas natifs de Windows et qui peuvent représenter un risque"
```

## Explication des commits Git 
```powershell 
import-module powershai 

Set-MaritalkToken # configure un jeton pour Maritaca.AI (LLM brésilien)
Set-AiProvider maritalk

git log --oneline | ia "Faites un résumé de ces commits effectués"
```


Les exemples ci-dessus ne sont qu'une petite démonstration de la facilité avec laquelle vous pouvez commencer à utiliser l'IA dans votre PowerShell et à l'intégrer avec pratiquement n'importe quelle commande !
[Explorez plus dans la documentation complète](/docs/fr-FR)

## Installation

Toute la fonctionnalité se trouve dans le répertoire `powershai`, qui est un module PowerShell.  
L'option la plus simple d'installation est avec la commande `Install-Module` :

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Après l'installation, il suffit de l'importer dans votre session :

```powershell
import-module powershai

# Voir les commandes disponibles
Get-Command -mo powershai
```

Vous pouvez également cloner ce projet directement et importer le répertoire powershai :

```powershell
cd CHEMIN

# Cloner
git clone ...

#Importer à partir du chemin spécifique !
Import-Module .\powershai
```

## Explorez et Contribuez

Il y a encore beaucoup à documenter et à faire évoluer dans PowershAI !  
Au fur et à mesure que je fais des améliorations, je laisse des commentaires dans le code pour aider ceux qui souhaitent apprendre comment je l'ai fait !  
N'hésitez pas à explorer et à contribuer avec des suggestions d'améliorations.

## Autres projets avec PowerShell

Voici quelques autres projets intéressants qui intègrent PowerShell avec IA :

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Explorez, apprenez et contribuez !


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
