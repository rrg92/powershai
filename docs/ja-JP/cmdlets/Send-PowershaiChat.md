---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Powershaiのチャットにメッセージを送信します

## DESCRIPTION <!--!= @#Desc !-->
このcmdletは、現在のプロバイダーのLLMに新しいメッセージを送信することを可能にします。  
デフォルトでは、アクティブなチャットに送信されます。-Chatパラメーターを使用してチャットを上書きできます。アクティブなチャットがない場合は、デフォルトが使用されます。  

チャットのさまざまなパラメーターがこのコマンドに影響を与えます。チャットのパラメーターに関する詳細は、Get-PowershaiChatParameterコマンドを参照してください。  
チャットのパラメーターに加えて、コマンド自体のパラメーターも動作を上書きすることができます。各パラメーターの詳細については、get-helpを使用してこのcmdletのドキュメントを参照してください。  

簡素化とコマンドラインをクリーンに保ち、ユーザーがプロンプトとデータにより集中できるようにするために、いくつかのエイリアスが提供されています。  
これらのエイリアスは特定のパラメーターを有効にすることができます。
それらは次のとおりです：
	ia|ai
		ポルトガル語で「人工知能」の略。これは単純なエイリアスで、パラメーターを変更しません。コマンドラインを大幅に短縮するのに役立ちます。
	
	iat|ait
		Send-PowershaAIChat -Temporaryと同じ
	
	io|ao
		Send-PowershaAIChat -Objectと同じ
	
	iam|aim 
		Send-PowershaaiChat -Screenshotと同じ 

ユーザーは独自のエイリアスを作成できます。例えば：
	Set-Alias ki ia # ドイツ語のエイリアスを定義します！
	Set-Alias kit iat # kitエイリアスをiatに定義し、kitを使用する場合、iat（一時チャット）と同じ動作をします！

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] 
[-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] 
[-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
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
このパラメーターは、パイプラインによって優先的に使用されるべきです。
このコマンドはデータを<contexto></contexto>タグで囲み、プロンプトに一緒に挿入します。

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
cmdletをパイプラインの各オブジェクトに対して実行するよう強制します
デフォルトでは、すべてのオブジェクトを配列に蓄積し、その配列を文字列に変換して一度にLLMに送信します。

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
JSONモードを有効にします 
このモードでは、返される結果は常にJSONになります。
現在のモデルはこれをサポートする必要があります！

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
このモードではJSONモードが自動的に有効になります！
コマンドは何も画面に書き込まず、結果をオブジェクトとして返します！
それはパイプラインに戻されます！

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
LLMに送信されたコンテキストデータを応答の前に表示します！
プロンプトに挿入されているデータがデバッグするのに役立ちます。

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
以前の会話（コンテキストの履歴）を送信せず、プロンプトと応答をコンテキスト履歴に含めます。

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
LLMの応答を無視し、コンテキスト履歴にプロンプトを含めません

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
履歴を送信せず、応答とプロンプトを含めません。  
これは-Forgetと-Snubを同時に渡すのと同じです。

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
この実行のために関数呼び出しを無効にします！

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
このコンテキストフォーマッタを変更します
Format-PowershaiContextでさらに詳しく見てください

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
変更されたコンテキストフォーマッタのパラメーター。

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
メッセージをパイプラインに返し、画面に直接書き込みません！
このオプションは、ユーザーがメッセージの正しい宛先を指定する責任を負うことを前提としています！
パイプラインに渡されたオブジェクトには次のプロパティがあります：
	text 			- モデルから返されたテキスト（またはテキストの一部） 
	formatted		- プロンプトを含むフォーマットされたテキスト。画面に直接書かれたかのように（色なし）
	event			- イベント。発生したイベントを示します。Invoke-AiChatToolsに文書化されている同じイベントです
	interaction 	- Invoke-AiChatToolsによって生成されたinteractionオブジェクト

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
行の配列を返します 
ストリームモードが有効になっている場合は、1行ずつ返されます！

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
チャットのパラメーターを上書きします！
各オプションをハッシュテーブルで指定します！

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
チャットパラメーターRawParamsの値を直接指定します！
ChatParamOverrideでも指定されている場合、マージが行われ、ここで指定されたパラメーターが優先されます。
RawParamsは、モデルのAPIに直接送信されるパラメーターを定義するチャットパラメーターです！
これらのパラメーターは、powershaiによって計算されたデフォルト値を上書きします！
これにより、ユーザーはパラメーターを完全に制御できますが、各プロバイダーを理解する必要があります！
また、各プロバイダーは、この実装を提供し、APIでこれらのパラメーターを使用する責任があります。

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
PowerShellウィンドウの背後にある画面のスクリーンショットをキャプチャし、プロンプトと一緒に送信します。 
現在のモードは画像（ビジョン言語モデル）をサポートする必要があります。

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


<!--PowershaiAiDocBlockStart-->
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
