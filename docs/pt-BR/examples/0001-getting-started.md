# Usado o PowershAI 

Este arquivo cont�m alguns exemplos b�sicos de como voc� pode usar o PowershAI. 

Ap�s ler este arquivo, voc� ser� capaz de:

- Instalar e importar o PowershAI 
- Entender o que � um provider do PowershAI na pr�tica
- Criar uma conta gratuita no provider Groq
- Definir as credenciais de autentica��o de um provider
- 
- Conversar com o modelo LLM Llama3.3, via provider Groq 

---

## Instalando o PowershAI 

A instala��o do PowershAI � simples:

1. Abra uma sess�o do PowerShell
2. Digite o comando `Install-Module -Scope CurrentUser powershai`

> [!NOTE]
> O par�metro -Scope CurrentUser garante que o PowershAI seja instalado apenas para o seu usu�rio, sem precisar abrir o powershell como administrador.

Agora que voc� instalou o m�dulo, voc� pode import�-lo para a sess�o atual usando o comando `import-module powershai`.

Sempre que voc� abrir uma nova sess�o do PowerShell, ser� necess�rio importar o m�dulo novamente usando o mesmo comando `import-module`.

### Sobre Execution Policy

Se voc� receber mensagens de erro relacionadas � Execution Policy, ser� necess�rio autorizar a execu��o de scripts. 

Voc� pode fazer isso de duas maneiras:

- Na sua sess�o do PowerShell, use o comando `Set-ExecutionPolicy -Scope Process Bypass`. Isso permitir� a execu��o apenas na sess�o atual.
- Voc� tamb�m pode configur�-lo permanentemente usando `Set-ExecutionPolicy Bypass`. 

A Pol�tica de Execu��o � uma configura��o espec�fica do PowerShell. Como o m�dulo PowershAI n�o � assinado digitalmente (assim como a maioria dos m�dulos publicados), pode gerar essas mensagens de erro. Se voc� quiser saber mais sobre a Pol�tica de Execu��o e suas implica��es, confira a documenta��o oficial da Microsoft: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4

## Criando uma conta no Groq e obtendo uma API KEY

O PowershAI fornece acesso a v�rios LLMs por meio de providers. Cada provider � uma organiza��o ou desenvolvedor de LLM que disponibiliza sua API para acesso.

Por exemplo, a OpenAI fornece acesso ao modelo GPT, que � um modelo pago desenvolvido por eles mesmos.

O PowershAI suporta v�rios providers e para este exemplo, usaremos o provider Groq. A Groq � uma empresa que oferece acesso a v�rios LLMs open source por meio de sua API. Eles oferecem um plano gratuito, que � suficiente para os exemplos demonstrados aqui.

Para criar uma conta, acesse https://console.groq.com/login e crie sua conta, caso ainda n�o tenha uma. Depois de criar sua conta, acesse https://console.groq.com/keys e clique no bot�o **Create API Key**. Copie a chave gerada e d� um nome que preferir. Sugest�o: _Powershai-Tests_

> [!WARNING]
> Depois de fechar a tela que mostra a API KEY, ela n�o poder� ser visualizada novamente.
> Portanto, recomendo que s� feche quando voc� concluir todos os exemplos a seguir

## Primeira conversa 

Agora que voc� tem sua chave API, defina-a no PowershAI usando os seguintes comandos:

```powershell
import-module powershai 
Set-AiProvider groq
Set-AiCredential
```

O comando acima importa o m�dulo, e muda o provider atual para o groq.  
O provider atual � o provider default em alguns comandos do powershai que precisam se comunicar com um LLM.  
O comando `Set-AiCredential` configura um credencial no provider atual. Cada provider define as informa��es necess�rias.  
Voc� precisa consultar a [doc de providers](../providers/) (ou `get-help Set-AiCredential`), para obter mais detalhes do que informar.
No caso do groq, a �nica informa��o � a API KEY que voc� obt�m no portal

---
Agora voc� est� pronto para conversar com os LLM dos groq.  

