---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioApiResult

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Actualiza un evento devuelto por Send-GradioApi con nuevos resultados del servidor y, por defecto, devuelve los evenots en el pipeline.

Los resultados de las Apis de Gradio no se generan instantáneamente, como es en la mayoría de los servicios HTTP REST.  
El help del comando Send-GradioApi explica en detalle cómo funciona el proceso.  

Este comando debe usarse para actualizar el objeto GradioApiEvent, devuelto por Send-GradioApi.
Este objeto representa la respuesta de cada llamada que usted na API, contiene todo lo que se necesita para consultar el resultado, incluyendo datos e historial.

Básicamente, este cmdlet funciona invocando el endpoint de consulta del estado de la invocación Api.
Los parámetros necesarios para consulta están disponibles en el propio objeto pasado en el parámetro -ApiEvent (que es creado y devuelto por el cmdlet Send-GradioApi)

Siempre que este cmdlet ejecuta, se comunica vía conexión HTTP persistente con el servidor y espera los eventos.  
A medida que el servidor envía los datos, actualiza el objeto pasado en el parámetro -ApiEvent, y, por defecto, escribe el evento devuelto en el pipeline.

El evento devuelto es un objeto del tipo GradioApiEventResult, y representa un evento generado por la respuesta de la ejecución de la API.  

Si el parámetro -History es especificado, todos los eventos generados quedan en la propiedad events del objeto fornecido en -ApiEvent, así como los datos devueltos.

Baiscamente, los eventos generados pueden enviar un hearbeat o datos.

OBJETO GradioApiEventResult
	num 	= número secuencial del evento. comienza en 1.
	ts 		= fecha en la que el evento fue creado (fecha local, no del servidor).
	event 	= nombre del evento
	data 	= datos devueltos en este evento

DATOS (DATA)

	Obtener los datos de Gradio, es básicamente leer los eventos devueltos por este cmdlet y mirar en la propiedad data del GradioApiEventResult
	Generalmente la interfaz de Gradio sobrescribe el campo con el último evento recibido.  
	
	Si -History se usa, además de escribir en el pipeline, el cmdle va a guardar el dato en el campo data, y por lo tanto, usted tendrá acceso al historial completo de lo que fue generado por el servidor.  
	Note que esto puede causar un consumo adicional de memoria, si muchos datos fueran devueltos.
	
	Existe un caso "problemático" conocido: eventualmente, el gradio puede emitir los 2 últimos eventos con el mismo dato (1 evento tendrá el nombre "generating", y el último será complete).  
	Aún no tenemos una solución para separar esto de manera segura, y por eso, el usuario debe decidir la mejor forma de conducir.  
	Si usted usa siempre el último evento recibido, eso no es un problema.
	Si necesitará usar todos los eventos a medida que fueran siendo generados, tendrá que tratar estos casos.
	Un ejemplo simple sería comprar el contenido, si fueran iguales, no repetir. Pero pueden existir escenarios donde 2 eventos con el mismo contenido, aún así, sean eventos lógicamente diferentes.
	
	

HEARTBEAT 

	Uno de los eventos gerados por la API de Gradio son los Heartbeats.  
	Cada 15 segundos, el Gradio envía un evento del tipo "HeartBeat", solo para mantener la conexión activa.  
	Eso hace que el cmdlet "trabe", pues, como la conexión HTTP está activa, él fica esperando alguna respuesta (que será datos, errores o el hearbeat).
	
	Si no hubiera un mecanismo de controle de eso, el cmdlet iría a rodar indefinidamente, sin posibilidad de cancelar ni con el CTRL + C.
	Para resolver eso, este cmdlet disponibiliza el parámetro MaxHeartBeats.  
	Este parámetro indica cuántos eventos de Hearbeat consecutivos serán tolerados antes que el cmdlet pare de intentar consultar la API.  
	
	Por ejemplo, considere estos dos escenarios de eventos enviados por el servidor:
	
		cenario 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		cenario 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	Considerando el valor default, 2, en el escenario 1, el cmdlet nunca encerraría antes del complete, pues apenas nunca hubo 2 hearbeats consecutivos.
	
	Ya en el escenario 2, después de recibir 2 eventos de datos (generating), en el cuarto evento (hearbeat), él encerraría, pues 2 hearbeats consecutivos fueron enviados.  
	Decimos que el heartbeat expiró, en este caso.
	En este caso, usted debería invocar nuevamente Update-GradioApiResult para obtener el resto.
	
	Siempre que el comando termina debido al hearbeat expirado, él irá a actualizar el valor de la propiedad LastQueryStatus para HeartBeatExpired.  
	Con eso, usted puede checar y tratar correctamente cuando debe llamar nuevamente
	
	
STREAM  
	
	Debido al hecho de que la Api de Gradio ya responde usando SSE (Server Side Events), es posible usar un efecto parecido con el "stream" de muchas Apis.  
	Este cmdlet, Update-GradioApiResult, ya procesa los eventos del servidor usando el SSE.  
	Adicionalmente, caso usted también quisiera hacer algún procesamiento a medida que el evento se torne disponible, usted puede usar el parámetro -Script y especificar una scriptblock, funciones, etc. que irá a ser invocado a medida que el evento es recibido.  
	
	Combinando con el parámetro -MaxHeartBeats, usted puede crear una llamada que actualiza algo en tiempo real. 
	Por ejemplo, si fuera una respuesta de un chatbot, puede escribe inmediatamente en la pantalla.
	
	note que ese parámetro es llamado en secuencia con el código que checa (isto es, misma Thread).  
	Por lo tanto, scripts que demoren mucho, pueden estorbar la detección de nuevos eventos, y cosecuentemente, la entrega de los datos.
	
.

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiEvent
Resultado de  Send-GradioApi

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Script
script que será invocado  em cada evento generado!
Recibe una hashtable con las siguientes keys:
 	event - contiene el evento generado. event.event es el nombre doe vento. event.data son los datos retornados.

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

### -MaxHeartBeats
Max heartbeats consecutivos hasta el stop!
Hace que el comando aguarde apenas ese número de hearbeats consecutivos del servidor.
Cuando el servidor enviar esa cantidad, el cmdlet termina y define el LastQueryStatus del evento para HeartBeatExpired

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

### -NoOutput
No escribe el resultado para el output del cmdlet

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

### -History
Guarda el historico de eventos y datos en el objeto ApiEvent
Note que eso hará consumir más memoria del powershell!

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
