# Contribuyendo para el PowershAI  

¡Muchas gracias por tu interés en contribuir al PowershAI!  
Uno de los principales objetivos de este proyecto es que se construya a partir de la experiencia de varias personas, haciéndolo más estable, robusto y único.

Esta guía te ayudará con todo lo que necesitas configurar y nuestros estándares para que puedas modificar el proyecto y enviar los cambios.


# Requisitos Previos  

El PowershAI es un módulo PowerShell relativamente simple: solo necesitas una computadora con PowerShell y un editor de textos para modificarlo.  
En Windows, me gusta mucho usar Notepad++, pero puedes usar cualquier editor que prefieras, como Visual Studio Code.

Además, las herramientas que necesitarás son para interactuar con Git y algunos otros módulos de PowerShell para ejecutar pruebas y/o generar documentación. 

Aquí hay una lista resumida del software que necesitas:

- Un editor de textos de tu preferencia
- PowerShell instalado, puede ser Windows o Linux.
- Git, obviamente, para clonar el repositorio y hacer push
- Módulo Pester, si deseas ejecutar pruebas. Instala con `Install-Module Pester` (necesitas hacer esto solo 1 vez)
- Módulo PlatyPS, si deseas generar documentación. Instala con `Install-Module PlatyPs` (necesitas hacer esto solo 1 vez)


Una vez que tengas todo lo que necesitas, clona este repositorio en un directorio de tu preferencia.  
Para los ejemplos de este artículo, asumiré que clonaste en `C:\temp\powershai`, pero puedes elegir cualquier directorio que prefieras. 

Antes de comenzar a modificar el PowershAI, es muy importante que entiendas su funcionamiento y comandos básicos.  
Te recomiendo que veas la sección de [ejemplos](examples/) y trates de usar el PowershAI para que puedas modificarlo.

Básicamente, necesitas estar familiarizado con la sintaxis de PowerShell, entender los conceptos introducidos por el PowershAI, como providers, y, obviamente, un básico sobre LLMs, APIs y HTTP REST.


# Flujo de trabajo de desarrollo 

Agregar o alterar algo en el PowershAI es un proceso relativamente simple.  
El flujo básico es este:

* Crea un issue describiendo el problema, si no existe
* Clona el repositorio del PowershAI en un directorio de tu elección
* Realiza las modificaciones necesarias y prueba (aquí incluyen modificaciones de código y documentación, incluyendo traducción automática)
* Ejecuta los scripts de prueba en tu entorno y asegúrate de que todas las pruebas pasen
* Genera un PR y envíalo detallando lo máximo posible, siempre con claridad. Mantén la comunicación en inglés o portugués de Brasil.
* Añade en el CHANGELOG, en la sección unreleased
* Un mantenedor deberá revisar tus modificaciones y aprobarlas o no.
* Una vez aprobado, será fusionado en la rama de la próxima versión, que será controlada por un mantenedor

Conocer la estructura de archivos y directorios es esencial para determinar qué vas a cambiar. Ve a continuación.

# Estructura de Archivos y Directorios 

Al clonar el proyecto, verás varios directorios y archivos, explicados resumidamente a continuación:|Item				| Descripción														|
|-------------------|---------------------------------------------------------------|
|docs				| Contiene la documentación de PowershAI 							|
|powershai 			| Contiene el código fuente de PowershAI							|
|tests 				| Contiene los scripts de prueba de PowershAI 						|
|util 				| Contiene scripts auxiliares de desarrollo					|


## powershai 

El directorio [powershai] es el módulo en sí, es decir, el código fuente de PowershAI.  
Al igual que cualquier módulo de PowerShell, contiene un archivo .psm1 y un archivo .psd1.  
El archivo [powershai.psm1] es la raíz del módulo, es decir, es el archivo que se ejecuta cuando ejecutas un `Import-Module powershai`.  
El archivo [powershai.psd1] es el manifiesto del módulo, que contiene metadatos importantes sobre el módulo, como versión, dependencias y derechos de autor.

