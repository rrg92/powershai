---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Cria um novo Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
O PowershaAI traz um conceito de "chats", semelhantes aos chats que você vê na OpenAI, ou as "threads" da API de Assistants.  
Cada chat criado tem seu próprio conjunto de parâmetros, contexto e histórico.  
Quando você usa o cmdlet Send-PowershaiChat (alias ia), ele está enviando mensagens ao modelo, e o histórico dessa conversa com o modelo fica no chat criado aqui pelo PowershAI.  
Ou seja, todo o histórico da sua conversa com o modelo é mantido aqui na sua sessão do PowershAI, e não lá no modelo ou na API.  
Com isso o PowershAI mantém todo o controle do que enviar ao LLM e não depende de mecanismos das diferentes APIs de diferentes providers para gerenciar o histórico. 


Cada Chat possui um conjunto de parâmetros que ao serem alterados afetam somente quele chat.  
Certos parâmetros do PowershAI são globais, como por exemplo, o provider usado. Ao mudar o provider, o Chat passa a usar o novo provider, mas mantém o mesmo histórico.  
Isso permite conversar com diferentes modelos, enquanto mantém o mesmo histórico.  

Além destes parâmetros, cada Chat possui um histórico.  
O histórico contém todas as conversas e interações feitas com os modelos, guardando as repostas retornadas pelas APIs.

Um Chat também tem um contexto, que é nada mais do que todas as mensagesn enviadas.  
Cada vez que uma nova mensagem é enviada em um chat, o Powershai adiciona esta mensage ao contexto.  
Ao receber a resposta do modelo, esta resposta é adicionada ao contexto.  
Na próxima mensagem enviada, todo ess ehistórico de mensagem do contexto é enviado, fazendo com que o modelo, independente do provider, tenha a memória da conversa.  

o fato do contexto ser mantido aqui na sua sessão do Powershell permite funcionaldiades como gravar o seu histórico em disco, implementar um provider exclusivo para guardar o seu hitórico na nuvem, manter apenas no seu Pc, etc. Futuras funcionalidades podem se beneficiar disso.

Todos os comandos *-PowershaiChat giram em todos do chat ativo ou do chat que voce explicitamente especifica no parametro (geralmente com o nome -ChatId).  
O ChatAtivo é o chat em que as mensagens serão enviadas, caso nao seja especificado o ChatId  (ou se o comando não permite especificar um chat explicito).  

Existe um chat especial chamado "default" que é o chat criado sempre que voce usa o Send-PowershaiChat sem especifciar um chat e se não houver chat ativo definido.  

Se você fechar sua sessão do Powershell, todo esse histoico de Chats é perdido.  
Você pode salvar em disco, usando o comando Export-PowershaiSettings. O conteudo é salvo criptografado por uma senha que voce especificar.

Ao emviar mensagens, o PowershaAI mantém um mecanismo interno que limpa o contexto do chat, para evitar enviar mais do que o necessário.
O tamanho do contexto local (aqui na sua sessao do Powershai, e nao do LLM), é controlado por um parametro (use Get-PowershaiChatParameter para ver a lista de parametros)

Note que, devido a essa maneira do Powershai funcionar, dependendo da quantidade de informacoes enviadas e retornadas, mais as configuracoes dos parametros, voce pode fazer seu Powershell consumir bastante memória. Voce pode limpar o contexto e historico manualmente do seu chat usando Reset-PowershaiCurrentChat

Veja mais detalhes sobre no tópico about_Powershai_Chats,

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id do chat. Se não especifico, irá gerar um padrão 
ALguns padrões de id são reservados para uso interno. Se você us´-alos poderá causar instabilidades no PowershAI.
Os seguintes valores são reservados:
 default 
 _pwshai_*

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -IfNotExists
Cria somente se não existe um chat com o mesmo nome

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -Recreate
Forçar recriar o chat se ele já estiver criado!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -Tools
Cria o chat e inclui essas tools!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```