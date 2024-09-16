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

PowershAI (PowerShell + AI) es un módulo que integra servicios de Inteligencia Artificial directamente en PowerShell.  
Puedes invocar los comandos tanto en scripts como en la línea de comandos.  

Hay varios comandos que te permiten conversar con LLMs, invocar espacios de Hugging Face, Gradio, etc.  
Puedes conversar con GPT-4o-mini, gemini flash, llama 3.1, etc., usando tus propios tokens de estos servicios.  
Esto es, no pagas nada por usar PowershAI, además de los costos que ya tendrías normalmente al usar estos servicios.  

Este módulo es ideal para integrar comandos powershell con tus LLMs favoritos, probar llamadas, POCs, etc.  
¡Es ideal para aquellos que ya están acostumbrados a PowerShell y quieren traer la IA a sus scripts de una manera más simple y fácil!

Los siguientes ejemplos muestran cómo puedes usar Powershai en situaciones comunes:

## Analizando logs del Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configura un token para OpenAI (solo necesitas hacerlo 1x)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Algún evento importante?"
```

## Descripción de servicios 
```powershell 
import-module powershai 

Set-GoogleApiKey # configura un token para Google Gemini (solo necesitas hacerlo 1x)
Set-AiProvider google

Get-Service | ia "Haz un resumen de qué servicios no son nativos de Windows y pueden representar un riesgo"
```

## Explicación commits del git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura un token para Maritaca.AI (LLM brasileño)
Set-AiProvider maritalk

git log --oneline | ia "Haz un resumen de estos commits realizados"
```


Los ejemplos anteriores son solo una pequeña demostración de lo fácil que es empezar a usar IA en tu Powershell e integrarlo con prácticamente cualquier comando.
[Explora más en la documentación](docs/pt-BR)

## Instalación

Toda la funcionalidad está en el directorio `powershai`, que es un módulo PowerShell.  
La opción más simple de instalación es con el comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Después de instalar, solo tienes que importarlo en tu sesión:

```powershell
import-module powershai

# Ver los comandos disponibles
Get-Command -mo powershai
```

También puedes clonar este proyecto directamente e importar el directorio powershai:

```powershell
cd CAMINO

# Clonar
git clone ...

# Importar desde la ruta específica!
Import-Module .\powershai
```

## Explora y Contribuye

¡Todavía hay mucho que documentar y evolucionar en PowershAI!  
A medida que hago mejoras, dejo comentarios en el código para ayudar a aquellos que quieren aprender cómo lo hice!  
Siéntete libre de explorar y contribuir con sugerencias de mejora.

## Otros Proyectos con PowerShell

Aquí hay algunos otros proyectos interesantes que integran PowerShell con IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

¡Explora, aprende y contribuye!




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
