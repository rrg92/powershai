---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Powershai チャットにメッセージを送信します

## DESCRIPTION <!--!= @#Desc !-->
このコマンドレットを使用すると、現在のプロバイダーの LLM に新しいメッセージを送信できます。  
デフォルトでは、アクティブなチャットにメッセージを送信します。 -Chat パラメーターを使用してチャットを上書きできます。  アクティブなチャットがない場合は、デフォルトのチャットが使用されます。  

チャットのさまざまなパラメーターが、このコマンドの動作に影響します。チャットのパラメーターの詳細については、Get-PowershaiChatParameter コマンドを参照してください。  
チャットのパラメーターに加えて、コマンド自体のパラメーターによって動作を上書きできます。  詳細については、get-help を使用して、このコマンドレットの各パラメーターのドキュメントを参照してください。  

シンプルにするため、およびコマンドラインをクリーンに保ち、ユーザーがプロンプトとデータに集中できるように、いくつかのエイリアスが提供されています。  
これらのエイリアスでは、特定のパラメーターを有効にすることができます。
具体的には次のとおりです。
	ia|ai
		これは、ポルトガル語の「人工知能」の略語です。これは、単なるエイリアスであり、パラメーターは変更されません。コマンドラインを大幅に短縮できます。
	
	iat|ait
		Send-PowershaAIChat -Temporary と同じです。
		
	io|ao
		Send-PowershaAIChat -Object と同じです。

ユーザーは独自のエイリアスを作成できます。例を挙げます。
	Set-Alias ki ia # DEfine o alias para o alemao!
	Set-Alias kit iat # DEfine o alias kit para iat, fazendo o comportamento ser igual ao iat (chat temporaria) quando usado o kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] 
[-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
モデルに送信するプロンプト

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
含めるシステムメッセージ

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
コンテキスト
このパラメーターは、パイプラインから優先的に使用します。
このコマンドによって、データが <contexto></contexto> タグに配置され、プロンプトに挿入されます。

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
パイプラインの各オブジェクトに対してコマンドレットを実行します。
デフォルトでは、すべてのオブジェクトを配列に蓄積し、配列を文字列に変換してから、LLM に一度に送信します。

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
JSON モードを有効にします。
このモードでは、返される結果は常に JSON になります。
現在のモデルでサポートされている必要があります！

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
オブジェクトモード！
このモードでは、JSON モードが自動的に有効になります！
コマンドは何も出力せず、結果をオブジェクトとして返します。
これは、パイプラインに戻されます。

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
LLM に送信されたコンテキストのデータを、応答の前に表示します。
プロンプトに挿入されているデータのデバッグに役立ちます。

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
以前の会話（コンテキストの履歴）を送信しませんが、プロンプトと応答を履歴コンテキストに含めます。

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
LLM の応答を無視し、プロンプトを履歴コンテキストに含めません

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
履歴を送信せず、応答とプロンプトも含まれません。  
-Forget と -Snub を一緒に渡す場合と同じです。

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
この実行のみ、関数呼び出しを無効にします！

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
この実行のコンテキストフォーマッターを変更します。
詳細については、Format-PowershaiContext を参照してください。

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
変更されたコンテキストフォーマッターのパラメーター。

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
メッセージをパイプラインに戻し、画面に直接出力しません！
このオプションは、ユーザーがメッセージの正しい宛先を指定することを前提としています！
パイプラインに渡されるオブジェクトには、次のプロパティがあります。
	text 			- モデルによって返されたテキスト（またはテキストの一部）
	formatted		- プロンプトを含めた書式設定されたテキスト（画面に直接出力される場合と同じ）（色なし）
	event			- イベント。イベントの発生元を示します。Invoke-AiChatTools でドキュメント化されているものと同じイベントです
	interaction 	- Invoke-AiChatTools によって生成された interaction オブジェクト

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
行の配列を返します。
ストリームモードが有効な場合は、一度に 1 行を返します！

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




<!--PowershaiAiDocBlockStart-->
_PowershAI e IA を使用して自動翻訳されました。_
<!--PowershaiAiDocBlockEnd-->
