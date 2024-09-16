# Chats 


# Introducción <!--! @#Short --> 

PowershAi define el concepto de Chats, que ayudan a crear historial y contexto de las conversaciones!  

# Detalles  <!--! @#Long --> 

PowershAi crea el concepto de Chats, que son muy similares al concepto de Chats en la mayoría de los servicios de LLM.  

Los chats permiten conversar con servicios de LLM de una manera estándar, independientemente del proveedor actual.  
Proporcionan una forma estándar para estas funcionalidades:

- Historial de chats 
- Contexto 
- Pipeline (usar el resultado de otros comandos)
- Llamadas a herramientas (ejecutar comandos a petición del LLM)

No todos los proveedores implementan el soporte para Chats.  
Para saber si un proveedor posee el soporte para el chat, usa el cmdlet Get-AiProviders, y consulta la propiedad "Chat". Si es $true, entonces el chat es soportado.  
Y, una vez que el chat es soportado, no todas las funciones pueden ser soportadas, debido a las limitaciones del proveedor.  

## Iniciar un nuevo chat 

La forma más sencilla de iniciar un nuevo chat es usando el comando Send-PowershaiChat.  
Obviamente, debes usarlo después de configurar el proveedor (usando `Set-AiProvider`) y las configuraciones iniciales, como la autenticación, si es necesario.  

```powershell 
Send-PowershaiChat "Hola, estoy hablando contigo desde Powershai"
```

Por simplicidad, el comando `Send-PowershaiChat` tiene un alias llamado `ia` (abreviatura de inteligencia artificial).  
Con él, se reduce bastante y se concentra más en el prompt:

```powershell 
ia "Hola, estoy hablando contigo desde Powershai"
```

Todo mensaje se envía en un chat.  Si no se crea un chat explícitamente, el chat especial llamado `default` se usa.  
Puedes crear un nuevo chat usando `New-PowershaiChat`.  

Cada chat tiene su propio historial de conversaciones y configuraciones. Puede contener sus propias funciones, etc.
Crear chats adicionales puede ser útil en caso de que necesites mantener más de un tema sin que se mezclen!


## Comandos de Chat  

Los comandos que manipulan los chats de alguna forma están en el formato `*-Powershai*Chat*`.  
Generalmente, estos comandos aceptan un parámetro -ChatId, que permite especificar el nombre o el objeto del chat creado con `New-PowershaiChat`.  
Si no se especifica, usan el chat activo.  

## Chat Activo  

El Chat activo es el chat default usado por los comandos PowershaiChat.  
Cuando solo existe 1 chat creado, se considera como chat activo.  
Si tienes más de 1 chat activo, puedes usar el comando `Set-PowershaiActiveChat` para definir cuál es. Puedes pasar el nombre o el objeto retornado por `New-PowershaiChat`.


## Parámetros del chat  

Todo chat posee algunos parámetros que controlan diversos aspectos.  
Por ejemplo, el máximo de tokens a ser retornado por el LLM.  

Nuevos parámetros pueden ser añadidos a cada versión de PowershAI.  
La forma más fácil de obtener los parámetros y lo que hacen es usando el comando `Get-PowershaiChatParameter`;  
Este comando va a traer la lista de parámetros que pueden ser configurados, junto con el valor actual y una descripción de cómo usarlo.  
Puedes alterar los parámetros usando el comando `Set-PowershaiChatParameter`.  

Algunos parámetros listados son los parámetros directos de la API del proveedor. Vendrán con una descripción que indica eso.  

## Contexto e Historial  

Todo Chat posee un contexto e historial.  
El historial es todo el historial de mensajes enviados y recibidos en la conversación.
El tamaño del contexto es cuánto del historial se va a enviar al LLM, para que recuerde las respuestas.  

Nota que este tamaño del contexto es un concepto de PowershAI, y no es el mismo "tamaño del contexto" que se define en los LLMs.  
El tamaño del contexto afecta solo a Powershai, y, dependiendo del valor, puede superar el tamaño del contexto del proveedor, lo que puede generar errores.  
Es importante mantener el tamaño del contexto equilibrado entre mantener el LLM actualizado con lo que ya se ha dicho y no exceder el máximo de tokens del LLM.  