Voc� pode usar os comandos `ia` ou `ai` para iniciar uma conversa com o LLM, mantendo o hist�rico de mensagens. Estes comandos s�o apenas aliases para o cmdlet `Send-PowershaiChat`, que � usado para iniciar uma conversa diretamente do shell com o modelo padr�o do provider.

Por exemplo, digite no PowerShell:

```powershell
ia "Ol�! Estou conversando com voc� a partir do PowershAI, seguindo o primeiro exemplo!"
```

O comando acima, vai, de maneira transparente, invocar a API do groq, passar o seu prompt e escrever o resultado na tela.

## Integrando o resultado 

Como um bom shell, uma das funcionalidades mais poderosas do PowerShell � a capacidade de integrar comandos usando o pipe `|`.  
O PowershAI aproveita essa funcionalidade, permitindo que voc� conecte praticamente qualquer comando do powershell com uma IA!

Por exemplo, veja como � f�cil pedir ao LLM para identificar os dez primeiros processos que mais consomem mem�ria:

```powershell
Get-Process | sort-object WorkingSet64 -Descending | select -First 10 | ia "O que s�o esses processos em execu��o?"
```

No exemplo acima, voc� usou o cmdlet `Get-Process` para obter uma lista de processos. Este � um comando bem famoso no powershell.  
Ent�o, o resultado de `Get-Process` foi enviado para Sort-Object, que ordenou os resultados pela propridade WorkingSet64, isto �, o total de mem�ria alocada, em bytes.  
Em seguida, voc� escolhe os primieros 10 resultados ap�s a orden��o, tarefa que o comando `Select-Object` (alias `select`) faz muito bem!.  
E, por fim, o comando ia obteve esses 10 resultados, enviou ao groq seguido do prompt pedindo para explicar os processos.

## Listando e trocando modelos 

O PowershAI assume que todo provider pode ter um ou v�rios modelos dispon�veis para conversa.  
Isso reflete o fato de que cada provider pode ter vers�es diferentes de cada modelo, cada um com suas vantagens e desvantagens.  

A maioria dos providers define um modelo padr�o, ent�o, ao usar esse provider, voc� j� pode conversar imediatamente, como � o caso do groq.  
Voc� pode listar todos os modelos de LLM dispon�veis usando `Get-AiModels`. 

Para mudar o modelo padr�o, utilize `Set-AiDefaultModel`. Por exemplo: 

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

Voc� tamb�m pode gerar texto manualmente usando o comando `Get-AiChat`. Este comando envia um prompt para o LLM, sem hist�rico de conversa. Voc� tem controle total sobre os par�metros usados, como prompt, hist�rico de mensagens, streaming, etc. 

Por exemplo:
```
$resp = Get-AiChat "Ol�!"
$resp.choices[0].message.content # O resultado deste comando sempre ser� um objeto do tipo chat.completion, da OpenAI, independente do provider usado.
```

## Adicionando ferramentas 

O PowershAI permite que voc� adicione ferramentas ("tools") aos modelos que as suportam. Pense em uma tool como uma fun��o que voc� d� ao LLM. � como se estivesse dando habilidades adicionais ao modelo, permitindo que ele obtenha informa��es externas, execute a��es, etc. Aqui � onde sua criatividade entra em cena.

No PowershAI, voc� define uma tool criando uma fun��o e documentando-a com coment�rios no c�digo. Veja este exemplo:

