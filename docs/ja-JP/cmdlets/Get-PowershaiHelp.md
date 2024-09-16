---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
Powershai についてのヘルプを取得するために、現在のプロバイダーを使用します。

## DESCRIPTION <!--!= @#Desc !-->
この cmdlet は、PowershAI 自身の  コマンドを使用して、ユーザーが自分自身についてヘルプを得るのを支援します。  
基本的に、ユーザーからの質問に基づいて、一般的な情報と基本的なヘルプを含むプロンプトを作成します。  
次に、これをチャットの LLM に送信します。

送信されるデータ量が多いことから、128k を超えるデータを受け入れ、価格の安いプロバイダーおよびモデルでのみこのコマンドを使用することをお勧めします。  
現時点では、このコマンドは実験的であり、次のモデルでのみ機能します。
	- Openai gpt-4*
	
内部的には、"_pwshai_help" という名前の Powershai チャットが作成され、そこですべての履歴が保持されます。

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
ヘルプテキストを説明します。

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

### -command
特定のコマンドのヘルプが必要な場合は、ここにコマンドを指定してください。
PowershaiChat のコマンドである必要はありません。

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

### -Recreate
チャットを再作成します。

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
