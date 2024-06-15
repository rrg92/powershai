# PowershAI

PowershAI (PowerShell + AI) é um modulo que adiciona funcionalidades para que você possa usar serviços de Inteliência Artificial direto no PowerShell.  
Você pode invocar os comandos em um script ou na linha de comando.  

Ele é útil para testar chamadas ou integrar tarefas simples com algum serviço de IA.  

Atualmente, o PowerShai suporta apenas os serviços compatíveis com a API da OpenAI.  
Mas, outros serviços serão adicionados!

# Como usar

Toda a funcionalidade fica no arquivo powershai.psm1, que é um módulo powershell.  
Você pode baixar para um diretório qualquer na sua máquina e importar:

```powershell
import-module CAMINHO\powershai.psm1
```

Você pode instalar no seu diretório de módulos e importá-lo apenas usando o nome `import-module powershai.psm1`

A API padrão é a da OpenAI, então, para começar a usá-la, insira seu token usando o comando `Set-OpenaiToken`.  
Siga as instruções (não cole seu token direto no prompt não deixar histórico, pois ele é um dado sensível).  

Caso queria usar em algum script, de maneira automática, define o token usando  variável de ambiente OPENAI_API_KEY.  
Utilize meios seguros para definir a variável de ambiente.  

Uma vez que você seu token está configurado, basta chamar qualquer umas dos comandos disponíveisl.  
Por exemplo, o comando `Get-OpenAiChat` invoca um chat, respondendo suas perguntas, instruções o apenas complentando o texto.

Exemplo:

```powershell
Get-OpenaiChat "Olá, voce conhece PowerShell?"
```

O retorno dessa funcao é o mesmo da api da OpenAI.  


E, por fim, você pode querer aprender como tudo isso pode ser usando o comando `ChaTest`.  

```powershell
ChaTest
```

Com este comando, será criado um pequeno ChatClient no proprio prompt onde você poderá interagir diretamente com o modelo, enviando e recebendo respostas, mantenod o histórico.  

## Function Calling

Umas grandes coisas que decidi implantar aqui é o suporte a Function Calling (ou Tool Calling).
O Function Calling é um recurso que tem sido implantando nos LLMs que permite executar funções externas.  
Basicamente, você descreve uma ou mais função, e seus parâmetros, e o modelo pode decidir invocá-la.  
Mais sobre o function calling: https://platform.openai.com/docs/guides/function-calling

A grande sacada é que não é o modelo que executa o código, e sim o client (no caso, o PowershAI).
Ou seja, você é o responsável por descrever e controlar o código que o modelo vai rodar, e fornecer o ambiente para isso.  
O resultado da sua função, deve ser enviado de volta ao modelo para que ele continue gerando a resposta. 

E, isso me deu a ideia de implementar um executor de funcoes integrado ao PowershAI.  
O Powershell tem um excelente mecanismo de documentação de código com comentários, que deixou isso mais prático e fácil ainda!

Veja um exemplo na prática:  

Crie um arquivo chamado MinhasFuncoes.ps1 com o seguinte conteudo:

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
		Obtem um numero aleatorio!
#>
function NumeroAleatorio {
	param(
		#Numero minimo
		$Min = $null
		
		,#Numero maximo
		$Max = $null
	)
	return Get-Random -Min $Min -Max $max;
}
```

Agora, invoque o ChaTest, passando o caminho do arquivo:


```powershell
Chatest -Functions C:\temp\MinhasFuncoes.ps1
```

Note o uso dos comentarios para descrever funcoes e parametros.  
Esta é uma sintaxe suportada pelo Powershell, é o [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4)

Experimente pedir ao modelo qual a data atual ou peça pra ele gerar um número aleatório!  
Você vai ver que ele vai executar suas funcoes!

Isso abre possibilidades infinitas, e sua criatividades é o limite!


# MUITO IMPORTANTE SOBRE FUNCTION CALLING  

Você notou que o recurso de Function Calling é poderoso por permitir executar código.  
E, ao mesmo tempo, é perigoso. Portanto, tenha extrema cautela com o que você implementa.  
Lembre-se que o PowershAI vai executar conforme o modelo pedir.  

Algumas dicas de segurança:

- Evite rodar o script com o usuario Administrador
- Evite implementar codigo que exclua ou modifique dados importantes 
- Teste as funcoes antes
- Não inclua modulos ou scritps de terceiros que você não conheça



# Explore  e Contribua

Há muito o que documentar e evoluir no PowershAI ainda!  
A medida que vou fazendo, deixo comentários no código para ajudar os curiosos que queiram aprender como eu fiz!  
Fique a vontade para explorar e contribuir com sugestoes de melhorias.


# Outros projetos com PowerShell  

Eu vi que existem alguns outros projetos que integram o PowerShell com IA, e são bem interessante.  
Aqui estão os dois que eu mai gostei:


- https://github.com/dfinke/PSAI
- https://github.com/mkht/PSOpenAI
- https://github.com/potatoqualitee/dbatools.ai









