# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Se corrigieron errores del proveedor Hugging Face debido a redirecciones.
- Se corrigió la instalación de módulos para pruebas usando Docker Compose.
- Se corrigieron problemas de rendimiento en la conversión de herramientas debido a un posible gran número de comandos en una sesión. Ahora usa módulos dinámicos. Ver `ConvertTo-OpenaiTool`.
- Se corrigieron problemas de incompatibilidad entre la API GROQ y OpenAI. `message.refusal` ya no es aceptado.
- Se corrigieron pequeños errores en PowerShell Core para Linux.
- **PROVEEDOR OPENAI**: Se resolvió el código de excepción causado por la ausencia de un modelo predeterminado.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NUEVO PROVEEDOR**: Bienvenido Azure 🎉
- **NUEVO PROVEEDOR**: Bienvenido Cohere 🎉
- Se agregó la función `AI Credentials` — una nueva forma predeterminada para que los usuarios definan credenciales, permitiendo que los proveedores soliciten datos de credenciales de los usuarios.
- Los proveedores se migraron para usar `AI Credentials`, manteniendo la compatibilidad con comandos anteriores.
- Nuevo cmdlet `Confirm-PowershaiObjectSchema`, para validar esquemas usando OpenAPI con una sintaxis más "PowerShellzada".
- Se agregó soporte para redirecciones HTTP en la biblioteca HTTP
- Se agregaron varias pruebas nuevas con Pester, que van desde pruebas unitarias básicas hasta casos más complejos, como llamadas a herramientas LLM reales.
- El nuevo cmdlet `Switch-PowershaiSettings` permite alternar configuraciones y crear chats, proveedores predeterminados, modelos, etc., como si fueran perfiles distintos.
- **Lógica de reintentos**: Se agregó `Enter-PowershaiRetry` para re-ejecutar scripts en función de condiciones.
- **Lógica de reintentos**: Se agregó lógica de reintentos en `Get-AiChat` para ejecutar fácilmente el prompt en el LLM nuevamente en caso de que la respuesta anterior no sea la deseada.
- El nuevo cmdlet `Enter-AiProvider` ahora permite ejecutar código bajo un proveedor específico. Los cmdlets que dependen de un proveedor, siempre usarán el proveedor en el que se "ingresó" más recientemente en lugar del proveedor actual.
- Pila de proveedores (Push/Pop): Al igual que en `Push-Location` y `Pop-Location`, ahora puede insertar y eliminar proveedores para cambios más rápidos al ejecutar código en otro proveedor.
- Nuevo cmdlet `Get-AiEmbeddings`: Se agregaron cmdlets predeterminados para obtener incrustaciones de un texto, permitiendo que los proveedores expongan la generación de incrustaciones y que el usuario tenga un mecanismo predeterminado para generarlas.
- Nuevo cmdlet `Reset-AiDefaultModel` para desmarcar el modelo predeterminado.
- Se agregaron los parámetros `ProviderRawParams` a `Get-AiChat` e `Invoke-AiChat` para sobrescribir los parámetros específicos en la API, por proveedor.
- **PROVEEDOR HUGGINGFACE**: Se agregaron nuevas pruebas usando un espacio Hugging Face real exclusivo mantenido como un submódulo de este proyecto. Esto permite probar varios aspectos al mismo tiempo: sesiones Gradio e integración Hugging Face.
- **PROVEEDOR OPENAI**: Se agregó un nuevo cmdlet para generar llamadas a herramientas: `ConvertTo-OpenaiTool`, que admite herramientas definidas en bloques de scripts.
- **PROVEEDOR OLLAMA**: Nuevo cmdlet `Get-OllamaEmbeddings` para devolver incrustaciones usando Ollama.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **CAMBIO DE ROMPIMIENTO**: El parámetro del Chat `ContextFormatter` se cambió el nombre a `PromptBuilder`.
- Se cambió la visualización predeterminada (formats.ps1xml) de algunos cmdlets como `Get-AiModels`.
- Mejora en el registro detallado al eliminar el historial antiguo debido a `MaxContextSize` en chats.
- Nueva forma en que se almacenan las configuraciones de PowershAI, introduciendo un concepto de "Almacenamiento de configuraciones", permitiendo el cambio de configuración (por ejemplo, para pruebas).
- Se actualizaron los emojis que se muestran junto con el nombre del modelo cuando se usa el comando Send-PowershaiChat
- Mejoras en el cifrado de la exportación/importación de configuraciones (Export=-PowershaiSettings). Ahora usa como derivación de clave y sal.
- Mejora en el retorno de la interfaz *_Chat, para que sea más fiel al estándar de OpenAI.
- Se agregó la opción `IsOpenaiCompatible` para proveedores. Los proveedores que deseen reutilizar cmdlets OpenAI deben definir este indicador como `true` para que funcione correctamente.
- Mejora en el manejo de errores de `Invoke-AiChatTools` en el procesamiento de llamadas a herramientas.
- **PROVEEDOR GOOGLE**: Se agregó el cmdlet `Invoke-GoogleApi` para permitir llamadas de API directas por parte de los usuarios.
- **PROVEEDOR HUGGING FACE**: Pequeños ajustes en la forma de insertar el token en las solicitudes de la API.
- **PROVEEDOR OPENAI**: `Get-OpenaiToolFromCommand` y `Get-OpenaiToolFromScript` ahora usan `ConvertTo-OpenaiTool` para centralizar la conversión de comando a herramienta OpenAI.
- **PROVEEDOR GROQ**: Se actualizó el modelo predeterminado de `llama-3.1-70b-versatile` a `llama-3.2-70b-versatile`.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Se corrigió un error en la función `New-GradioSessionApiProxyFunction`, relacionado con algunas funciones internas.
- Se agregó soporte para Gradio 5, que es necesario debido a cambios en los endpoints de la API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Soporte para imágenes en `Send-PowershaiChat` para los proveedores OpenAI y Google.
- Un comando experimental, `Invoke-AiScreenshots`, ¡que agrega soporte para tomar capturas de pantalla y analizarlas!
- Soporte para llamadas a herramientas en el proveedor Google.
- Se inició CHANGELOG.
- Soporte para TAB para Set-AiProvider. 
- Se agregó soporte básico para salida estructurada al parámetro `ResponseFormat` del cmdlet `Get-AiChat`. Esto permite pasar una tabla hash que describe el esquema OpenAPI del resultado.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **CAMBIO DE ROMPIMIENTO**: La propiedad `content` de los mensajes OpenAI ahora se envía como una matriz para alinearse con las especificaciones para otros tipos de medios. Esto requiere la actualización de scripts que dependen del formato de cadena única anterior y de versiones antiguas de proveedores que no admiten esta sintaxis.
- Se corrigió el parámetro `RawParams` de `Get-AiChat`. Ahora puede pasar parámetros de la API al proveedor en cuestión para tener un control estricto sobre el resultado
- Actualizaciones de DOC: Nuevos documentos traducidos con AiDoc y actualizaciones. Pequeña corrección en AiDoc.ps1 para no traducir algunos comandos de sintaxis markdown.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Se cambiaron las configuraciones de seguridad y se mejoró el manejo de mayúsculas y minúsculas. Esto no se estaba validando, lo que resultaba en un error.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowerShell e IA
_
<!--PowershaiAiDocBlockEnd-->
