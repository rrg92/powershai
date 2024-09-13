---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS

## SYNTAX

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force]
 [<CommonParameters>]
```

## DESCRIPTION
Cria funcoes que encapsulam as chamadas de um endpoint do Gradio (ou todos os endpoints).
 
Este cmdlet é muito útil para criar funcoes powershell que encapsulam um endpoint API do Gradio, onde os parâmetros da API são criados como parâmetros da função.
 
Assim, recursos nativos do powershell, como auto complete, tipo de dados e documentação, podem ser usados e fica muito fácil invocar qualquer endpoint de uma sessão.

O comando consulta os metadados dos endpoints e parâmetros e cria as funcoes powershell no escopo global.
 
Com isso, o usuario consegue invocar as funções diretamente, como se fossem funcoes normal.
 

Por exemplo, suponha que uma aplicação Gradio no endereço http://mydemo1.hf.space tenho um endpoint chamado /GenerateImage para gerar imagens com o Stable Diffusion.
 
Assuma que essa aplicação aceite 2 parâmetros: Prompt (a descriao da imagem a ser gerada) e Steps (o numero total de steps).

Normalmente, voce poderia usar o comando Invoke-GradioSessionApi, assim: 

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

Isso iria dar inicio a API, e você poderia obter os resultados usando Update-GradioApiResult:

$ApiEvent | Update-GradioApiResult

Com este cmdlet, você consegue encapsular um pouco mais estas chamadas:

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

O comando acima criará uma funcao chamada Invoke-GradioApiGenerateimage.
Então, voc poe usar de maneira simples para gerar a imagem:

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100 

Por padrão, o comando executaria e já iria obter os eventos de resultados, escrevendo no pipeline para que você possa integrar com outros comandos.
 
Inclusive, conectar vários spaces é muito simples, veja abaixo sobre pipeline.

NOMENCLATURA 

	O nome das funcoes criadas segue o formato:  \<Prefix\>\<NomeOp\>
		\<Prefix\> é o valor do parametro -Prefix deste cmdlet. 
		\<NomeOp\> é o nome da operacao, mantido somente letras e números
		
		Por exemploi, se a operção é /Op1, e o Prefixo INvoke-GradioApi, a seguinte funcao será criad: Invoke-GradioApiOp1

	
PARAMETROS
	As funcoes criadas contém a lógica necessária para transformar os parâmetros passados e executar o cmdlet Invoke-GradioSessionApi.
 
	Ou seja, o mesmo retorno se aplica como se estivesse invocando este cmdlet diretamente. 
(Isto é, um evento será retornado e adicionaod alista de eventos da sessao atual).
	
	Os parâmetros das funcoes podem variar conforme o endpoint da API, pois cada endpoint possui um conjunto diferente de parâmetros e tipos de dados.
	Parâmetros que são arquivos (ou lista de arquivos), possuem um passo adicional de upload.
O arquivo pode ser referenciado localmente e o upload dele sera feito para o servidor.
 
	Caso seja informado uma URL, ou um objeto FileData recebido de outro comando, nenhum upload adicional será feito, apenas será gerado um objeto FileData correspondente para envio via API.

	Além dos parâmetros do endpoint, há um conjunto adicional de parâmetros que sempre serão adicionados a funcao criada.
 
	São eles:
		- Manual  
		Se usado, faz com que o cmdlet retorne o evento gerado por INvoke-GradioSessionApi.
 
		Neste caso você terá que manualmente obter os resultados usando Update-GradioSessionApiResult
		
		- ApiResultMap 
		Mapeia os resultados de outros comandos para os parâmetros.
Veha mais sobre na seção PIPELINE.
		
		- DebugData
		Para fins de debug pelos desenvolvedores.
		
UPLOAD 	
	Parametros que aceitam arquivos são tratados de uma maneira especial.
 
	Antes da invocacao da API, o cmdlet Send-GradioSessionFiles éusado para fazer o upload desses arquivos para o respectivo app gradio.
 
	Isso é uma oura grande vantagem de se usar esse cmdlet, pois isso fica transparente, e o usuário não precisa lidar com uploads.

PIPELINE 
	
	Uma das funcionalidades mais poderosas do powershell é o pipeline, one é possível conectar vários comandos usando o pipe |.
	E este cmdlet procura também usurfruir ao máximo desse recurso.
 
	
	Todas as funcoes criadas podem ser conectadas com o |.
	Ao fazer isso, cada evento gerado pelo cmdlet anterior é passado para o próximo.
 
	
	Considere duas apps gradios, App1 e App2.
	App1 possui o endpoint Img, com um parametro chamado Text, que gera imagens usando Diffusers, exibindo as parciais de cada imagem a medida que são geradas.
	App2 possui um endpoint Ascii, com um parametor chamado Image, que transforma uma iamgem em uma versão ascii em texto.
	
	Você pode conectar estes dois comandos de uma maneira muito simpels com o pipeline.
 
	Primeiro, crie as sessoes

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator
		
	Crie as funcoes 
		$App1 | New-GradioSessionApiProxy -Prefix App # isso criar a funcao AppImg
		$App2 | New-GradioSessionApiProxy -Prefix App # isso criar a funcao AppAscii
		
	Gere a imagem e conecte com o gerador asciii :
	
	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data\[0\]; write-host $_.pipeline\[0\].data\[0\].url } 
	
	Agora vamos quebrar a sequencia acima.
	
	Antes do primeiro pipe, temos o comando que gera a imagem: AppImg -Text "A car" 
	Esta funcao está chamado o endpoint /Img de App1.
Este endpoint produz uma saida para etapa da geracao de imagens com a lib Diffusers do hugging face.
 
	Neste caso, cada saida será uma imagem (bem embaraçada), até a última saida que será a iamgem final.
 
	Este resultado fica na proprodade data do objeto do pipeline.
Ela é um array com os resultados.
	
	Logo em seguida no pipe, temos o comando: AppAscii -Map ImageInput=0
	Este comando irá recber cada objeto gerado pelo comando AppImg, que no caso, são as imagens parciais do processo de difusão.
 
	
	Devido ao fato os comandos podem gerar uma rray de saidas, é preciso mapear exatamente qual dos resultados devem ser associados com quais parametros.
 
	Por isso, usamos o parametro -Map (-Map é um Alias, na verdade, o nome correto é ApiResultMap)
	A sintaxe é simples: NomeParam=DataIndex,NomeParam=DataIndex  
	No comando acima, estamos dizendo: AppAscii, utilize o primeiro valor da proprodiade data no parametro ImageInput.
 
	Por exemplo, se AppImg retornasse 4 valores, e imagem estivesse na ultima posicao, vc deveria usar ImageInput=3 (0 é a primeira).
	
	
	Por fim, o ultiomo pipe apenas evole o resultado de AppAscii, que agora se encontrano objeto do pipeline, $_, na proprodade .data (igual o resultado de AppImg).
 
	E, para complementar, o objeto do pipeline possui uma proprodade especial, chamada pipeline.
Com ela, voce acessar todos os resultados dos comandos geraod.s  
	Por exemplo, $_.pipeline\[0\], contém o resultado do primeiro comando (AppImg). 
	
	Graça a esse mecanismo, fica muito mais fácil conectar diferentes apps Gradio em unico pipeline.
	Note que esta sequencia funciona apenas entre comandos gerados por New-GradioSessionApiProxy.
Fazer o pipe de outros comanos, não irá produzir esse mesmo efeito (terá qiue usar algo como o For-EachObject e associar os parametros diretamente)


SESSOES 
	Quando a funcao é criada, a sessao de origem é cravada junto com a funcao .
 
	Se a sessao for removida, o cmdlet irá gerar um erro.
NEste caso, voce deve criar a funcao invocando este cmdlet novamente.
 


O seguinte diagrama resume as dependencias envolvidas:

	New-GradioSessionApiProxyFunction(Prefix)
		---\> function \<Prefix\>\<OpName\>
			---\> Send-GradioSessionFiles (quando houer arquivos)
			---\> Invoke-GradioSessionApi | Update-GradioSessionApiResult

Uma vez que Invoke-GradioSessionApi é a executada no fim das contas, todas as regras delas se aplicam.
Voce pode ser Get-GradioSessionApiProxyFunction para obter uma lista do que foi craido e Remove-GradioSessionApiProxyFunction para remover uma ou mais funcoes criadas.
 
As funcoes são criadas com um modulo dinamico.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ApiName
Criar somente para este endpoint em especifico

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix
Prefixo das funcoes criadas

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Invoke-GradioApi
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session
Sessao

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: .
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
Força  a criação da funcão, mesmo se já existir uma com o mesmo nome!

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
