![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)



# PowershAI

[english](docs/en-US)

PowershAI (PowerShell + AI) é um módulo que integra serviços de Inteligência Artificial diretamente no PowerShell.  
Você pode invocar os comandos tanto em scripts quanto na linha de comando.  

Existem vários comandos que permitem conversas com LLMs, invocar spaces do Hugging Face, Gradio, etc.  
Você pode conversar com o GPT-4o-mini, gemini flash, llama 3.1, etc, usando seus próprios tokens destes serviço.  
Isso é, você não paga nada pra usar o PowershAI, além dos custos que você já teria normlamente ao usar esses serviços.  

Este módulo é ideal para integrar comandos powershell com seus LLM favoritos, testar chamadas, pocs, etc.  
É ideal para quem já está acostumado com o PowerShell e quer trazer a IA pro seus scripts de uma maneira mais simples e fácil!

Os seguintes exemplos mostram como você pode o Powershai em situações comuns:

## Analisando logs do Windows 
```powershell 
import-module powershai 

Set-OpenaiToken # configura um token para OpenAI (precisa fazer isso apenas 1x)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "Algum evento importante?"
```

## Descrição de serviços 
```powershell 
import-module powershai 

Set-GoogleApiKey # configura um token para o Google Gemini (precisa fazer isso apenas 1x)
Set-AiProvider google

Get-Service | ia "Faça um resumo de quais serviços não são nativos do Windows e podem representar um risco"
```

## Explicação commits do git 
```powershell 
import-module powershai 

Set-MaritalkToken # configura um token para Maritaca.AI (LLM brasileiro)
Set-AiProvider maritalk

git log --oneline | ia "Faça um resumo desses commits feitos"
```


Os exemplos acima são apenas uma pequena demonstração de como é fácil começar a usar IA no seu Powershell e integrar com praticamente qualquer comando!
[Explore mais na documentação](docs/pt-BR)

## Instalação

Toda a funcionalidade está no diretório `powershai`, que é um módulo PowerShell.  
A opção mais simples de instalação é com o comando `Install-Module`:

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

Após instalar, basta importar na sua sessão:

```powershell
import-module powershai

# Veja os comandos disponiveis
Get-Command -mo powershai
```

Você também pode clonar esse projeto diretamente e importar o diretório powershai:

```powershell
cd CAMINHO

# Clona
git clone ...

#Importar a partir do caminho específico!
Import-Module .\powershai
```

## Explore e Contribua

Ainda há muito a documentar e evoluir no PowershAI!  
À medida que faço melhorias, deixo comentários no código para ajudar aqueles que querem aprender como eu fiz!  
Sinta-se à vontade para explorar e contribuir com sugestões de melhorias.

## Outros Projetos com PowerShell

Aqui estão alguns outros projetos interessantes que integram PowerShell com IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

Explore, aprenda e contribua!