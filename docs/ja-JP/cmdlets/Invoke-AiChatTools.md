---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
LLMにメッセージを送信し、ツール呼び出しをサポートし、モデルによって要求されたツールをPowerShellコマンドとして実行します。

## DESCRIPTION <!--!= @#Desc !-->
これは、PowerShellでツールの処理を容易にするための補助関数です。
モデルが要求したときに「ツール」の処理を行います！

ツールは特定の形式で渡す必要があり、about_Powershai_Chatsトピックで文書化されています。
この形式は、OpenAI（OpenAPIスキーマ）によって受け入れられるスキーマに対して、PowerShellの関数とコマンドを正しくマッピングします。

このコマンドは、モデルが関数を呼び出そうとしているときにそれを識別するロジック、これらの関数の実行、およびその応答をモデルに戻すロジックをすべてカプセル化しています。
モデルがさらに関数を呼び出すことを決定するのをやめるまで、またはモデルとのインタラクションの制限（はい、ここでは「インタラクション」と呼びます、そして「イテレーション」ではありません）が終了するまで、このループに留まります。

インタラクションの概念は簡単です：関数がモデルにプロンプトを送信するたびに、それは1回のインタラクションとしてカウントされます。
以下は、発生する可能性のある典型的なフローです：
	

動作の詳細については、about_Powershai_Chatsトピックを参照してください。

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] 
<Object>] [[-MaxSeqErrors] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] 
[-Stream] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt

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

### -Tools
ツールの配列。このコマンドのドキュメントで説明されています。
Get-OpenaiTool*の結果を使用して、可能な値を生成します。  
OpenaiToolタイプのオブジェクトの配列を渡すことができます。
同じ関数が複数のツールで定義されている場合、定義された順序で最初に見つかったものが使用されます！

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

### -PrevContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxTokens
最大出力！

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 500
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxInteractions
合計で、最大5回のインタラクションを許可します！

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxSeqErrors
関数が生成できる連続エラーの最大数です。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 2
Accept pipeline input: false
Accept wildcard characters: false
```

### -temperature

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -on
イベントハンドラー
各キーは、このコマンドによっていつかトリガーされるイベントです！
イベント：
answer: モデルからの応答を取得した後にトリガーされます（またはストリームを使用して応答が利用可能になったとき）。
func: モデルによって要求されたツールの実行を開始する前にトリガーされます。
	exec: モデルが関数を実行した後にトリガーされます。
	error: 実行された関数がエラーを生成したときにトリガーされます。
	stream: 応答が送信されたとき（ストリームによって）および-DifferentStreamEvent。
	beforeAnswer: すべての応答の後にトリガーされます。ストリームで使用するときに便利です！
	afterAnswer: 応答を開始する前にトリガーされます。ストリームで使用するときに便利です！

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 9
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Json
response_format = "json"を送信し、モデルにJSONを返すよう強制します。

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

### -RawParams
カスタムパラメーターを呼び出しに直接追加（自動的に定義されたパラメーターを上書きします）。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 10
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Stream

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
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
