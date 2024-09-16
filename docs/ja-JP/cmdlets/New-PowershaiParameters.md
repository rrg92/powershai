---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
PowershaiChat のパラメーターを表す新しいオブジェクトを作成します。

## DESCRIPTION <!--!= @#Desc !-->
チャットで使用できるすべての可能なパラメーターを含む、デフォルトのオブジェクトを作成します。
ユーザーは、get-help New-PowershaiParameters を使用してパラメーターのドキュメントを取得できます。

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] 
<Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
true の場合、ストリーミングモードを使用します。つまり、メッセージはモデルが生成するにつれて表示されます

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
JSON モードを有効にします。このモードでは、モデルは JSON を含む応答を返すように強制されます。
有効にすると、ストリーム経由で生成されたメッセージは生成時に表示されず、最終的な結果のみが返されます。

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
使用するモデルの名前
null の場合、Set-AiDefaultModel で定義されたモデルを使用します

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
モデルが返すトークンの最大数

```yml
Parameter Set: (All)
Type: Int32
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 2048
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowFullSend
LLM に送信されているプロンプト全体を出力します

```yml
Parameter Set: (All)
Type: Boolean
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowTokenStats
各メッセージの最後に、API から返された消費統計（トークン単位）を表示します

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
一度に行うことができる対話の最大数
メッセージが送信されるたびに、モデルは 1 つの反復を実行します（メッセージを送信して応答を受信します）。
モデルが関数呼び出しを要求した場合、生成された応答はモデルに再送信されます。これは別の反復としてカウントされます。
このパラメーターは、各呼び出しで発生する可能性のある反復の最大数を制御します。
これは、予期しない無限ループを防ぐのに役立ちます。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 50
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
Tool Calling で生成されたシーケンスエラーの最大数。
Tool Calling を使用する場合、このパラメーターは、エラーが発生したシーケンスのない Tool を呼び出すことができる回数に制限します。
エラーとして考慮されるのは、構成されたスクリプトまたはコマンドによって発生した例外です。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 5
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxContextSize
コンテキストの最大サイズ（文字単位）
将来はトークン単位になります
現在のチャットのコンテキスト内のメッセージの数を制御します。この数が超えると、Powershai は自動的に古いメッセージを消去します。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: 8192
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterFunc
パイプライン経由で渡されるオブジェクトのフォーマットに使用される関数

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: ConvertTo-PowershaiContextOutString
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormatterParams
ContextFormatterFunc に渡される引数

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 11
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowArgs
true の場合、Tool Calling がアクティブになって何らかの関数を実行するときに、関数の引数を出力します

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 12
Default Value: True
Accept pipeline input: false
Accept wildcard characters: false
```

### -PrintToolsResults
PowershAI がモデルのツール呼び出しに応答して実行したときに、ツールの結果を出力します

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 13
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -SystemMessageFixed
履歴とチャットのクリーンアップに関係なく、常に送信されることが保証されている System Message です。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 14
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
モデルを呼び出す API に直接渡されるパラメーター。
プロバイダーはこれに対するサポートを実装する必要があります。
これを使用するには、プロバイダーの実装の詳細と API の動作方法を理解している必要があります。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 15
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -ContextFormat
コンテキストデータを注入するときに使用するテンプレートを制御します。
このパラメーターは、コンテキストを含める文字列を返すスクリプトブロックです。
スクリプトブロックのパラメーターは次のとおりです。
	FormattedObject 	- フォーマッターでフォーマットされたアクティブなチャットを表すオブジェクト。
	CmdParams 			- Send-PowershaAIChat に渡されるパラメーター。GetMyParams によって返されるオブジェクトと同じです。
	Chat 				- データが送信されているチャット。
null の場合、デフォルトが生成されます。詳細については、Send-PowershaiChat コマンドレットを参照してください。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 16
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_PowershAI e IA を使用して自動翻訳されました。_
<!--PowershaiAiDocBlockEnd-->
