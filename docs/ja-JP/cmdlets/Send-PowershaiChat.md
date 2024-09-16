---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Powershai のチャットでメッセージを送信します

## DESCRIPTION <!--!= @#Desc !-->
この cmdlet を使用すると、現在のプロバイダーの LLM に新しいメッセージを送信できます。  
デフォルトでは、アクティブなチャットに送信されます。 -Chat パラメーターを使用してチャットを上書きできます。  アクティブなチャットがない場合は、デフォルトが使用されます。  

チャットのさまざまなパラメーターは、このコマンドがどのように機能するかを決定します。チャットのパラメーターの詳細については、Get-PowershaiChatParameter コマンドを参照してください。  
チャットのパラメーターに加えて、コマンド自体の他のパラメーターを使用して動作を上書きできます。  詳細については、get-help を使用してこの cmdlet の各パラメーターのドキュメントを参照してください。  

簡略化とコマンドラインのクリーンアップのため、ユーザーはプロンプトとデータに集中できます。いくつかのエイリアスが提供されます。  
これらのエイリアスは、特定のパラメーターを有効にすることができます。
次のとおりです。
	ia|ai
		これは日本語の「人工知能」の略です。これは単純なエイリアスであり、パラメーターは変更されません。コマンドラインを大幅に短縮するのに役立ちます。
	
	iat|ait
		Send-PowershaAIChat -Temporary と同じです
		
	io|ao
		Send-PowershaAIChat -Object と同じです

ユーザーは独自のエイリアスを作成できます。たとえば、次のようにします。
	Set-Alias ki ia # ドイツ語のエイリアスを定義します！
	Set-Alias kit iat # iat のエイリアス kit を定義します。kit を使用すると、iat と同じ動作になります（一時チャット）！

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] [-Forget] [-Snub] [-Temporary] 
[-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [<CommonParameters>]
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
このパラメーターは、パイプラインで使用するように意図されています。
このコマンドを使用すると、データが <contexto></contexto> タグに配置され、プロンプトに挿入されます。

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
cmdlet にパイプラインの各オブジェクトに対して実行させる

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
JSON モードを有効にする
このモードでは、返される結果は常に JSON になります。
現在のモデルはサポートしている必要があります！

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
コマンドは画面に何も出力せず、結果をオブジェクトとして返します！
パイプラインに返されます！

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
LLM に送信されるコンテキストデータを、応答の前に表示します！
これは、プロンプトに挿入されているデータのデバッグに役立ちます。

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
以前の会話（コンテキスト履歴）を送信しませんが、プロンプトと応答をコンテキスト履歴に含めます。

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
LLM の応答を無視し、プロンプトをコンテキスト履歴に含めません

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
-Forget と -Snub を一緒に渡すのと同じです。

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
この実行に対してのみ、関数呼び出しを無効にします！

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
このためにコンテキストフォーマッターを変更します
Format-PowershaiContext の詳細については、こちらを参照してください。

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
メッセージをパイプラインに返し、画面に直接出力しません！
このオプションは、ユーザーがメッセージの正しい宛先を処理することを前提としています！
パイプラインに渡されるオブジェクトには、次のプロパティが含まれています。
	text 			- モデルから返されたテキスト（またはテキストの一部）
	formatted		- プロンプトを含むフォーマット済みテキスト（画面に出力された場合と同様）（色は除く）
	event			- イベント。イベントを生成したイベントを示します。Invoke-AiChatTools に記載されているイベントと同じです
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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
