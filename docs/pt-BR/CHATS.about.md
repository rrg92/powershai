# Chats 


# Introdução <!--! @#Short --> 

O PowershAi define o conceito de Chats, que ajudam a criar histórico e contexto de conversas!  

# Detalhes  <!--! @#Long --> 

O PowershAi cria o conceito de Chats, que são muito semelhantes ao conceito de Chats na maioria dos serviços de LLM.  

Os chats permitem conversar com serviços de LLM de uma maneira padrão, independnete do provider atual.  
Eles proveem um jeito padrão para estas funcionalidades:

- Histórico de chats 
- Contexto 
- Pipeline (usar o resultaod de outros comandos)
- Tool calling (executar comandos a pedido do LLM)

Nem todos os providers implementar o suporte aos Chats.  
Para saber se um provider possui o suporte ao chat, use o cmdlet Get-AiProviders, e consulte a propriedade "Chat". Se for $true, então o chat é suportado.  
E, uma vez que o chat é suportado, nem todos os recursos podem ser suportados, devido a limitações do provider.  

## Inciando um novo chat 

A maneira mais simples de inicir um novo chart é usando o comando Send-PowershaiChat.  
Obviamente, você deve usá-lo depois de configurar o provider (usando `Set-AiProvider`) e as configurações inicais, como autenticação, se necessário.  

```powershell 
Send-PowershaiChat "Olá, estoi conversando com você a partir do Powershai"
```

Por simplicidade, o comando `Send-PowershaiChat` tem um alias chamado `ia` (abreviação do português, Inteligência Artificial).  
Com ele, você reduz bastante e concentra mais no prompt:

```powershell 
ia "Olá, estoi conversando com você a partir do Powershai"
```

Toda mensagem é enviada em um chat.  Se você não cria um chat explicitamente, o chat especial chamado `default` é usado.  
Você pode criar um novo chat usando `New-PowershaiChat`.  

Cada chat tem seu próprio histórico de conversas e configurações. Pode conter suas próprias funções, etc.
Criar chats adicionais pode ser útil caso precise manter mais de um assunto sem que eles se misturem!


## Comandos de Chat  

Os comandos que manipulam os chats de alguma forma são no formato `*-Powershai*Chat*`.  
Geralmente, estes comandos aceitam um parâmetro -ChatId, que permite especificar o nome ou objeto do chat criado com `New-PowershaiChat`.  
Se não é especificado, eles usam o chat ativo.  

## Chat Ativo  

O Chat ativo é o chat default usado pelos comandos PowershaiChat.  
Quando existe apenas 1 chat criado, ele é considerado como chat ativo.  
Se você possui mais de 1 chat tivo, pode usar o comando `Set-PowershaiActiveChat` para definir qual é. Você pode passar o nome ou o objeto retornaod por `New-PowershaiChat`.


## Parâmetros do chat  

Todo chat possui alguns parâmetros que controlam diversos aspectos.  
Por exemplo, o máximo de tokens a ser retornado pelo LLM.  

Novos parâmetros podem ser adicionados a cada versão do PowershAI.  
A maneira mais fácil de obter os parâmetros eo que eles fazem é usando o comando `Get-PowershaiChatParameter`;  
Este comando vai trazer a lista de parâmetros que pode ser configurada, junto com o valor atual e uma descrição de como usá-lo.  
Você pode alterar os parâmetors usando o comando `Set-PowershaiChatParameter`.  

Alguns parâmetros listados são os parâmetros diretos da API do provider. Eles virão com uma descrição que indica isso.  

## Contexto e Histórico  

Todo Chat possui um contexto e histórico.  
O histórico é todo o histórico de mensagens enviadas e recebias na conversa.
O context size é quanto do histórico ele vai enviar ao LLM, para que ele lembre das respostas.  

Note que esse Context Size é um conceito do PowershAI, e não é o mesmo "Context length" que são definidos nos LLM.  
O Context Size afeta apenas o Powershai, e, dependendo do valor, ele pode ultrapassar o Context Length do provider, o que pode gerar erros.  
É imporante manter o Context Size equilibrado entre manter o LLM atualizado com o que já foi dito e não estourar o máximo de tokens do LLM.  

Você controla o contexto size usando através do parâmetro do chat, isto é, usando `Set-PowershaiChatParameter`.

note que o histórico eo contexto são armazenados na memória da sessão, isto é, se você fechar sua sessão do Powershell, eles irão se perder.  
Futuramente, podemos ter mecanismos que permitam ao usuário salvar autoamticamente e recuperar entre sessoes.  

Também, é importante lembrar que, uma vez que o histo´rico é salvo na memória do Powershell, conversas muito longas podem causar estouro ou um alto consumo de memória do powershell.  
Você pode Resetar os chats a qualquer momento usaod o comando `Reset-PowershaiCurrentChat`, que irá apahar todo o histórico do chat ativo.  
Use com cautela, pois isso causara todo o histórico ser perdido eo LLM não irá lembrar das peculiaridades informadas ao longo da conversa.  


## Pipeline  

Um dos recursos mais podersos dos Chats do Powershai é a integração com o pipeline do Powershell.  
Basicamente, você pode jgoar o resultado de qualquer comando powershell e ele será usado como contexto.  

