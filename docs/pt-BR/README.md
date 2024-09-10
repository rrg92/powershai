# Powershai

# RESUMO <!--! @#Short --> 

PowershAI (Powershell + AI) é um modulo que adiciona acesso a IA através do Powershell

# DETALHES  <!--! @#Long --> 

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

## Obtendo Ajuda  

Apesar do esforço para documentar o PowershAI ao máximo, muito provavelmente não iremos conseguir a tempo criar toda a documentação necessária para esclarecer as dúdivas, ou mesmo falar de todos os comandos disponíveis.  Por isso, é importante que você saiba fazer um básico disso sozinho. 

Você pode listar todos os comandos disponíveis quando o comando `Get-Command -mo powershai`.  
Este comando vai retornar todos os cmdlets, alias e funções exportadas do módulo powerhsai.  
Ele é o ponto de partida mais fácil para descobrir quais comandos. Muitos comandos são auto-explicativos, apenas olhando o nome.  

E, para cada comando, você pode obter mais detalhes usando `Get-Help -Full NomeComando`.
Caso ainda o comando não tenha uma documentação completa, ou alguma dúvida que você precisa esteja faltando, você pode abrir uma issue no git solicitando mais complemento.  

Por fim, você pode explorar o código-fonte do PowershAI, procurando por comentários deixados ao longo do código, que podem explicar alguma funcionamento ou arquitetura, de forma mais técnica.  

Nós iremos atualizando a documentação a medida que novas versões são lançadas.
Encourajamos você a contribuir para o PowershAI, submetendo Pull Requsts ou issues com melhorias na documentação caso encontre algo que possa ser melhor explicado, ou que ainda não foi explicado.  


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


## Chats  

Os Chats são o principal ponto de partida e permitem que você converse com os vários LLM disponibilizados pelos providers.  
Veja o documento [chats](CHATS.about.md) para mais detalhes. A seguir, uma introdução rápida aos chats.

### Conversando com o modelo

Uma vez que a configuração inicial do provider está feita, você pode iniciar a conversa!  
A maneira mais fácil de iniciar a conversa é usando o comando `Send-PowershaiChat` ou o alias `ia`:

```powershell
ia "Olá, você conhece PowerShell?"
```

Este comando vai enviar a mensagem pro modelo do provider que foi configurado e a resposta será exibida em seguida.  
Note que o tempo de resposta depende da capacidade do modelo e da rede.  

Você pode usar o pipeline para jogar o resultado de outros comandos diretamente como contexto da ia:

```powershell
1..100 | Get-Random -count 10 | ia "Me fale curiosidades sobre esses números"
```  
O comando acima vai gerar uma sequencia de 1 a 100 e jogar cada número no pipeline do PowerShell.  
Então, o comando Get-Random vai filtrar somente 10 desses números, aleatoriamente.  
E por fim, essa sequencia será jogada (toda de uma vez) para a ia e será enviada com a mensagem que colocou no parâmetro.  

Você pode usar o parâmetro `-ForEach` para que a ia processe cada input por vez, por exemplo:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Me fale curiosidades sobre esses números"
```  

A diferença deste comando acima, é que a IA será chamada 10x, um para cada número.  
No exemplo anterior, ela será chamada apenas 1x, com todos os 10 números.  
A vantagem de usar esse método é reduzir o contexto, mas pode demorar mais tempo, pois mais requisições serão feitas.  
Testes conforme suas necessidades!

### Modo objeto  

Por padrão, o comando `ia` não retorna nada. Mas você pode alterar esse comportamento usando o parâmetro `-Object`.  
Quando este parâmetro é ativado, ele pede ao LLM que gere o resultado em JSON e escreve o retorno de volta no pipeline.  
ISso significa, que você pode fazer algo assim:

```powershell
ia -Obj "5 numeros aleatorios, com seu valor escrito por extenso"

#ou usando o alias, io/powershellgallery/dt/powershai

