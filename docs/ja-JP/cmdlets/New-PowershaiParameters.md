---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
PowershaiChat のパラメーターを表す新しいオブジェクトを作成します。

## DESCRIPTION <!--!= @#Desc !-->
チャットで使用できるすべてのパラメーターを含む、標準のオブジェクトを作成します!
ユーザーは get-help New-PowershaiParameters を使用してパラメーターのドキュメントを取得できます。

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] <Boolean>] [[-ShowTokenStats] <Object>] 
[[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] [[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] 
[[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] [[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
True の場合、ストリームモードを使用します。つまり、メッセージはモデルが生成するにつれて表示されます。

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
有効にすると、ストリームで生成されたメッセージは生成時に表示されず、最終的な結果のみが返されます。

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
null の場合、Set-AiDefaultModel で定義されたモデルを使用します。

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
モデルが返すことができるトークンの最大数

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
LLM に送信されている完全なプロンプトを出力します。

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
各メッセージの最後に、API から返された消費統計情報をトークンで表示します。

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
一度に行うことができる相互作用の最大数
メッセージが送信されるたびに、モデルは 1 回の反復を実行します (メッセージを送信して応答を受け取ります)。
モデルが関数呼び出しを要求する場合、生成された応答はモデルに再送信されます。これは別の相互作用としてカウントされます。
このパラメーターは、各呼び出しで存在できる相互作用の最大数を制御します。
これにより、予期しない無限ループを回避するのに役立ちます。

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
Tool Calling によって生成される連続エラーの最大数
Tool Calling を使用する場合、このパラメーターは、エラーが発生した連続ツールを何回呼び出せるかを制限します。
考慮されるエラーは、設定されたスクリプトまたはコマンドによって発生した例外です。

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
コンテキストの最大サイズ (文字数)
将来はトークンで表されます。
現在のチャットのコンテキスト内のメッセージ数を制御します。この数値を超えると、Powershai は古いメッセージを自動的にクリアします。

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
パイプラインを通じて渡されるオブジェクトの書式設定に使用される関数

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
True の場合、Tool Calling がアクティブになって関数が実行されるときに、関数の引数を出力します。

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
PowershAI が Tool Calling に応じてツールを実行したときに、ツールの結果を出力します。

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
履歴やチャットのクリーンアップに関係なく、常に送信されることが保証される System Message!

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
プロバイダーは、これに対するサポートを実装する必要があります。
これを使用するには、プロバイダーの実装の詳細と API の動作を理解する必要があります。

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
コンテキストデータを挿入するときに使用されるテンプレートを制御します。
このパラメーターは、コンテキストを含む文字列を返すスクリプトブロックです。
スクリプトブロックのパラメーターは次のとおりです。
	FormattedObject 	- フォーマッターでフォーマットされた、アクティブなチャットを表すオブジェクト。
	CmdParams 			- Send-PowershaAIChat に渡されたパラメーター。GetMyParams によって返されたのと同じオブジェクトです。
	Chat 				- データが送信されているチャット。
null の場合、デフォルトが生成されます。詳細については、cmdlet Send-PowershaAIChat を参照してください。

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
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
