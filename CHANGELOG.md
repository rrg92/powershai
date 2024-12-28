# Changelog

## [Unreleased]

## [v0.7.0]

### Fixed 
- Fixed Hugging Face provider errors due to redirects.  
- Fixed installation of modules for testing using Docker Compose.  
- Fixed performance issues when converting tools due to a possible large number of commands in a session. Now uses dynamic modules. See `ConvertTo-OpenaiTool`.  
- Fixed incompatibility issues between GROQ API and OpenAI. The `message.refusal` is no longer accepted.  
- Fixed minor bugs in PowerShell Core for Linux.  
- **OPENAI PROVIDER**: Resolved exception code caused by the absence of a default model.  

### Added 
- **NEW PROVIDER**: Welcome to Azure 🎉  
- **NEW PROVIDER**: Welcome to Cohere 🎉  
- Added the AI Credentials feature—a new standard way for users to set credentials, allowing providers to request credential data from users.  
- Migrated providers to use AI Credentials while maintaining compatibility with older commands.  
- New cmdlet `Confirm-PowershaiObjectSchema`, to validate schemas using OpenAPI with a syntax more "PowerShell-like".  
- Added support for HTTP redirections in `httplib`.  
- Added numerous new tests for PowershAI, ranging from basic unit tests to more complex cases, such as real LLM tool calls.  
- New cmdlet `Switch-PowershaiSettings` allows switching settings and creating chats, default providers, models, etc., like distinct profiles.  
- **Retry Logic**: Added `Enter-PowershaiRetry` to rerun scripts based on conditions.  
- **Retry Logic**: Added retry logic in `Get-AiChat` to simplify retrying LLM inference based on responses or user-defined checks.  
- New cmdlet `Enter-AiProvider` now allows executing code under a specific provider. All provider-dependent cmdlets will always return results from the most recently "entered" provider.  
- Push/Pop Providers: Like `Push-Location` and `Pop-Location`, you can now push and pop providers for quicker changes when running code in another provider.  
- New cmdlet `Get-AiEmbeddings`: Added standard embeddings cmdlets, allowing providers to expose embeddings generation.  
- New cmdlet `Reset-AiDefaultModel` to unset the default model.  
- Added `ProviderRawParams` to `Get-AiChat` and `Invoke-AiChat` to specify raw parameters per provider.  
- **HUGGINGFACE PROVIDER**: Added new tests using a real exclusive Hugging Face Space maintained as a submodule of this project. This enables testing multiple aspects at once: Gradio sessions and Hugging Face integration.  
- **OPENAI PROVIDER**: Added a new cmdlet to generate tool calling: `ConvertTo-OpenaiTool`, supporting tools defined in script blocks.  
- **OLLAMA PROVIDER**: New cmdlet `Get-OllamaEmbeddings` to return embeddings using Ollama.  

### Changed 
- **BREAKING CHANGE**: Renamed chat parameter `ContextFormatter` to `PromptBuilder`.  
- Default display (interactive only) of many cmdlet results, like `Get-AiModels`.  
- Updated Hugging Face provider token retrieval mechanism.  
- Improved verbose logging when removing old history due to `MaxContextSize` in chats.  
- Redesigned how PowershAI settings are stored by introducing a "Settings Store" concept, enabling configuration switching (e.g., testing).  
- Updated prompts and emojis for many providers in chats to better visually match the chosen provider and model.  
- Enhanced export/import encryption to use more secure features, such as key derivation and salt.  
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` and `Get-OpenaiToolFromScript` now use `ConvertTo-OpenaiTool` to centralize command-to-OpenAI Tool conversion.  
- **GROQ PROVIDER**: Updated the default model from `llama-3.1-70b-versatile` to `llama-3.2-70b-versatile`.  
- Adjusted return schema of `*_Chat` interface results to be more OpenAI-compliant.  
- Enhanced stream handling in all providers to align with new changes.  
- Added the `IsOpenaiCompatible` flag. Providers wishing to reuse OpenAI cmdlets must set this flag to `true` to function correctly.  
- Improved error handling and alignment in `Invoke-AiChatTools` to better manage tool calling errors and match updates in providers.  
- **GOOGLE PROVIDER**: Exposed `Invoke-GoogleApi` to allow direct API calls by users.  

## [v0.6.6] - 2024-11-25

### Fixed  
- Fix gradio proxy function bug, due to missing internal functions 
- Fix not working with gradio 5 endpoints due v5 breaking changes in url

## [v0.6.5] - 2024-11-14

### Added
- Support for images in `Send-PowershaiChat` for both OpenAI and Google Providers.
- An experimental command, `Invoke-AiScreenshots`, which adds support for taking screenshots and analyzing them!
- Tool calling support in the Google Provider.
- A CHANGE LOG has been initiated
- Tab completion to Set-AiProvider
- Added basic support for structured output to the `Get-AiChat` cmdlet's `ResponseFormat` parameter.  This allows passing a hashtable describing the OpenAPI schema of the result.

### Changed
- **BREAKING CHANGE**: The `content` property of OpenAI messages is now sent as an array to align with specifications for other media types.  This requires updating scripts that rely on the previous single-string format and old providers versions thats dont supports that syntax.
- The `RawParams` of `Get-AiChat` have been fixed. You can now pass raw parameters to the underlying provider to take control of generation. Raw parameters will overwrite those generated by PowerShell.
- DOC Updates: New docs translated with AiDoc and updates. Minor fix in AiDoc.ps1 to not translate some markdown syntax commands.


### Fixed 
- Fixed issue #13. Safety settings were changed, and case handling was improved. This was not being validated, which resulted in an error.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0