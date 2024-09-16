---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
Powershai Chat に送信されるメッセージのコンテキストに注入されるオブジェクトをフォーマットします。

## DESCRIPTION <!--!= @#Desc !-->
LLM は文字列のみを処理するため、コンテキストで渡されるオブジェクトは、プロンプトに注入される前に文字列形式に変換する必要があります。
また、オブジェクトの文字列形式には複数の表現があるため、Powershai ではユーザーがこれらを完全に制御できるようにしています。  

オブジェクトをプロンプトに注入する必要がある場合、Send-PowershaAIChat を使用してパイプラインまたはコンテキストパラメーターを介して呼び出されると、この cmdlet が呼び出されます。
この cmdlet は、オブジェクトを文字列に変換する役割を担います。オブジェクトは、配列、ハッシュテーブル、カスタムなど、どんなオブジェクトでもかまいません。  

この cmdlet は、Set-PowershaiChatContextFormatter で設定されたフォーマッター関数を呼び出してこれを実現します。
一般的に、この関数を直接呼び出す必要はありませんが、テストを行う場合は呼び出すことができます。

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
注入される任意のオブジェクト

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

### -params
フォーマッター関数に渡されるパラメーター

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

### -func
呼び出す関数を上書きします。指定されていない場合は、チャットのデフォルトが使用されます。

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

### -ChatId
操作するチャット

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
