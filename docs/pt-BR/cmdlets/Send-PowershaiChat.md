---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Send-PowershaiChat

## SYNOPSIS
Envia uma mensagem em um Chat do Powershai

## SYNTAX

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json]
 [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>]
 [-FormatterParams <Object>] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Este cmdlet permite que você envie uma nova mensagem para o LLM do provider atual.
 
Por padrão, ele envia no chat ativo.
Você pode sobrescrever o chat usando o parâmetro -Chat. 
Se não houver um chat ativo, ele irá usar o default.
 

Diversos parâmetros do Chat afetam como este comando.
Veja o comando Get-PowershaiChatParameter para mais info sobre os parâmetros do chat.
 
Além dos parâmetros do chat, os próprios parâmetros do comando podem sobrescrever comportamento. 
Para mais detalhes, consule a documentação de cada parâmetro deste cmdlet usando get-help.
 

Para simplicidade, e manter a liNha de comando limmpa, permitindo o usuário focar mais no prompt e nos dados, alguns alias são disponibilizados.
 
Estes alias podem ativar certos parâmetros.
São eles:
	ia|ai
		Abreviação de "Inteligência Artifical" em português.
Este é um alias simples e não muda nenum parâmetro.
Ele ajuda a reduzir bastante a linha de comando.
	
	iat|ait
		O mesmo que Send-PowershaAIChat -Temporary
		
	io|ao
		O mesmo que Send-PowershaAIChat -Object

O usuário pode criar seus próprios alias.
Por exemplo:
	Set-Alias ki ia # DEfine o alias para o alemao!
	Set-Alias kit iat # DEfine o alias kit para iat, fazendo o comportamento ser igual ao iat (chat temporaria) quando usado o kit!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -prompt
o prompt a ser enviado ao modelo

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

### -SystemMessages
System message para ser incluída

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -context
O contexto 
Esse parâmetro é pra usado preferencialmente pelo pipeline.
Ele irá fazer com que o comando coloque os dados em tags \<contexto\>\</contexto\> e injeterá junto no prompt.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ForEach
Força o cmdlet executar para cada objeto do pipeline
Por padrão, ele acumula todos os objetos em um array, converte o array para string só e envia de um só vez pro LLM.

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

### -Json
Habilia o modo json 
nesse modo os resultados retornados sempre será um JSON.
O modelo atual deve suportar!

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

### -Object
Modo Object!
neste modo o modo JSON será ativado automaticamente!
O comando não vai escrever nada na tela, e vai retornar os resultados como um objeto!
Que serão jogados de volta no pipeline!

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

### -PrintContext
Mostra os dados de contexto enviados ao LLM antes da resposta!
É útil para debugar o que está senod injetado de dados no prompt.

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

### -Forget
Não enviar as conversas anteriores (o histórico de contexto), mas incluir o prompt e a resposta no contexto histórico.

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

### -Snub
Ignorar a resposta do LLM, e não incluir o prompt no contexto histórico

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

### -Temporary
Não envia o histórico e nem inclui a resposta e prompt.
 
É o mesmo que passar -Forget e -Snub juntos.

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

### -DisableTools
Desliga o function call para esta execução somente!

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoCalls, NoTools, nt

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatterFunc
Alterar o contexto formatter pra este
Veha mais sobre em Format-PowershaiContext

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatterParams
Parametros do contexto formatter alterado.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Retorna as mensagens de volta no pipeline, sem escrever direto na tela!
Esta opção assume que o usuário irá ser o responsável por dar o correto destino da mensagem!
O objeto passado ao pipeline terá as seguintes propriedades:
	text 			- O texto (ou trecho) do texto retornado pelo modelo 
	formatted		- O texto formatado, incluindo o prompt, como se fosse escrito direto na tela (sem as cores)
	event			- O evento.
Indica o evento que originou.
São os mesmos eventos documentaados em Invoke-AiChatTools
	interaction 	- O objeto interaction gerado por Invoke-AiChatTools

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
