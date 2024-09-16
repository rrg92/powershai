# Provider OpenAI  

# RESUMO <!--! @#Short --> 

Esta é a documentação oficial do provider OpenAI da PowershAI.

# DETALHES  <!--! @#Long --> 

O provider OpenAI fornecer todos os comandos para se comunicar com os serviços da OpenAI.  
Os cmdltets desse provider possui o formato Verbo-OpenaiNomes.  
O provider implementa as chamadas HTTP conforme documentando em https://platform.openai.com/docs/api-reference

**Obs**: Nem todas as features da API estão implementadas ainda


## Configurações iniciais 

Usar o provider da OpenAI envolve basicamente ativá-lo e configurar o token.  
Você precisa gerar uma API Token no site da OpenAI. Ou seja, você vai precisar criar uma conta e inserir créditos.  
Verifique mais em https://platform.openai.com/api-keys 

Uma vez que você possui essas informações, pode executar o seguinte códig para ativar o provider:

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

Se você estiver executando em backgroind (sem interatividade), o token pode ser configurado usando a variável de ambiente `OPENAI_API_KEY`.  

Com o token configurado, você está apto a invocar a usar o Chat do Powershai:

```
ia "Olá, estou falando com você a partir do Powershai"
```

E, obviamente, você pode invocar os comandos diretamente:

```
Get-OpenaiChat -prompt "s: Você é um bot que responde perguntas sobre powershell","Como exibir a hora atual?"
```




* Use Set-AiProvider openai (é o padrão)
Opcionalmente pode passar uma URL alternativa

* Use Set-OpenaiToken para configurar o token!


## Internals

A OpenAI é um importante provider, pois além de fornecer diversos serviços avançados e robutos de IA, ele também serve como um guia de padronização do PowershAI.  
A maioria dos padrões definidos no PowershAI seguem as especificações da OpenAI, que é o provider mais amplamente utilizado e é prática comum usar a OpenAI como base.  


E, devido ao fato de que outros providers costuam seguir a OpenAI, este provider também é preparado para o reproveitamento de código.  
Criar um novo provider que usa as mesmas especificações da OpenAI é muito simples, bastando apenas definir algumas variáveis de configurações!

