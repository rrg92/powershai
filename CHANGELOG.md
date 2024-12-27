# Changelog

## [Unreleased]

### Fixed 
- 1334f68 Fix validations for linux. This commit fixes the validations for Linux by adding support for int64 type in addition to int type. It also improves the error handling and logging for retry mechanisms.
- b6ec7d6 Update Hugging Face provider to use new credentials and fix #32.  The changes include updating the Send-GradioApi function to use a new method for resolving Hugging Face tokens, handling different HTTP status codes (404, 308, 302) when getting Gradio info, updating the alias for connecting to Hugging Face spaces, and improving the tests for the provider.
- 55ce99e Minor fix to better verbose log when removing old history due maxcontextsize. The verbose log now includes the removed messages and their count, improving the clarity of the log message.
- 6a477c6 Minor bug fixes to powershell on linux and prepare to run in github workflow. The changes include installing Pester and platyPS modules, adding MaxRedirects parameter to handle HTTP redirects, improving HTTP request handling, and updating tests.  The changes also include updating the github workflow to support running tests.
- 1d601e8 Fixed the installation of modules in the Dockerfile by adding the -Force flag to the Install-Module command. Also, added the -NonInteractive flag to prevent interactive prompts during module installation. Improved docker-compose file by adding a backslash at the end of the command line to handle potential issues with trailing whitespace.
- b40b4ee Fixes in tool calling and added support to scriptblock. The changes include improvements to how tools are called, and adds support for scriptblocks in tool definitions. This allows for more flexibility and extensibility when defining custom tools for the AI chat application.
- b67941d Fixed tests to handle environment variables properly. Added functions to get and set environment variables related to AI credentials. Modified tests to clean up and restore environment variables before and after tests.
- 87a3b41 Minor fix in settings init.  The function UpgradePowershaiSettingsStore now handles cases where the CurrentStore variable is null by initializing it to an empty hashtable.
- c7a83d6 Fixed incompatibility issues between groq api and openai. The message.refusal is no longer accepted.
- 8f117d2 Avoid auto module load when getting metadata. Fix finish_reason set when streaming
- 5431d6f Minor fix in default model of openai Provider. The function Get-OpenaiChat now checks if a default model is set and throws an error if not, instead of throwing an error if the default model is not found. Additionally, the function azure_Chat now includes the parameter model="-" and uses the ReqChanger function to modify the request parameters.
- 4fc45b3 Minor fix checking if schema is array
- cd7517a Fix google credentials set. The previous implementation incorrectly retrieved the API key. This commit corrects it by directly accessing the credential property.
- 082fa56 Fix: When switching settings, set old provider only if providers are already loaded

### Added 
- 1b0f34d GetParamCallAlias and Enter-PowershaiRetry functions. GetParamCallAlias retrieves the alias used for a parameter in a function call. Enter-PowershaiRetry allows retrying a command until a specified result is achieved, managing errors and progress.
- 77a0c47 Push-AiProvider and Pop-AiProvider cmdlets to manage a stack of AI providers.  This allows for nested provider contexts, enabling more complex AI workflow management.
- 7501997 Cohere support
- 700b469 retry logic with options to customize check and retry behavior.  Added parameters: Check (with aliases CheckLike, CheckRegex, CheckJson), Retries, and AnswerOnly.  The Check parameter allows for validating the response using various methods (string equality, regex matching, JSON schema validation).  Retries specifies the maximum number of retry attempts. AnswerOnly returns only the text content of the response.
- 8942203 support for embeddings in the Ollama provider. Added Get-AiEmbeddings function to retrieve embeddings. Added Get-OllamaEmbeddings function to get embeddings using Ollama models. Added support for specifying default embeddings model and a regex for supported embedding models.
- 45d5787 emojis to model prompts in the ollama provider.
- 27ca4f1 command Reset-AiDefaultModel and minor adjusts in Get-AiChat
- 5fe678d AI Credential, Azure provider support, multiple settings feature, and several enhancements and bug fixes.  Added more pester tests and reorganized the directory structure.
- 0ae9634 support for scriptblocks in Get-OpenaiToolsFromCommand, changed to import in a separate module context, and added many tests related to tool calls and runs.
- 57d37e6 hugging face spaces submodule and updated the powershai provider to support spaces. The changes include adding a new function to resolve the Hugging Face token, updating the Invoke-GradioHttp and InvokeHfApi functions to use the new token resolution function, and adding tests for the new functionality.

### Changed 
- Enhanced export/import encryption by adding derived keys and salt to improve security.  This closes issue #29
- Changed environment variable names for testing purposes.  Updated docker-compose.yml to use TEST_OPENAI_API_KEY and TEST_GOOGLE_API_KEY instead of OPENAI_API_KEY and GOOGLE_API_KEY respectively
- Padronizado as respostas da interface "Chat" para ser OpenAI.
- Melhorado emojis de alguns providers 
- Get-AiModels exibe uma tabela por padrão, mostrando campos padrões 
- Get-AiChat: Tools somente são passadas se o provider indica que o modelo suporta tools. Isso evita erros.


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