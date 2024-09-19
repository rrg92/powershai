# Provider Azure OpenAI

O provider Azure OpenAI implementa todas as funções necessárias para se conectar com a API dos modelos que podem ser configurados em sua assinatura do Azure.  
Os modelos seguem o mesmo padrão da OpenAI, e a maioria dos comandos funcionam exatamente como a openai.  

# Início rápido  

Para usar o provider azure, ative ele usando `Set-AiProvider azure`.  
No azure, além da Api Key, é necessário os seguintes dados para construir a URL da API:

- ResourceName  
Este é o nome do recurso que representa o seu serviço do tipo Azure OpenAI.  

- DeploymentName  
Este é o nome que você configurou ao implementar o modelo no Azure AI Studio

- ApiVersion  
A versão da API a ser usada. O provider sempre usará a última versão estável GA como padrão.   

Com estes dados, o powershai monta a URL da API.  

O comando `Set-OpenaiAzureUrl`  pode ser usado para configurar estas informações:

```powershell 
# Definindo resource name e deploy. ApiVersion é opcional.
Set-OpenaiAzureUrl -ResourceName iatalking-azai123456789 -DeploymentName testdeploy
```

Por praticidade, você pode usar uma URL que copiou diretamente do portal ou do Azure AI Studio:
Por exemplo:

```powershell 
Set-OpenaiAzureUrl https://iatalking-azai123456789.openai.azure.com/openai/deployments/testdeploy/chat/completions?api-version=2023-03-15-preview
```


Isso irá configurar o ResourceName como `iatalking-azai123456789`, DeploymentName como `testdeploy`, e ApiVersion como `2023-03-15-preview`.  
O comando também irá solicitar a Api key, que é disponbilizada no portal ou no ai studio.  

Você pode trocar a API key posteriormente, se precisar, usando o comando `Set-OpenaiAzureApiKey`


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