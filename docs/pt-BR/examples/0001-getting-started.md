# Usado o PowershAI 

Este arquivo contém alguns exemplos básicos de como você pode usar o PowershAI. 

Após ler este arquivo, você será capaz de:

- Instalar e importar o PowershAI 
- Entender o que é um provider do PowershAI na prática
- Criar uma conta gratuita no provider Groq
- Definir as credenciais de autenticação de um provider
- 
- Conversar com o modelo LLM Llama3.3, via provider Groq 

---

## Instalando o PowershAI 

A instalação do PowershAI é simples:

1. Abra uma sessão do PowerShell
2. Digite o comando `Install-Module -Scope CurrentUser powershai`

> [!NOTE]
> O parâmetro -Scope CurrentUser garante que o PowershAI seja instalado apenas para o seu usuário, sem precisar abrir o powershell como administrador.

Agora que você instalou o módulo, você pode importá-lo para a sessão atual usando o comando `import-module powershai`.

Sempre que você abrir uma nova sessão do PowerShell, será necessário importar o módulo novamente usando o mesmo comando `import-module`.

### Sobre Execution Policy

Se você receber mensagens de erro relacionadas à Execution Policy, será necessário autorizar a execução de scripts. 

Você pode fazer isso de duas maneiras:

- Na sua sessão do PowerShell, use o comando `Set-ExecutionPolicy -Scope Process Bypass`. Isso permitirá a execução apenas na sessão atual.
- Você também pode configurá-lo permanentemente usando `Set-ExecutionPolicy Bypass`. 

A Política de Execução é uma configuração específica do PowerShell. Como o módulo PowershAI não é assinado digitalmente (assim como a maioria dos módulos publicados), pode gerar essas mensagens de erro. Se você quiser saber mais sobre a Política de Execução e suas implicações, confira a documentação oficial da Microsoft: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4

## Criando uma conta no Groq e obtendo uma API KEY

O PowershAI fornece acesso a vários LLMs por meio de providers. Cada provider é uma organização ou desenvolvedor de LLM que disponibiliza sua API para acesso.

Por exemplo, a OpenAI fornece acesso ao modelo GPT, que é um modelo pago desenvolvido por eles mesmos.

O PowershAI suporta vários providers e para este exemplo, usaremos o provider Groq. A Groq é uma empresa que oferece acesso a vários LLMs open source por meio de sua API. Eles oferecem um plano gratuito, que é suficiente para os exemplos demonstrados aqui.

Para criar uma conta, acesse https://console.groq.com/login e crie sua conta, caso ainda não tenha uma. Depois de criar sua conta, acesse https://console.groq.com/keys e clique no botão **Create API Key**. Copie a chave gerada e dê um nome que preferir. Sugestão: _Powershai-Tests_

> [!WARNING]
> Depois de fechar a tela que mostra a API KEY, ela não poderá ser visualizada novamente.
> Portanto, recomendo que só feche quando você concluir todos os exemplos a seguir

## Primeira conversa 

Agora que você tem sua chave API, defina-a no PowershAI usando os seguintes comandos:

```powershell
import-module powershai 
Set-AiProvider groq
Set-AiCredential
```

O comando acima importa o módulo, e muda o provider atual para o groq.  
O provider atual é o provider default em alguns comandos do powershai que precisam se comunicar com um LLM.  
O comando `Set-AiCredential` configura um credencial no provider atual. Cada provider define as informações necessárias.  
Você precisa consultar a [doc de providers](../providers/) (ou `get-help Set-AiCredential`), para obter mais detalhes do que informar.
No caso do groq, a única informação é a API KEY que você obtém no portal

---
Agora você está pronto para conversar com os LLM dos groq.  

Você pode usar os comandos `ia` ou `ai` para iniciar uma conversa com o LLM, mantendo o histórico de mensagens. Estes comandos são apenas aliases para o cmdlet `Send-PowershaiChat`, que é usado para iniciar uma conversa diretamente do shell com o modelo padrão do provider.

Por exemplo, digite no PowerShell:

```powershell
ia "Olá! Estou conversando com você a partir do PowershAI, seguindo o primeiro exemplo!"
```

O comando acima, vai, de maneira transparente, invocar a API do groq, passar o seu prompt e escrever o resultado na tela.

## Integrando o resultado 

Como um bom shell, uma das funcionalidades mais poderosas do PowerShell é a capacidade de integrar comandos usando o pipe `|`.  
O PowershAI aproveita essa funcionalidade, permitindo que você conecte praticamente qualquer comando do powershell com uma IA!

Por exemplo, veja como é fácil pedir ao LLM para identificar os dez primeiros processos que mais consomem memória:

```powershell
Get-Process | sort-object WorkingSet64 -Descending | select -First 10 | ia "O que são esses processos em execução?"
```

No exemplo acima, você usou o cmdlet `Get-Process` para obter uma lista de processos. Este é um comando bem famoso no powershell.  
Então, o resultado de `Get-Process` foi enviado para Sort-Object, que ordenou os resultados pela propridade WorkingSet64, isto é, o total de memória alocada, em bytes.  
Em seguida, você escolhe os primieros 10 resultados após a ordenção, tarefa que o comando `Select-Object` (alias `select`) faz muito bem!.  
E, por fim, o comando ia obteve esses 10 resultados, enviou ao groq seguido do prompt pedindo para explicar os processos.

## Listando e trocando modelos 

O PowershAI assume que todo provider pode ter um ou vários modelos disponíveis para conversa.  
Isso reflete o fato de que cada provider pode ter versões diferentes de cada modelo, cada um com suas vantagens e desvantagens.  

A maioria dos providers define um modelo padrão, então, ao usar esse provider, você já pode conversar imediatamente, como é o caso do groq.  
Você pode listar todos os modelos de LLM disponíveis usando `Get-AiModels`. 

