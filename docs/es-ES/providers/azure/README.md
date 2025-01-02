# Proveedor Azure OpenAI

El proveedor Azure OpenAI implementa todas las funciones necesarias para conectarse con la API de los modelos que pueden configurarse en su suscripción de Azure.
Los modelos siguen el mismo patrón de OpenAI, y la mayoría de los comandos funcionan exactamente igual que openai.

# Inicio rápido

Usar el proveedor de Azure implica los siguientes pasos:

- Crear los recursos en el portal de Azure, o Azure AI Studio.

  - Con esto tendrá las URLs y API Keys necesarias para la autenticación.
- Usar `Set-AiProvider azure` para cambiar el proveedor actual a azure.
- Definir información de la URL de la API usando el comando `Set-AiAzureApiUrl`. El parámetro `-ChangeToken` permite que usted defina el token junto.

Una vez que haya seguido estos pasos, puede conversar normalmente usando comandos con `ia`.


## APIs y URL

Para usar el proveedor azure, actívelo usando `Set-AiProvider azure`.
Básicamente, azure proporciona las siguientes APIs para conversar con LLM:

- API Azure OpenAI
Esta API permite que usted converse con los modelos de OpenAI que están en la infraestructura de Azure o que fueron aprovisionados exclusivamente para usted.

- API de Inferencia
Esta API permite que usted converse con otros modelos, como Phi3, Llama3.1, diversos modelos de hugging face, etc.
Estos modelos pueden ser aprovisionados de forma serverless (usted tiene una API funcional, independientemente de dónde se ejecuta, con quién comparte, etc.) o de forma exclusiva (donde el modelo está disponible exclusivamente en una máquina para usted).

Al final de cuentas, para usted, como usuario de powershai, solo necesita saber que este proveedor puede ajustar correctamente las llamadas de la API.
Y todas son compatibles con el mismo formato de la API de OpenAI (aunque no todas las funcionalidades pueden estar disponibles para ciertos modelos, como el Tool Calling).

Es importante saber que existen estos dos tipos, ya que esto le guiará en la configuración inicial.
Debe usar el comando `Set-AiAzureApiUrl` para definir la URL de su API.

Este cmdlet es muy flexible.
Puede especificar una URL de Azure OpenAI. Ej.:

```powershell
Set-AiAzureApiUrl -ChangeToken https://iatalking.openai.azure.com/openai/deployments/gpt-4o-mini/chat/completions?api-version=2023-03-15-preview
```

Con el comando anterior, identificará qué API debe usarse y los parámetros correctos.
También, identifica las URLs referentes a la API de inferencia:

```powershell
Set-AiAzureApiUrl -ChangeToken https://test-powershai.eastus2.models.ai.azure.com
```

Note el uso del parámetro `-ChangeToken`.
Este parámetro le obligará a tener que insertar el token de nuevo.
Es útil cuando se está cambiando, o configurando por primera vez.

Puede cambiar la API key posteriormente, si necesita, usando el comando `Set-AiAzureApiKey`


## Links útiles

Los siguientes enlaces pueden ayudarle a configurar su Azure OpenAI, y obtener sus credenciales.


- Visión general de Azure OpenaAI
https://learn.microsoft.com/en-us/azure/ai-services/openai/overview

- Creación del recurso en el portal
https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/create-resource?pivots=web-portal

- Sobre Azure AI Studio
https://learn.microsoft.com/en-us/azure/ai-studio/what-is-ai-studio

- Referencia de la API
https://learn.microsoft.com/en-us/azure/ai-services/openai/reference


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowerShell e IA_
<!--PowershaiAiDocBlockEnd-->
