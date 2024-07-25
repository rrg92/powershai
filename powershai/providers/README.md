# Providers PowerShai

Um provider é um arquivo .ps1 que implementa as funcoes requeridas pelo PowershAI.  
Imagine que é como se fosse uma classe que será instanciada pelo PowershaAI quando o usuário quiser usar alguma função deste provider.  


Cada provider deve ser criado nesse diretório como um arquivo de script powershell .ps1;
O basename do arquivo é o mesmo nome do provider.
As seguintes funcoes devem ser definidas:

- NomeProvider_GetModels  
Deve listar os modelos disponíveis.  Deve retornar um array de objetos contendo a propriedade "name", que indica o nome do modelo, que deve ser passado nas apis.  

- NomeProvider_SetToken  
Deve setar e validar o token.  

- NomeProvider_InvokeHttp  
Deve implementar a funcao http para comunicação com o provider.

- NomeProvider_ChatCompletion
Deve implementar a funcao para chat completion (semelhante a api chat completino da openai).


Adicionalmente, o provider pode exportar cmdlets que podem ser disponibilizados ao usuario diretamente.  
Para isso, exporte no formato padrãod o Powershell Verbo-NomeProviderSubstantivo. Por exemplo, Get-OpenaiModels.

O script pode retornar um hashtable contendo informacoes e keys salvas na variavevel de settings, permitindo reusar e salvar configuracoes!