Los demás archivos son cargados por [powershai.psm1], automáticamente o a medida que se ejecutan ciertos comandos.
Al principio, todo el código fuente de PowershAI estaba en el archivo [powershai.psm1], pero a medida que crece, es mejor para el desarrollo separarlo en archivos más pequeños, agrupados por funcionalidades. A medida que se lanzan nuevas versiones, pueden surgir nuevas estructuras y archivos para una mejor organización. 

A continuación, un breve resumen de los archivos y/o directorios más importantes:

- [lib](/powershai/lib)  
Contiene diversos scripts auxiliares con funciones genéricas y utilidades que serán usadas por otros componentes de PowershAI.

- [chats.ps1](/powershai/chats.ps1)  
Contiene todos los cmdlets y funciones que implementan la función de PowershAI Chats

- [AiCredentials.ps1](/powershai/AiCredentials.ps1)
Contiene todos los cmdlets y funciones que implementan la función de AiCredential

- [providers](/powershai/providers)  
Contiene 1 archivo para cada proveedor, con el nombre del proveedor.  
El PowershAI.psm1 cargará estos archivos al ser importado.  
Para más información sobre cómo desarrollar proveedores, consulta [la documentación de desarrollo de proveedores](providers/DEVELOPMENT.about.md)


Este es un resumen del flujo básico de lo que sucede cuando importas el módulo de PowershAI:

- El archivo `powershai.psm1` define una serie de funciones y variables
- Carga funciones definidas en las libs
- Por último, los proveedores en [providers](/powershai/providers) son cargados


La forma más rápida de descubrir dónde está definido el comando que deseas alterar es haciendo una búsqueda simple usando comandos de PowerShell (o mediante la búsqueda de Git)
Algunos ejemplos:

```powershell 
# ¿Dónde está la función Get-Aichat?
gci -rec powershai | sls 'function Get-AiChat' -SimpleMatch

# ¿dónde hay una función con 'Encryption' en el nombre?
gci -rec powershai | sls 'function.+Encryption'

#Consejo: sls es un alias para Select-String, un comando nativo de PowerShell que busca dentro del archivo usando RegEx o coincidencia simple. Similar a Grep de Linux.
```

Una vez que determines el archivo, puedes abrirlo en tu editor preferido y comenzar a ajustarlo.  Recuerda probar y configurar las credenciales para los proveedores, en caso de que necesites invocar un comando que interactúe con un LLM que requiera autenticación.

### Importando el módulo en desarrollo

Normalmente, importas el módulo con el comando `Import-Module powershai`.  
Este comando busca el módulo en la ruta de módulos estándar de PowerShell.  
Durante el desarrollo, debes importar desde la ruta donde clonaste:

```
cd C:\temp\
git clone https://github.com/rrg92/powershai
cd powershai
Import-Module -force ./powershai
```

Ten en cuenta que el comando especifica `./powershai`. Esto hace que PowerShell busque el módulo en el directorio `powershai` del directorio actual.  
Con esto, aseguras que estás importando el módulo del directorio clonado actualmente, y no el módulo instalado en uno de los directorios estándar de módulo.

> [!NOTE]
> Siempre que hagas un cambio en los fuentes de PowershAI, debes importar el módulo nuevamente.

## tests 

El directorio `tests` contiene todo lo necesario para probar PowershAI.  
La base de las pruebas se realiza con el módulo Pester, que es un módulo de PowerShell que facilita la creación y ejecución de pruebas.  

Los archivos con las definiciones de las pruebas se encuentran en el directorio [tests/pester](/tests/pester).  
Un script llamado [tests/test.ps1](/tests/test.ps1) te permite invocar fácilmente Pester y manejar algunos filtros para que puedas omitir pruebas específicas mientras desarrollas.  

### Ejecutando pruebas 

La forma más sencilla de iniciar las pruebas de PowershAI es invocando el script:

```
tests/test.ps1
```

Sin ningún parámetro, este script invocará una serie de pruebas consideradas como "básicas".  
Para realizar todas las pruebas, pasa el valor "production" como primer argumento:

```
tests/test.ps1 production
```

