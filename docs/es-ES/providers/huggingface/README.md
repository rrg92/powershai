# Proveedor Hugging Face

Hugging Face es el mayor repositorio de modelos de IA del mundo.  
¡Allí, tienes acceso a una increíble gama de modelos, conjuntos de datos, demostraciones con Gradio y mucho más!  

¡Es el GitHub de la Inteligencia Artificial, tanto comercial como de código abierto! 

El proveedor de Hugging Face de PowershAI conecta tu powershell con una increíble gama de servicios y modelos.  

## Gradio

Gradio es un framework para crear demostraciones para modelos de IA. Con poco código en python, es posible subir interfaces que aceptan diversos inputs, como texto, archivos, etc.  
Y, además de eso, administra muchas cuestiones como colas, cargas, etc.  Y, para completar, junto con la interfaz, puede proporcionar una API para que la funcionalidad expuesta a través de la UI también sea accesible a través de lenguajes de programación.  
PowershAI se beneficia de esto y expone las APIs de Gradio de una forma más fácil, donde es posible invocar una funcionalidad desde tu terminal y tener prácticamente la misma experiencia.


## Hugging Face Hub  

Hugging Face Hub es la plataforma a la que accedes en https://huggingface.co  
Está organizado en modelos (models), que son básicamente el código fuente de los modelos de IA que otras personas y empresas crean en todo el mundo.  
También existen los "Spaces", que son donde puedes subir código para publicar aplicaciones escritas en python (usando Gradio, por ejemplo) o docker.  

