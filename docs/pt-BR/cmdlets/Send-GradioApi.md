---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Envia dados a um Gradio e retorna um objeto que representa o evento!
Passe esse objeto para os demais cmdlets para obter os resultados.

FUNCIONAMENTO DA API DO GRADIO 

	Baseado em: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	Para entender melhor como usar este cmdlet, é importante entender como a API do Gradio funciona.  
	Quando invocamos algum endpoint da API, ele não retorna os dados imediatamente.  
	Isso se deve ao simples fato do processamento ser extenso, devido a natureza (IA e Machine Learning).  
	
	Então, ao invés de retornar o resultado, ou aguardar indefinidamente, o Gradio retorna um "Event Id".  
	Com esse evento, conseguimos periodicamente obter os resultaods gerados.  
	O gradio vai gerar mensagens de eventos com os dados que foram gerados. Precisamos passar o EventId gerado para obter os novos pedaços gerados.
	Estes eventos são enviados via Server Side Events (SSE), e podem ser um destes:
		- hearbeat 
		A cada 15 segundos, o Gradio vai enviar este evento para manter a conexão ativa.  
		Por isso que, ao usar o cmdlet Update-GradioApiResult, ele pode demorar um pouco para retornar.
		
		- complete 
		É a última mensagem enviada pelo Gradio quando os dados foram gerados com sucesso!
		
		- error 
		Enviado quando houve algum erro no processamento.  
		
		- generating
		É gerado quando a API já tem dados disponíveis, mas, ainda pode vir mais.
	
	Aqui no PowershAI, nós separamos isso também em 3 partes: 
		- Este cmdlet (Send-GradioApi) faz a requisição inicial para o Gradio e retorna um objeto que representa o evento (chamamods ele de um objeto GradioApiEvent)
		- Este objeto resultante, de tipo GradioApiEvent,  contém tudo o que é necessário para consultar o evento e ele também guarda os dados e erros obtidos.
		- Por fim, temos o cmdlet Update-GradioApiResult, onde você deve passar o evento gerado, e ele irá consultar a API do gradio e obter os novos dados.  
			Verifiaue o help deste cmdlet para mais informações de como controlar esse mecanismo de obter os dados.
			
	
	Então, em um flixo normal, você deve fazer o seguinte: 
	
		#INvoque o endpoint do graido!
		$MeuEvento = SEnd-GradioApi ... 
	
		# Obtenha resultados até que tenha temrinado!
		# Verifique o help deste cmdlet para aprender mais!
		$MeuEvento | Update-GradioApiResult
		
Objeto GradioApiEvent

	O objeto GradioApiEvent resultante deste cmdlet contém tudo o que é necessário para que PowershAI controle o mecanismo e obtenha os dados.  
	É importante que você conheça sua estrutura para que saiba como coletar os dados gerados pela API.
	Propriedades:
	
		- Status  
		Indica o status do evento. 
		Quando este status for "complete", significa que a API já terminou o processamento e todos os dados possíveis já foram gerados.  
		Enquanto for diferente disso, você deve invocar Update-GradioApiResult para que ele chque o status e atualize as informacoes. 
		
		- QueryUrl  
		Valor interno que contém o endpoint exato par a consulta dos resultados
		
		- data  
		Um array contendo todos os dados de resposta gerado. Cada vez que você invoca Update-GradioApiResult, se houver dados, ele irá adicionar a este array.  
		
		- events  
		Lista de eventos que foram gerados pelo server. 
		
		- error  
		Se houve erros na resposta, esse campio conterá algum objeto, string, etc., descrevendo mais detalhes.
		
		- LastQueryStatus  
		Indica o status da última consulta na API.  
		Se "normal", indica que a API foi consultada e retornou até o fim normalmente.
		Se "HeartBeatExpired", indica que a consulta foi interrompida devido ao timeout de hearbeat configurado pelo usuário no cmdlet Update-GradioApiResult
		
		- req 
		Dados da requisicao feita!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] 
[[-token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ApiName

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -SessionHash

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -EventId
Se informado, não chamada a API, mas cria o objeto e usa esse valor como se fosse o retorno

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```