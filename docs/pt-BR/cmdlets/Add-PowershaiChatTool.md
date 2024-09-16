---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Adiciona funcoes, scripts, executáveis como uma tool invocável pelo LLM no chat atual (ou default para todos).

## DESCRIPTION <!--!= @#Desc !-->
Adiciona funcoes na sessao atual para a lista de Tool caling permitidos!
Quando um comando é adicionado, ele é enviado ao modelo atual como uma opcao para Tool Calling.
O help dsponivel da função será usado para descrevê-la, iuncluindo os parâmetros.
Com isso, você pode, em runtime, adicionar novas habilidades na IA que poderão ser invocadas pelo LLM e executadas pelo PowershAI.  

AO adicionar scritps, todas as funcoes dentro do script são adicionadas de uma só vez.

Para mais informações sobre tools consule o topico about_Powershai_Chats

MUITO IMPORTANTE: 
NUNCA ADICIONEI COMANDOS QUE VOCÊ NÃO CONHEÇA OU QUE POSSAM COMPROMETER SEU COMPUTADOR.  
O POWERSHELL VAI EXECUTÁ-LO A PEDIDO DO LLM E COM OS PARÂMETROS QUE O LLM INVOCAR, E COM AS CREDENCIAIS DO USUÁRIO ATUAL.  
SE VOCÊ ESTIVER LOGADO COM UMA CONTA PRIVILEGIADA, COMO O ADMINISTRADOR, NOTE QUE VOCÊ PODERÁ EXECUTAR QUALQUER AÇÃO A PEDIDO DE UM SERVER REMOTO (O LLM).

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
Nome do comando, caminho do script ou executável
Pode ser um array de string com estes elementos misturados.
Quando nome que termina com .ps1 é passado, é tratado como um script (isto é, será carregado as funcoes do script)
Caso queria tratar com um comando (executar o script), informe o parâmetor -Command, para forçar ser tratado como um comando!

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

### -description
Descrição para esse tool a ser passada ao LLM.  
O comando vai usar o help e enviar, também o conteúdo descrito
Se este parâmetro for adicionado, ele é enviado junto com o help.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ForceCommand
Força tratar como command. Útil quando você quer que um script seja executado como comando.
ùtil somente quando você passa um nome ambíguo de arquivo, que coincide como nome de algum comando!

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

### -ChatId
Chat em qual criar a tool

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
Cria a tool globalmente, isto é, será disponível em todos os chats

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