Conoce más sobre Hugging Face [en esta publicación del blog Ia Talking](https://iatalk.ing/hugging-face/)
Y, conoce Hugging Face Hub [en la documentación oficial](https://huggingface.co/docs/hub/en/index)

Con PowershaAI, puedes listar modelos e incluso interactuar con la API de varios spaces, ejecutando las aplicaciones de IA más variadas desde tu terminal.  


# Uso básico

El proveedor de Hugging Face de PowershAI tiene muchos cmdlets para la interacción.  
Está organizado en los siguientes comandos:

* los comandos que interactúan con Hugging Face poseen `HuggingFace` o `Hf` en el nombre. Ejemplo: `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* los comandos que interactúan con Gradio, independientemente de si son un Space de Hugging Face o no, poseen `Gradio` o `GradioSession'  en el nombre: `Send-GradioApi`, `Update-GradioSessionApiResult`
* Puedes usar este comando para obtener la lista completa: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

No necesitas autenticarte para acceder a los recursos públicos de Hugging Face.  
Hay una infinidad de modelos y spaces disponibles gratuitamente sin necesidad de autenticación.  
Por ejemplo, el siguiente comando enumera los 5 mejores modelos más descargados de Meta (autor: meta-llama):

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

El cmdlet Invoke-HuggingFaceHub es responsable de invocar los puntos finales de la API del Hub.  Los parámetros son los mismos que se documentan en https://huggingface.co/docs/hub/en/api
Sin embargo, necesitarás un token si necesitas acceder a recursos privados: `Set-HuggingFaceToken` (o `Set-HfToken`)  es el cmdlet para insertar el token predeterminado usado en todas las solicitudes.  



# Estructura de comandos del proveedor Hugging Face  
 
El proveedor de Hugging Face está organizado en 3 grupos principales de comandos: Gradio, Gradio Session y Hugging Face.  


## Comandos Gradio*`

Los cmdlets del grupo "gradio" tienen la estructura Verbo-GradioNombre.  Estos comandos implementan el acceso a la API de Gradio.  
Estos comandos son básicamente wrappers para las APIs. Su construcción se basó en esta documentación: https://www.gradio.app/guides/querying-gradio-apps-with-curl  y también observando el código fuente de Gradio (por ejemplo: [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
Estos comandos se pueden usar con cualquier aplicación Gradio, independientemente de dónde estén alojadas: en tu máquina local, en un space de Hugging Face, en un servidor en la nube... 
Solo necesitas la URL principal de la aplicación.  


Considera esta aplicación Gradio:

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="Duration, in, seconds", value=5);
    txtResults = gr.Text(label="Resultado");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

Básicamente, esta aplicación muestra 2 campos de texto, uno de los cuales es donde el usuario escribe texto y el otro se usa para mostrar la salida.  
Un botón, que al ser presionado, dispara la función Op1. La función realiza un bucle durante un determinado número de segundos informados en el parámetro.  
Cada segundo, devuelve cuánto tiempo ha pasado.  

Supón que al iniciar, esta aplicación sea accesible en http://127.0.0.1:7860.
Con este proveedor, conectarse a esta aplicación es simple:

```powershell
# instala powershai, si no está instalado!
Install-Module powershai 

# Importa
import-module powershai 

# Verifica los endpoints de la api!
Get-GradioInfo http://127.0.0.1:7860
```

El cmdlet `Get-GradioInfo` es el más simple. Simplemente lee el endpiunt /info que tiene toda aplicación Gradio.  
Este endpoint devuelve información valiosa, como los endpoints de la API disponibles:

```powershell
# Verifica los endpoints de la api!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# lista los parámetros del endpoint
$AppInfo.named_endpoints.'/op1'.parameters
```

Puedes invocar la API usando el cmdlet `Send-GradioApi`.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Ten en cuenta que necesitamos pasar la URL, el nombre del endpoint sin la barra y la matriz con la lista de parámetros.
El resultado de esta solicitud es un evento que se puede usar para consultar el resultado de la API.
Para obtener los resultados, debes usar `Update-GradioApiResult' 

```powershell
$Event | Update-GradioApiResult
```

El cmdlet `Update-GradioApiResult` escribirá los eventos generados por la API en el pipeline.  
Se devolverá un objeto para cada evento generado por el servidor. La propiedad `data` de este objeto tiene los datos devueltos, si los hay.  


También existe el comando `Send-GradioFile`, que permite realizar cargas.  Devuelve una matriz de objetos FileData, que representan el archivo en el servidor.  

Ten en cuenta que estos cmdlets son bastante primitivos: debes hacerlo todo manualmente. Obtener los endpoitns, invocar la api, enviar los parámetros como matriz, subir los archivos.  
Aunque estos comandos abstraen las llamadas HTTP directas de Gradio, aún exigen mucho al usuario.  
Es por eso que se creó el grupo de comandos GradioSession, que ayudan a abstraer aún más y a facilitar la vida del usuario.


## Comandos GradioSession*  

Los comandos del grupo GradioSession ayudan a abstraer aún más el acceso a una aplicación Gradio.  
Con ellos, estás más cerca del powershell al interactuar con una aplicación Gradio y más lejos de las llamadas nativas.  

Vamos a usar el propio ejemplo de la aplicación anterior para hacer algunas comparaciones:

```powershell
# crea una nueva session 
New-GradioSession http://127.0.0.1:7860
```

El cmdlet `New-GradioSession` crea una nueva sesión con Gradio.  Esta nueva sesión tiene elementos únicos como un SessionId, lista de archivos subidos, configuraciones, etc.  
El comando devuelve el objeto que representa esta sesión, y puedes obtener todas las sesiones creadas usando `Get-GradioSession`.  
Imagina que una GradoSession como una pestaña del navegador abierta con tu aplicación Gradio abierta.  

Los comandos GradioSession operan, por defecto, en la sesión predeterminada. Si solo existe 1 sesión, es la sesión predeterminada.  
Si existen más de una, el usuario debe elegir cuál es la predeterminada usando el comando `Set-GradioSession`

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

Uno de los comandos más poderosos es `New-GradioSessionApiProxyFunction` (o alias GradioApiFunction).  
Este comando transforma las APIs de Gradio de la sesión en funciones Powershell, es decir, puedes invocar la API como si fuera una función Powershell.  
Vamos a volver al ejemplo anterior


```powershell
# primero, abriendo la sessao!
New-GradioSession http://127.0.0.1:7860

# Ahora, vamos a crear las funcoes!
New-GradioSessionApiProxyFunction
```

El código anterior generará una función Powershell llamada Invoke-GradioApiOp1.  
Esta función tiene los mismos parámetros que el endpoint '/op1', y puedes usar get-help para obtener más información:  

```powershell
get-help -full Invoke-GradioApiOp1
```

Para ejecutar, solo tienes que invocar:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Ten en cuenta que el parámetro `Duration` definido en la aplicación Gradio se convirtió en un parámetro Powershell.  
En el fondo, Invoke-GradioApiOp1 está ejecutando `Update-GradioApiResult`, es decir, el retorno es el mismo objeto.
¡Pero, observa lo simple que fue invocar la API de Gradio y recibir el resultado!

Las aplicaciones que definen archivos, como música, imágenes, etc., generan funciones que suben automáticamente estos archivos.  
El usuario solo necesita especificar la ruta local.  

Eventualmente, es posible que haya algún tipo de dato que no sea compatible con la conversión, y, en caso de que te encuentres con alguno, abre una issue (o envía un PR) para que lo evaluemos e implementemos.



## Comandos HuggingFace* (o Hf*)  

Los comandos de este grupo se crearon para operar con la API de Hugging Face.  
Básicamente, encapsulan las llamadas HTTP a los diversos endpoints de Hugging Face.  

Un ejemplo:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

Este comando devuelve un objeto que contiene diversa información sobre el space diffusers-labs, del usuario rrg92.  
Como es un space Gradio, puedes conectarlo con los demás cmdlets (los cmdlets GradioSession pueden entender cuándo se les pasa un objeto devuelto por Get-HuggingFaceSpace).

```
# Conectar no space (e, automatic, cria uma gradio session)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

#Default
Set-GradioSession -Default $diff

# Cria funcoes!
New-GradioSessionApiProxyFunction

# invoca!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**IMPORTANTE: Recuerda que el acceso a determinados spaces solo se puede realizar con autenticación. En estos casos, debes usar Set-HuggingFaceToken y especificar un token de acceso.**




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
