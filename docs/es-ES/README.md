# Powershai

# RESUMEN <!--! @#Short --> 

PowershAI (Powershell + AI) es un módulo que añade acceso a IA a través de Powershell

# DETALLES  <!--! @#Long --> 

PowershAI (PowerShell + AI) es un módulo que integra servicios de Inteligencia Artificial directamente en PowerShell.  
Puedes invocar los comandos tanto en scripts como en la línea de comandos.  

Existen varios comandos que permiten conversaciones con LLMs, invocar espacios de Hugging Face, Gradio, etc.  
Puedes conversar con el GPT-4o-mini, gemini flash, llama 3.3, etc., usando tus propios tokens de estos servicios.  
Es decir, no pagas nada por usar PowershAI, además de los costos que ya tendrías normalmente al usar esos servicios de pago o ejecutándolos localmente.

Este módulo es ideal para integrar comandos powershell con tus LLM favoritos, probar llamadas, pocs, etc.  
Es ideal para quienes ya están acostumbrados a PowerShell y quieren llevar la IA a sus scripts de una manera más simple y fácil.

> [!IMPORTANT]
> ¡Este no es un módulo oficial de OpenAI, Google, Microsoft o de cualquier otro proveedor listado aquí!
> Este proyecto es una iniciativa personal y, con el objetivo de ser mantenido por la propia comunidad open source.

Los siguientes ejemplos muestran cómo puedes usar PowershAI.

## Por dónde empezar 

La [doc de ejemplos](examples/) contiene diversos ejemplos prácticos de cómo usar.  
Comienza por el [ejemplo 0001], y ve uno a uno, para, gradualmente, aprender a usar PowershAI desde lo básico hasta lo avanzado.

Aquí hay algunos ejemplos simples y rápidos para que entiendas de qué es capaz PowershAI:

```powershell 
import-module powershai 

#  Interpretando los Logs de Windows usando el GPT de OpenAI
Set-AiProvider openai 
Set-AiCredential 
Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "¿Algún evento importante?"

# Describiendo servicios de Windows usando Google Gemini
Set-AiProvider google
Set-AiCredential
Get-Service | ia "Haz un resumen de cuáles servicios no son nativos de Windows y pueden representar un riesgo"

# Explicando commits de GitHub usando Sabia, LLM brasileño de Maritaca AI 
Set-AiProvider maritalk
Set-AiCredential # configura un token para Maritaca.AI (LLM brasileño)
git log --oneline | ia "Haz un resumen de estos commits realizados"
```

### Instalación

Toda la funcionalidad está en el directorio `powershai`, que es un módulo de PowerShell.  
La opción más simple de instalación es con el comando `Install-Module`:

```powershell
Install-Module powershai -Scope CurrentUser
```

Después de instalar, solo tienes que importar en tu sesión:

```powershell
import-module powershai

# Ve los comandos disponibles
Get-Command -mo powershai
```

También puedes clonar este proyecto directamente e importar el directorio powershai:

```powershell
cd RUTA

# Clona
git clone ...

# Importar desde la ruta específica!
Import-Module .\powershai
```

### Próximos pasos 

Después de instalar PowershAI, ya puedes comenzar a usarlo.  
Para empezar a usarlo, debes elegir un proveedor y configurar las autenticaciones para él.  Um proveedor es lo que conecta el powershai con alguna API de un modelo. Hay varios implementados.  
Ve el [ejemplo 0001] para entender cómo usar proveedores.  
Consulta la [doc de proveedores](providers/) para aprender más sobre la arquitectura y funcionamiento.

Aquí hay un script simple para listar proveedores:
```powershell 
import-module powershai

# Lista de proveedores 
Get-AiProviders

# ¡Debes consultar la documentación de cada proveedor para detalles de cómo usarlo!
# La documentación puede ser accedida usando get-help 
Get-Help about_NombreProveedor

# Ejemplo:
Get-Help about_huggingface
```

### Obteniendo Ayuda  

A pesar del esfuerzo por documentar el PowershAI al máximo, muy probablemente no lograremos a tiempo crear toda la documentación necesaria para aclarar las dudas, o incluso hablar de todos los comandos disponibles. Por eso, es importante que sepas hacer un básico de esto solo. 

Puedes listar todos los comandos disponibles cuando el comando `Get-Command -mo powershai`.  
Este comando devolverá todos los cmdlets, alias y funciones exportadas del módulo powerhsai.  
Es el punto de partida más fácil para descubrir qué comandos. Muchos comandos son auto-explicativos, solo mirando el nombre.  

Y, para cada comando, puedes obtener más detalles usando `Get-Help -Full NombreComando`.
Si el comando aún no tiene una documentación completa, o alguna duda que necesitas está faltando, puedes abrir un issue en git solicitando más complemento.  

Finalmente, puedes explorar el código fuente del PowershAI, buscando comentarios dejados a lo largo del código, que pueden explicar algún funcionamiento o arquitectura, de forma más técnica.  

Iremos actualizando la documentación a medida que se lancen nuevas versiones.
Te animamos a contribuir al PowershAI, enviando Pull Requests o issues con mejoras en la documentación si encuentras algo que pueda ser mejor explicado, o que aún no ha sido explicado.  


