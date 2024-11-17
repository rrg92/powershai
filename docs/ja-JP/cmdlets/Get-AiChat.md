---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
LLMにメッセージを送信し、応答を返します

## DESCRIPTION <!--!= @#Desc !-->
これは、PowershAIによって提供される最も基本的なチャットの形式です。  
この関数を使用すると、現在のプロバイダーのLLMにメッセージを送信できます。  

この関数は、PowershAIが提供するLLMへの標準化された低レベルのアクセス方法です。  
それは履歴やコンテキストを管理しません。単純なプロンプトを呼び出すために便利であり、チャットのように複数のインタラクションを必要としません。  
Function Callingをサポートしていますが、コードを実行することはなく、モデルの応答のみを返します。



** プロバイダーへの情報
	プロバイダーは、この機能が利用できるようにChat関数を実装する必要があります。 
	Chat関数は、OpenAIのChat Completion関数と同じ仕様の応答を持つオブジェクトを返す必要があります。
	以下のリンクは参考になります：
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (ストリーミングなしの返却)
	プロバイダーは、この関数のパラメータを実装する必要があります。 
	各パラメータの詳細とプロバイダーへのマッピング方法については、ドキュメントを参照してください；
	
	モデルが指定されたパラメータのいずれかをサポートしていない場合（つまり、同等の機能がない場合、または同等に実装できない場合）、エラーが返される必要があります。

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] 
[[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
送信するプロンプト。ConvertTo-OpenaiMessage関数によって説明される形式である必要があります

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
モデルの名前。指定されていない場合、プロバイダーのデフォルトを使用します。

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
返される最大トークン数

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
応答のフォーマット 
受け入れ可能なフォーマットと動作は、OpenAIと同じである必要があります：https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
ショートカット：
	"json"|"json_object"は、{"type": "json_object"}に相当します。
	オブジェクトは、OpenAIのAPIに直接渡されたかのように、response_format.json_schemaフィールドで指定されたスキーマを指定する必要があります。

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
呼び出す必要があるツールのリスト！
Get-OpenaiTool*のようなコマンドを使用して、PowerShellの関数を期待されるフォーマットに簡単に変換できます！
モデルが関数を呼び出す場合、ストリームおよび通常の応答の両方は、OpenAIのツール呼び出しモデルに従う必要があります。
このパラメータは、OpenAIのFunction Callingと同じスキーマに従う必要があります：https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
プロバイダーのAPIの直接パラメータを指定します。
これにより、他のパラメータに基づいて計算および生成された値が上書きされます。

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
モデルストリームを有効にします 
LLMによって生成された各テキストに対して呼び出されるScriptBlockを指定する必要があります。
スクリプトは、ストリーミングで返されるのと同じ形式の各セクションを表すパラメータを受け取る必要があります。
このパラメータは、OpenAIのストリーミングで返される同じスキーマであるchoicesプロパティを含むオブジェクトです：
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
APIの応答をIncludeRawRespというフィールドに含めます

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
