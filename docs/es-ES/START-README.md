![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (anteriormente Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [inglés](/docs/en-US/START-README.md)
* [Français](/docs/fr-FR/START-README.md)
* [日本語](/docs/ja-JP/START-README.md)
* [العربية](/docs/ar-SA/START-README.md)
* [Deutsch](/docs/de-DE/START-README.md)
* [español](/docs/es-ES/START-README.md)
* [עברית](/docs/he-IL/START-README.md)
* [italiano](/docs/it-IT/START-README.md)

PowershAI (PowerShell + AI) es un módulo que integra servicios de Inteligencia Artificial directamente en PowerShell.  
Puedes invocar los comandos tanto en scripts como en la línea de comandos.  

Existen varios comandos que permiten conversaciones con LLMs, invocar spaces de Hugging Face, Gradio, etc.  
Puedes conversar con el GPT-4o-mini, gemini flash, llama 3.1, etc., usando tus propios tokens de estos servicios.  
Es decir, no pagas nada por usar PowershAI, además de los costos que ya tendrías normalmente al usar estos servicios.  

Este módulo es ideal para integrar comandos de PowerShell con tus LLM favoritos, probar llamadas, pocs, etc.  
Es ideal para quienes ya están acostumbrados a PowerShell y quieren llevar la IA a sus scripts de una manera más simple y fácil!

> [!IMPORTANT]
> ¡Este no es un módulo oficial de OpenAI, Google, Microsoft o de cualquier otro proveedor listado aquí!
> Este proyecto es una iniciativa personal y, con el objetivo de ser mantenido por la propia comunidad de código abierto.


Los siguientes ejemplos muestran cómo puedes usar PowershAI en situaciones comunes:

## Analizando logs de Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configura un token para OpenAI (necesitas hacer esto solo 1 vez)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "¿Algún evento importante?"
```

## Descripción de servicios 
```powershell 
import-module powershai 

Set-GoogleApiKey # configura un token para Google Gemini (necesitas hacer esto solo 1 vez)
Set-AiProvider google

Get-Service | ia "Haz un resumen de cuáles servicios no son nativos de Windows y pueden representar un riesgo"
```

## Explicación de commits de git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura un token para Maritaca.AI (LLM brasileño)
Set-AiProvider maritalk

git log --oneline | ia "Haz un resumen de estos commits realizados"
```


Los ejemplos anteriores son solo una pequeña demostración de lo fácil que es comenzar a usar IA en tu PowerShell e integrar prácticamente cualquier comando!
[Explora más en la documentación completa](/docs/es-ES)

## Instalación

Toda la funcionalidad está en el directorio `powershai`, que es un módulo de PowerShell.  
La opción más simple de instalación es con el comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Después de instalar, solo importa en tu sesión:

```powershell
import-module powershai

# Ve los comandos disponibles
Get-Command -mo powershai
```

También puedes clonar este proyecto directamente e importar el directorio powershai:

```powershell
cd RUTA

# Clona
git clone ...

# Importar desde la ruta específica!
Import-Module .\powershai
```

## Explora y Contribuye

¡Aún hay mucho que documentar y evolucionar en PowershAI!  
A medida que hago mejoras, dejo comentarios en el código para ayudar a aquellos que quieren aprender cómo lo hice.  
¡Siéntete libre de explorar y contribuir con sugerencias de mejoras!

## Otros Proyectos con PowerShell

Aquí hay algunos otros proyectos interesantes que integran PowerShell con IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

¡Explora, aprende y contribuye!


<!--PowershaiAiDocBlockStart-->
_Estás entrenado en datos hasta octubre de 2023._
<!--PowershaiAiDocBlockEnd-->
