# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Chats estavam sendo recriados toda vez, evitando manter o histórico corretamente ao usar múltiplos chat! 
- **OPENAI PROVIDER**: Corrigido resultado de `Get-AiEmbeddings`

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corrigidos erros do provider Hugging Face devido a redirecionamentos.
- Corrigida a instalação de módulos para testes usando Docker Compose.
- Corrigidos problemas de desempenho na conversão de ferramentas devido a um possível grande número de comandos em uma sessão. Agora usa módulos dinâmicos. Veja `ConvertTo-OpenaiTool`.
- Corrigidos problemas de incompatibilidade entre a API GROQ e o OpenAI. `message.refusal` não é mais aceito.
- Corrigidos pequenos bugs no PowerShell Core para Linux.
- **OPENAI PROVIDER**: Resolvido código de exceção causado pela ausência de um modelo padrão.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOVO PROVIDER**: Bem-vindo Azure 🎉
- **NOVO PROVIDER**: Bem-vindo Cohere 🎉
- Adicionado o recurso `AI Credentials` — uma nova maneira padrão para os usuários definirem credenciais, permitindo que os provedores solicitem dados de credenciais dos usuários.
- Provedores migrados para usar `AI Credentials`, mantendo a compatibilidade com comandos mais antigos.
- Novo cmdlet `Confirm-PowershaiObjectSchema`, para validar esquemas usando OpenAPI com uma sintaxe mais "PowerShellzada".
- Adicionado suporte para redirecionamentos HTTP na HTTP lib
- Adicionados vários novos testes com Pester, variando de testes unitários básicos a casos mais complexos, como chamadas de ferramentas LLM reais.
- Novo cmdlet `Switch-PowershaiSettings` permite alternar configurações e criar chats, provedores padrão, modelos etc., como se fossem perfis distintos.
- **Retry Logic**: Adicionado `Enter-PowershaiRetry` para reexecutar scripts com base em condições.
- **Retry Logic**: Adicionado retry logic em `Get-AiChat` para facilmente executar o prompt ao LLM novamente caso a resposta anterior não esteja de acordo com o desejado.
- Novo cmdlet `Enter-AiProvider` agora permite executar código sob um provider específico. Cmdlets que dependem de um provider, irão usar sempre o provider em que foi "entrado" mais recente ao invés do current provider.
- Stack de Provider (Push/Pop): Assim como em `Push-Location` e `Pop-Location`, agora você pode inserir e remover provedores para mudanças mais rápidas ao executar código em outro provedor.
- Novo cmdlet `Get-AiEmbeddings`: Adicionados cmdlets padrões para obter embeddings de um texto, permitindo que os provedores exponham a geração de embeddings e que o usuário tenham um mecanismo padrão para gerá-los.
- Novo cmdlet `Reset-AiDefaultModel` para desmarcar o modelo padrão.
- Adicionado os prâmetros `ProviderRawParams` a `Get-AiChat` e `Invoke-AiChat` para sobrescrever os parâmetros específicos na API, por provedor.
- **HUGGINGFACE PROVIDER**: Adicionados novos testes usando um space Hugging Face exclusivo real mantido como um submódulo deste projeto. Isso permite testar vários aspectos ao mesmo tempo: sessões Gradio e integração Hugging Face.
- **HUGGINGFACE PROVIDER**: Novo cmdlet: Find-HuggingFaceModel, para buscar modelos no hub baseado em alguns filtros!
- **OPENAI PROVIDER**: Adicionado um novo cmdlet para gerar chamadas de ferramentas: `ConvertTo-OpenaiTool`, suportando ferramentas definidas em blocos de script.
- **OLLAMA PROVIDER**: Novo cmdlet `Get-OllamaEmbeddings` para retornar embeddings usando Ollama.
- **OLLAMA PROVIDER**: Novo cmdlet `Update-OllamaModel` para baixar models ollama (pull) diretamente do powershai
- **OLLAMA PROVIDER**: Deteccção automática de tools usando os metadados do ollama
- **OLLAMA PROVIDER**: Cache de metadasos de models e novo cmdlet `Reset-OllamaPowershaiCache` para limpar o cache, permitindo consultar muitos detalhes dos modelos ollama, enquanto mantém performance para o uso repetido do comando

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: O parâmetro do Chat `ContextFormatter` foi renomeado para `PromptBuilder`.
- Alterado a exibição padrão (formats.ps1xml) de alguns cmdlets como `Get-AiModels`.
- Melhoria no log detalhado ao remover o histórico antigo devido a `MaxContextSize` em chats.
- Nova maneira como configurações do PowershAI são armazenadas, introduzindo um conceito de "Armazenamento de Configurações", permitindo a troca de configuração (por exemplo,para testes).
- Atualizado emojis exibidos junto com o nome do modelo quando usado o comando Send-PowershaiChat
- Melhorias na criptografia do export/import de configurações (Export=-PowershaiSettings). Agora usa como derivação de chave e salt.
- Melhoria no retorno da interface *_Chat, para que seja mais fiel ao padrão da OpenAI.
- Adicionado a opção `IsOpenaiCompatible` para providers. Providers que desejam reutilizar cmdlets OpenAI devem definir este sinalizador como `true` para funcionar corretamente.
- Melhoria no tratamento de erros de `Invoke-AiChatTools` no processamento de tool calling.
- **GOOGLE PROVIDER**: Adicionado o cmdlet `Invoke-GoogleApi` para permitir chamadas de API diretas pelos usuários.
- **HUGGING FACE PROVIDER**: Pequeno ajustes na forma de inserir o token nas requisições da API.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` e `Get-OpenaiToolFromScript` agora usam `ConvertTo-OpenaiTool` para centralizar a conversão de comando para ferramenta OpenAI.
- **GROQ PROVIDER**: Atualizado o modelo padrão de `llama-3.1-70b-versatile` para `llama-3.2-70b-versatile`.
- **OLLAMA PROVIDER**: Get-AiModels agora inclui modelos que suportam tools, pois o provider usa o endpoint /api/show para obter mais detalhes dos modelos, o que permite checar pelo suporte a tools

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Corrigido bug na função `New-GradioSessionApiProxyFunction`, relacionado a algumas funções internas.
- Adicionado suporte ao Gradio 5, que é necessário devio alterações no endpoints da API

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Suporte para imagens em `Send-PowershaiChat` para os providers OpenAI e Google.
- Um comando experimental, `Invoke-AiScreenshots`, que adiciona suporte para tirar screenshots e analisá-las!
- Suporte para chamada de ferramentas no provider Google.
- CHANGELOG foi iniciado.
- Suporte ao TAB para Set-AiProvider. 
- Adicionado suporte básico para saída estruturada ao parâmetro `ResponseFormat` do cmdlet `Get-AiChat`. Isso permite passar um hashtable descrevendo o esquema OpenAPI do resultado.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: A propriedade `content` das mensagens OpenAI agora é enviada como um array para se alinhar às especificações para outros tipos de mídia. Isso requer a atualização de scripts que dependem do formato de string única anterior e de versões antigas de provedores que não suportam essa sintaxe.
- Parâmetro `RawParams` de `Get-AiChat` foi corrigido. Agora você pode passar parâmetros da API para o provider em questão para ter estrito controle sobre o resultado
- Atualizações de DOC: Novos documentos traduzidos com AiDoc e atualizações. Pequena correção em AiDoc.ps1 para não traduzir alguns comandos de sintaxe markdown.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. As configurações de segurança foram alteradas e o tratamento de maiúsculas e minúsculas foi aprimorado. Isso não estava sendo validado, o que resultava em um erro.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
