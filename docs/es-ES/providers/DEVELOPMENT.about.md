# Desarrollando Providers  

Este es un guía y referencia para el funcionamiento y desarrollo de providers.  
Utilízalo como base si quieres contribuir a un provider existente o crear uno nuevo.  

Como ya debes haber leído en alguna introducción sobre el PowershAI, los providers son quienes, de hecho, contienen la lógica para invocar sus respectivas APIs y devolver el resultado.  
Actúan como un traductor entre el PowershAI y la API de un servicio de IA.  
Podrías imaginarlos como los drivers en Windows, o plugins de un wordpress, por ejemplo.  

El objetivo de un provider es que implemente todo lo que el PowershAI necesita para su funcionamiento de manera transparente.  

# Cómo se cargan los providers  

Cuando importas el powershai, una de las últimas etapas que realiza es cargar los providers.  
Lo hace leyendo el directorio de providers, que es un valor hard-code y se encuentra en el directorio [providers](/powershai/providers).  

Este directorio debe contener un script .ps1 para cada provider existente.  
El nombre del archivo es tratado por powershai como el nombre del provider.  

Este nombre es importante, ya que es a través de él, por ejemplo, que activas el provider con el comando `Set-AiProvider`.  
Debido al hecho de que es un archivo en un directorio, esto naturalmente evita duplicados y lo hace único.  

El powershai va a leer el directorio de providers, y para cada archivo .ps1, va a invocar el archivo.  
El powershell usa el operador ".", es decir, el archivo se ejecuta en el mismo contexto que el núcleo del Powershai (powershai.psm1).  
Esto significa que errores en un provider van a impedir que todo el powershai sea importado.  
Esto es intencional: Si hay algo incorrecto en un archivo, es importante que esto sea tratado y resuelto.  

El script del provider es como cualquier script de powershell.  
Puedes definir funciones, usar Export-ModuleMember, etc.  

La única exigencia que el powershai hace, es que el script retorne un hashtable con algunas keys obligatorias (ver abajo).  

El powershai entonces obtiene este retorno, y crea un objeto en la memoria de la sesión que representa a ese provider, y guarda esas keys retornadas.  
Además de las keys por defecto exigidas por el powershai, otras pueden ser definidas, conforme a la necesidad de cada provider, siempre que no sean las mismas keys reservadas.

Opcionalmente, los providers necesitan implementar interfaces creadas por el Powershai.  
El Powershell no tiene un concepto nativo de interfaz de la orientación a objetos, pero, aquí en powershai reutilizamos este concepto ya que es prácticamente el mismo objetivo: el powershai define algunas operaciones que, si son implementadas por el provider, activan ciertas funcionalidades. Por ejemplo, la interfaz GetModels debe ser implementada para que el comando `Get-AiModels` retorne correctamente.  

Cada interfaz define sus reglas, inputs y retornos que el provider debe tratar. La sección abajo sobre interfaces documenta todas las interfaces.  

## Nombre de los comandos  Os providers deben seguir un estándar en el nombre de sus comandos.  
Los comandos exportados del módulo deben ser: `Verbo`-`NombreProvider``NombreComando`.  
* Verbo debe ser uno de los verbos aprobados de PowerShell.  
* NombreProvider debe ser un nombre válido del provider.  
Los nombres válidos para el provider son el propio nombre del archivo (sin extensión), o "Ai" + nombre del archivo, sin extensión.  
* NombreComando es el nombre común que se le dará al comando.

Para comandos internos, el siguiente estándar debe ser adoptado: `NombreProvider_NombreComando`.  
note que este estándar es el mismo que el de las interfaces, por lo tanto, no debes usar interfaces.

# Claves del Provider  

Todo provider debe retornar un hashtable con una lista de claves exigidas por PowerShell (que se llaman lista de Claves reservadas).  
Opcionalmente, el provider puede definir otras claves para uso propio.  

## Lista de Claves Reservadas

* DefaultModel  
Nombre del modelo por defecto. Es donde el comando `Set-aiDefaultModel` graba.

* info  
Un hashtable que contiene información sobre el provider.  

* info.desc  
Breve descripción del provider   

* info.url  
URL para la documentación o página principal sobre el provider.

* ToolsModels  
Nombre de modelos (acepta regex), que soportan la llamada a funciones.  
Esta lista sirve como pista, si un modelo está en esta, PowerShell no necesita invocar Get-AiModels para determinar.

* CredentialEnvName  
Nombres de las variables de entorno que pueden contener credenciales por defecto.  
Array o string.  
El formato del valor de la credencial es exclusivo de cada provider. La documentación debe dejar claro cómo definirlo.

* DefaultEmbeddingsModel  
Modelo por defecto utilizado para obtener embeddings.

* EmbeddingsModels  
Nombre de modelos (acepta regex), que soportan generar embeddings.

* IsOpenaiCompatible  
Indica que el modelo es compatible con OpenAI. Esto hará que el provider OpenAI pueda determinar correctamente el provider activo actual cuando se invoquen las funciones que dependen del provider actual. Todo provider que reutiliza las funciones de OpenAI debe definir esta clave como true.

# Interfaces

Las interfaces de PowerShell definen estándares de operaciones que los providers deben seguir.  
Gracias a estas interfaces, PowerShell puede ser dinámico.  

El provider debe implementar una interfaz como una función, cmdlet o alias.  
El nombre del comando debe seguir este estándar para ser identificado correctamente: nombreprovider_NombreInterface.  
`nombreprovider` es el nombre del archivo del provider, sin la extensión.  
`NombreInterface` es el nombre de la interfaz (según lista a continuación).  

## Lista de Interfaces 

### Chat  
Esta interfaz es invocada por PowerShell siempre que quiere que el modelo LLM complete un texto.  
Es invocada por Get-Aichat.

### FormatPrompt 

Esta interfaz es invocada al escribir la respuesta del LLM en la pantalla.  
Debe retornar una string con el texto.

### GetModels  
Invocada cuando se listan los modelos.  
No recibe ningún parámetro y debe retornar un array con la lista de modelos.  
Cada elemento del array debe ser un objeto que contenga, al menos, las siguientes propiedades:- name  
Nombre del modelo de IA

- tools  
Verdadero si soporta el tool calling de openai.  
¡De lo contrario, asume que no soporta!  
Solo los modelos cuyo valor es verdadero, podrán invocar una herramienta de IA.

### SetCredential  
Invocada cuando el usuario está solicitando definir una nueva credencial (token, api key).  
Las credenciales son el mecanismo estándar del powershell para almacenar la información sensible que el proveedor puede necesitar para autenticación.  
Todos los parámetros definidos además del primero, que es AiCredential, serán incluidos en la función AiCredential.  
¡Siempre que el proveedor sea cambiado, la función será actualizada con los parámetros!

### GetEmbeddings  
Invocada cuando el usuario ejecuta Get-AiEmbeddings, para obtener los embeddings de uno o más fragmentos de texto.  
Consulte Get-AiEmbeddings para detalles de los parámetros que debe procesar y resultado.


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