Puedes controlar el tamaño del contexto a través del parámetro del chat, es decir, usando `Set-PowershaiChatParameter`.

Nota que el historial y el contexto se almacenan en la memoria de la sesión, es decir, si cierras tu sesión de Powershell, se perderán.  
En el futuro, podemos tener mecanismos que permitan al usuario guardar automáticamente y recuperar entre sesiones.  

También, es importante recordar que, una vez que el historial se guarda en la memoria de Powershell, las conversaciones muy largas pueden causar un desbordamiento o un alto consumo de memoria de powershell.  
Puedes reiniciar los chats en cualquier momento usando el comando `Reset-PowershaiCurrentChat`, que borrará todo el historial del chat activo.  
Usa con precaución, ya que esto causará que todo el historial se pierda y el LLM no recordará las peculiaridades informadas a lo largo de la conversación.  


## Pipeline  

Uno de los recursos más poderosos de los Chats de Powershai es la integración con el pipeline de Powershell.  
Básicamente, puedes pasar el resultado de cualquier comando de powershell y se usará como contexto.  

PowershAI hace esto convirtiendo los objetos a texto y enviándolos en el prompt.  
Entonces, el mensaje del chat se añade a continuación.  

Por ejemplo:

```
Get-Service | ia "Haz un resumen sobre qué servicios no son comunes en Windows"
```

En las configuraciones estándar de Powershai, el comando `ia`  (alias para `Send-PowershaiChat`), va a obtener todos los objetos retornados por `Get-Service` y los formateará como una cadena gigante única.  
Entonces, esa cadena se inyectará en el prompt del LLM, y se le indicará que use ese resultado como "contexto" para el prompt del usuario.  

El prompt del usuario se concatena justo después.  

Con esto, se crea un efecto poderoso: puedes integrar fácilmente las salidas de los comandos con tus prompts, usando un simple pipe, que es una operación común en Powershell.  
El LLM tiende a considerar bien.  

A pesar de poseer un valor estándar, tienes total control de cómo se envían estos objetos.  
La primera forma de controlar es cómo el objeto se convierte a texto.  Como el prompt es una cadena, es necesario convertir ese objeto a texto.  
Por defecto, se convierte en una representación estándar de Powershell, según el tipo (usando el comando `Out-String`).  
Puedes cambiar esto usando el comando `Set-PowershaiChatContextFormatter`. Puedes definir, por ejemplo, JSON, tabla, e incluso un script personalizado para tener total control.  

La otra forma de controlar cómo se envía el contexto es usando el parámetro del chat `ContextFormat`.  
Este parámetro controla todo el mensaje que se inyectará en el prompt. Es un scriptblock.  
Debes retornar un array de cadenas, que equivale al prompt enviado.  
Este script tiene acceso a parámetros como el objeto formateado que se está pasando en el pipeline, los valores de los parámetros del comando Send-PowershaiChat, etc.  
El valor default del script está hard-coded, y debes consultar directamente en el código para saber cómo se envía (y para un ejemplo de cómo implementar el tuyo propio).  


###  Herramientas

Una de las grandes funcionalidades implementadas es el soporte a la Llamada a Funciones (o Llamada a Herramientas).  
Esta función, disponible en varios LLMs, permite que la IA decida invocar funciones para traer datos adicionales en la respuesta.  
Básicamente, se describe una o más funciones y sus parámetros, y el modelo puede decidir invocarlas.  

**IMPORTANTE: Solo se puede usar esta función en proveedores que expongan la llamada a funciones usando la misma especificación de OpenAI**

