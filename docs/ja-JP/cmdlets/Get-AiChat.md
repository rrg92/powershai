---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
LLM にメッセージを送信し、応答を返します

## DESCRIPTION <!--!= @#Desc !-->
これは PowershAI が提供する最も基本的なチャット形式です。  
この関数を使用すると、現在のプロバイダーの LLM にメッセージを送信できます。  

この関数は、PowershAI が提供する LLM へのより低レベルな、標準化されたアクセス方法です。  
履歴やコンテキストは管理しません。これは、チャットのような複数回のやり取りを必要としない、単純なプロンプトを呼び出すのに役立ちます。 
関数呼び出しをサポートしていますが、コードを実行することはなく、モデルからの応答のみを返します。



** プロバイダー向けの情報
	プロバイダーは、この機能を使用できるようにするために、チャット関数を実装する必要があります。 
	チャット関数は、OpenAI のチャット完了関数の仕様と同じ応答を含むオブジェクトを返す必要があります。
	次のリンクは、参考になります。
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (ストリーミングなしの戻り値)
	プロバイダーはこの関数のパラメーターを実装する必要があります。 
	詳細については、各パラメーターのドキュメントを参照し、プロバイダーにどのようにマッピングするかを確認してください。
	
	モデルが指定されたパラメーターのいずれかをサポートしない場合（つまり、同等の機能がない場合、または同等に実装できない場合）、エラーが返されます。

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
送信するプロンプト。ConvertTo-OpenaiMessage 関数で説明されている形式にする必要があります

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

### -temperature
モデルの温度

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
モデル名。指定しない場合は、プロバイダーのデフォルトを使用します。

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
返されるトークンの最大数

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
応答の形式 
許容される形式と動作は、OpenAI のものと同じでなければなりません: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
ショートカット:
	"json" は、{"type": "json_object"} に相当します

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Functions
呼び出されるべきツールのリスト!
Get-OpenaiTool* コマンドを使用して、Powershell 関数を簡単に期待される形式に変換できます。
モデルが関数を呼び出した場合、ストリーミングでも通常でも、応答は OpenAI のツール呼び出しモデルに従う必要があります。
このパラメーターは、OpenAI の関数呼び出しと同じスキーマに従う必要があります: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
プロバイダーの API の直接パラメーターを指定します。
これにより、他のパラメーターに基づいて計算および生成された値が上書きされます。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback
モデルのストリームを有効にします 
LLM によって生成された各テキストに対して呼び出されるスクリプトブロックを指定する必要があります。
スクリプトは、OpenAI のストリーミングによって返されるのと同じストリーミング形式で、各セグメントを表すパラメーターを受け取る必要があります。
	このパラメーターは、OpenAI のストリーミングによって返されるのと同じスキーマである choices プロパティを含むオブジェクトです。
		https://platform.openai.com/docs/api-reference/chat/streaming

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

### -IncludeRawResp
API の応答を IncludeRawResp というフィールドに含めます

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
