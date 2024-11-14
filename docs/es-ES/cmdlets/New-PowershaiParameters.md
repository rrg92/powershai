---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
Crea un nuevo objeto que representa los parámetros de un PowershaiChat

## DESCRIPTION <!--!= @#Desc !-->
Crea un objeto estándar que contiene todos los posibles parámetros que pueden ser utilizados en el chat.
El usuario puede usar un get-help New-PowershaiParameters para obtener la documentación de los parámetros.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] 
<Boolean>] [[-ShowTokenStats] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] 
[[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] 
[[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
Cuando es verdadero, usa el modo stream, es decir, los mensajes se muestran a medida que el modelo los produce

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
Habilita el modo JSON. En este modo, el modelo se ve obligado a devolver una respuesta en JSON.  
Cuando está activado, los mensajes generados a través del stream no se exhiben a medida que son producidos, y solo se devuelve el resultado final.

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
Nombre del modelo a ser utilizado  
Si es nulo, utiliza el modelo definido con Set-AiDefaultModel

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
Máximo de tokens a ser devueltos por el modelo

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
Imprime el prompt completo que se está enviando al LLM

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
Al final de cada mensaje, muestra las estadísticas de consumo, en tokens, devueltas por la API

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
Máximo de interacciones a realizar de una sola vez 
Cada vez que se envía un mensaje, el modelo ejecuta 1 iteración (envía el mensaje y recibe una respuesta).  
Si el modelo pide una llamada a función, la respuesta generada se enviará nuevamente al modelo. Esto cuenta como otra interacción.  
Este parámetro controla el máximo de interacciones que pueden existir en cada llamada.
Esto ayuda a prevenir bucles infinitos inesperados.

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
Máximo de errores en secuencia generados por Tool Calling.  
Al usar tool calling, este parámetro limita cuántas herramientas sin secuencia que resultaron en error pueden ser llamadas.  
El error considerado es la excepción disparada por el script o comando configurado.

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
Controla la cantidad de mensajes en el contexto actual del chat. Cuando este número se supere, Powershai limpia automáticamente los mensajes más antiguos.

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
Función utilizada para formatear los objetos pasados a través del pipeline

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
Argumentos a ser pasados a la ContextFormatterFunc

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
Si es verdadero, muestra los argumentos de las funciones cuando se activa Tool Calling para ejecutar alguna función

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
Muestra los resultados de las herramientas cuando son ejecutadas por PowershAI en respuesta al tool calling del modelo

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
Mensaje del sistema que se garantiza que se envíe siempre, independientemente del historial y limpieza del chat.

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
Parámetros a ser pasados directamente a la API que invoca el modelo.  
El proveedor debe implementar el soporte a esto.  
Para usarlo, debes conocer los detalles de implementación del proveedor y cómo funciona su API.

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
Controla la plantilla utilizada al inyectar datos de contexto.
Este parámetro es un scriptblock que debe devolver una cadena con el contexto a ser inyectado en el prompt.
Los parámetros del scriptblock son:
	FormattedObject 	- El objeto que representa el chat activo, ya formateado con el Formatter configurado
	CmdParams 			- Los parámetros pasados a Send-PowershaAIChat. Es el mismo objeto retornado por GetMyParams
	Chat 				- El chat en el cual los datos están siendo enviados.
Si es nulo, generará uno por defecto. Verifica el cmdlet Send-PowershaiChat para detalles.

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
_Estás entrenado en datos hasta octubre de 2023._
<!--PowershaiAiDocBlockEnd-->
