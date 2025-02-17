# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Añadido groq a las pruebas automáticas

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Corregido error en el proveedor groq, relacionado con los mensajes del sistema
- **COHERE PROVIDER**: Corregido error relacionado con los mensajes del modelo cuando tenían respuestas de tool calls.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Los chats se estaban recreando cada vez, ¡evitando mantener el historial correctamente al usar múltiples chats!
- **OPENAI PROVIDER**: Corregido resultado de `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corregidos errores del proveedor Hugging Face debido a redireccionamientos.
- Corregida la instalación de módulos para pruebas usando Docker Compose.
- Corregidos problemas de rendimiento en la conversión de herramientas debido a un posible gran número de comandos en una sesión. Ahora usa módulos dinámicos. Vea `ConvertTo-OpenaiTool`.
- Corregidos problemas de incompatibilidad entre la API GROQ y el OpenAI. `message.refusal` ya no es aceptado.
- Corregidos pequeños bugs en PowerShell Core para Linux.
- **OPENAI PROVIDER**: Resuelto código de excepción causado por la ausencia de un modelo estándar.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NUEVO PROVEEDOR**: ¡Bienvenido Azure 🎉!
- **NUEVO PROVEEDOR**: ¡Bienvenido Cohere 🎉!
- Añadido el recurso `AI Credentials` — una nueva manera estándar para que los usuarios definan credenciales, permitiendo que los proveedores soliciten datos de credenciales de los usuarios.
- Proveedores migrados para usar `AI Credentials`, manteniendo la compatibilidad con comandos más antiguos.
- Nuevo cmdlet `Confirm-PowershaiObjectSchema`, para validar esquemas usando OpenAPI con una sintaxis más "PowerShellzada".
- Añadido soporte para redireccionamientos HTTP en la HTTP lib
- Añadidos varias pruebas nuevas con Pester, variando desde pruebas unitarias básicas hasta casos más complejos, como llamadas de herramientas LLM reales.
- Nuevo cmdlet `Switch-PowershaiSettings` permite alternar configuraciones y crear chats, proveedores estándar, modelos, etc., como si fueran perfiles distintos.
- **Retry Logic**: Añadido `Enter-PowershaiRetry` para reejecutar scripts basándose en condiciones.
- **Retry Logic**: Añadido retry logic en `Get-AiChat` para ejecutar fácilmente el prompt al LLM nuevamente en caso de que la respuesta anterior no esté de acuerdo con lo deseado.
- Nuevo cmdlet `Enter-AiProvider` ahora permite ejecutar código bajo un proveedor específico. Cmdlets que dependen de un proveedor, usarán siempre el proveedor en el que se ha "entrado" más reciente en lugar del proveedor actual.
- Stack de Provider (Push/Pop): Así como en `Push-Location` y `Pop-Location`, ahora puedes insertar y remover proveedores para cambios más rápidos al ejecutar código en otro proveedor.
- Nuevo cmdlet `Get-AiEmbeddings`: Añadidos cmdlets estándar para obtener embeddings de un texto, permitiendo que los proveedores expongan la generación de embeddings y que el usuario tenga un mecanismo estándar para generarlos.
- Nuevo cmdlet `Reset-AiDefaultModel` para desmarcar el modelo estándar.
- Añadidos los parámetros `ProviderRawParams` a `Get-AiChat` e `Invoke-AiChat` para sobrescribir los parámetros específicos en la API, por proveedor.
- **HUGGINGFACE PROVIDER**: Añadidos nuevos tests usando un space Hugging Face exclusivo real mantenido como un submódulo de este proyecto. Esto permite probar varios aspectos al mismo tiempo: sesiones Gradio e integración Hugging Face.
- **HUGGINGFACE PROVIDER**: Nuevo cmdlet: Find-HuggingFaceModel, ¡para buscar modelos en el hub basándose en algunos filtros!
- **OPENAI PROVIDER**: Añadido un nuevo cmdlet para generar llamadas de herramientas: `ConvertTo-OpenaiTool`, soportando herramientas definidas en bloques de script.
- **OLLAMA PROVIDER**: Nuevo cmdlet `Get-OllamaEmbeddings` para retornar embeddings usando Ollama.
- **OLLAMA PROVIDER**: Nuevo cmdlet `Update-OllamaModel` para descargar models ollama (pull) directamente desde powershai
- **OLLAMA PROVIDER**: Detección automática de tools usando los metadatos del ollama
- **OLLAMA PROVIDER**: Cache de metadatos de models y nuevo cmdlet `Reset-OllamaPowershaiCache` para limpiar el cache, permitiendo consultar muchos detalles de los modelos ollama, mientras mantiene performance para el uso repetido del comando

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: El parámetro del Chat `ContextFormatter` ha sido renombrado a `PromptBuilder`.
- Cambiado la visualización estándar (formats.ps1xml) de algunos cmdlets como `Get-AiModels`.
- Mejora en el log detallado al remover el historial antiguo debido a `MaxContextSize` en chats.
- Nueva manera como las configuraciones de PowershAI son almacenadas, introduciendo un concepto de "Almacenamiento de Configuraciones", permitiendo el intercambio de configuración (por ejemplo, para pruebas).
- Actualizado emojis mostrados junto con el nombre del modelo cuando se usa el comando Send-PowershaiChat
- Mejoras en la encriptación del export/import de configuraciones (Export=-PowershaiSettings). Ahora usa como derivación de clave y salt.
- Mejora en el retorno de la interfaz *_Chat, para que sea más fiel al estándar de OpenAI.
- Añadida la opción `IsOpenaiCompatible` para proveedores. Los proveedores que deseen reutilizar cmdlets OpenAI deben definir este indicador como `true` para funcionar correctamente.
- Mejora en el tratamiento de errores de `Invoke-AiChatTools` en el procesamiento de tool calling.
- **GOOGLE PROVIDER**: Añadido el cmdlet `Invoke-GoogleApi` para permitir llamadas de API directas por los usuarios.
- **HUGGING FACE PROVIDER**: Pequeño ajuste en la forma de insertar el token en las peticiones de la API.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` y `Get-OpenaiToolFromScript` ahora usan `ConvertTo-OpenaiTool` para centralizar la conversión de comando a herramienta OpenAI.
- **GROQ PROVIDER**: Actualizado el modelo estándar de `llama-3.1-70b-versatile` a `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels ahora incluye modelos que soportan tools, pues el provider usa el endpoint /api/show para obtener más detalles de los modelos, lo que permite checar por el soporte a tools

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corregido bug en la función `New-GradioSessionApiProxyFunction`, relacionado con algunas funciones internas.
- Añadido soporte para Gradio 5, que es necesario debido a cambios en los endpoints de la API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Soporte para imágenes en `Send-PowershaiChat` para los proveedores OpenAI y Google.
- Un comando experimental, `Invoke-AiScreenshots`, ¡que añade soporte para tomar capturas de pantalla y analizarlas!
- Soporte para llamada de herramientas en el proveedor Google.
- CHANGELOG ha sido iniciado.
- Soporte para el TAB para Set-AiProvider.
- Añadido soporte básico para salida estructurada al parámetro `ResponseFormat` del cmdlet `Get-AiChat`. Esto permite pasar un hashtable describiendo el esquema OpenAPI del resultado.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: La propiedad `content` de los mensajes OpenAI ahora es enviada como un array para alinearse a las especificaciones para otros tipos de medios. Esto requiere la actualización de scripts que dependen del formato de string única anterior y de versiones antiguas de proveedores que no soportan esta sintaxis.
- Parámetro `RawParams` de `Get-AiChat` fue corregido. Ahora puedes pasar parámetros de la API para el proveedor en cuestión para tener estricto control sobre el resultado
- Actualizaciones de DOC: Nuevos documentos traducidos con AiDoc y actualizaciones. Pequeña corrección en AiDoc.ps1 para no traducir algunos comandos de sintaxis markdown.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Las configuraciones de seguridad fueron alteradas y el tratamiento de mayúsculas y minúsculas fue mejorado. Esto no estaba siendo validado, lo que resultaba en un error.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2



<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
