---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Envia uma mensagem em um Chat do Powershai

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet permite que você envie uma nova mensagem para o LLM do provider atual.  
Por padrão, ele envia no chat ativo. Você pode sobrescrever o chat usando o parâmetro -Chat.  Se não houver um chat ativo, ele irá usar o default.  

Diversos parâmetros do Chat afetam como este comando. Veja o comando Get-PowershaiChatParameter para mais info sobre os parâmetros do chat.  
Além dos parâmetros do chat, os próprios parâmetros do comando podem sobrescrever comportamento.  Para mais detalhes, consule a documentação de cada parâmetro deste cmdlet usando get-help.  

Para simplicidade, e manter a liNha de comando limmpa, permitindo o usuário focar mais no prompt e nos dados, alguns alias são disponibilizados.  
Estes alias podem ativar certos parâmetros.
São eles:
	ia|ai
		Abreviação de "Inteligência Artifical" em português. Este é um alias simples e não muda nenum parâmetro. Ele ajuda a reduzir bastante a linha de comando.
	
	iat|ait
		O mesmo que Send-PowershaAIChat -Temporary
		
	io|ao
		O mesmo que Send-PowershaAIChat -Object
		
	iam|aim 
		O mesmo que Send-PowershaaiChat -Screenshot 

O usuário pode criar seus próprios alias. Por exemplo:
	Set-Alias ki ia # DEfine o alias para o alemao!
	Set-Alias kit iat # DEfine o alias kit para iat, fazendo o comportamento ser igual ao iat (chat temporaria) quando usado o kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] [-DisableTools] 
[-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] [-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
o prompt a ser enviado ao modelo

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

### -SystemMessages
System message para ser incluída

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
O contexto 
Esse parâmetro é pra usado preferencialmente pelo pipeline.
Ele irá fazer com que o comando coloque os dados em tags <contexto></contexto> e injeterá junto no prompt.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
Força o cmdlet executar para cada objeto do pipeline
Por padrão, ele acumula todos os objetos em um array, converte o array para string só e envia de um só vez pro LLM.

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

### -Json
Habilia o modo json 
nesse modo os resultados retornados sempre será um JSON.
O modelo atual deve suportar!

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

### -Object
Modo Object!
neste modo o modo JSON será ativado automaticamente!
O comando não vai escrever nada na tela, e vai retornar os resultados como um objeto!
Que serão jogados de volta no pipeline!

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

### -PrintContext
Mostra os dados de contexto enviados ao LLM antes da resposta!
É útil para debugar o que está senod injetado de dados no prompt.

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

### -Forget
Não enviar as conversas anteriores (o histórico de contexto), mas incluir o prompt e a resposta no contexto histórico.

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

### -Snub
Ignorar a resposta do LLM, e não incluir o prompt no contexto histórico

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

### -Temporary
Não envia o histórico e nem inclui a resposta e prompt.  
É o mesmo que passar -Forget e -Snub juntos.

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

### -DisableTools
Desliga o function call para esta execução somente!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
Alterar o contexto formatter pra este
Veha mais sobre em Format-PowershaiContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterParams
Parametros do contexto formatter alterado.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PassThru
Retorna as mensagens de volta no pipeline, sem escrever direto na tela!
Esta opção assume que o usuário irá ser o responsável por dar o correto destino da mensagem!
O objeto passado ao pipeline terá as seguintes propriedades:
	text 			- O texto (ou trecho) do texto retornado pelo modelo 
	formatted		- O texto formatado, incluindo o prompt, como se fosse escrito direto na tela (sem as cores)
	event			- O evento. Indica o evento que originou. São os mesmos eventos documentaados em Invoke-AiChatTools
	interaction 	- O objeto interaction gerado por Invoke-AiChatTools

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

### -Lines
Retorna um array de linhas 
Se o modo stream estiver ativado, retornará uma linha por vez!

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

### -ChatParamsOverride
Sobrescrever parâmetros do chat!
Especifique cada opção em umas hastables!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Especifica diretamente o valor do chat parameter RawParams!
Se especificado também em ChatParamOverride, um merge é feito, dando prioridade aos parametros especificados aqui.
O RawParams é um chat parameter que define parametros que serão enviados diretamente a api do modelo!
Estes parametros irão sobrescrever os valores padrões calculados pelo powershai!
Com isso, o usuario tem total controle sobre os parâmetros, mas precisa conmhecer cada provider!
Também, cada provider é responsável por prover essa implementaão e usar esses parâmetros na sua api.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
Captura um print screen da tela que está atrás da janela do powershell e envia junto com o prompt. 
Note que o mode atual deve suportar imagens (Vision Language Models).

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```