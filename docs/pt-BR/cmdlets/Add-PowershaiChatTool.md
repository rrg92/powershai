---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Add-PowershaiChatTool

## SYNOPSIS
Adiciona funcoes, scripts, executáveis como uma tool invocável pelo LLM no chat atual (ou default para todos).

## SYNTAX

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>]
 [-Global] [<CommonParameters>]
```

## DESCRIPTION
Adiciona funcoes na sessao atual para a lista de Tool caling permitidos!
Quando um comando é adicionado, ele é enviado ao modelo atual como uma opcao para Tool Calling.
O help dsponivel da função será usado para descrevê-la, iuncluindo os parâmetros.
Com isso, você pode, em runtime, adicionar novas habilidades na IA que poderão ser invocadas pelo LLM e executadas pelo PowershAI.
 

AO adicionar scritps, todas as funcoes dentro do script são adicionadas de uma só vez.

Para mais informações sobre tools consule o topico about_Powershai_Chats

MUITO IMPORTANTE: 
NUNCA ADICIONEI COMANDOS QUE VOCÊ N O CONHEÇA OU QUE POSSAM COMPROMETER SEU COMPUTADOR.
 
O POWERSHELL VAI EXECUTÁ-LO A PEDIDO DO LLM E COM OS PARÂMETROS QUE O LLM INVOCAR, E COM AS CREDENCIAIS DO USUÁRIO ATUAL.
 
SE VOCÊ ESTIVER LOGADO COM UMA CONTA PRIVILEGIADA, COMO O ADMINISTRADOR, NOTE QUE VOCÊ PODERÁ EXECUTAR QUALQUER AÇ O A PEDIDO DE UM SERVER REMOTO (O LLM).

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -names
Nome do comando, caminho do script ou executável
Pode ser um array de string com estes elementos misturados.
Quando nome que termina com .ps1 é passado, é tratado como um script (isto é, será carregado as funcoes do script)
Caso queria tratar com um comando (executar o script), informe o parâmetor -Command, para forçar ser tratado como um comando!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
Descrição para esse tool a ser passada ao LLM.
 
O comando vai usar o help e enviar, também o conteúdo descrito
Se este parâmetro for adicionado, ele é enviado junto com o help.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceCommand
Força tratar como command.
Útil quando você quer que um script seja executado como comando.
ùtil somente quando você passa um nome ambíguo de arquivo, que coincide como nome de algum comando!

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChatId
Chat em qual criar a tool

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -Global
Cria a tool globalmente, isto é, será disponível em todos os chats

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
