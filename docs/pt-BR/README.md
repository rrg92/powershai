# Powershai

# SHORT DESCRIPTION

PowershAI (Powershell + AI) é um modulo que adiciona acesso a IA através do Powershell

# LONG DESCRIPTION

O PowershAI é um módulo que adiciona recursos de IA a sua sessão do Powershell.  
O objetivo é facilitar e encapsular chamadas e tratamentos complexos paras as APIs dos principais serviços de IA existentes.  

O PowershAI define um conjunto de padrões que permitem que o usuário converse com LLMs, direto do prompt, ou que use o resultado de comandos como contexto em um prompt.  
E, através de um conjunto padronizado de funções, diferentes provedores podem ser usados: Por exemplo, você pode conversar com o GPT-4o ou o Gemini Flash usando exatamente o mesmo código.  

Além dessa padroinização, o PowershAI também expoe as funcoes internas e específicas para conexão com os diferentes provedores de serviços de IA.  
Com isso, você pode customizar e criar scrips que utilizem recursos específicos dessas APIs.  

A arquitetura do PowershAI define o conceito de "provider" que são arquivos que implementam todos os detalhes necessários para conversar com suas respectivas APIs.  
Novos providers podem ser adicionados, com novas funcionalidades, a medida que se torem disponíoveis.  

No final, você tem diversas opções de começar a usar IA nos seus scripts. 

Exemplos de providers famosos que já estão implementandos completa ou parcialmente:

- OpenAI 
- Hugging Face 
- Gemini 
- Ollama
- Maritalk (LLM brasileiro)

Para começar a usar o PowershAI é bem simples:

```powershell 
# Instale o modulo!
Install-Module -Scope CurrentUser powershai 

# Importe!
import-module powershai

# Lista de providers 
Get-AiProviders

# Você deve consultar a documentação de cada provider para detalhes de como usá-lo!
# A documentação pode ser acessada usando get-help 
Get-Help about_NomeProvider

# Exemplo:
Get-Help about_huggingface
```

## Estrutura de comandos  

O PowershAI exporta diversos comandos que podem ser usados.  
A maioria desses comandos possuem "Ai" ou "Powershai". 
Chamamos estes comandos de `comandos globais` do Powershai, pois não são comandos para um provider específico.

Por exemplo: `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Os providers também exportam comandos, que geralmente terão um nome do provider. Consulte a documentação do provider para saber mais sobre o padrão de comandos exportado.  

Por convenção,  nenhum provider deve implementar comandos com "Ai" ou "Powershai" no nome, pois são reservados aos comandos globais, independente de provider.  
Também, os alias definidos pelos providers devem sempre conter mais de 5 caractares. Alias menores estão reservados para os comandos globais.

Você pode encontrar a documentação destes comandos na [doc de comandos globais](cmdlets/).  
Você podem pode usar o comando Get-PowershaiGlobalCommands para obter a lista!

## Documentação dos Providers  

A [documentação de providers](providers) é o local oficial para obter ajuda sobre o funcionamento de cada provider.  
Essa documentação também pode ser acessada através do comando `Get-Help` do powershell.  

A documentação de providers é sempre disponibilizada via help `about_Powershai_NomeProvider_Topico`.  
O tópico `about_Powershai_NomeProvider` é o ponto de partida e deve sempre conter as informações inicais para os primeiros usos, bem como as explicações para o correto uso dos demais tópicos.  

# EXAMPLES

## Uso básico 

Usar o PowershAI é muito simples. O exemplo abaixo mostra como você pode usar com a OpenAI:

```powershell 
# Altere o provider atual para OpenAI
Set-AiProvider openai 

# Configure o token de autenticação (Você deve gerar o token no site platform.openai.com)
Set-OpenaiToken 

# Use um dos comandos para inciar um chat!  ia é um alias para Send-PowershaiChat, que envia uma mensagem no chat default!
ia "Olá, estou falando do Powershaui com você!"
```


# NOTE

O PowershAI possui uma gama de comandos disponóveis.  
Cada provider fornece uma série de comandos com uma padrão de nomenclatura.  
Você sempre deve ler a documentação do provider para obter mais detalhes de como usá-lo.  

# TROUBLESHOOTING NOTE

Apesar de possuir bastante código e ter já bastante funcionalidade, o PowershAI é um projeto novo, que está sendo desenvolvido.  
Alguns bugs podem ser encontrados e, nesta fase, é importante que você sempre ajude reportando, através de issues, no repositório oficial em https://github.com/rrg92/powershai  

Se você quiser fazer o troubleshooting de um problema, recomendo seguir estas etapas:

- Utilize o Debug para te ajudar. Comandos como Set-PSBreakpoint são simples de invocar na linha de comando e podem te ajudar a econimizar tempo
- Algumas funcoes não exibem o erro completo. Você pode usar a variável $error, e acessar o último. Por exemplo:  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # Isso ajua a encontrar a linha exada onde a exception ocorreu!
```

# SEE ALSO

- Vídeo sobre Como usar o Provider do Hugging Face: https://www.youtube.com/watch?v=DOWb8MTS5iU
- Veja a doc de cada provider para mais detalhes sobre como usar os seus cmdlets

# KEYWORDS

- Inteligência Artificial
- IA


