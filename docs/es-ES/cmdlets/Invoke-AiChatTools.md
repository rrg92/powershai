---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Envía mensaje a un LLM, con soporte a Tool Calling, y ejecuta las tools solicitadas por el modelo como comandos powershell.

## DESCRIPTION <!--!= @#Desc !-->
Esta es una función auxiliar para ayudar a hacer el procesamiento de tools más fácil con powershell.
Él maneja el procesamiento de las "Tools", ejecutándolas cuando el modelo las solicita!

Debes pasar las tools en un formato específico, documentado en el tema about_Powershai_Chats
Este formato mapea correctamente funciones y comandos powershell al esquema aceptable por OpenAI (OpenAPI Schema).  

Este comando encapsula toda la lógica que identifica cuando el modelo quiere invocar la función, la ejecución de estas funciones, y el envío de esa respuesta de vuelta al modelo.  
Él permanece en este loop hasta que el modelo pare de decidir invocar más funciones, o que el límite de interacciones (sí, aquí las llamamos interacciones, no iteraciones) con el modelo haya finalizado.

El concepto de interacción es simple: Cada vez que la función envía un prompt al modelo, cuenta como una integración.  
Debajo está un flujo típico que puede suceder:
	

Puedes obtener más detalles de cómo funciona consultando el tema about_Powershai_Chats

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] 
[[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
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
Usa los resultado de Get-OpenaiTool* para generar los valores posibles.  
Puedes pasar un array de objetos del tipo OpenaiTool.
Si una misma funcion estiver definida en más de 1 tool, la primera encontrada en la ordem definida será usada!

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




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