## Arquitectura Básica del PowershAI 

Esta sección proporciona una visión general del PowershAI.  
Recomiendo la lectura una vez que hayas seguido al menos el [ejemplo 0001], para que te familiarices más con el uso. 


## Estructura de comandos  

El PowershAI exporta diversos comandos que pueden ser usados.  
La mayoría de estos comandos poseen "Ai" o "Powershai". 
Llamamos a estos comandos `comandos globales` del Powershai, ya que no son comandos para un proveedor específico.

Por ejemplo: `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Los proveedores también exportan comandos, que generalmente tendrán un nombre del proveedor. Consulta la documentación del proveedor para saber más sobre el patrón de comandos exportados.  

Por convención, ningún proveedor debe implementar comandos con "Ai" o "Powershai" en el nombre, ya que están reservados para los comandos globales, independientemente del proveedor.  
Sin embargo, los nombres Ai + NombreProveedor aún pueden ser usados por los mismos (ex.: AiHuggingFace*, AiOpenai*, AiAzure*, AiGoogle*) y están reservados solo para el proveedor.```markdown
También, los alias definidos por los proveedores deben siempre contener más de 5 caracteres. Alias más pequeños están reservados para los comandos globales.

Puedes encontrar la documentación de estos comandos en la [doc de comandos globales](cmdlets/).  
¡Puedes usar el comando Get-PowershaiGlobalCommands para obtener la lista!

### Providers  

Los Providers son scripts que conectan el powershai a los más variados proveedores de IA alrededor del mundo.  
La [documentación de providers](providers) es el lugar oficial para obtener ayuda sobre el funcionamiento de cada provider.  
Esta documentación también puede ser accedida a través del comando `Get-Help` de powershell.  

La documentación de providers siempre se proporciona a través de help `about_Powershai_NomeProvider_Topico`.  
El tópico `about_Powershai_NomeProvider` es el punto de partida y debe siempre contener la información inicial para los primeros usos, así como las explicaciones para el correcto uso de los demás tópicos.  


### Chats  

Los Chats son el principal punto de partida y permiten que converses con los varios LLM disponibles por los providers.  
Consulta el documento [chats](CHATS.about.md) para más detalles. A continuación, una introducción rápida a los chats.

#### Conversando con el modelo

Una vez que la configuración inicial del provider está hecha, ¡puedes iniciar la conversación!  
La manera más fácil de iniciar la conversación es usando el comando `Send-PowershaiChat` o el alias `ia`:

```powershell
ia "Hola, ¿conoces PowerShell?"
```

Este comando enviará el mensaje al modelo del provider que fue configurado y la respuesta será exhibida a continuación.  
Ten en cuenta que el tiempo de respuesta depende de la capacidad del modelo y de la red.  

Puedes usar el pipeline para pasar el resultado de otros comandos directamente como contexto de la ia:

```powershell
1..100 | Get-Random -count 10 | ia "Háblame de curiosidades sobre estos números"
```  
El comando anterior generará una secuencia de 1 a 100 y pasará cada número al pipeline de PowerShell.  
Entonces, el comando Get-Random filtrará solamente 10 de esos números, aleatoriamente.  
Y por último, esta secuencia será enviada (toda de una vez) a la ia y será enviada con el mensaje que colocaste en el parámetro.  

Puedes usar el parámetro `-ForEach` para que la ia procese cada entrada por vez, por ejemplo:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Háblame de curiosidades sobre estos números"
```  

La diferencia de este comando anterior, es que la IA será llamada 10 veces, una por cada número.  
En el ejemplo anterior, será llamada solo 1 vez, con todos los 10 números.  
La ventaja de usar este método es reducir el contexto, pero puede tardar más tiempo, ya que se realizarán más solicitudes.  
¡Prueba según tus necesidades!

#### Modo objeto  

Por defecto, el comando `ia` no devuelve nada. Pero puedes cambiar este comportamiento usando el parámetro `-Object`.  
Cuando este parámetro está activado, le pide al LLM que genere el resultado en JSON y escribe el retorno de vuelta en el pipeline.  
Esto significa que puedes hacer algo así:

```powershell
```ia -Obj "5 números aleatorios, con su valor escrito por extenso"

#o usando el alias, io/powershellgallery/dt/powershai

io "5 números aleatorios, con su valor escrito por extenso"
```  

**IMPORTANTE: Ten en cuenta que no todos los proveedores pueden soportar este modo, ya que el modelo necesita ser capaz de soportar JSON! Si recibes errores, confirma si el mismo comando funciona con un modelo de OpenAI. También puedes abrir un issue**


### Guardando configuraciones  

El PowershAI permite ajustar una serie de configuraciones, como parámetros de chats, tokens de autenticación, etc.  
Siempre que cambias una configuración, esta configuración se guarda solo en la memoria de tu sesión de Powershell.  
Si cierras y abres nuevamente, todas las configuraciones realizadas se perderán.  

