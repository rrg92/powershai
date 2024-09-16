---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
Send-PowershaiChat コマンドの -Context パラメータに渡されるオブジェクトをフォーマットするために使用する関数を定義します。

## DESCRIPTION <!--!= @#Desc !-->
Send-PowershaiChat をパイプラインで呼び出すか、-Context パラメータを直接渡すと、このオブジェクトが LLM のプロンプトに挿入されます。  
挿入する前に、このオブジェクトを文字列に変換する必要があります。  
この変換は、Powershai では「コンテキストフォーマッター」と呼ばれます。  
コンテキストフォーマッターは、渡された各オブジェクトを取得し、プロンプトに挿入される文字列に変換する関数です。
使用する関数は、最初の引数として変換するオブジェクトを受け取ります。  

その他の引数は任意です。これらの値は、この関数の -Params パラメータを使用して指定できます！

Powershai はネイティブのコンテキストフォーマッターを提供しています。  
Get-Command ConvertTo-PowershaiContext* または Get-PowershaiContextFormatters を使用して一覧を取得してください！

ネイティブのコンテキストフォーマッターは単なる PowerShell 関数なので、Get-Help 名を使用して詳細情報を確認できます。

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>] [<CommonParameters>]
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

### -Func
PowerShell 関数の名前
Get-PowershaiContextFormatters コマンドを使用して一覧を確認してください

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Str
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