Esta es la opción utilizada al realizar la prueba final para una nueva versión de PowershAI.  
Si tienes Docker instalado, puedes usar `docker compose up --build` para iniciar la misma batería de pruebas en producción que se realizará en Git.  
Por defecto, se utiliza una imagen de PowerShell Core en Linux. El archivo `docker-compose.yml` y `Dockerfile` en la raíz del repositorio contienen todas las opciones utilizadas.

Pasar la prueba de producción es uno de los requisitos previos para que tus modificaciones sean aceptadas. Por lo tanto, antes de enviar tu PR, ejecuta las pruebas locales para asegurarte de que todo funcione como se espera. 

### Definiendo pruebas 

También debes definir y ajustar las pruebas para las modificaciones que realices.  
Uno de los objetivos que tenemos para PowershAI es que todos los comandos tengan una prueba unitaria definida, además de las pruebas que validan características más complejas.  
Como PowershAI comenzó sin pruebas, es probable que aún existan muchos comandos sin pruebas.  
Pero, a medida que estos comandos se modifican, o se añaden nuevos, es obligatorio que las pruebas sean definidas y ajustadas.  

Para crear una prueba, debes usar la [sintaxis del módulo Pester 5](https://pester.dev/docs/quick-start).El directorio en el que el script de prueba buscará es `tests/pester`, por lo que debes colocar los archivos allí.  
Solo se cargarán archivos con la extensión `.tests.ps1`.  

## docs  

El directorio `docs` contiene toda la documentación de PowershAI. Cada subdirectorio es específico de un idioma y debe ser identificado por el código BCP 47 (formato aa-BB).  
Puedes crear archivos Markdown directamente en el directorio del idioma deseado y comenzar a editar en el idioma.  

Algunos archivos incluidos solo serán accesibles en este repositorio de Git, sin embargo, algunos serán utilizados para montar una documentación accesible a través del comando `Get-Help` de PowerShell.  
El proceso de publicación de PowershAI generará los archivos necesarios con toda la documentación, según idiomas. Así, el usuario podrá usar el comando `Get-Help`, que determinará la documentación correcta según idioma y ubicación de la máquina donde se ejecuta PowershAI.

Para que esto funcione correctamente, el directorio `docs/` tiene una organización mínima que debe ser seguida para que el proceso automático funcione, y, al mismo tiempo, sea posible tener una documentación mínima accesible directamente aquí por el repositorio de Git.

### Reglas del directorio docs
El directorio `docs` tiene algunas reglas simples para organizar mejor y permitir la creación de los archivos de ayuda en PowerShell:

#### Usar extensión .md (Markdown) o .about.md
Debes crear la documentación usando archivos Markdown (extensión `.md`).
Los archivos que tienen la extensión `.about.md` se convertirán en un tema de ayuda de PowerShell. Por ejemplo, el archivo `CHATS.about.md` se convertirá en el tema de ayuda `powershai_CHATS`.  
Cada subdirectorio en el que se encuentre un archivo `.about.md`, el nombre del directorio se prefija en el tema de ayuda. `README.md` se considera como el tema de ayuda del propio directorio.
Por ejemplo, un archivo en `docs/es-ES/providers/openai/README.md` se convertirá en el tema de ayuda `powershai_providers_openai`.  
Mientras que el archivo `docs/es-ES/providers/openai/INTERNALS.about.md` se convertirá en el tema de ayuda `powershai_providers_openai_internals`.

#### Directorio docs/`lang`/cmdlets
Este directorio contiene un archivo Markdown para cada cmdlet que necesita ser documentado.  
El contenido de estos archivos debe seguir el formato aceptado por PlatyPS.  
Puedes usar el script auxiliar `util\Cmdlets2Markdown.ps1` para generar los archivos Markdown a partir de la documentación hecha a través de comentarios.

#### Directorio docs/`lang`/providers
Contiene un subdirectorio para cada proveedor y dentro de ese subdirectorio toda la documentación pertinente al proveedor debe ser documentada.  
La documentación sobre proveedores, que no es específica de un proveedor, debe quedar en la raíz `docs/lang/providers`.

#### Directorio docs/`lang`/examples
Este directorio contiene los ejemplos de uso de PowershAI.  
El nombre de los archivos debe seguir el patrón `NNNN.md`, donde NNNN es un número de 0000 a 9999, siempre con los ceros a la izquierda.

### Traducción  

La traducción de la documentación puede hacerse de dos formas: manualmente o con IA usando el propio PowershAI.  Para traducir con PowershAI, puedes usar el script `util\aidoc.ps1`. Este script fue creado para permitir disponibilizar la documentación de PowershAI en otros idiomas rápidamente. 

#### Traducción manual 

La traducción manual es muy simple: copia el archivo del idioma desde el cual quieres traducir al mismo camino en el directorio del idioma al cual vas a traducir.  
Entonces edita el archivo, haz las revisiones y realiza el commit.

Los archivos traducidos manualmente no serán traducidos por el proceso automático descrito a continuación.

#### Traducción automática 
El proceso de traducción automática es este:
- Escribes la documentación en el idioma original, generando el archivo Markdown conforme a las reglas anteriores.
- Importa el módulo PowershAI en la sesión y asegúrate de que las credenciales están configuradas correctamente.
- Usas el script `util\aidoc.ps1` pasando como origen el idioma en el que escribes y el idioma de destino deseado. Recomiendo usar Google Gemini.
- El script generará los archivos. Puedes revisar. Si todo está bien, entonces haz un commit de Git. Si no es así, elimina los archivos no deseados o usa `git restore` o `git clean`.

El script `AiDoc.ps1` mantiene un archivo de control en cada directorio llamado `AiTranslations.json`. Este archivo se utiliza para controlar qué archivos han sido traducidos automáticamente en cada idioma y con él el `AiDoc.ps1` puede determinar cuándo un archivo de origen ha sido modificado, evitando traducciones de archivos que no han sido alterados. 

Además, si editas manualmente uno de los archivos en el directorio de destino, ese archivo no será traducido automáticamente, para evitar sobrescribir una revisión que hayas hecho. Por lo tanto, si cambias los archivos, por mínimo que sea esa alteración, esto puede impedir que la traducción automática ocurra. Si deseas que la traducción se realice de todos modos, elimina el archivo de destino o usa el parámetro `-Force` de `AiDoc.ps1`.

Aquí hay algunos ejemplos de uso:

```powershell 
Import-Module -force ./powershai # Importar powershai (usando el propio módulo en el directorio actual para usar las últimas características implementadas!)
Set-AiProvider google # usa google como proveedor 
Set-AiCredential # Configura las credenciales del proveedor de google (esto solo necesitas hacerlo 1 vez)

# Ejemplo: Traducción simple 
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US  

# Ejemplo: Filtrando archivos específicos 
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US  -FileFilter CHANGELOG.md

# Ejemplo: Traducir a todos los idiomas disponibles 
gci docs | %{ util\aidoc.ps1 -SrcLang pt-BR -TargetLang $_.name   }

```


# Versionado en PowershAI 

PowershAI sigue el versionado semántico (o un subconjunto de él).  

La versión actual se controla de la siguiente manera:

1. A través de la etiqueta de git en el formato vX.Y.Z
2. archivo [powershai.psd1]

Cuando se crea una nueva versión, se deberá asignar una etiqueta al último commit de esa versión.  
Todos los commits realizados desde la última etiqueta son considerados parte de esa versión.  No archivo [powershai.psd1], debes mantener la versión compatible con lo que se definió en la etiqueta.  
Si no está correcto, la compilación automática fallará.

Un mantenedor de powershai es el responsable de aprobar y/o ejecutar el flujo de nueva versión.  

Actualmente, PowershAI se encuentra en versión `0.`, ya que algunas cosas pueden cambiar.  
Pero, cada vez más estamos haciéndolo más estable y la tendencia es que las próximas sean mucho más compatibles.  

La versión `1.0.0` se publicará oficialmente cuando haya suficientes pruebas por parte de la comunidad.


[powershai]: /powershai/powershai
[powershai.psm1]: /powershai/powershai.psm1
[powershai.psd1]: /powershai/powershai.psd1


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