Para mudar o modelo padrão, utilize `Set-AiDefaultModel`. Por exemplo: 

```
import-module powershai 

Set-AiProvider groq
# Lista os modelos disponiveis
Get-AiModels 

# Muda o modelo default
Set-AiDefaultModel gemma2-9b-it # Muda para o modelo open-source Gemma2, do Google.

ai "Em que plataforma estamos conversando?"
```

## Gerando completion simples 

Você também pode gerar texto manualmente usando o comando `Get-AiChat`. Este comando envia um prompt para o LLM, sem histórico de conversa. Você tem controle total sobre os parâmetros usados, como prompt, histórico de mensagens, streaming, etc. 

Por exemplo:
```
$resp = Get-AiChat "Olá!"
$resp.choices[0].message.content # O resultado deste comando sempre será um objeto do tipo chat.completion, da OpenAI, independente do provider usado.
```

## Adicionando ferramentas 

O PowershAI permite que você adicione ferramentas ("tools") aos modelos que as suportam. Pense em uma tool como uma função que você dá ao LLM. É como se estivesse dando habilidades adicionais ao modelo, permitindo que ele obtenha informações externas, execute ações, etc. Aqui é onde sua criatividade entra em cena.

No PowershAI, você define uma tool criando uma função e documentando-a com comentários no código. Veja este exemplo:

```powershell 

function GetDateTime {
	<#
		.SYNOPSIS 
			Obtém a data e hora atual.
	#>
	param()
	
	Get-Date
}

function GetTopProcesses {
	<#
		.SYNOPSIS 
			Obtém os processos que mais consomem memória, mostrando o nome do processo, a quantidade total de memória (em bytes) e o uso total de CPU.
	#>
	param(
		# Limita a quantidade de processos retornados
		[int]$top = 10
	)
	
	Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First $top -Property Name, WorkingSet64, CPU
}

# Importe o módulo do PowershAI
import-module powershai;

# Use o provider Groq
Set-AiProvider groq 

# Selecione um modelo que suporte a chamada de ferramentas (tools)
Get-AiModels | ? { $_.tools }

# Defina o modelo padrão
Set-AiDefaultModel llama-3.3-70b-versatile

# Teste sem ferramentas adicionadas
ia "Quantas horas são agora?"

# Adicione a tool GetDateTime
Add-AiTool GetDateTime

ia "Quantas horas são agora?"

# Obtenha uma visão geral dos processos sem ferramentas
ia "Me dê uma visão geral dos 20 processos em execução."

# Adicione a função GetTopProcesses como uma ferramenta
Add-AiTool GetTopProcesses

ia "Me dê uma visão geral dos 15 processos que mais consomem memória."
```

Observe no exemplo acima como usamos comentários para documentar a função e seus parâmetros. Isso traz flexibilidade e agilidade na integração de seus scripts com modelos de IA. Então usamos o comando Add-AiTool para registrar essa função como um tool que pode ser invocada.  Todo o help da função, e dos parâmetros, são transformados em um formato aceitável pelo modelo.  O modelo então, baseado no texto enviado (e no histórico anterior), pode decidir invocar a tool. Quando ele decide invocar o a tool, ele envia uma resposta de volta ao PowershAI, contendo as tools que quer invocar e os argumentos a serem passados. O powershai então, detecta esse pedido e executa as funções solicitadas. Ou seja, as funções são executadas na própria sessão do powershell em que você está.

Você também pode adicionar comandos nativos do PowerShell. O PowershAI usará a documentação desses comandos para descrever a ferramenta e seus parâmetros. 

Por exemplo, você poderia adicionar o comando Get-Date diretamente como uma ferramenta. 

```powershell
# Remova todas as ferramentas adicionadas anteriormente (este comando não exclui as funções, apenas remove a associação com a conversa)
Get-AiTools | Remove-AiTool

# Apague o histórico de conversas (você deve confirmar). Fazemos isso para que o modelo não considere as respostas anteriores.
Reset-PowershaiCurrentChat

# Pergunte sobre a data atual sem adicionar ferramentas
ia "Qual é a data de hoje?"

# Adicione o comando Get-Date como uma ferramenta
Add-AiTool Get-Date
```

Você pode adicionar ferramentas de outras maneiras, como scripts .ps1 ou executáveis. Consulte a ajuda do comando `Add-AiTool` para obter mais detalhes.

> [!WARNING]
> Por mais que os modelos possuam filtros e diveras barreiras de segurança, dar ele acesso a sua sessão do powershai pode ser perigoso
> Portanto, somente adicione tools definidas e revisadas por você (ou de fontes que você confia)
> Uma vez que o modelo pode livremente decidir invocar uma tool, ele terá acesso ao mesmo nível de privilégio que o seu!

## Salvando as configurações 

Por fim, é importante conhecer a capacidade de salvar suas configurações do PowershAI. Seria tedioso ter que gerar uma nova chave API a cada vez que você quisesse usar o módulo. 

Para facilitar o uso do PowershAI e manter a segurança, você pode exportar suas configurações usando `Export-PowershaiSettings`.


```powershell 
Export-PowershaiSettings
```

Basta digitar o comando e o PowershAI pedirá uma senha. Em seguida, ele criptografará todas as configurações da sessão atual em um arquivo, usando as chaves geradas a partir dessa senha.

Para importar as configurações salvadas, use `Import-PowershaiSettings`.

```powershell 
Import-PowershaiSettings
```

Lembre-se de escolher uma senha forte e memorizá-la, ou guardá-la em um local seguro. O objetivo deste comando é facilitar o uso interativo do PowershAI. Para uso em segundo plano, é recomendável configurar variáveis de ambiente.