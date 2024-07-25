![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)



# PowershAI

[english](docs/en)

PowershAI (PowerShell + AI) é um módulo que integra serviços de Inteligência Artificial diretamente no PowerShell.  
Você pode invocar os comandos tanto em scripts quanto na linha de comando.

Este módulo é ideal para testar chamadas ou integrar tarefas simples com serviços de IA.  
É ideal para quem já está acostumado com o PowerShell e quer trazer a IA pro seus scripts e uso.  

Atualmente, o PowershAI suporta alguns serviços de IA.
No entanto, outros serviços serão adicionados em breve!
Providers de AI suportados e que planejo implementar:

- [x] OpenAI
- [] Azure OpenAI
- [x] Ollama
- [] Hugging face
- [] Google Gemini
- [x] Anthropic Claude (parcial, pendente: json mode)
- [] Cohere Command R
- [] Sapiens chat (LLM brasileiro)
- [x] Maritalk (LLM brasileiro)
- [x] Groq Cloud

[Este post contém mais detalhes (e um vídeo)](https://iatalk.ing/powershai-powershell-inteligencia-artificial/)

**IMPORTANTE: Este é um projeto em construção e muita coisa ainda pode mudar**

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

Pronto, agora os comandos estão importados na sua sessão.  
Você pode obter ajuda (que vamos melhorando ao longo das próximas versões) usando o próprio PowerShell:

```powershell
# Listar todos os comandos e funções disponívesis:
get-command -mo powershai 

# Listas os alias (atalhos para os comandos)
get-alias | ? {$_.source -eq 'powershai'}

# obter ajuda de um comando especifico 
get-command -full NomeComando
```

## Usando 

O PowershAI pode conversar com vários serviços de IA.  
Por padrão, ele usa a API da OpenAI (a criadora do ChatGPT). 
Dependendo do provider que você quer usar, você precisará realizar algumas configurações antes de invocar o chat: 

A [documentação de providers](docs/providers) contém os detalhes que você precisa saber para usar com cada um!

### Guia rápido dos principais providers

Guia rápido:

** OpenAI  
A única coisa que precisa é uma API Token.  
Você configura a API Token com o comando `Set-OpenaiToken`. Siga as instruções.  

** Ollama  
Para usar o ollama, você precisa mudar o provider usando o comando `Set-AiProvider ollama`.  
Por padrão, ele usa a URL http://localhost:11434, mas voce pode mudar passando o segundo argumento `Set-AiProvider ollama http://meuserverollama`  
Você então deve configurar um model para ser usado.  Use o comando `Get-AiModels` para listar os models disponíveis.  
Use o comando `Set-AiModel NAME` para definir o model a ser usado, usando o campo `name` resultante da listagem do comando anterior.  

### Conversando com a IA

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
ia -Obj "5 numeros aleatorios, com seu valor escrito por extenso" | %{  }
```  


### Modo interativo  

As primeiras versões do PowershAI apresentaram o comando `Chatest`.  
Ele foi a primeira implementação que criei do chat interativo com o objetivo de juntar todas as funcionalidades do PowershAI em um único comando, simulando um client mais completo de chat direto no seu PowerShell.  

Você consegue usar o Chatest ainda, mas ele é depreciado e em breve irei removê-lo.  
Recomendo usar o `ia` que contém muito mais funcionalidades e reparoveita o próprio prompt do powershell.

E, se ainda preferir um modo interativo parecido com o Chatest, você pode usar o comando `Enter-PowershaiChat`. 

### Chats  

Ao usar o comando `ia`, ele usa um chat default. Todo o contexto da conversa é mantido, incluindo as mensagens anteriores.  
Para iniciar um novo chat, com um novo contexto, utilize o comando `New-PowershaiChat ChatId`.  
Este comando cria um chat identificado por `ChatId`, que pode ser qualquer string que você quiser (desde que seja unico).  
Se você não especificar um NOME, ele vai criar um automático usando um timestamp.  

Os chats são como se fosse aqueles chats da interface do ChatGPT.  
Cada chat tem seu próprio histórico de mensagens, configurações e contexto.  

Você pode definir o chat atual usando o comando `Set-PowershaiActiveChat ChatId`.  
A maioria dos comandos, como o `ia`, operam no chat ativo.
 

###  Function Calling

Uma das grandes funcionalidades implementadas é o suporte a Function Calling (ou Tool Calling).  
Este recurso, disponível em vários LLMs, permite que a IA decida invocar funções para ajudar na resposta.  
Basicamente, você descreve uma ou mais funções e seus parâmetros, e o modelo pode decidir invocá-las.  

Para mais detalhes, veja a documentação oficial da OpenAI sobre Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling).

O modelo é responsável por invocar a função, mas, a execução dessa invocação é feita pelo client, no nosso caso, o PowersAI.  
E para tornar esse procesos fácil e dinâmico, o PowershAI permite que você escreva suas próprias funções, fazendo com que o LLM possa decidir invocá-las. Você é responsável por descrever, controlar o código que o modelo vai rodar.
O resultado da sua função deve ser enviado de volta ao modelo para que ele continue gerando a resposta.

Para demonstrar, crie um arquivo chamado `MinhasFuncoes.ps1` com o seguinte conteúdo:

```powershell
<#
    .DESCRIPTION
    Lista a hora atual
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    Obtém um número aleatório!
#>
function NumeroAleatorio {
    param(
        # Número mínimo
        $Min = $null,
        
        # Número máximo
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**Note o uso dos comentários para descrever funções e parâmetros**.  
Esta é uma sintaxe suportada pelo PowerShell, conhecida como [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Agora, carregue essas funções no seu chat ativo:

```powershell
iaf C:\temp\MinhasFuncoes.ps1

# DICA: iaf é um alis para o comando Update-PowershaiChatFunctions
```

Experimente pedir ao modelo qual a data atual ou peça para ele gerar um número aleatório! Você verá que ele executará suas funções! Isso abre possibilidades infinitas, e sua criatividade é o limite!

```powershell
ia "Gere um número aleatório e depois me diga qual a data atual!"
```

### **MUITO IMPORTANTE SOBRE FUNCTION CALLING**

O recurso de Function Calling é poderoso por permitir a execução de código, mas também é perigoso, MUITO PERIGOSO.  
Portanto, tenha extrema cautela com o que você implementa e executa.
Lembre-se de que o PowershAI executará conforme o modelo pedir. 

Algumas dicas de segurança:

- Evite rodar o script com um usuário Administrador.
- Evite implementar código que exclua ou modifique dados importantes.
- Teste as funções antes.
- Não inclua módulos ou scripts de terceiros que você não conheça ou não confie.  

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