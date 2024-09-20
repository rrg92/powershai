# Provider Azure OpenAI

O provider Azure OpenAI implementa todas as funções necessárias para se conectar com a API dos modelos que podem ser configurados em sua assinatura do Azure.  
Os modelos seguem o mesmo padrão da OpenAI, e a maioria dos comandos funcionam exatamente como a openai.  

# Início rápido  

Usar o provider do Azure envolve os seguintes passos:

- Criar os recursos no portal do Azure, ou Azure AI Studio.  
	- Com isso você terá as URLs e API Keys necessárias para autenticação.  
- Usar `Set-AiProvider azure` para mudar o provider atual para o azure.  
- Definir informações da URL da API usando o comando  `Set-AiAzureApiUrl`. o parâmetro `-ChangeToken` permite que você defina o token junto.  

Uma vez que seguiu estes passos, você pode conversar normalmente usando comandos com `ia`.  


## APIs e URL  

Para usar o provider azure, ative ele usando `Set-AiProvider azure`.  
Basicamente, o azure fornece as seguintes APIs para conversar com LLM:

- API Azure OpenAI   
Esta API permite que você converse com os modelos da OpenAI que estão na infra do Azure ou que foram provisionados exclusivamente para você.  

- API de Inferência  
Esta API permite que você converse com outros modelos, como Phi3, Llama3.1, diversos modelos do hugging face, etc.  
Estes modelos podem ser provisionados de forma serveless (você tem uma API funcional, independente de onde executa, com quem compartilha, etc.) ou de forma exclusiva (onde o modelo é disponibilizado exclusivamente em um máquina para você). 

No fim das contas, para você, enquanto usuário do powershai, apenas precisa saber que este provider consegue ajustar corretamente as chamadas da API.  
E elas são todas compatíveis com o mesmo formato da APi da OpenAI (porém nem todas as funcionalidades podem estar disponíveis para certos modelos, como o Tool Calling).  

É importante saber que existem esses dois tipos, pois isso vai te guiar na configuração inicial.  
Você deve ser o comando `Set-AiAzureApiUrl` para definir a URL da sua API.  

Este cmdlet é bem flexível.  
Você pode especificar um URL do Azure OpenAI. Ex.:

```powershell
Set-AiAzureApiUrl -ChangeToken https://iatalking.openai.azure.com/openai/deployments/gpt-4o-mini/chat/completions?api-version=2023-03-15-preview 
```

Com o comando acima, ele vai identificar qual API deve ser usada e os parâmetros corretos.  
Também, ele identifica as URLs referentes à API de inferência:

```powershell
Set-AiAzureApiUrl -ChangeToken https://test-powershai.eastus2.models.ai.azure.com
```

Note o uso do parãmetro `-ChangeToken`.  
Este parâmetro forçar você ter que inserir o token novamente.  Ele é útil quando se está mudando, ou configurando a primeira vez.

Você pode trocar a API key posteriormente, se precisar, usando o comando `Set-AiAzureApiKey`


## Links úteis  

Os seguintes links podem te ajudar como configurar seu Azure OpenAI, e obter suas credenciais.


- Overview do Azure OpenaAI  
https://learn.microsoft.com/en-us/azure/ai-services/openai/overview

- Criação do Resource no portal  
https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/create-resource?pivots=web-portal

- Sobre o Azure AI Studio  
https://learn.microsoft.com/en-us/azure/ai-studio/what-is-ai-studio

- Referência da API  
https://learn.microsoft.com/en-us/azure/ai-services/openai/reference