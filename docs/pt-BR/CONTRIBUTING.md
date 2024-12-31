# Contribuindo para o PowershAI  

Muito obrigado pelo seu interesse em contribuir para o PowershAI!
Um dos principais objetivos desse projeto é que ele seja construído a partir da experiência de várias pessoas, tornando-o mais estável, robusto e único!

Este guia vai ajudá-lo com tudo o que você precisa configurar e nossos padrões para que você possa modificar o projeto e submeter as alterações.


# Pré-Requisitos  

O PowershAI é um módulo PowerShell relativamente simples: você precisa apenas de um computador com PowerShell e um editor de textos para alterá-lo.  
No Windows, eu gosto muito de usar o Notepad++, mas você pode usar qualquer editor que preferir, como o Visual Studio Code.

No mais, as ferramentas que você precisará são para interação com o Git e alguns outros módulos PowerShell para rodar testes e/ou gerar documentação. 

Aqui está uma lista resumida do software que você precisa:

- Um editor de textos de sua preferência
- PowerShell instalado, pode ser Windows ou Linux.
- Git, obviamente, para clonar o repositório e fazer push
- Módulo Pester, caso queira rodar testes. Instale com `Install-Module Pester` (precisa fazer isso apenas 1x)
- Módulo PlatyPS, caso queira gerar documentação. Instale com `Install-Module PlatyPs` (precisa fazer isso apenas 1x)


Uma vez que você tenha tudo o que precisa, faça o clone desse repositório em um diretório de sua preferência.  
Para os exemplos deste artigo, assumirei que você clonou em `C:\temp\powershai`, mas você pode escolher qualquer diretório de sua preferência. 

Antes de começar a modificar o PowershAI, é muito importante que você entenda seu funcionamento e comandos básicos. 
Recomendo que você veja a seção de [exemplos](examples/) e tente usar o PowershAI para que possa modificá-lo.

Basicamente, você precisa estar familiarizado com a sintaxe do PowerShell, entender os conceitos introduzidos pelo PowershAI, como providers, e, obviamente, um básico sobre LLMs, APIs e HTTP REST.


# Workflow de desenvolvimento 

Adicionar ou alterar algo no PowershAI é um processo relativamente simples.  
O fluxo básico é este:

* Crie uma issue descrevendo o problema, caso não exista
* Clone o repositório do PowershAI em um diretório de sua escolha
* Faça as modificações necessárias e teste (aqui incluem modificações de código e documentação, incluindo tradução automática)
* Execute os scripts de teste em seu ambiente e certifique-se de que todos os testes passem
* Gere um PR e envie detalhando o máximo possível, sempre com clareza. Mantenha a comunicação em inglês ou português do Brasil.
* Adicione no CHANGELOG, na seção unreleased
* Um mantenedor deverá revisar suas modificações e aprová-las ou não.
* Uma vez aprovado, ela será mesclada na branch da próxima versão, que será controlada por um mantenedor

Conhecer a estrutura de arquivos e diretórios é essencial para determinar o que você vai alterar. Veja a seguir.

# Estrutura de Arquivos e Diretórios 

Ao clonar o projeto, você verá vários diretórios e arquivos, explicados resumidamente a seguir:

|Item				| Descrição														|
|-------------------|---------------------------------------------------------------|
|docs				| Contém a documentação do PowershAI 							|
|powershai 			| Contém o código fonte do PowershAI							|
|tests 				| Contém os scripts de teste do PowershAI 						|
|util 				| Contém scripts auxiliares de desenvolvimento					|


## powershai 

O diretório [powershai] é o módulo em si, isto é, o código-fonte do PowershAI.  
Assim como qualquer módulo PowerShell, ele contém um arquivo .psm1 e um arquivo .psd1.  
O arquivo [powershai.psm1] é o root do módulo, isto é, é o arquivo que é executado quando você executa um `Import-Module powershai`.  
O arquivo [powershai.psd1] é o module manifest, que contém metadados importantes sobre o módulo, como versão, dependências e copyright.

