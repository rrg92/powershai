---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Cria um novo objeto que representa os parâmetros de um PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
Cria um ojbeto padrao contendo todos o spossveis parametros que podem ser usados no chat!
O usuário pode usar um get-help New-PowershaiParameters para obter a doc dos parametros.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] 
[[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Quando true, usa o modo stream, isto é, as mensagens são mostradas a medida que o modelo as produz

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
Habilia o modo JSON. Nesse modo, o modelo é forçado a retornar uma resposta com JSON.  
Quandoa ativado, as mensagens geradas via stream não sãoe xibidas a medida que são produzidas, e somente o resultado final é retornado.

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Nome do modelo a ser usado  
Se null, usa o modelo definido com Set-AiDefaultModel

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
Maximo de tokens a ser retornado pelo modelo

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 2048
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowFullSend
Printa o prompt inteiro que está sendo enviado ao LLM

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowTokenStats
Ao final de cada mensagem, exibe as estatísticas de consumo, em tokens, retornadas pela API

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
Maximo de interacoes a serem feitas de um só vez 
Cada vez uma mensagem é enviada, o modelo executa 1 iteração (envia a mensagem e recebe uma resposta).  
Se o modelo pedir um function calling, a restpoa gerada será enviada novamente ao modelo. Isso conta como outra interacao.  
Esse parâmetro controla o máximo de interacoes que podem existir em cada chamada.
Isso ajuda a prevenir loops infinitos inesperados.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 50
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
MAximo de erros em sequencia gerado por Tool Calling.  
Ao usar tool calling, esse parametro limita quantos tools sem sequencia que resultaram em erro podem ser chamados.  
O erro consideraod é a exception disparada pelo script ou comando configuirado.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 5
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxContextSize
Tamanho máximo do contexto, em caracteres 
No futuro, será em tokens 
Controla a quantidade de mensagens no contexto atual do chat. Quando esse número ultrapassar, o Powershai limpa automaticamente as mensagens mais antigas.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: 8192
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterFunc
Função usada para formatação dos objetos passados via pipeline

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: ConvertTo-PowershaiContextOutString
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterParams
Argumentos para ser passados para a ContextFormatterFunc

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowArgs
Se true, exibe os argumenots das funcoes quando o Tool Calling é ativado para executar alguma funcao

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolsResults
Exibe os resultados das tools quando são executadas pelo PowershAI em resposta ao tool calling do modelo

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 13
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -SystemMessageFixed
System Message que é garantida ser enviada sempre, independente do histórico e clenaup do chat!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 14
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Parãmetros a serem passados diretamente para a API que invoca o modelo.  
O provider deve implementar o suporte a esse.  
Para usá-lo você deve saber os detalhes de implementação do provider e como a API dele funciona!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormat
Controla o template usado ao injetar dados de contexto!
Este parâmetro é um scriptblock que deve retornar uma string com o contexto a ser injetado no prompt!
Os parâmetros do scriptblock são:
	FormattedObject 	- O objeto que representa o chat ativo, já formatado com o Formatter configurado
	CmdParams 			- Os parâmetros passados para Send-PowershaAIChat. É o mesmo objeto retorndo por GetMyParams
	Chat 				- O chat no qual os dados estão sendo enviados.
Se nulo, irá gerar um default. Verifique o cmdlet Send-PowershaiChat para detalhes

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 16
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```