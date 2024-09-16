---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Crea un nuevo objeto que representa los parámetros de un PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
Crea un objeto estándar conteniendo todos los posibles parámetros que pueden ser usados en el chat!
El usuario puede usar un get-help New-PowershaiParameters para obtener la documentación de los parámetros.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] 
<Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Cuando true, usa el modo stream, es decir, las mensajes son mostradas a medida que el modelo las produce

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
Habilita el modo JSON. En este modo, el modelo es forzado a retornar una respuesta con JSON.  
Cuando se activa, los mensajes generados vía stream no son exibidos a medida que son producidos, y solo el resultado final es retornado.

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
Nombre del modelo a ser usado  
Si null, usa el modelo definido con Set-AiDefaultModel

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
Máximo de tokens a ser retornado por el modelo

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
Imprime el prompt entero que está siendo enviado al LLM

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
Al final de cada mensaje, exhibe las estadísticas de consumo, en tokens, retornadas por la API

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
Máximo de interacciones a serem feitas de una sola vez 
Cada vez una mensaje es enviada, el modelo ejecuta 1 iteración (envia el mensaje y recibe una respuesta).  
Si el modelo pide un function calling, la respuesta generada será enviada nuevamente al modelo. Esto cuenta como otra interacción.  
Este parámetro controla el máximo de interacciones que pueden existir en cada llamada.
Esto ayuda a prevenir loops infinitos inesperados.

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
Máximo de errores en secuencia generado por Tool Calling.  
Al usar tool calling, este parámetro limita cuántos tools sin secuencia que resultaron en error pueden ser llamados.  
El error considerado es la exception disparada por el script o comando configurado.

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
Tamaño máximo del contexto, en caracteres 
En el futuro, será en tokens 
Controla la cantidad de mensajes en el contexto actual del chat. Cuando este número sobrepase, el Powershai limpia automáticamente los mensajes más antiguos.

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
Función usada para formatación de los objetos pasados vía pipeline

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
Argumentos para ser pasados para la ContextFormatterFunc

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
Si true, exhibe los argumentos de las funciones cuando el Tool Calling es activado para ejecutar alguna función

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
Exhibe los resultados de las tools cuando son ejecutadas por el PowershAI en respuesta al tool calling del modelo

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
System Message que es garantizada ser enviada siempre, independiente del histórico y clenaup del chat!

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
Parámetros a serem passados directamente para la API que invoca el modelo.  
El provider debe implementar el soporte a este.  
Para usarlo usted debe saber los detalles de implementación del provider y como la API de él funciona!

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
Controla el template usado al inyectar datos de contexto!
Este parámetro es un scriptblock que debe retornar una string con el contexto a ser inyectado en el prompt!
Los parámetros del scriptblock son:
	FormattedObject 	- El objeto que representa el chat activo, ya formatado con el Formatter configurado
	CmdParams 			- Los parámetros pasados para Send-PowershaAIChat. Es el mismo objeto retornando por GetMyParams
	Chat 				- El chat en el cual los datos están siendo enviados.
Si nulo, irá generar un default. Verifique el cmdlet Send-PowershaAIChat para detalles

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




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
