---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
現在のセッションのエンドポイントへの新しい呼び出しを作成します。

## DESCRIPTION <!--!= @#Desc !-->
Gradio API を使用して、指定されたエンドポイントに呼び出しを行い、必要なパラメーターを渡します。  
この呼び出しは、GradioApiEvent（Send-GradioApi を参照）を生成します。これは、セッション設定に内部的に保存されます。  
このオブジェクトには、API の結果を取得するために必要なものがすべて含まれています。  

この cmdlet は、SessionApiEvent 型のオブジェクトを返します。このオブジェクトには、次のプロパティが含まれています。
	id - 生成されたイベントの内部 ID。
	event - 生成された内部イベント。イベントを操作する cmdlet で直接使用できます。
	
セッションには、定義された呼び出しの制限があります。
目的は、制御を失うような、無限の呼び出しを作成することを防ぐことです。

呼び出しに影響を与えるセッションのオプションは 2 つあります（Set-GradioSession で変更できます）。
	- MaxCalls 
	作成できる呼び出しの最大数を制御します。
	
	- MaxCallsPolicy 
	最大値に達した場合の動作を制御します。
	可能な値:
		- Error 	= エラーが発生します！
		- Remove 	= 最も古いものを削除します。
		- Warning 	= 警告を表示しますが、制限を超えることができます。

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
エンドポイントの名前（先頭のスラッシュなし）。

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

### -Params
パラメーターのリスト。
配列の場合、Gradio の API に直接渡されます。
ハッシュテーブルの場合、/info で返されるパラメーターの位置に基づいて配列が構築されます。

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

### -EventId
指定した場合、既存のイベント ID で作成します（モジュール外で生成された可能性があります）。

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

### -session
セッション。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
新しいトークンの使用を強制します。「public」の場合、トークンは使用されません。

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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
