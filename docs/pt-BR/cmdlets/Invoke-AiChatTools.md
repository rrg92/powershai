---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Envia mensagem para um LLM, com suporte a Tool Calling, e executa as tools solicitadas pelo modelo como comandos powershell.

## DESCRIPTION <!--!= @#Desc !-->
Esta é uma função auxiliar para ajudar a fazer o processamento de tools mais fácil com powershell.
Ele lida com o processamento das "Tools", executando quando o modelo solicita!

Você deve passar as tools em um formato específico, documentando no tópico about_Powershai_Chats
Esse formato mapeia corretamente funções e comandos powershell pra o esquema aceitável pela OpenAI (OpenAPI Schema).  

Este comando encapsula toda a lógica que identifica quando o modelo quer invocar a função, a execução dessas funções,e o envio dessa resposta de volta ao modelo.  
Ele fica nesse loop até que o modelo pare de decidir invocar mais funções, ou que o limite de interações (sim, aqui chamamos de interações mesmo, e não iterações) com o modelo tenha finalizado.

O conceito de interação é simples: Cada vez que a função envia um prompt para o modelo, conta como uma integração.  
Abaixo está um fluxo típico que pode acontecer:
	

Você pode obter mais detalhes do funcionamento consultando o tópico about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] 
<Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [[-ProviderRawParams] <Object>] [[-AiChatParams] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt

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

### -Tools
Array de tools, conforme explicado na doc deste comando
Use os resultado de Get-OpenaiTool* para gerar os valores possíveis.  
Você pode passar um array de objetos do tipo OpenaiTool.
Se uma mesma funcoes estiver definida em mais de 1 tool, a primeira encontrada na ordem definida será usada!

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

### -PrevContext

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

### -MaxTokens
máx output!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 500
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
No total, permitir no max 5 iteracoes!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Quantidade maximo de erros consecutivos que sua funcao pode gerar antes que ele encerre.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 2
Accept pipeline input: false
Accept wildcard characters: false
```

### -temperature

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -on
Event handler
Cada key é um evento que será disparado em algum momento por esse comando!
eventos:
answer: disparado após obter a resposta do modelo (ou quando uma resposta fica disponivel ao usar stream).
func: disparado antes de iniciar a execução de uma tool solicitada pelo modelo.
	exec: disparado após o modelo executar a funcao.
	error: disparado quando a funcao executada gera um erro
	stream: disparado quando uma resposta foi enviada (pelo stream) e -DifferentStreamEvent
	beforeAnswer: Disparado após todas as respostas. Util quando usado em stream!
	afterAnswer: Disparado antes de iniciar as respostas. Util quando usado em stream!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Envia o response_format = "json", forçando o modelo a devolver um json.

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Adicionar parâmetros customizados diretamente na chamada (irá sobrescrever os parâmetros definidos automaticamente).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Stream

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ProviderRawParams
Especifica raw params por provider. Será enviado ao Get-AiChat, portanto, é o mesmo funcionamento.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -AiChatParams
Sobrescrever os parâmetros de Get-AiChat

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```