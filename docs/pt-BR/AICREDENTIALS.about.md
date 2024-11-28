# Ai Credentials 


# Introdução <!--! @#Short --> 

AI Credentials é um mecanismo do powershai que permite configurar credenciais e tokens de acessos as APIs dos providers 

# Detalhes  <!--! @#Long --> 

A maioria dos providers disponibilizados no powershai necessitam de algum tipo de autenticação.  
Seja via API Token, JWT, oauth, etc, pode ser que seja necessário prover algum tipo de credencial.

As primeiras versões do Powershai deixavam livre para cada provider implementar seus próprios comandos de autenticação.  
Mas, visto que esse é um processo comum a quase todo provider, entendemos que era importante padronizar a forma como essas credenciais são criadas e acessadas.
Assim, os usuários tem um jeito padrão de se autenticar, usando os mesmos comandos sempre, o que é mais fácil, até para obter ajudar.

Com isso, nasce o AI Credentials: Um mecanismo padrão do powershai para gerenciar as credenciais dos providers.  

## Definindo credenciais 

Para criar uma nova credencial, use Set-AiCredential:

```powershell 
Set-AiCredential
```

Set-AiCredential é um alias para o comando definitivo definido pelo provider atual.
Cada provider pode fornecer uma implementação específica, que contém seu próprio código e parâmetros.  

O PowershAI gerencia para onde este alias aponta, conforme o provider é trocado.  

O provider pode fornecer parâmetros adicionais, então, `Set-AiCredential` pode conter parâmetros diferentes, dependendo do provider.
Uma outra maneira de definir credenciais é usando variáveis de ambiente. Cada provider pode definir a lista de variáveis possíveis.

Use `get-help Set-AiCredential` ou consulte a doc do provider para mais detalhes e orientações de como fornecer os parâmetros e variáveis de ambiente.

Opcionalmente, você pode definir um nome e descrição para credencial, usando o parâmetro `-Name` `-Description`.  
Se o nome não for especificado, ele usará um nome default.  

Se uma credencial com o nome já existir, ele pergunta se você quer substituir. Você pode usar -force para pular a confirmação.  


## Usando credenciais 

Os providers interagem com o AI Credentials através do comando `Get-AiDefaultCredential`.  
Você pode usar o comando para checar qual credential será usada pelo provider ativo.  

Para evitar usar tokens incorretos, o powershai agora a estratatégia de não usar um credential se não houver uma garantia que é a intenção do usuário usá-la

Baseado nisso, este comando retorna a default credential. O powershai define uma default credential seguindo essas regras:

* Se existe somente 1 credential, ela é a default 
* Caso contrário, o usuário deve explicitamente definir a default usando Set-AiDefaultCredential

Credenciais definidas via variáveis de ambiente são tratadas como default.  
Porém, se foi definida uma credential via variável de ambiente e existem uma credential definida como default explicitamente, então o powershai retorna um erro.

Graças a esse mecanismo, todos os providers podem, de maneira padrão, obter credenciais definidas pelo usuário, sob os mesmos mecanismos de validação, ainda mantendo as diferenças informações que podem ser necessárias. 


Lembre-se que para obter mais informações e ajuda, você pode usar o comando Get-Help `Comando`. Os comandos do AiCredential tendem a conter muitos detalhes de funcionamento não documentados neste tópico.