Os demais arquivos são carregados pelo [powershai.psm1], automaticamente ou conforme certos comandos são executados.
No início, todo o código-fonte do PowershAI estava no arquivo [powershai.psm1], mas, conforme ele vai crescendo, fica melhor para o desenvolvimento ir separando em arquivos menores, agrupado por funcionalidades. À medida que novas versões são lançadas, novas estruturas e arquivos podem surgir para melhor organização. 

A seguir um breve resumo dos arquivos e/ou diretórios mais importantes:

- [lib](/powershai/lib)  
Contém diversos scripts auxiliares com funções genéricas e utilidades que serão usadas por outros componentes do PowershAI.

- [chats.ps1](/powershai/chats.ps1)  
Contém todos os cmdlets e funções que implementam a feature de PowershAI Chats

- [AiCredentials.ps1](/powershai/AiCredentials.ps1)
Contém todos os cmdlets e funções que implementam a feature de AiCredential

- [providers](/powershai/providers)  
Contém 1 arquivo para cada provider, com o nome do provider.  
O PowershAI.psm1 irá carregar estes arquivos ao ser importado.  
Para mais informações sobre como desenvolver providers veja [a doc de desenvolvimento de providers](providers/DEVELOPMENT.about.md)


Este é um resumo do fluxo básico do que acontece quando você importa o módulo do PowershAI:

- O arquivo `powershai.psm1` define uma série de funções e variáveis
- Ele carrega funções definidas nas libs
- Por fim, os providers em [providers](/powershai/providers) são carregados


O jeito mais rápido de descobrir onde está definido o comando que você quer alterar é fazendo uma busca simples usando comandos PowerShell (ou pela pesquisa do Git)
Alguns exemplos:

```powershell 
# Onde está a função Get-Aichat?
gci -rec powershai | sls 'function Get-AiChat' -SimpleMatch

# onde tem uma função com 'Encryption' no nome?
gci -rec powershai | sls 'function.+Encryption'

#Dica: sls é um alias para Select-String, um comando nativo do PowerShell que faz busca dentro do arquivo usando RegEx ou match simple. Semelhante ao Grep do Linux.
```

Uma vez que você determinou o arquivo, você pode abri-lo em seu editor preferido e começar a ajustá-lo.  
Lembre-se de testar e configurar as credenciais para os providers, caso precise invocar um comando que irá interagir com um LLM que requeira autenticação.

### Importando o módulo em desenvolvimento

Normalmente, você importa o módulo com o comando `Import-Module powershai`.  
Este comando busca o módulo no path de módulos padrão do PowerShell.
Durante o desenvolvimento, você deve importar do caminho onde clonou:

```
cd C:\temp\
git clone https://github.com/rrg92/powershai
cd powershai
Import-Module -force ./powershai
```

Note que o comando especifica `./powershai`. Isso faz com que o PowerShell procure o módulo no diretório `powershai` do diretório atual.  
Com isso, você garante que está importando o módulo do diretório clonado atualmente, e não o módulo instalado em um dos diretórios padrões de módulo.

> [!NOTE]
> Sempre que você fizer uma alteração nos fontes do PowershAI, você deve importar o módulo novamente.


## tests 

O diretório `tests` contém tudo o que é necessário para testar o PowershAI.  
A base dos testes é feita com o módulo Pester, que é um módulo PowerShell que facilita a criação e execução de testes.  

Os arquivos com as definições dos testes ficam no diretório [tests/pester](/tests/pester).  
Um script chamado [tests/test.ps1](/tests/test.ps1) permite que você facilmente invoque o Pester e lida com alguns filtros para que você possa pular testes específicos enquanto estiver desenvolvendo.  

### Executando testes 

O jeito mais fácil de iniciar os testes do PowershAI é invocando o script:

```
tests/test.ps1
```

Sem quaisquer parâmetros, esse script vai invocar uma série de testes considerados como "básicos".
Para realizar todos os testes, passe o valor "production" no primeiro argumento:

```
tests/test.ps1 production
```

