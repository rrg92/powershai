---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Envia mensagens para um LLM e retorna a resposta

## DESCRIPTION <!--!= @#Desc !-->
Esta é a forma mais básica de Chat promovida pelo PowershAI.  
Com esta função, você pode enviar uma mensagem para um LLM do provider atual.  

Esta função é mais baixo nível, de maneria padronizada, de acesso a um LLM que o powershai disponibiliza.  
Ela não gerencia histórico ou contexto. Ela é útil para invocar promps simples, que não requerem várias interações como em um Chat. 
Apesar de suportar o Functon Calling, ela não executa qualquer código, e apenas devolve a resposta do modelo.



** INFORMACOES PARA PROVIDERS
	O provider deve implementar a função Chat para que esta funcionalidad esteja disponíveil. 
	A função chat deve retornar um objeto com a resposta com a mesma especificação da OpenAI, função Chat Completion.
	Os links a seguir servem de base:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (retorno sem streaming)
	O provider deve implementar os parâmetros dessa função. 
	Veja a documentação de cada parãmetro para detalhes e como mapear para um provider;
	
	Quando o modelo não suportar um dos parâmetros informados (isto pé, não houver funcionalidade equivalente,ou que possa ser implementanda de maneira equivalente) um erro deverá ser retornado.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
O prompt a ser enviado. Deve ser no formato descrito pela função ConvertTo-OpenaiMessage

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

### -temperature
Temperatuta do modelo

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Nome do modelo. Se não especificado, usa o default do provider.

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
Máximo de tokens a ser retornado

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
Formato da resposta 
Os formatos aceitáveis, e comportamento, devem seguir o mesmo da OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Atalhos:
	"json", equivale a {"type": "json_object"}

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

### -Functions
Lista de tools que devem ser invocadas!
Você pode usar o comandos como Get-OpenaiTool*, para transformar funcões powershell facilmente no formato esperado!
Se o modelo invocar a função, a resposta, tanto em stream, quanto normal, deve também seguir o modelo de tool caling da OpenAI.
Este parâmetro deve seguir o mesmo esquema do Function Calling da OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Especifique parâmetros diretos da API do provider.
Isso irá sobrescrever os valores que foram calculados e gerados com base nos outros parâmetros.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback
Habilita o modelo Stream 
Você deve especificar um ScriptBlock que será invocado para cada texto gerado pelo LLM.
O script deve receber um parâmetro que representa cada trecho, no mesmo formato de streaming retornado
	Este parâmetro é um objeto que conterá a propridade choices, que é nom mesmo esquema retornado pelo streaming da OpenAI:
		https://platform.openai.com/docs/api-reference/chat/streaming

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

### -IncludeRawResp
Incluir a resposta da API em um campo chamado IncludeRawResp

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