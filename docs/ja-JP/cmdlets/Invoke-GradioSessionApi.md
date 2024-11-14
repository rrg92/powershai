---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
現在のセッションのエンドポイントに新しいコールを作成します。

## DESCRIPTION <!--!= @#Desc !-->
特定のエンドポイントに対して、指定されたパラメータを渡してGradio APIを使用してコールを実行します。  
このコールはGradioApiEventを生成し（Send-GradioApiを参照）、セッションの設定に内部的に保存されます。  
このオブジェクトには、APIの結果を取得するために必要なすべての情報が含まれています。  

コマンドレットは、次のプロパティを持つSessionApiEventタイプのオブジェクトを返します：
	id - 生成されたイベントの内部ID。
	event - 生成された内部イベント。イベントを操作するコマンドレットと直接使用できます。
	
セッションには定義されたコールの制限があります。
これは、制御を失わないように無制限のコールを作成するのを防ぐことを目的としています。

コールに影響を与えるセッションの2つのオプションがあります（Set-GradioSessionで変更可能）：
	- MaxCalls 
	作成できるコールの最大数を制御します。
	
	- MaxCallsPolicy 
	Maxが達成されたときに何をするかを制御します。
	可能な値：
		- Error 	= エラーになります！
		- Remove 	= 最も古いものを削除します。
		- Warning 	= 警告を表示しますが、制限を超えることを許可します。

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
エンドポイントの名前（最初のスラッシュなし）

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
パラメータのリスト 
配列の場合、Gradio APIに直接渡されます。 
ハッシュテーブルの場合、/infoによって返されたパラメータの位置に基づいて配列を構築します。

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
指定された場合、既存のイベントIDで作成します（モジュールの外部で生成されている可能性があります）。

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
セッション

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
新しいトークンの使用を強制します。"public"の場合、トークンは使用されません！

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
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