Esta é a opção usada ao fazer o teste final para uma nova versão do PowershAI.
Se você possui Docker instalado, pode usar `docker compose up --build` para iniciar a mesma bateria de testes em produção que será feita no Git.  
Por padrão, é usada uma imagem do PowerShell Core no Linux. O arquivo `docker-compose.yml` e `Dockerfile` na raiz do repositório contêm todas as opções usadas.

Passar no teste de produção é um dos pré-requisitos para que suas modificações sejam aceitas. Portanto, antes de submeter seu PR, execute os testes locais para garantir que tudo está funcionando como esperado. 


### Definindo testes 

Você também deve definir e ajustar os testes para as modificações que fizer.  
Um dos objetivos que temos para o PowershAI é que todos os comandos tenham um teste unitário definido, além dos testes que validam features mais complexas.  
Como o PowershAI começou sem testes, é provável que ainda existam muitos comandos sem testes.  
Mas, à medida que estes comandos são modificados, ou novos são adicionados, é mandatório que os testes sejam definidos e ajustados.  

Para criar um teste, você deve usar a [sintaxe do módulo Pester 5](https://pester.dev/docs/quick-start).  
O diretório em que o script de teste irá procurar é o `tests/pester`, logo você deve colocar os arquivos lá.  
Somente serão carregados arquivos com a extensão `.tests.ps1`.  



## docs  

O diretório `docs` contém toda a documentação do PowershAI. Cada subdiretório é específico de um idioma e deve ser identificado pelo código BCP 47 (formato aa-BB).  
Você pode criar arquivos Markdown diretamente no diretório do idioma desejado e iniciar a edição no idioma.  

Alguns arquivos incluídos serão acessíveis apenas neste repositório Git, porém alguns serão usados para montar uma documentação acessível pelo comando `Get-Help` do PowerShell.  
O processo de publicação do PowershAI gerará os arquivos necessários com toda a documentação, conforme idiomas. Assim, o usuário poderá usar o comando `Get-Help`, que determinará a documentação correta conforme idioma e localização da máquina onde o PowershAI é executado.

Para que isso funcione corretamente, o diretório `docs/` possui uma organização mínima que deve ser seguida para que o processo automático funcione, e, ao mesmo tempo, seja possível ter uma documentação mínima acessível diretamente aqui pelo repositório do Git.

### Regras do diretório docs
O diretório `docs` possui algumas regras simples para organizar melhor e permitir a criação dos arquivos de ajuda no PowerShell:

#### Usar extensão .md (Markdown) ou .about.md
Você deve criar a documentação usando arquivos Markdown (extensão `.md`).
Arquivos que possuem a extensão `.about.md` serão convertidos em um help topic do PowerShell. Por exemplo, o arquivo `CHATS.about.md` virará o help topic `powershai_CHATS`.  
Cada subdiretório em que um arquivo `.about.md` é encontrado, o nome do diretório é prefixado no help topic.  `README.md` é considerado como o help topic do próprio diretório.
Por exemplo, um arquivo em `docs/pt-BR/providers/openai/README.md` virará o help topic `powershai_providers_openai`.  
Já o arquivo `docs/pt-BR/providers/openai/INTERNALS.about.md` virará o help topic `powershai_providers_openai_internals`.

#### Diretório docs/`lang`/cmdlets
Este diretório contém um arquivo Markdown para cada cmdlet que precisa ser documentado.  
O conteúdo desses arquivos deve seguir o formato aceito pelo PlatyPS.  
Você pode usar o script auxiliar `util\Cmdlets2Markdown.ps1` para gerar os arquivos Markdown a partir da documentação feita via comentários.

#### Diretório docs/`lang`/providers
Contém um subdiretório para cada provider e dentro desse subdiretório toda a documentação pertinente ao provider deve ser documentada.  
Documentação sobre providers, que não é específica de um provider, deve ficar na raiz `docs/lang/providers`.

#### Diretório docs/`lang`/examples
Este diretório contém os exemplos de uso do PowershAI.  
O nome dos arquivos deve seguir o padrão `NNNN.md`, onde NNNN é um número de 0000 a 9999, sempre com os zeros à esquerda.

### Tradução  

A tradução da documentação pode ser feita de duas formas: manualmente ou com IA usando o próprio PowershAI. 
Para traduzir com PowershAI, você pode usar o script `util\aidoc.ps1`. Este script foi criado para permitir disponibilizar a documentação do PowershAI em outros idiomas rapidamente. 

#### Tradução manual 

A tradução manual é muito simples: copie o arquivo do idioma a partir do qual você quer traduzir para o mesmo caminho no diretório do idioma para o qual você vai traduzir.  
Então edite o arquivo, faça as revisões e faça o commit.

Arquivos traduzidos manualmente não serão traduzidos pelo processo automático descrito abaixo.

#### Tradução automática 
O processo de tradução automática é este:
- Você escreve a documentação no idioma original, gerando o arquivo Markdown conforme as regras acima
- Importe o módulo PowershAI na sessão e certifique-se de que as credenciais estão configuradas corretamente
- Você usa o script `util\aidoc.ps1` passando como origem o idioma em que você escreve e o idioma de destino desejado. Recomendo usar o Google Gemini.
- O script gerará os arquivos. Você pode revisar. Se estiver tudo ok, então faça um Git commit. Caso não esteja, remova os arquivos indesejados ou use `git restore` ou `git clean`.


O script `AiDoc.ps1` mantém um arquivo de controle em cada diretório chamado `AiTranslations.json`. Este arquivo é usado para controlar quais arquivos foram traduzidos automaticamente em cada idioma e com ele o `AiDoc.ps1` pode determinar quando um arquivo de origem foi alterado, evitando traduções de arquivos que não foram alterados. 

Também, se você manualmente editar um dos arquivos no diretório de destino, esse arquivo não será traduzido mais automaticamente, para evitar sobrescrever uma revisão que você tenha feito. Logo, caso altere os arquivos, por mínimo que seja essa alteração, isso pode impedir que a tradução automática ocorra. Se você quiser que a tradução seja feita mesmo assim, delete o arquivo de destino ou use o parâmetro `-Force` do `AiDoc.ps1`.


Aqui estão alguns exemplos de uso:

```powershell 
Import-Module -force ./powershai # Importar powershai (usando o próprio módulo no diretório atual para usar as últimas features implementadas!)
Set-AiProvider google # usa o google como provider 
Set-AiCredential # Configura as credenciais do provider do google (isso você precisa fazer 1x somente)

# Exemplo: Tradução simples 
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US  

# Exemplo: Filtrando arquivos específicos 
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US  -FileFilter CHANGELOG.md

# Exemplo: Traduzir para todos os idiomas disponíveis 
gci docs | %{ util\aidoc.ps1 -SrcLang pt-BR -TargetLang $_.name   }

```


# Versionamento no PowershAI 

O PowershAI segue o semantic versioning (ou um subset dele).  

A versão atual é controlada da seguinte maneira:

1. Via tag do git no formato vX.Y.Z
2. arquivo [powershai.psd1]

Quando uma nova versão é criada, uma tag deverá ser atribuída ao último commit daquela versão.  
Todos os commits feitos desde a última tag, é considerado parte dessa versão.  

No arquivo [powershai.psd1], você deve manter a versão compatível com o que foi definida na tag.  
Se não estiver correto, o build automático irá falhar.

Um maintainer do powershai é o responsável por aprovar e/ou executar o fluxo de nova versão.  

Atualmente, o PowershAI encontra-se em versão `0.`, pois algumas coisas podem mudar.  
Mas, cada vez mais estamos tornando ele mais estável e a tendência é que as próximas seja muito mais compatíveis.  

A versão `1.0.0` será publicadas oficialmente quando houverem testes suficientes por uma parte da comunidade.


[powershai]: /powershai/powershai
[powershai.psm1]: /powershai/powershai.psm1
[powershai.psd1]: /powershai/powershai.psd1