io "5 numeros aleatorios, com seu valor escrito por extenso"
```  

**IMPORTANTE: Note que nem todo provider pode suportar este modo, pois o modelo precisa ser capaz de suportar JSON! Caso receba erros, confirme se o mesmo comando funciona com um modelo da OpenAI. VocÇe pode abrir uma issue também**


## Salvando configurações  

O PowershAI permite ajustar uma série de configurações, como parâmetros de chats, tokens de autenticação, etc.  
Sempre que você altera uma configuração, esta configuração é salva apenas na memória da sua sessão do Powershell.  
Se você fechar, e abrir novamente, todas as configurações feitas serão perdidas.  

Para que você não precise ficar gerando tokens toda vez, por exemplo, o Powershai fornece 2 comandos para exportar e importar configurações.  
O comando `Export-PowershaiSettings`  exporta as configurações para um arquivo no diretório profile do usuário logado.  
Devido ao fato de que os dados exportados podem ser sensíveis, você precisa informar uma senha, que será usada para gerar um chave de criptografia.  
Os dados exportados são criptografados usando AES-256.  
Você pode importar usando `Import-PowershaiSettings`. Você terá que fornecer a senha que usou para exportar.  

Note que esta senha não é armazenada em local nenhum, então, você é o responsável por memorizá-la ou guardar em um cofre de sua escolha.

## Custos  

É importante lembrar que alguns providers podem cobrar pelos serviços usados.  
O PowershAI não faz nenhum gerenciamento de custo.  Ele pode injetar dados em prompts, parâmetros, etc.  
Você deve fazer o acompanhamento usando as ferramentas que o site do provider fornece para tal.  

Futuras versões podem incluir comandos ou parâmetros que ajudem a controlar melhor, mas, por enquanto, o usuário deve monitorar.  



### Export e Import  de Configurações e Tokens

Para facilitar o reuso dos dados (tokens, default models, histórico de chats, etc.) o PowershAI permite que você exporte a sessão.  
Para isso, use o comando `Export-PowershaiSettings`. Você vai precisar fornecer uma senha, que será usada para criar um chave e criptografar esse arquivo.  
Somente com essa senha, você consegue importá-lo novamente. Para importar, use o comando `Import-PowershaiSettings`.  
Por padrão, os Chats não exportados. Para exportá-los, você pode adicionar o parâmetro -Chats: `Export-PowershaiSettings -Chats`.  
Note que isso pode deixar o arquivo maior, além de aumentar o tempo de export/import.  A vantagem é que você consegue continuar a conversa entre diferentes sessões.  
Essa funcionalidade foi criada originalmente com o intuito de evitar ter que ficar gerando Api Key toda vez que precisasse usar o PowershAI. Com ela, você gera 1 vez suas api keys em cada provider, e exporta a medida que atualiza. Como está protegido por senha, você pode deixar salvo tranquilamente em um arquivo no seu computador.  
Use a ajuda no comando para obter mais informacoes de como usá-lo.


# EXEMPLOS <!--! @#Ex -->

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

## Exportando configurações 


```powershell 
# defina algum token, por exemplo 
Set-OpenaiToken 

# Após o coando acima rodar, basta exportar!
Export-PowershaiSettings

# Você terá que fornecer a senha!
```

## Importando configurações 


```powershell 
import-module powershai 

# Importe as configuraçoes 
Import-PowershaiSettings # O comando irá pedir a senha usada na exportacao
```

# Informaçoes Importantes <!--! @#Note -->

O PowershAI possui uma gama de comandos disponóveis.  
Cada provider fornece uma série de comandos com uma padrão de nomenclatura.  
Você sempre deve ler a documentação do provider para obter mais detalhes de como usá-lo.  

# Solução de problemas <!--! @#Troub -->

Apesar de possuir bastante código e ter já bastante funcionalidade, o PowershAI é um projeto novo, que está sendo desenvolvido.  
Alguns bugs podem ser encontrados e, nesta fase, é importante que você sempre ajude reportando, através de issues, no repositório oficial em https://github.com/rrg92/powershai  

Se você quiser fazer o troubleshooting de um problema, recomendo seguir estas etapas:

- Utilize o Debug para te ajudar. Comandos como Set-PSBreakpoint são simples de invocar na linha de comando e podem te ajudar a econimizar tempo
- Algumas funcoes não exibem o erro completo. Você pode usar a variável $error, e acessar o último. Por exemplo:  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # Isso ajua a encontrar a linha exada onde a exception ocorreu!
```

# Veja também <!--! @#Also -->

- Vídeo sobre Como usar o Provider do Hugging Face: https://www.youtube.com/watch?v=DOWb8MTS5iU
- Veja a doc de cada provider para mais detalhes sobre como usar os seus cmdlets

# Tags <!--! @#Kw -->

- Inteligência Artificial
- IA
