---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
OpenAI 標準メッセージフォーマットに文字列とオブジェクトの配列を変換します！

## DESCRIPTION <!--!= @#Desc !-->
混合配列を渡すことができます。各項目は文字列またはオブジェクトです。
文字列の場合、s、u、または a のプレフィックスで始まる場合があります。それぞれ system、user、または assistant を表します。
オブジェクトの場合、直接結果の配列に追加されます。

参照: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "これはテキストです",@{role:"assistant";content="アシスタントの返信"}, "s:システムメッセージ"
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


<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
