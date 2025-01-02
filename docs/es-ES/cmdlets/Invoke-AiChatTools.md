---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Envía un mensaje a un LLM, con soporte para Tool Calling, y ejecuta las herramientas solicitadas por el modelo como comandos powershell.

## DESCRIPTION <!--!= @#Desc !-->
Esta es una función auxiliar para ayudar a hacer el procesamiento de herramientas más fácil con powershell.
¡Él maneja el procesamiento de las "Tools", ejecutando cuando el modelo lo solicita!

Debes pasar las herramientas en un formato específico, documentando en el tema about_Powershai_Chats
Este formato mapea correctamente funciones y comandos powershell para el esquema aceptable por OpenAI (OpenAPI Schema).  

Este comando encapsula toda la lógica que identifica cuando el modelo quiere invocar la función, la ejecución de estas funciones, y el envío de esa respuesta de vuelta al modelo.  
Él permanece en este bucle hasta que el modelo deje de decidir invocar más funciones, o que el límite de interacciones (sí, aquí llamamos interacciones y no iteraciones) con el modelo haya finalizado.

El concepto de interacción es simple: Cada vez que la función envía un prompt al modelo, cuenta como una integración.  
A continuación se muestra un flujo típico que puede ocurrir:
	

Puedes obtener más detalles del funcionamiento consultando el tema about_Powershai_Chats

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
Array de herramientas, conforme explicado en la doc de este comando
Usa los resultados de Get-OpenaiTool* para generar los valores posibles.  
Puedes pasar un array de objetos del tipo OpenaiTool.
¡Si una misma función está definida en más de 1 herramienta, la primera encontrada en el orden definido será usada!

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
En total, permitir un máximo de 5 iteraciones!

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

### -MaxSeqErrorsQuantidade máximo de errores consecutivos que su función puede generar antes de que se cierre.

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
Manejador de eventos
¡Cada key es un evento que será disparado en algún momento por este comando!
eventos:
answer: disparado después de obtener la respuesta del modelo (o cuando una respuesta queda disponible al usar stream).
func: disparado antes de iniciar la ejecución de una herramienta solicitada por el modelo.
	exec: disparado después de que el modelo ejecute la función.
	error: disparado cuando la función ejecutada genera un error
	stream: disparado cuando se ha enviado una respuesta (por el stream) y -DifferentStreamEvent
	beforeAnswer: Disparado después de todas las respuestas. ¡Útil cuando se usa en stream!
	afterAnswer: Disparado antes de iniciar las respuestas. ¡Útil cuando se usa en stream!

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
Envía el response_format = "json", forzando al modelo a devolver un json.

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
Agregar parámetros personalizados directamente en la llamada (sobrescribirá los parámetros definidos automáticamente).

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
Especifica raw params por proveedor. Se enviará a Get-AiChat, por lo tanto, tiene el mismo funcionamiento.

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
Sobrescribir los parámetros de Get-AiChat

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
