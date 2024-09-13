---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Update-GradioApiResult

## SYNOPSIS

## SYNTAX

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput]
 [-History] [<CommonParameters>]
```

## DESCRIPTION
Atualiza um evento retornado por Send-GradioApi com novos resultados do servidor e, por padrão, retorna os evenots no pipeline.

Os resultados das Apis do Gradio não são gerados instantaneamente, como é na maioria dos serviços HTTP REST.
 
O help do comando Send-GradioApi explica no detalhe como funciona o processo.
 

Este comando deve ser usado para atualizar o objeto GradioApiEvent, retornado pelo Send-GradioApi.
Este objeto representa a resposta de cada chamada que você na API, ele contém tudo o que é preciso para consultar o resultado, incluindo dados e histórico.

Basicamente, este cmdlet funciona invocando o endpoint de consulta do status da invocação Api.
Os parâmetros necessários para consulta estão disponíveis no próprio objeto passado no parametro -ApiEvent (que é criado e retornado pelo cmdlet Send-GradioApi)

Sempre que este cmdlet executa, ele se comunica via conexão HTTP persistente com o servidor e aguarda os eventos.
 
A medida que o servidor envia os dados, ele atualiza o objeto passado no parâmetro -ApiEvent, e, por padrão, escreve o evento retornado no pipeline.

O evento retornado é um objeto do tipo GradioApiEventResult, e representa um evento gerado pela resposta da execução da API.
 

Se o parametro -History é especificado, todos os eventos gerados ficam na propriedade events do objeto fornecido em -ApiEvent, bem como os dados retornados.

Baiscamente, os eventos gerados podem enviar um hearbeat ou dados.

OBJETO GradioApiEventResult
	num 	= número sequencial do evento.
comeca em 1.
	ts 		= data em que o evento foi criado (data local,não do servidor).
	event 	= nome do evento
	data 	= dados retornados neste evento

DADOS (DATA)

	Obter os dados do Gradio, é basicamente ler os eventos retornados por este cmdlet e olhar na propriedade data do GradioApiEventResult
	Geralmente a interface do Gradio sobrescreve o campo com o último evento recebido.
 
	
	Se -History for usado, além de escrever no pipeline, o cmdle vai guardar o dado no campo data, e portanto, você terá acesso ao histórico compelto do que foi gerado pelo servidor.
 
	Note que isso pode causar um consumo adicional de memória, se muitos dados forem retornados.
	
	Existe um caso "problemático" conhecido: eventualmente, o gradio pode emitir os 2 ultimos eventos com o mesmo dado (1 evento terá o nome "generating", e o ultimo será complete).
 
	Ainda não temos uma solução para separar isso de maneira segura, e por isso, o usuário deve decidir a melhor forma de conduzir.
 
	Se você usar sempre o último evento recebido, isso não é um problema.
	Se precisará usar todos os eventos a medida que forem sendo gerados, terá que tratar esses casos.
	Um exemplo simples seria comprar o conteudo, se fossem iguais, não repetir.
Mas podem existir cenários onde 2 eventos com o mesm conteúdo, ainda sim, sejam eventos logicamente diferentes.
	
	

HEARTBEAT 

	Um dos evetnos geraods pela API do Gradio são os Heartbeats.
 
	A cada 15 segundos, o Gradio envia um evento do tipo "HeartBeat", apenas para manter a conexão ativa.
 
	Isso faz com que o cmdlet "trave", pois, como a conexão HTTP está ativa, ele fica esperando alguma resposta (que será dados, erros ou o hearbeat).
	
	Se não houver um mecanismo de contorle disso, o cmdlet iria rodar indefiniamente, sem possibilidade de cancelar nem com o CTRL + C.
	Para resolver isso, este cmdlet disponibiliza o parãmetro MaxHeartBeats.
 
	Este parâmetro indica quantos eventos de Hearbeat consecutivos serão tolerados antes que o cmdlet pare de tentar consultar a API.
 
	
	Por exemplo, considere estes dois cenários de eventos enviados pelo servidor:
	
		cenario 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		cenario 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	Considerando o valor default, 2, no cenario 1, o cmdlet nunca encerraria antes do complete, pois apenas nunca houve 2 hearbeats consecutivos.
	
	Já no cenário 2, após receber 2 eventos de dados (generating), no quarto evento (hearbeat), ele encerraria, pois 2 hearbeats consecutivos foram enviados.
 
	Dizemos que o heartbeat expirou, neste caso.
	Neste caso, você deveria invocar novamente Update-GradioApiResult para obter o restante.
	
	Sempre que o comando encerra devido ao hearbeat expirado, ele irá atualizar o valor da propriedade LastQueryStatus para HeartBeatExpired.
 
	Com isso, você pode checar e tratar corretamente quando deve chamar novamente
	
	
STREAM  
	
	DEvido ao fato de que a Api do Gradio já responde usando SSE (Server Side Events), é possível usar um efeito parecido com o "stream" de muitas Apis.
 
	Este cmdlet, Update-GradioApiResult, já processa os eventos do servidor usando o SSE.
 
	Adicionalmente, caso você também queria fazer algum processamento a medida que o evento se torne disponível, você pode usar o parâmetro -Script e especificar uma scriptblock, funcoes, etc.
que irá ser invocado a medisa que o evento é recebido.
 
	
	Combianando com o parâmetro -MaxHeartBeats, você pode criar uma chamada que atualiza algo em tempo real. 
	Por exemplo, se for uma resposta de um chatbot, pode escreve imediatamente na tela.
	
	note que esse parâmetro é chamado em sequencia com o código que checa (isto é, mesma Thread).
 
	Portanto, scripts que demorem muito, podem atrapalhar a detecção de novos eventos, e cosequentemente, a entrega dos dados.
	
.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ApiEvent
Resultado de  Send-GradioApi

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Script
script que será invocado  em cada evento gerado!
Recebe uma hashtable com as seguintes keys:
 	event - contém o evento gerado.
event.event é o nome doe vento.
event.data são os dados retornados.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxHeartBeats
Max heartbeats consecutivos até o stop!
Faz com que o comando aguarde apenas esse número de hearbeats consecutivos do servidor.
Quando o servidor enviar essa quantiodade, o cmdlet encerra e define o LastQueryStatus do evento para HeartBeatExpired

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoOutput
Não escreve o resultado para o output do cmdlet

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

### -History
Guarda o historico de eventos e dados no objeto ApiEvent
Note que isso fará consumir mais memória do powershell!

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
