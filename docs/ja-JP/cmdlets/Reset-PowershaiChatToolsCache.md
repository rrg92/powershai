---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
AI Tools のキャッシュをクリアします。

## DESCRIPTION <!--!= @#Desc !-->
PowershAI は、"コンパイル済み" ツールのキャッシュを保持します。
PowershAI は、LLM にツールのリストを送信する場合、ツールの説明、パラメータのリスト、説明などを送信する必要があります。  
このリストの作成には、ツールのリスト、関数のリスト、およびそれぞれに対してヘルプ (および各パラメータのヘルプ) をスキャンするため、かなりの時間がかかる可能性があります。

Add-AiTool のようなコマンドレットを追加しても、その時点でコンパイルされません。
これは、LLM を呼び出す必要がある場合 (Send-PowershaiChat 関数内) に実行されます。  
キャッシュが存在しない場合、その場でコンパイルされます。これにより、最初の LLM への送信が、通常よりも数ミリ秒または数秒遅くなる可能性があります。  

この影響は、送信される関数とパラメータの数に比例します。  

Add-AiTool または Add-AiScriptTool を使用すると、キャッシュが無効になり、次回の実行時にキャッシュが生成されます。  
これにより、多くの関数を一度に追加し、追加するたびにコンパイルする必要がなくなります。

ただし、関数を変更しても、キャッシュは再計算されません。  
そのため、このコマンドレットを使用して、コードまたはスクリプトを変更した後の次回の実行に、ツールの最新データが含まれるようにする必要があります。

## SYNTAX <!--!= @#Syntax !-->

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
