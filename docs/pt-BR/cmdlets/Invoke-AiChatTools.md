---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-AiChatTools

## SYNOPSIS
Envia mensagem para um LLM, com suporte a Tool Calling, e executa as tools solicitadas pelo modelo como comandos powershell.

## SYNTAX

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>]
 [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] <Object>]
 [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
```

## DESCRIPTION
Esta é uma função auxiliar para ajudar a fazer o processamento de tools mais fácil com powershell.
Ele lida com o processamento das "Tools", executando quando o modelo solicita!

Você deve passar as tools em um formato específico, documentando no tópico about_Powershai_Chats
Esse formato mapeia corretamente funções e comandos powershell pra o esquema aceitável pela OpenAI (OpenAPI Schema).
 

Este comando encapsula toda a lógica que identifica quando o modelo quer invocar a função, a execução dessas funções,e o envio dessa resposta de volta ao modelo.
 
Ele fica nesse loop até que o modelo pare de decidir invocar mais funções, ou que o limite de interações (sim, aqui chamamos de interações mesmo, e não iterações) com o modelo tenha finalizado.

O conceito de interação é simples: Cada vez que a função envia um prompt para o modelo, conta como uma integração.
 
Abaixo está um fluxo típico que pode acontecer:
	

Você pode obter mais detalhes do funcionamento consultando o tópico about_Powershai_Chats

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -prompt
{{ Fill prompt Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tools
Array de tools, conforme explicado na doc deste comando
Use os resultado de Get-OpenaiTool* para gerar os valores possíveis.
 
Você pode passar um array de objetos do tipo OpenaiTool.
Se uma mesma funcoes estiver definida em mais de 1 tool, a primeira encontrada na ordem definida será usada!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrevContext
{{ Fill PrevContext Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxTokens
máx output!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 500
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxInteractions
No total, permitir no max 5 iteracoes!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxSeqErrors
Quantidade maximo de erros consecutivos que sua funcao pode gerar antes que ele encerre.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -temperature
{{ Fill temperature Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0.6
Accept pipeline input: False
Accept wildcard characters: False
```

### -model
{{ Fill model Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
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
	beforeAnswer: Disparado após todas as respostas.
Util quando usado em stream!
	afterAnswer: Disparado antes de iniciar as respostas.
Util quando usado em stream!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Json
Envia o response_format = "json", forçando o modelo a devolver um json.

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

### -RawParams
Adicionar parâmetros customizados diretamente na chamada (irá sobrescrever os parâmetros definidos automaticamente).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream
{{ Fill Stream Description }}

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
