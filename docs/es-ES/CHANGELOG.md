# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.3]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVIDER**: Añadido parámetro -DisableRetry de Get-GradioInfo
- **HUGGINGFACE PROVIDER**: Añadidos parámetros GradioServerRoot en Get-HuggingFaceSpace y ServerRoot en Connect-HuggingFaceSpaceGradio
- **HUGGINGFACE PROVIDER**: Añadida lógica para detectar si el space de hugging face usa Gradio 5 y ajustar el server root
- **HUGGINGFACE PROVIDER**: Añadidos spaces privados a las pruebas del provider

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: Corregido problema de autenticación en spaces privados


## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Añadido groq a las pruebas automáticas

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Corregido error en el provider groq, relacionado con system messages 
- **COHERE PROVIDER**: Corregido error relacionado con mensajes del modelo cuando tenían respuestas de tool calls.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: ¡Los chats se estaban recreando cada vez, evitando mantener el historial correctamente al usar múltiples chats! 
- **OPENAI PROVIDER**: Corregido resultado de `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corregidos errores del provider Hugging Face debido a redirecciones.
- Corregida la instalación de módulos para pruebas usando Docker Compose.
- Corregidos problemas de rendimiento en la conversión de herramientas debido a un posible gran número de comandos en una sesión. Ahora utiliza módulos dinámicos. Ver `ConvertTo-OpenaiTool`.
- Corregidos problemas de incompatibilidad entre la API GROQ y OpenAI. `message.refusal` ya no es aceptado.
- Corregidos pequeños bugs en PowerShell Core para Linux.
- **OPENAI PROVIDER**: Resuelto código de excepción causado por la ausencia de un modelo predeterminado.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NUEVO PROVEEDOR**: Bienvenido Azure 🎉
- **NUEVO PROVEEDOR**: Bienvenido Cohere 🎉
- Añadida la función `AI Credentials` — una nueva forma estándar para que los usuarios definan credenciales, permitiendo que los proveedores soliciten datos de credenciales de los usuarios.
- Proveedores migrados para usar `AI Credentials`, manteniendo la compatibilidad con comandos más antiguos.
- Nuevo cmdlet `Confirm-PowershaiObjectSchema`, para validar esquemas usando OpenAPI con una sintaxis más "PowerShellizada".
- Añadido soporte para redirecciones HTTP en la librería HTTP
- Añadidas varias nuevas pruebas con Pester, que van desde pruebas unitarias básicas hasta casos más complejos, como llamadas de herramientas LLM reales.
- Nuevo cmdlet `Switch-PowershaiSettings` permite alternar configuraciones y crear chats, proveedores predeterminados, modelos, etc., como si fueran perfiles distintos.
- **Retry Logic**: Añadido `Enter-PowershaiRetry` para reejecutar scripts basados en condiciones.
- **Retry Logic**: Añadida lógica de reintento en `Get-AiChat` para ejecutar fácilmente el prompt al LLM nuevamente si la respuesta anterior no está de acuerdo con lo deseado.- El nuevo cmdlet `Enter-AiProvider` ahora permite ejecutar código bajo un proveedor específico. Cmdlets que dependen de un proveedor, usarán siempre el proveedor en el que se "entró" más recientemente en lugar del proveedor actual.
- Pila de Proveedores (Push/Pop): Al igual que en `Push-Location` y `Pop-Location`, ahora puedes insertar y eliminar proveedores para cambios más rápidos al ejecutar código en otro proveedor.
- Nuevo cmdlet `Get-AiEmbeddings`: Se han añadido cmdlets estándar para obtener embeddings de un texto, permitiendo que los proveedores expongan la generación de embeddings y que el usuario tenga un mecanismo estándar para generarlos.
- Nuevo cmdlet `Reset-AiDefaultModel` para desmarcar el modelo predeterminado.
- Se han añadido los parámetros `ProviderRawParams` a `Get-AiChat` e `Invoke-AiChat` para sobrescribir los parámetros específicos en la API, por proveedor.
- **HUGGINGFACE PROVIDER**: Se han añadido nuevas pruebas utilizando un espacio real de Hugging Face exclusivo mantenido como un submódulo de este proyecto. Esto permite probar varios aspectos al mismo tiempo: sesiones de Gradio e integración de Hugging Face.
- **HUGGINGFACE PROVIDER**: Nuevo cmdlet: Find-HuggingFaceModel, para buscar modelos en el hub basado en algunos filtros!
- **OPENAI PROVIDER**: Se ha añadido un nuevo cmdlet para generar llamadas a herramientas: `ConvertTo-OpenaiTool`, soportando herramientas definidas en bloques de script.
- **OLLAMA PROVIDER**: Nuevo cmdlet `Get-OllamaEmbeddings` para retornar embeddings usando Ollama.
- **OLLAMA PROVIDER**: Nuevo cmdlet `Update-OllamaModel` para descargar modelos ollama (pull) directamente del powershai
- **OLLAMA PROVIDER**: Detección automática de herramientas usando los metadatos de ollama
- **OLLAMA PROVIDER**: Caché de metadatos de modelos y nuevo cmdlet `Reset-OllamaPowershaiCache` para limpiar la caché, permitiendo consultar muchos detalles de los modelos ollama, mientras mantiene el rendimiento para el uso repetido del comando

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: El parámetro del Chat `ContextFormatter` ha sido renombrado a `PromptBuilder`.
- Se ha cambiado la visualización predeterminada (formats.ps1xml) de algunos cmdlets como `Get-AiModels`.
- Mejora en el registro detallado al eliminar el historial antiguo debido a `MaxContextSize` en chats.
- Nueva forma en que se almacenan las configuraciones de PowershAI, introduciendo un concepto de "Almacenamiento de Configuraciones", permitiendo el intercambio de configuración (por ejemplo, para pruebas).
- Actualizados los emojis mostrados junto con el nombre del modelo cuando se usa el comando Send-PowershaiChat
- Mejoras en la criptografía de exportación/importación de configuraciones (Export=-PowershaiSettings). Ahora usa como derivación de clave y sal.
- Mejora en el retorno de la interfaz *_Chat, para que sea más fiel al estándar de OpenAI.
- Se ha añadido la opción `IsOpenaiCompatible` para proveedores. Los proveedores que desean reutilizar cmdlets de OpenAI deben definir este indicador como `true` para funcionar correctamente.
- Mejora en el tratamiento de errores de `Invoke-AiChatTools` en el procesamiento de llamadas a herramientas.- **PROVEEDOR GOOGLE**: Se agregó el cmdlet `Invoke-GoogleApi` para permitir llamadas directas a la API por parte de los usuarios.
- **PROVEEDOR HUGGING FACE**: Pequeños ajustes en la forma de insertar el token en las solicitudes de la API.
- **PROVEEDOR OPENAI**: `Get-OpenaiToolFromCommand` y `Get-OpenaiToolFromScript` ahora utilizan `ConvertTo-OpenaiTool` para centralizar la conversión de comando a herramienta OpenAI.
- **PROVEEDOR GROQ**: Actualizado el modelo predeterminado de `llama-3.1-70b-versatile` a `llama-3.2-70b-versatile`.
- **PROVEEDOR OLLAMA**: Get-AiModels ahora incluye modelos que soportan tools, ya que el proveedor utiliza el endpoint /api/show para obtener más detalles de los modelos, lo que permite verificar el soporte para tools.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Se corrigió un error en la función `New-GradioSessionApiProxyFunction`, relacionado con algunas funciones internas.
- Se agregó soporte para Gradio 5, que es necesario debido a cambios en los endpoints de la API.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Soporte para imágenes en `Send-PowershaiChat` para los proveedores OpenAI y Google.
- Un comando experimental, `Invoke-AiScreenshots`, que agrega soporte para tomar capturas de pantalla y analizarlas.
- Soporte para la llamada de herramientas en el proveedor Google.
- CHANGELOG fue iniciado.
- Soporte para TAB para Set-AiProvider.
- Se agregó soporte básico para salida estructurada al parámetro `ResponseFormat` del cmdlet `Get-AiChat`. Esto permite pasar un hashtable describiendo el esquema OpenAPI del resultado.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **CAMBIO ROMPEDOR**: La propiedad `content` de los mensajes OpenAI ahora se envía como un array para alinearse con las especificaciones para otros tipos de medios. Esto requiere la actualización de scripts que dependen del formato de cadena única anterior y de versiones antiguas de proveedores que no soportan esta sintaxis.
- El parámetro `RawParams` de `Get-AiChat` fue corregido. Ahora puedes pasar parámetros de la API al proveedor en cuestión para tener un control estricto sobre el resultado.
- Actualizaciones de DOC: Nuevos documentos traducidos con AiDoc y actualizaciones. Pequeña corrección en AiDoc.ps1 para no traducir algunos comandos de sintaxis markdown.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Las configuraciones de seguridad fueron cambiadas y el tratamiento de mayúsculas y minúsculas fue mejorado. Esto no estaba siendo validado, lo que resultaba en un error.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2


<!--PowershaiAiDocBlockStart-->
_Estás entrenado con datos hasta octubre de 2023._
<!--PowershaiAiDocBlockEnd-->