Para que no tengas que estar generando tokens cada vez, por ejemplo, el Powershai proporciona 2 comandos para exportar e importar configuraciones.  
El comando `Export-PowershaiSettings` exporta las configuraciones a un archivo en el directorio de perfil del usuario conectado.  
Debido al hecho de que los datos exportados pueden ser sensibles, necesitas proporcionar una contraseña, que se usará para generar una clave de cifrado.  
Los datos exportados se cifran usando AES-256.  
Puedes importar usando `Import-PowershaiSettings`. Tendrás que proporcionar la contraseña que usaste para exportar.  

Ten en cuenta que esta contraseña no se almacena en ningún lugar, así que eres responsable de memorizarla o guardarla en un lugar seguro de tu elección.

### Costos  

Es importante recordar que algunos proveedores pueden cobrar por los servicios utilizados.  
El PowershAI no realiza ninguna gestión de costos. Puede inyectar datos en prompts, parámetros, etc.  
Debes hacer el seguimiento utilizando las herramientas que el sitio del proveedor proporciona para tal fin.  

Futuras versiones pueden incluir comandos o parámetros que ayuden a controlar mejor, pero, por ahora, el usuario debe monitorear.  



### Exportar e Importar Configuraciones y Tokens

Para facilitar la reutilización de los datos (tokens, modelos predeterminados, historial de chats, etc.) el PowershAI permite que exportes la sesión.  
Para ello, usa el comando `Export-PowershaiSettings`. Necesitarás proporcionar una contraseña, que se usará para crear una clave y cifrar este archivo.  
Solo con esta contraseña, podrás importarlo nuevamente. Para importar, usa el comando `Import-PowershaiSettings`.  
Por defecto, los Chats no se exportan. Para exportarlos, puedes agregar el parámetro -Chats: `Export-PowershaiSettings -Chats`.  
Ten en cuenta que esto puede hacer que el archivo sea más grande, además de aumentar el tiempo de exportación/importación. La ventaja es que puedes continuar la conversación entre diferentes sesiones.  
Esta funcionalidad fue creada originalmente con el objetivo de evitar tener que estar generando Api Key cada vez que necesitaras usar el PowershAI. Con ella, generas una vez tus api keys en cada proveedor, y exportas a medida que actualizas. Como está protegido por contraseña, puedes guardarlo tranquilamente en un archivo en tu computadora.  Use la ayuda en el comando para obtener más información sobre cómo usarlo.

#  NOTAS 

## Otros Proyectos con PowerShell

Aquí hay algunos otros proyectos interesantes que integran PowerShell con IA:

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

# EJEMPLOS <!--! @#Ex -->

## Uso básico 

Usar el PowershAI es muy simple. El siguiente ejemplo muestra cómo puedes usarlo con OpenAI:

```powershell 
# Cambia el proveedor actual a OpenAI
Set-AiProvider openai 

# Configura el token de autenticación (Debes generar el token en el sitio platform.openai.com)
Set-OpenaiToken 

# ¡Usa uno de los comandos para iniciar un chat!  ia es un alias para Send-PowershaiChat, que envía un mensaje en el chat por defecto!
ia "¡Hola, estoy hablando del Powershaui contigo!"
```

## Exportando configuraciones 


```powershell 
# define algún token, por ejemplo 
Set-OpenaiToken 

# Después de que el comando anterior se ejecute, ¡simplemente exporta!
Export-PowershaiSettings

# ¡Tendrás que proporcionar la contraseña!
```

## Importando configuraciones 


```powershell 
import-module powershai 

# Importa las configuraciones 
Import-PowershaiSettings # El comando pedirá la contraseña usada en la exportación
```

# Información Importante <!--! @#Note -->

El PowershAI tiene una gama de comandos disponibles.  
Cada proveedor proporciona una serie de comandos con un patrón de nomenclatura.  
Siempre debes leer la documentación del proveedor para obtener más detalles sobre cómo usarlo.  

# Solución de problemas <!--! @#Troub -->

A pesar de tener bastante código y ya contar con bastante funcionalidad, el PowershAI es un proyecto nuevo que está en desarrollo.  
Se pueden encontrar algunos errores y, en esta fase, es importante que siempre ayudes reportando, a través de issues, en el repositorio oficial en https://github.com/rrg92/powershai  

Si deseas solucionar un problema, te recomiendo seguir estos pasos:

- Utiliza el Debug para ayudarte. Comandos como Set-PSBreakpoint son simples de invocar en la línea de comando y pueden ayudarte a ahorrar tiempo
- Algunas funciones no muestran el error completo. Puedes usar la variable $error y acceder al último. Por ejemplo:  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # ¡Esto ayuda a encontrar la línea exacta donde ocurrió la excepción!
```

# Ve también <!--! @#Also -->

- Video sobre Cómo usar el Proveedor de Hugging Face: https://www.youtube.com/watch?v=DOWb8MTS5iU
- Consulta la documentación de cada proveedor para más detalles sobre cómo usar sus cmdlets

# Etiquetas <!--! @#Kw -->

- Inteligencia Artificial
- IA



[ejemplo 0001]: examples/0001.md


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
