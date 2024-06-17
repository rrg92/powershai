# PowershAI

PowershAI (PowerShell + AI) é um módulo que integra serviços de Inteligência Artificial diretamente no PowerShell.  
Você pode invocar os comandos tanto em scripts quanto na linha de comando.

Este módulo é ideal para testar chamadas ou integrar tarefas simples com serviços de IA.  

Atualmente, o PowershAI suporta apenas os serviços compatíveis com a API da OpenAI.  
No entanto, outros serviços serão adicionados em breve!

## Como Usar

[Este post contém mais detalhes (e um vídeo)](https://iatalk.ing/powershai-powershell-inteligencia-artificial/)

Toda a funcionalidade está no arquivo `powershai.psm1`, que é um módulo PowerShell.  
Você pode baixá-lo para um diretório qualquer na sua máquina e importá-lo:

```powershell
Import-Module CAMINHO\powershai.psm1
```

Você também pode instalá-lo no seu diretório de módulos e importá-lo apenas usando o nome:

```powershell
Import-Module powershai.psm1
```

A API padrão é a da OpenAI. Para começar a usá-la, insira seu token usando o comando `Set-OpenaiToken`.  
Siga as instruções e evite colar seu token diretamente no prompt para não deixá-lo no histórico, pois é um dado sensível.  

Caso queira usar em algum script de maneira automática, defina o token usando a variável de ambiente `OPENAI_API_KEY`.  
Utilize meios seguros para definir a variável de ambiente.

Uma vez que seu token esteja configurado, basta chamar qualquer um dos comandos disponíveis.  
Por exemplo, o comando `Get-OpenAiChat` invoca um chat, respondendo suas perguntas, instruções ou apenas completando o texto.

Exemplo:

```powershell
Get-OpenaiChat "Olá, você conhece PowerShell?"
```

O retorno dessa função é o mesmo da API da OpenAI.

## Explorando com o ChaTest

Para experimentar a interação direta com o modelo, use o comando `ChaTest`:

```powershell
ChaTest
```

Com este comando, será criado um pequeno client no próprio prompt onde você poderá interagir diretamente com o modelo, enviando e recebendo respostas enquanto mantém o histórico.

## Function Calling

Uma das grandes funcionalidades implementadas é o suporte a Function Calling (ou Tool Calling).  
Este recurso, disponível em LLMs, permite executar funções externas. Basicamente, você descreve uma ou mais funções e seus parâmetros, e o modelo pode decidir invocá-las.  
Para mais detalhes, veja a documentação oficial da OpenAI sobre Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling).

O segredo é que o modelo não executa o código diretamente; quem faz isso é o cliente (neste caso, o PowershAI).  
Você é responsável por descrever, controlar o código que o modelo vai rodar e fornecer o ambiente necessário.  
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

Agora, invoque o ChaTest, passando o caminho do arquivo:

```powershell
ChaTest -Functions C:\temp\MinhasFuncoes.ps1
```

Note o uso dos comentários para descrever funções e parâmetros. Esta é uma sintaxe suportada pelo PowerShell, conhecida como [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Experimente pedir ao modelo qual a data atual ou peça para ele gerar um número aleatório! Você verá que ele executará suas funções! Isso abre possibilidades infinitas, e sua criatividade é o limite!

## MUITO IMPORTANTE SOBRE FUNCTION CALLING

O recurso de Function Calling é poderoso por permitir a execução de código, mas também é perigoso. Portanto, tenha extrema cautela com o que você implementa.  
Lembre-se de que o PowershAI executará conforme o modelo pedir. 

Algumas dicas de segurança:

- Evite rodar o script com um usuário Administrador.
- Evite implementar código que exclua ou modifique dados importantes.
- Teste as funções antes.
- Não inclua módulos ou scripts de terceiros que você não conheça.

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