O PowershAI faz isso convertendo os objetos para texto e enviando no prompt.  
Então, a mensagem do chat é adicinada em seguida.  

Por exemplo:

```
Get-Service | ia "Faça um resumo sobre quais serviços não é comum no Windows"
```

Nas configurações padrões do Powershai, o comando `ia`  (alias para `Send-PowershaiChat`), vai obter todos os objetos retornados por `Get-Service` e formatá-los como uma string gigante única.  
Então, essa string será injetada no prompt do LLM, e será instruído a ele queuse esse resultado como "contexto" para o prompt do usuário.  

O prompt do usuário é concatenado logo em seguida.  

Com isso, cria-se um efeito poderoso: Você pode facilmente integrar as saídas dos comandos com seus prompts, usando um simples pipes, que é uma operação comum no Powershell.  
O LLM tende a considerar bem.  

Apesar de possuir um valor padrão, você tem total controle de como esse objetos são enviados.  
A primeria forma de controlar é como o obejto é convertido para texto.  Como o prompt é uma string, é necessário converter esse objeto para texto.  
Por padrão, ele converte em uma representação padrão do Powershell, conforme o tipo (usando o comando `Out-String`).  
Você pode alterar isso usando o comando `Set-PowershaiChatContextFormatter`. Você pode definir, por exemplo, JSON, tabela, e até um script customizado para ter total controle.  

A outra forma de controlar como o contexto é enviado é usando o parâmetro do chat `ContextFormat`.  
Esse parâmetro controla toda a mensagem que será injetada no prompt. Ele é um scriptblock.  
Você deve reotrna um array de string, que equivale ao prompt enviado.  
Esse script tem acesso a parâmetros como o objeto formatado que está passando no pipeline, os valores dos parâmetros do comando Send-PowershaiChat, etc.  
O valor default do script é hard-coded, e você deve conferir direto no código para saber como ele envia (e para um exemplo de como implementar o seu próprio).  


###  Tools

Uma das grandes funcionalidades implementadas é o suporte a Function Calling (ou Tool Calling).  
Este recurso, disponível em vários LLMs, permite que a IA decida invocar funções para trazer dados adicionais na resposta.  
Basicamente, você descreve uma ou mais funções e seus parâmetros, e o modelo pode decidir invocá-las.  

**IMPORTANTE: Você só vai conseguir usar esse recurso em providers que expõe function calling usando a mesma especificação da OpenAI**

Para mais detalhes, veja a documentação oficial da OpenAI sobre Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling).

O modelo apenas decide quais funçoes invocar, quando invocar e seus prâmetros. A execução dessa invocação é feita pelo client, no nosso caso, o PowershAI.  
Os modelos esperam a definição das funções descrevendo o que elas fazem, seu parâmetros, retornos, etc.  Originalmente isso é feito usando algo como OpenAPI Spec para descrever as funções.  
Porém, o Powershell possui um poderoso sistema de Help ussando comentários, que permite descrever funções e seus parâmetros, além dos tipos dados.  

O PowershAI integra com esse sistema de help, traduzidno ele para um OpenAPI specification.  O usuário pode escrever suas funções normalmente, usando comentários para documentá-la e isso é enviado ao modelo.  

Para demonstrar esse recurso, vamos a um simples tutorial: crie um arquivo chamado `MinhasFuncoes.ps1` com o seguinte conteúdo

```powershell
# Arquivo MinhasFuncoes.ps1, salve em algum diretorio de sua preferência!

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

Agora, vamos adicionar esse arquivo ao PowershAI:

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #confiogure o token se ainda não configurou.


# Adicione o script como tools!
# Supondo que o script fo salvo em C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Confirme que s tools foram adicionadas 
Get-AiTool
```

Experimente pedir ao modelo qual a data atual ou peça para ele gerar um número aleatório! Você verá que ele executará suas funções! Isso abre possibilidades infinitas, e sua criatividade é o limite!

```powershell
ia "Quantas horas?"
```

No comando acima, o modelo vai invocar a função. Na tela você verá a função sendo chamada!  
Você pode adicionar qualquer comando ou script powershell como uma tool.  
Utilize o comando `Get-Help -Full Add-AiTol` para mais detalhes de como usar essa poderosa funcioinalidade.

O PowershAI automaticamente cuida de executar os comandos e enviar a resposta de volta ao modelo.  
Se o modelo decidir executar várias funções em paralelo, ou insitir em executar novas funções, o PowershAI irá gerenciar isso automaticamente.  
Note que, para evitar um loop inifinto de execuções, o PowershAI força um limite com o máximo de execuções.  
O parâmetro que controla essas interações com o modelo é o `MaxInteractions`.  



#### CONSIDERAÇÕES IMPORTANTES SOBRE O USO DE TOOLS

O recurso de Function Calling é poderoso por permitir a execução de código, mas também é perigoso, MUITO PERIGOSO.  
Portanto, tenha extrema cautela com o que você implementa e executa.
Lembre-se de que o PowershAI executará conforme o modelo pedir. 

Algumas dicas de segurança:

- Evite rodar o script com um usuário Administrador.
- Evite implementar código que exclua ou modifique dados importantes.
- Teste as funções antes.
- Não inclua módulos ou scripts de terceiros que você não conheça ou não confie.  


