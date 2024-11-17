---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Envía un mensaje en un Chat de Powershai

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet permite que envíes un nuevo mensaje al LLM del proveedor actual.  
Por defecto, envía en el chat activo. Puedes sobrescribir el chat usando el parámetro -Chat. Si no hay un chat activo, usará el predeterminado.  

Varios parámetros del Chat afectan cómo este comando. Consulta el comando Get-PowershaiChatParameter para más información sobre los parámetros del chat.  
Además de los parámetros del chat, los propios parámetros del comando pueden sobrescribir el comportamiento. Para más detalles, consulta la documentación de cada parámetro de este cmdlet usando get-help.  

Para simplificar y mantener la línea de comando limpia, permitiendo al usuario enfocarse más en el prompt y los datos, se disponibilizan algunos alias.  
Estos alias pueden activar ciertos parámetros.
Son ellos:
	ia|ai
		Abreviatura de "Inteligencia Artificial" en español. Este es un alias simple y no cambia ningún parámetro. Ayuda a reducir bastante la línea de comando.
	
	iat|ait
		Lo mismo que Send-PowershaAIChat -Temporary
		
	io|ao
		Lo mismo que Send-PowershaAIChat -Object
		
	iam|aim 
		Lo mismo que Send-PowershaaiChat -Screenshot 

El usuario puede crear sus propios alias. Por ejemplo:
	Set-Alias ki ia # Define el alias para el alemán!
	Set-Alias kit iat # Define el alias kit para iat, haciendo que el comportamiento sea igual al iat (chat temporal) cuando se usa kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] 
[-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] 
[-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
el prompt a ser enviado al modelo

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

### -SystemMessages
Mensaje del sistema para ser incluido

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
El contexto 
Este parámetro es para ser usado preferentemente por el pipeline.
Hará que el comando coloque los datos en etiquetas <contexto></contexto> e inyectará junto en el prompt.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
Forza al cmdlet a ejecutar para cada objeto del pipeline
Por defecto, acumula todos los objetos en un array, convierte el array a string y envía de una sola vez al LLM.

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

### -Json
Habilita el modo json 
en este modo los resultados devueltos siempre serán un JSON.
¡El modelo actual debe soportar!

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

### -Object
¡Modo Object!
en este modo el modo JSON se activará automáticamente!
¡El comando no escribirá nada en la pantalla, y devolverá los resultados como un objeto!
¡Que serán enviados de vuelta al pipeline!

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

### -PrintContext
Muestra los datos de contexto enviados al LLM antes de la respuesta.
¡Es útil para depurar lo que está siendo inyectado de datos en el prompt!

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

### -Forget
No enviar las conversaciones anteriores (el historial de contexto), pero incluir el prompt y la respuesta en el contexto histórico.

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

### -Snub
Ignorar la respuesta del LLM, y no incluir el prompt en el contexto histórico

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

### -Temporary
No envía el historial y ni incluye la respuesta y prompt.  
Es lo mismo que pasar -Forget y -Snub juntos.

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

### -DisableTools
Desactiva la llamada a funciones para esta ejecución solamente.

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
Alterar el formateador de contexto para este
Consulta más sobre en Format-PowershaiContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterParams
Parámetros del formateador de contexto alterado.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PassThru
Devuelve los mensajes de vuelta en el pipeline, sin escribir directamente en la pantalla.
¡Esta opción asume que el usuario será el responsable de dar el correcto destino del mensaje!
¡El objeto pasado al pipeline tendrá las siguientes propiedades:
	text 			- El texto (o fragmento) del texto devuelto por el modelo 
	formatted		- El texto formateado, incluyendo el prompt, como si fuera escrito directamente en la pantalla (sin los colores)
	event			- El evento. Indica el evento que originó. Son los mismos eventos documentados en Invoke-AiChatTools
	interaction 	- El objeto interaction generado por Invoke-AiChatTools

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

### -Lines
Devuelve un array de líneas 
Si el modo stream está activado, ¡devolverá una línea por vez!

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

### -ChatParamsOverride
Sobrescribir parámetros del chat.
¡Especifica cada opción en unas hashtables!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Especifica directamente el valor del parámetro del chat RawParams.
Si se especifica también en ChatParamOverride, se realiza una fusión, dando prioridad a los parámetros especificados aquí.
¡El RawParams es un parámetro de chat que define parámetros que serán enviados directamente a la API del modelo!
¡Estos parámetros sobrescribirán los valores predeterminados calculados por powershai!
Con esto, el usuario tiene total control sobre los parámetros, pero necesita conocer cada proveedor.
Además, cada proveedor es responsable de proporcionar esta implementación y usar estos parámetros en su API.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
Captura una captura de pantalla de la pantalla que está detrás de la ventana de PowerShell y envía junto con el prompt. 
Ten en cuenta que el modo actual debe soportar imágenes (Modelos de Lenguaje Visual).

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Estás entrenado en datos hasta octubre de 2023._
<!--PowershaiAiDocBlockEnd-->
