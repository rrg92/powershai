---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Crea un nuevo Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
PowershaAI trae un concepto de "chats", similar a los chats que ves en OpenAI, o las "threads" de la API de Assistants.  
Cada chat creado tiene su propio conjunto de parámetros, contexto e historial.  
Cuando usas el cmdlet Send-PowershaiChat (alias ia), está enviando mensajes al modelo, y el historial de esta conversación con el modelo queda en el chat creado aquí por PowershAI.  
Es decir, todo el historial de tu conversación con el modelo se mantiene aquí en tu sesión de PowershAI, y no en el modelo o en la API.  
Con esto PowershAI mantiene todo el control de lo que enviar al LLM y no depende de mecanismos de las diferentes APIs de diferentes providers para gestionar el historial. 


Cada Chat posee un conjunto de parámetros que al ser modificados afectan solo a ese chat.  
Ciertos parámetros de PowershAI son globales, como por ejemplo, el provider usado. Al cambiar el provider, el Chat pasa a usar el nuevo provider, pero mantiene el mismo historial.  
Esto permite conversar con diferentes modelos, mientras se mantiene el mismo historial.  

Además de estos parámetros, cada Chat posee un historial.  
El historial contiene todas las conversaciones e interacciones hechas con los modelos, guardando las respuestas retornadas por las APIs.

Un Chat también tiene un contexto, que es nada más que todas las mensajes enviadas.  
Cada vez que un nuevo mensaje es enviado en un chat, Powershai añade este mensaje al contexto.  
Al recibir la respuesta del modelo, esta respuesta es añadida al contexto.  
En el próximo mensaje enviado, todo este histórico de mensajes del contexto es enviado, haciendo que el modelo, independiente del provider, tenga la memoria de la conversación.  

El hecho de que el contexto se mantenga aquí en tu sesión de Powershell permite funcionalidades como grabar tu historial en disco, implementar un provider exclusivo para guardar tu historial en la nube, mantenerlo solo en tu Pc, etc. Futuras funcionalidades pueden beneficiarse de esto.

Todos los comandos *-PowershaiChat giran en torno al chat activo o al chat que explícitamente especificas en el parámetro (generalmente con el nombre -ChatId).  
El ChatAtivo es el chat en el que las mensajes serán enviadas, en caso de que no se especifique el ChatId  (o si el comando no permite especificar un chat explícito).  

Existe un chat especial llamado "default" que es el chat creado siempre que usas Send-PowershaiChat sin especificar un chat y si no hay chat activo definido.  

Si cierras tu sesión de Powershell, todo este histórico de Chats se pierde.  
Puedes guardar en disco, usando el comando Export-PowershaiSettings. El contenido se guarda encriptado por una contraseña que especifiques.

Al enviar mensajes, PowershAI mantiene un mecanismo interno que limpia el contexto del chat, para evitar enviar más de lo necesario.
El tamaño del contexto local (aquí en tu sesión de Powershai, y no del LLM), está controlado por un parámetro (usa Get-PowershaiChatParameter para ver la lista de parámetros)

Note que, debido a esta forma en que Powershai funciona, dependiendo de la cantidad de información enviada y retornada, más las configuraciones de los parámetros, puedes hacer que tu Powershell consuma bastante memoria. Puedes limpiar el contexto e historial manualmente de tu chat usando Reset-PowershaiCurrentChat

Vea más detalles sobre en el tópico about_Powershai_Chats,

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id del chat. Si no se especifica, generará uno por defecto.
Algunos patrones de id están reservados para uso interno. Si los usas puedes causar inestabilidades en PowershAI.
Los siguientes valores están reservados:
 default 
 _pwshai_*

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

### -IfNotExists
Crea solo si no existe un chat con el mismo nombre

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

### -Recreate
Forzar la recreación del chat si ya está creado!

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

### -Tools
Crea el chat e incluye estas herramientas!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
