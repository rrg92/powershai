---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# New-PowershaiParameters

## SYNOPSIS
Cria um novo objeto que representa os parâmetros de um PowershaiChat

## SYNTAX

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>]
 [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] [[-MaxInteractions] <Object>]
 [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>]
 [[-ContextFormatterParams] <Object>] [[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>]
 [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Cria um ojbeto padrao contendo todos o spossveis parametros que podem ser usados no chat!
O usuário pode usar um get-help New-PowershaiParameters para obter a doc dos parametros.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -stream
Quando true, usa o modo stream, isto é, as mensagens são mostradas a medida que o modelo as produz

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -Json
Habilia o modo JSON.
Nesse modo, o modelo é forçado a retornar uma resposta com JSON.
 
Quandoa ativado, as mensagens geradas via stream não sãoe xibidas a medida que são produzidas, e somente o resultado final é retornado.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -model
Nome do modelo a ser usado  
Se null, usa o modelo definido com Set-AiDefaultModel

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxTokens
Maximo de tokens a ser retornado pelo modelo

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 2048
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowFullSend
Printa o prompt inteiro que está sendo enviado ao LLM

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowTokenStats
Ao final de cada mensagem, exibe as estatísticas de consumo, em tokens, retornadas pela API

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxInteractions
Maximo de interacoes a serem feitas de um só vez 
Cada vez uma mensagem é enviada, o modelo executa 1 iteração (envia a mensagem e recebe uma resposta).
 
Se o modelo pedir um function calling, a restpoa gerada será enviada novamente ao modelo.
Isso conta como outra interacao.
 
Esse parâmetro controla o máximo de interacoes que podem existir em cada chamada.
Isso ajuda a prevenir loops infinitos inesperados.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxSeqErrors
MAximo de erros em sequencia gerado por Tool Calling.
 
Ao usar tool calling, esse parametro limita quantos tools sem sequencia que resultaram em erro podem ser chamados.
 
O erro consideraod é a exception disparada pelo script ou comando configuirado.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxContextSize
Tamanho máximo do contexto, em caracteres 
No futuro, será em tokens 
Controla a quantidade de mensagens no contexto atual do chat.
Quando esse número ultrapassar, o Powershai limpa automaticamente as mensagens mais antigas.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 8192
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContextFormatterFunc
Função usada para formatação dos objetos passados via pipeline

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: ConvertTo-PowershaiContextOutString
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContextFormatterParams
Argumentos para ser passados para a ContextFormatterFunc

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowArgs
Se true, exibe os argumenots das funcoes quando o Tool Calling é ativado para executar alguma funcao

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrintToolsResults
Exibe os resultados das tools quando são executadas pelo PowershAI em resposta ao tool calling do modelo

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SystemMessageFixed
System Message que é garantida ser enviada sempre, independente do histórico e clenaup do chat!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RawParams
Parãmetros a serem passados diretamente para a API que invoca o modelo.
 
O provider deve implementar o suporte a esse.
 
Para usá-lo você deve saber os detalhes de implementação do provider e como a API dele funciona!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContextFormat
Controla o template usado ao injetar dados de contexto!
Este parâmetro é um scriptblock que deve retornar uma string com o contexto a ser injetado no prompt!
Os parâmetros do scriptblock são:
	FormattedObject 	- O objeto que representa o chat ativo, já formatado com o Formatter configurado
	CmdParams 			- Os parâmetros passados para Send-PowershaAIChat.
É o mesmo objeto retorndo por GetMyParams
	Chat 				- O chat no qual os dados estão sendo enviados.
Se nulo, irá gerar um default.
Verifique o cmdlet Send-PowershaiChat para detalhes

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
