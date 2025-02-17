# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Added groq to automated tests

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Fixed error in groq provider, related to system messages
- **COHERE PROVIDER**: Fixed error related to model messages when they had tool call responses.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Chats were being recreated every time, preventing the history from being maintained correctly when using multiple chats!
- **OPENAI PROVIDER**: Fixed `Get-AiEmbeddings` result

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fixed Hugging Face provider errors due to redirects.
- Fixed module installation for tests using Docker Compose.
- Fixed performance issues in tool conversion due to a potentially large number of commands in a session. Now uses dynamic modules. See `ConvertTo-OpenaiTool`.
- Fixed incompatibility issues between the GROQ and OpenAI APIs. `message.refusal` is no longer accepted.
- Fixed minor bugs in PowerShell Core for Linux.
- **OPENAI PROVIDER**: Resolved exception code caused by the absence of a default model.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NEW PROVIDER**: Welcome Azure 🎉
- **NEW PROVIDER**: Welcome Cohere 🎉
- Added the `AI Credentials` feature — a new standard way for users to define credentials, allowing providers to request credential data from users.
- Migrated providers to use `AI Credentials`, maintaining compatibility with older commands.
- New cmdlet `Confirm-PowershaiObjectSchema`, to validate schemas using OpenAPI with a more "PowerShellized" syntax.
- Added support for HTTP redirects in the HTTP lib
- Added several new tests with Pester, ranging from basic unit tests to more complex cases such as real LLM tool calls.
- New cmdlet `Switch-PowershaiSettings` allows switching settings and creating chats, default providers, models, etc., as if they were distinct profiles.
- **Retry Logic**: Added `Enter-PowershaiRetry` to re-execute scripts based on conditions.
- **Retry Logic**: Added retry logic in `Get-AiChat` to easily re-execute the prompt to the LLM if the previous response is not as desired.
- New cmdlet `Enter-AiProvider` now allows executing code under a specific provider. Cmdlets that depend on a provider will always use the most recently "entered" provider instead of the current provider.
- Provider Stack (Push/Pop): Just like in `Push-Location` and `Pop-Location`, you can now insert and remove providers for faster changes when running code in another provider.
- New cmdlet `Get-AiEmbeddings`: Added standard cmdlets to get embeddings from a text, allowing providers to expose embedding generation and users to have a standard mechanism to generate them.
- New cmdlet `Reset-AiDefaultModel` to unmark the default model.
- Added the `ProviderRawParams` parameters to `Get-AiChat` and `Invoke-AiChat` to override the specific parameters in the API, per provider.
- **HUGGINGFACE PROVIDER**: Added new tests using a real exclusive Hugging Face space maintained as a submodule of this project. This allows testing several aspects at the same time: Gradio sessions and Hugging Face integration.
- **HUGGINGFACE PROVIDER**: New cmdlet: Find-HuggingFaceModel, to search for models in the hub based on some filters!
- **OPENAI PROVIDER**: Added a new cmdlet to generate tool calls: `ConvertTo-OpenaiTool`, supporting tools defined in script blocks.
- **OLLAMA PROVIDER**: New cmdlet `Get-OllamaEmbeddings` to return embeddings using Ollama.
- **OLLAMA PROVIDER**: New cmdlet `Update-OllamaModel` to download ollama models (pull) directly from powershai
- **OLLAMA PROVIDER**: Automatic detection of tools using ollama metadata
- **OLLAMA PROVIDER**: Model metadata cache and new cmdlet `Reset-OllamaPowershaiCache` to clear the cache, allowing querying many details of ollama models while maintaining performance for repeated use of the command

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: The Chat parameter `ContextFormatter` has been renamed to `PromptBuilder`.
- Changed the default display (formats.ps1xml) of some cmdlets such as `Get-AiModels`.
- Improved detailed logging when removing old history due to `MaxContextSize` in chats.
- New way PowershAI settings are stored, introducing a "Settings Storage" concept, allowing configuration switching (e.g., for testing).
- Updated emojis displayed next to the model name when using the Send-PowershaiChat command
- Improvements in the encryption of export/import of settings (Export=-PowershaiSettings). Now uses key and salt derivation.
- Improved the return of the *_Chat interface to be more faithful to the OpenAI standard.
- Added the `IsOpenaiCompatible` option for providers. Providers that want to reuse OpenAI cmdlets should set this flag to `true` to function correctly.
- Improved error handling of `Invoke-AiChatTools` in tool calling processing.
- **GOOGLE PROVIDER**: Added the `Invoke-GoogleApi` cmdlet to allow direct API calls by users.
- **HUGGING FACE PROVIDER**: Small adjustments to the way the token is inserted into API requests.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` and `Get-OpenaiToolFromScript` now use `ConvertTo-OpenaiTool` to centralize the conversion of command to OpenAI tool.
- **GROQ PROVIDER**: Updated the default model from `llama-3.1-70b-versatile` to `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels now includes models that support tools, as the provider uses the /api/show endpoint to get more details of the models, which allows checking for tool support

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fixed bug in the `New-GradioSessionApiProxyFunction` function, related to some internal functions.
- Added support for Gradio 5, which is necessary due to changes in the API endpoints

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Support for images in `Send-PowershaiChat` for OpenAI and Google providers.
- An experimental command, `Invoke-AiScreenshots`, which adds support for taking screenshots and analyzing them!
- Support for tool calling in the Google provider.
- CHANGELOG was started.
- TAB support for Set-AiProvider.
- Added basic support for structured output to the `ResponseFormat` parameter of the `Get-AiChat` cmdlet. This allows passing a hashtable describing the OpenAPI schema of the result.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: The `content` property of OpenAI messages is now sent as an array to align with specifications for other media types. This requires updating scripts that depend on the previous single string format and older versions of providers that do not support this syntax.
- `RawParams` parameter of `Get-AiChat` was fixed. Now you can pass API parameters to the provider in question to have strict control over the result
- DOC updates: New documents translated with AiDoc and updates. Small fix in AiDoc.ps1 to not translate some markdown syntax commands.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Security settings have been changed and case handling has been improved. This was not being validated, which resulted in an error.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