Para más detalles, consulta la documentación oficial de OpenAI sobre la Llamada a Funciones: [Llamada a Funciones](https://platform.openai.com/docs/guides/function-calling).

El modelo solo decide qué funciones invocar, cuándo invocarlas y sus parámetros. La ejecución de esa invocación la realiza el cliente, en nuestro caso, PowershAI.  
Los modelos esperan la definición de las funciones describiendo lo que hacen, sus parámetros, retornos, etc.  Originalmente esto se hace usando algo como OpenAPI Spec para describir las funciones.  
Sin embargo, Powershell posee un poderoso sistema de ayuda usando comentarios, que permite describir funciones y sus parámetros, además de los tipos de datos.  

PowershAI se integra con este sistema de ayuda, traduciéndolo a una especificación OpenAPI.  El usuario puede escribir sus funciones normalmente, usando comentarios para documentarlas y esto se envía al modelo.  

Para demostrar este recurso, vamos a un simple tutorial: crea un archivo llamado `MinhasFuncoes.ps1` con el siguiente contenido

```powershell
# Archivo MinhasFuncoes.ps1, guarda en algún directorio de tu preferencia!

<#
    .DESCRIPTION
    Lista la hora actual
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    Obtiene un número aleatorio!
#>
function NumeroAleatorio {
    param(
        # Número mínimo
        $Min = $null,
        
        # Número máximo
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**Nota el uso de los comentarios para describir funciones y parámetros**.  
Esta es una sintaxis soportada por PowerShell, conocida como [Ayuda Basada en Comentarios](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4).

Ahora, vamos a añadir este archivo a PowershAI:

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #configura el token si aún no lo has configurado.


# Añade el script como herramientas!
# Suponiendo que el script se guardó en C:\tempo\MinhasFuncoes.ps1
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Confirma que las herramientas fueron añadidas 
Get-AiTool
```

¡Experimenta pidiendo al modelo cuál es la fecha actual o pídele que genere un número aleatorio! ¡Verás que ejecutará tus funciones! ¡Esto abre posibilidades infinitas, y tu creatividad es el límite!

```powershell
ia "Cuántas horas?"
```

En el comando anterior, el modelo va a invocar la función. ¡En la pantalla verás la función siendo llamada!  
Puedes añadir cualquier comando o script de powershell como una herramienta.  
Utiliza el comando `Get-Help -Full Add-AiTol` para más detalles de cómo usar esta poderosa funcionalidad.

PowershAI automáticamente se encarga de ejecutar los comandos y enviar la respuesta de vuelta al modelo.  
Si el modelo decide ejecutar varias funciones en paralelo, o insiste en ejecutar nuevas funciones, PowershAI las gestionará automáticamente.  
Nota que, para evitar un bucle infinito de ejecuciones, PowershAI fuerza un límite con el máximo de ejecuciones.  
El parámetro que controla estas interacciones con el modelo es `MaxInteractions`.  


### Invoke-AiChatTools y Get-AiChat 

Estos dos cmdlets son la base de la función de chats de Powershai.  
`Get-AiChat` es el comando que permite comunicarse con el LLM de la forma más primitiva posible, casi cerca de la llamada HTTP.  
Es, básicamente, un wrapper estándar para la API que permite generar texto.  
Se le informa de los parámetros, que están estandarizados, y devuelve una respuesta, que también está estandarizada.
Independientemente del proveedor, la respuesta debe seguir la misma regla!

Ya el cmdlet `Invoke-AiChatTools` es un poco más elaborado y un poco más alto nivel.  
Permite especificar funciones de Powershell como herramientas.  Estas funciones se convierten a un formato que el LLM entiende.  
Usa el sistema de ayuda de Powershell para obtener todos los metadatos posibles para enviar al modelo.  
Envía los datos al modelo usando el comando `Get-Aichat`. Al obtener la respuesta, valida si hay llamada a herramientas, y si la hay, ejecuta las funciones equivalentes y devuelve la respuesta.  
Sigue haciendo este ciclo hasta que el modelo finalice la respuesta o que se alcance el máximo de interacciones.  
Una interacción es una llamada a la API al modelo. Al invocar Invoke-AiChatTools con funciones, pueden ser necesarias varias llamadas para devolver las respuestas al modelo.  

El siguiente diagrama explica este flujo:

```
	sequenceDiagram
		Invoke-AiChatTools->>modelo:prompt (INTERACCIÓN 1)
		modelo->>Invoke-AiChatTools:(response, 3 function call)
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 1
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 2
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 3
		Invoke-AiChatTools->>modelo:Resultado tool call + prompts anteriores prompt (INTERACCIÓN 2)
		modelo->>Invoke-AiChatTools:respuesta final
```


#### Cómo los comandos se transforman e invocan

El comando `Invoke-AiChatTools` espera en el parámetro -Functions una lista de comandos de powershell mapeados a schemas OpenAPI.  
Espera un objeto que llamamos OpenaiTool, conteniendo las siguientes props: (el nombre OpenAiTool se debe al hecho de que usamos el mismo formato de llamada a herramientas de OpenAI)

- tools  
Esta propiedad contiene el schema de la llamada a funciones que se enviará al LLM (en los parámetros que esperan esa información)  

- map  
Este es un método que retorna el comando de powershell (función, alias, cmdlet, exe, etc.) a ser ejecutado.  
Este método debe retornar un objeto con la propiedad llamada "func", que debe ser el nombre de una función, comando ejecutable o scriptblock.  
Recibirá en el primer argumento el nombre de la herramienta, y en el segundo el propio objeto OpenAiTool (como si fuera el this).

Además de estas propiedades, cualquier otra es libre de ser añadida al objeto OpenaiTool. Esto permite que el script map tenga acceso a cualquier dato externo que necesite.  

Cuando el LLM devuelve la solicitud de llamada a funciones, el nombre de la función a ser invocada se pasa al método `map`, y debe retornar qué comando debe ejecutar. 
Esto abre diversas posibilidades, permitiendo que, en tiempo de ejecución, se pueda determinar el comando a ser ejecutado a partir de un nombre.  
Gracias a este mecanismo el usuario tiene total control y flexibilidad sobre cómo va a responder a la llamada a herramientas del LLM.  

Entonces, el comando se invocará y los parámetros y valores enviados por el modelo se pasarán como Argumentos Ligados.  
Es decir, el comando o script debe ser capaz de recibir los parámetros (o identificarlos dinámicamente) a partir de su nombre.


Todo esto se hace en un bucle que va a iterar, secuencialmente, en cada Llamada a Herramientas retornado por el LLM.  
No hay ninguna garantía del orden en que se ejecutarán las herramientas, por lo tanto, nunca se debe presumir el orden, a menos que el LLM envíe una herramienta en secuencia.  
Esto significa que, en implementaciones futuras, diversas llamadas a herramientas pueden ser ejecutadas al mismo tiempo, en paralelo (En Jobs, por ejemplo).  

Internamente, PowershAI crea un script map estándar para los comandos añadidos usando `Add-AiTool`.  

Para un ejemplo de cómo implementar funciones que retornen este formato, consulta en el proveedor openai.ps1, los comandos que empiezan con Get-OpenaiTool*

Nota que esta función de Llamada a Herramientas funciona solo con modelos que soportan la Llamada a Herramientas siguiendo las mismas especificaciones de OpenAI (tanto de entrada como de retorno).  


#### CONSIDERACIONES IMPORTANTES SOBRE EL USO DE HERRAMIENTAS

La función de Llamada a Funciones es poderosa al permitir la ejecución de código, pero también es peligrosa, MUY PELIGROSA.  
Por lo tanto, ten extrema precaución con lo que implementas y ejecutas.
Recuerda que PowershAI ejecutará según lo que el modelo pida. 

Algunas sugerencias de seguridad:

- Evita ejecutar el script con un usuario Administrador.
- Evita implementar código que elimine o modifique datos importantes.
- Prueba las funciones antes.
- No incluyas módulos o scripts de terceros que no conozcas o en los que no confíes.  

La implementación actual ejecuta la función en la misma sesión, y con las mismas credenciales, del usuario conectado.  
Esto significa que, por ejemplo, si el modelo (intencional o erróneamente) pide ejecutar un comando peligroso, tus datos, o incluso tu computadora, pueden ser dañados o comprometidos.  

Por eso, vale esta advertencia: Ten el máximo cuidado y solo añade herramientas con scripts en los que tengas total confianza.  

Hay un plan para añadir futuros mecanismos para ayudar a aumentar la seguridad, como aislar en otros runspaces, abrir un proceso separado, con menos privilegios y permitir que el usuario tenga opciones para configurar esto.






<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
