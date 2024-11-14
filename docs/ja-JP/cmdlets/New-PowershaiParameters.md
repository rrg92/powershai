---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiParameters

## SYNOPSIS <!--!= @#Synop !-->
PowershaiChatのパラメータを表す新しいオブジェクトを作成します

## DESCRIPTION <!--!= @#Desc !-->
チャットで使用できるすべての可能なパラメータを含む標準オブジェクトを作成します！
ユーザーはget-help New-PowershaiParametersを使用してパラメータのドキュメントを取得できます。

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiParameters [[-stream] <Object>] [[-Json] <Boolean>] [[-model] <String>] [[-MaxTokens] <Int32>] [[-ShowFullSend] 
<Boolean>] [[-ShowTokenStats] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] [[-MaxContextSize] <Object>] 
[[-ContextFormatterFunc] <Object>] [[-ContextFormatterParams] <Object>] [[-ShowArgs] <Object>] [[-PrintToolsResults] <Object>] 
[[-SystemMessageFixed] <Object>] [[-RawParams] <Object>] [[-ContextFormat] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -stream
trueの場合、ストリームモードを使用します。つまり、メッセージはモデルが生成するにつれて表示されます。

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
JSONモードを有効にします。このモードでは、モデルはJSON形式で応答を返すよう強制されます。  
有効にすると、ストリーム経由で生成されたメッセージは生成されるにつれて表示されず、最終結果のみが返されます。

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
nullの場合、Set-AiDefaultModelで定義されたモデルを使用します。

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
モデルによって返されるトークンの最大数

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
LLMに送信されるプロンプト全体を表示します。

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
各メッセージの最後に、APIによって返されたトークン消費の統計を表示します。

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
一度に行う最大インタラクション数  
メッセージが送信されるたびに、モデルは1回のイテレーションを実行します（メッセージを送信し、応答を受け取ります）。  
モデルが関数呼び出しを要求すると、生成された応答はモデルに再送信されます。これは別のインタラクションとしてカウントされます。  
このパラメータは、各呼び出しで存在できる最大インタラクション数を制御します。
これにより、予期しない無限ループを防ぐのに役立ちます。

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
ツール呼び出しによって生成される最大連続エラー数。  
ツール呼び出しを使用する場合、このパラメータはエラーが発生した連続していないツールを呼び出す数を制限します。  
考慮されるエラーは、スクリプトまたは構成されたコマンドによって発生した例外です。

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
コンテキストの最大サイズ（文字数）  
将来的にはトークン単位になります。  
現在のチャットのコンテキスト内のメッセージの数を制御します。この数を超えると、Powershaiは自動的に古いメッセージを削除します。

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
パイプラインを介して渡されるオブジェクトのフォーマットに使用される関数

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
ContextFormatterFuncに渡される引数

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
trueの場合、ツール呼び出しが関数を実行するために有効になっているときに、関数の引数を表示します。

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
モデルのツール呼び出しに応じて、PowershAIによって実行されるツールの結果を表示します。

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
履歴やチャットのクリーンアップに関係なく、常に送信されることが保証されているシステムメッセージです！

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
モデルを呼び出すAPIに直接渡されるパラメータ。  
プロバイダーはこれをサポートする必要があります。  
これを使用するには、プロバイダーの実装の詳細とそのAPIの動作を理解している必要があります！

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
データコンテキストを注入する際に使用されるテンプレートを制御します！  
このパラメータは、プロンプトに注入されるコンテキストを含む文字列を返す必要があるスクリプトブロックです！  
スクリプトブロックのパラメータは次のとおりです：
	FormattedObject 	- フォーマッタでフォーマットされたアクティブチャットを表すオブジェクト
	CmdParams 			- Send-PowershaAIChatに渡されるパラメータ。GetMyParamsによって返されるオブジェクトと同じです。
	Chat 				- データが送信されているチャット。
nullの場合、デフォルトが生成されます。詳細については、cmdlet Send-PowershaiChatを確認してください。

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
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
