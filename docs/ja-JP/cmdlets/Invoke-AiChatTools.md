---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiChatTools

## SYNOPSIS <!--!= @#Synop !-->
LLM にメッセージを送信し、ツール呼び出しをサポートし、モデルによって要求されたツールを PowerShell コマンドとして実行します。

## DESCRIPTION <!--!= @#Desc !-->
これは、PowerShell でのツール処理を簡単にするためのヘルパー関数です。
それは "ツール" の処理を処理し、モデルが要求したときに実行します！

ツールを特定の形式で渡す必要があります。これは、about_Powershai_Chats トピックで文書化されています。
この形式は、PowerShell 関数とコマンドを OpenAI (OpenAPI スキーマ) で受け入れられるスキーマに正しくマッピングします。

このコマンドは、モデルが関数を呼び出そうとしたときの識別、これらの関数の実行、およびその応答をモデルに送り返すためのすべてのロジックをカプセル化します。
これは、モデルがさらに関数を呼び出すことを決定するのをやめたり、モデルとの相互作用の制限（はい、ここでは相互作用と呼び、反復と呼びません）が終了するまで、このループにとどまります。

相互作用の概念は簡単です。関数でモデルにプロンプトを送信するたびに、相互作用としてカウントされます。
以下は、発生する可能性のある一般的なフローです。


about_Powershai_Chats トピックで、詳細な動作を確認できます。

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiChatTools [[-prompt] <Object>] [[-Tools] <Object>] [[-PrevContext] <Object>] [[-MaxTokens] <Object>] [[-MaxInteractions] <Object>] [[-MaxSeqErrors] <Object>] 
[[-temperature] <Object>] [[-model] <Object>] [[-on] <Object>] [-Json] [[-RawParams] <Object>] [-Stream] [<CommonParameters>]
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
このコマンドのドキュメントで説明されているように、ツールの配列。
Get-OpenaiTool* の結果を使用して、可能な値を生成します。
OpenaiTool 型のオブジェクトの配列を渡すことができます。
同じ関数が複数のツールで定義されている場合、定義された順序で最初に検出されたものが使用されます！

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
合計で、最大 5 つの反復を許可します！

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
関数が終了するまでに生成できる連続エラーの最大数。

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
各キーは、このコマンドによってある時点でトリガーされるイベントです！
イベント:
answer: モデルから応答を取得した後（またはストリームを使用しているときに応答が利用可能になった場合）にトリガーされます。
func: モデルによって要求されたツールの実行を開始する前にトリガーされます。
	exec: モデルが関数を呼び出した後にトリガーされます。
	error: 実行された関数がエラーを生成したときにトリガーされます。
	stream: 応答が（ストリームによって）送信されたときにトリガーされ、-DifferentStreamEvent
	beforeAnswer: すべての応答の後にトリガーされます。ストリームで使用する場合に役立ちます！
	afterAnswer: 応答を開始する前にトリガーされます。ストリームで使用する場合に役立ちます！

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
response_format = "json" を送信し、モデルに JSON を返すように強制します。

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
カスタムパラメーターを直接呼び出しに追加します（自動的に定義されたパラメーターを上書きします）。

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
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
