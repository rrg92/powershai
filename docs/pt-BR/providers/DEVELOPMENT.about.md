# Desenvolvendo Providers  


Este é um guia e referência para o funcionamento e desenvolvimento de providers.  
Utilize ele como base se você quer contribuir para um provider existente ou criar um novo.  

Conforme você já deve ter lido em alguma introdução sobre o PowershAI, os providers são quem, de fato, contém a lógica para invocar as suas respecticas APIs e devolver o resultado.  
Eles atuam como um traduzir entre o PowershAI e a API de um serviço de IA.  
Você poderia imaginar eles como os drivers no Windows, ou plugins de um wordpress, por exemplo.  

O objetivo de um provider é que ele implemente tudo o que o PowershAI precisa para o seu funcionamnto de maneira transparente.  

# Como os providers são carregados  

Quando você importa o powershai, uma das últimas etapas que ele faz é carregar os provides.  
Ele faz isso lendo o diretório de providers, que é um valor hard-code e fica no diretório [providers](/powershai/providers).  

Este diretório deve conter um script .ps1 para cada provider existente.  
O nome do arquivo é tratado pelo powershai como nome do provider.  

Este nome é importante, pois é através dele, por exemplo, que você ativa o provider com o comando `Set-AiProvider`.  
Devido ao fato de que ele é um arquivo em um diretório, isso naturalmente evita duplicadas e o torna único.  

O powershai vai ler o diretório de providers, e para cada arquivo .ps1, ele vai invocár o arquivo.
O powershell usa o operador ".", isto é, o arquivo é executado no mesmo contexto que o core do Powershai (powershai.psm1).  
Isso significa que bugs em um provider, vão impedir todo o powershai de ser importado.  
Isso é intecional: Se há algo incorreto em um arquivo, é importante que isso seja tratado e resolvido.  

O script do provider é como um scriot powershell qualquer.  
Você pode definir funções, usar Export-ModuleMember, etc.  

A única exigência que o powershai faz, é que o script retorne uma hashtable com algumas keys obrigatórias (veja abaixo).  

O powershai então obtém esse retorno, e cria um objeto na memória da sessão que representa esse provider, e guarda essas keys retornadas.  
Além das keys defaults exigidas pelo powershai, outras podem ser definidas, conforme necessidade de cada provider, desde que não seja as mesmas keys reservadas.

Opcionalmente, os providers precisam implementar interfaces criadas pelo Powershai.  
O Powershell não tem um conceito native de interface da orientação a objeto, mas, aqui no powershai reusamos esse conceito pois é praticamente o mesmo objetivo: o powershai define algumas operações que, se implementadas pelo provider, ativam certas funcionalidades. Por exemplo, a interface GetModels deve ser implementada para que o comando `Get-AiModels` retorne corretamente.  

Cada interface define suas regras, inputs e retornos que o provider deve trata. A seção abaixo sobre interfaces documenta todas as interfaces.  


# Provider Keys  

Todo provider deve retornar uma hashtables com uma lista de keys exigidas pelo Powershai (que chamamdos de lista de Keys reservadas().  
Opcionalmente, o provier pode definir outras keys para uso próprio.  

## Lista de Key Reservadas

* DefaultModel  
Nome do modelo default. É onde o comando `Set-aiDefaultModel` grava.

* info  
Uma hashtable contendo informações sobre o provider.  

* info.desc  
Breve descrição do provider   

* info.url  
URL para a documentação ou página principal sobre o provider.

* ToolsModels
Nome de modelos (aceita regex), que suportam function calling.  
ESta lista serve como hint, caso um modelo esteja nesta, o powershai não precisa invocar Get-AiModels para determinar.


# Interfaces

As interfaces do Powershai definem padrões de operações que os providers devem seguir.  
Graças a essas interfaces, o powershai consegue ser dinâmico.  

O provider deve implementar uma interface como uma função, cmdlet ou alias.
O nome do comando deve seguir esse padrão para ser identificado corretamente:  nomeprovider_NomeInterface.  
`nomeprovider` é o nome do arquivo do provider, sem a extensão.  
`NomeInterface` é o nome da interface (conforme lista abaixo).  


## Lista de Interfaces 

### Chat  
Esta interface é invocada pelo powershai sempre que ele quer que o modelo llm complte um texto.  
É invocada por Get-Aichat.

### FormatPrompt 

ESta interface é invocada ao escrever a resposta do LLM na tela.  
Ela deve retornar uma string com o texto.

### GetModels  
Invocada quando se lista os modelos.  
Não recebe nenhum parâmetro e deve retorna um array com a lista de modelos.  
Cada elemento do array deve ser um objeto que contém, pelo menos, as sguintes proproeidades:

- name  
Nome do modelo de IA

- tools  
True se suporta o tool calling da openai.  
Caso contrário, assum eque não suporta!  
Somente modelos cujo valor é true, poderão invocar uma ai tool.