```powershell 

function GetDateTime {
	<#
		.SYNOPSIS 
			Obt�m a data e hora atual.
	#>
	param()
	
	Get-Date
}

function GetTopProcesses {
	<#
		.SYNOPSIS 
			Obt�m os processos que mais consomem mem�ria, mostrando o nome do processo, a quantidade total de mem�ria (em bytes) e o uso total de CPU.
	#>
	param(
		# Limita a quantidade de processos retornados
		[int]$top = 10
	)
	
	Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First $top -Property Name, WorkingSet64, CPU
}

# Importe o m�dulo do PowershAI
import-module powershai;

# Use o provider Groq
Set-AiProvider groq 

# Selecione um modelo que suporte a chamada de ferramentas (tools)
Get-AiModels | ? { $_.tools }

# Defina o modelo padr�o
Set-AiDefaultModel llama-3.3-70b-versatile

# Teste sem ferramentas adicionadas
ia "Quantas horas s�o agora?"

# Adicione a tool GetDateTime
Add-AiTool GetDateTime

ia "Quantas horas s�o agora?"

# Obtenha uma vis�o geral dos processos sem ferramentas
ia "Me d� uma vis�o geral dos 20 processos em execu��o."

# Adicione a fun��o GetTopProcesses como uma ferramenta
Add-AiTool GetTopProcesses

ia "Me d� uma vis�o geral dos 15 processos que mais consomem mem�ria."
```

Observe no exemplo acima como usamos coment�rios para documentar a fun��o e seus par�metros. Isso traz flexibilidade e agilidade na integra��o de seus scripts com modelos de IA. Ent�o usamos o comando Add-AiTool para registrar essa fun��o como um tool que pode ser invocada.  Todo o help da fun��o, e dos par�metros, s�o transformados em um formato aceit�vel pelo modelo.  O modelo ent�o, baseado no texto enviado (e no hist�rico anterior), pode decidir invocar a tool. Quando ele decide invocar o a tool, ele envia uma resposta de volta ao PowershAI, contendo as tools que quer invocar e os argumentos a serem passados. O powershai ent�o, detecta esse pedido e executa as fun��es solicitadas. Ou seja, as fun��es s�o executadas na pr�pria sess�o do powershell em que voc� est�.

Voc� tamb�m pode adicionar comandos nativos do PowerShell. O PowershAI usar� a documenta��o desses comandos para descrever a ferramenta e seus par�metros. 

Por exemplo, voc� poderia adicionar o comando Get-Date diretamente como uma ferramenta. 

```powershell
# Remova todas as ferramentas adicionadas anteriormente (este comando n�o exclui as fun��es, apenas remove a associa��o com a conversa)
Get-AiTools | Remove-AiTool

# Apague o hist�rico de conversas (voc� deve confirmar). Fazemos isso para que o modelo n�o considere as respostas anteriores.
Reset-PowershaiCurrentChat

# Pergunte sobre a data atual sem adicionar ferramentas
ia "Qual � a data de hoje?"

# Adicione o comando Get-Date como uma ferramenta
Add-AiTool Get-Date
```

Voc� pode adicionar ferramentas de outras maneiras, como scripts .ps1 ou execut�veis. Consulte a ajuda do comando `Add-AiTool` para obter mais detalhes.

> [!WARNING]
> Por mais que os modelos possuam filtros e diveras barreiras de seguran�a, dar ele acesso a sua sess�o do powershai pode ser perigoso
> Portanto, somente adicione tools definidas e revisadas por voc� (ou de fontes que voc� confia)
> Uma vez que o modelo pode livremente decidir invocar uma tool, ele ter� acesso ao mesmo n�vel de privil�gio que o seu!

## Salvando as configura��es 

Por fim, � importante conhecer a capacidade de salvar suas configura��es do PowershAI. Seria tedioso ter que gerar uma nova chave API a cada vez que voc� quisesse usar o m�dulo. 

Para facilitar o uso do PowershAI e manter a seguran�a, voc� pode exportar suas configura��es usando `Export-PowershaiSettings`.


```powershell 
Export-PowershaiSettings
```

Basta digitar o comando e o PowershAI pedir� uma senha. Em seguida, ele criptografar� todas as configura��es da sess�o atual em um arquivo, usando as chaves geradas a partir dessa senha.

Para importar as configura��es salvadas, use `Import-PowershaiSettings`.

```powershell 
Import-PowershaiSettings
```

Lembre-se de escolher uma senha forte e memoriz�-la, ou guard�-la em um local seguro. O objetivo deste comando � facilitar o uso interativo do PowershAI. Para uso em segundo plano, � recomend�vel configurar vari�veis de ambiente.