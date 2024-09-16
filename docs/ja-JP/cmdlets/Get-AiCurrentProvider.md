---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
アクティブなプロバイダーを取得します

## DESCRIPTION <!--!= @#Desc !-->
アクティブなプロバイダーを表すオブジェクトを返します。  
プロバイダーはオブジェクトとして実装され、セッションのメモリ内のグローバル変数に格納されます。  
この関数は、Set-AiProvider コマンドで定義されたアクティブなプロバイダーを返します。

返されるオブジェクトは、プロバイダーのすべてのフィールドを含むハッシュテーブルです。  
このコマンドは、通常、プロバイダーがアクティブなプロバイダーの名前を取得するために使用されます。  

-ContextProvider パラメータは、スクリプトが実行されている現在のプロバイダーを返します。  
プロバイダーのスクリプトで実行されている場合、Set-AiProvider で定義されたプロバイダーではなく、そのプロバイダーが返されます。

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
有効な場合、コンテキストプロバイダーを使用します。つまり、コードがプロバイダーのディレクトリのファイルで実行されている場合、そのプロバイダーを想定します。
そうでない場合は、現在有効になっているプロバイダーを取得します。

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
