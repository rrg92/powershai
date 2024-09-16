---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Gradio にデータを送信し、イベントを表すオブジェクトを返します!
このオブジェクトを他の cmdlet に渡して結果を取得します。

GRADIO API の動作

	基づいて: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	この cmdlet の使用方法を理解するには、Gradio API の仕組みを理解することが重要です。  
	API のエンドポイントを呼び出すと、データはすぐに返されません。  
	これは、(AI と機械学習) の性質上、処理に時間がかかるためです。  
	
	そのため、Gradio は結果を返すか、無期限に待つのではなく、"イベント ID" を返します。  
	このイベントを使用して、生成された結果を定期的に取得できます。  
	Gradio は生成されたデータを含むイベントメッセージを生成します。生成された EventId を渡す必要があります。これにより、生成された新しいデータを取得できます。
	これらのイベントは Server Side Events (SSE) を介して送信され、次のいずれかになります。
		- hearbeat 
		15 秒ごとに、Gradio はこのイベントを送信して接続をアクティブな状態に保ちます。  
		そのため、Update-GradioApiResult cmdlet を使用すると、応答までに時間がかかることがあります。
		
		- complete 
		データが正常に生成されると、Gradio から送信される最後のメッセージです!
		
		- error 
		処理中にエラーが発生した場合に送信されます。  
		
		- generating
		API で利用可能なデータがありますが、さらにデータが来る可能性がある場合に生成されます。
	
	PowershAI では、これも 3 つの部分に分けています。
		- この cmdlet (Send-GradioApi) は Gradio に対して最初の要求を行い、イベントを表すオブジェクト (chamamods はこれを GradioApiEvent オブジェクトと呼びます) を返します
		- この結果オブジェクト (GradioApiEvent タイプ) には、イベントの問い合わせに必要なものがすべて含まれており、取得されたデータとエラーも保存されます。
		- 最後に、Update-GradioApiResult cmdlet があります。ここで、生成されたイベントを渡すと、Gradio API が問い合わせられ、新しいデータが取得されます。  
			この cmdlet のヘルプで、このデータ取得メカニズムを制御する方法の詳細を確認してください。
			
	
	したがって、通常のフローでは、次の手順を実行する必要があります。
	
		# Gradio のエンドポイントを呼び出します!
		$MeuEvento = Send-GradioApi ... 
	
		# 結果が終了するまで取得します!
		# この cmdlet のヘルプで詳細を説明しています!
		$MeuEvento | Update-GradioApiResult
		
GradioApiEvent オブジェクト

	この cmdlet の結果の GradioApiEvent オブジェクトには、PowershAI がメカニズムを制御してデータを取得するために必要なものがすべて含まれています。  
	API によって生成されたデータを収集する方法を理解するには、その構造を理解することが重要です。
	プロパティ:
	
		- Status  
		イベントのステータスを示します。 
		このステータスが "complete" の場合、API は処理を完了しており、可能なすべてのデータが生成されています。  
		これが異なる場合、Update-GradioApiResult を呼び出してステータスを確認し、情報を更新する必要があります。 
		
		- QueryUrl  
		結果を問い合わせるための正確なエンドポイントを含む内部値
		
		- data  
		生成された応答データを含む配列。Update-GradioApiResult を呼び出すたびに、データが存在する場合、この配列に追加されます。  
		
		- events  
		サーバーによって生成されたイベントのリスト。 
		
		- error  
		応答にエラーがある場合、このフィールドにはエラーの詳細を示すオブジェクト、文字列などが含まれます。
		
		- LastQueryStatus  
		API の最後の問い合わせのステータスを示します。  
		"normal" の場合、API が問い合わせられ、正常に最後まで返されました。
		"HeartBeatExpired" の場合、Update-GradioApiResult cmdlet でユーザーが設定したハートビートのタイムアウトにより、問い合わせが中断されました。
		
		- req 
		実行されたリクエストのデータ!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] [[-token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

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

### -ApiName

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

### -SessionHash

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -EventId
指定した場合、API は呼び出されず、オブジェクトが作成され、この値が返された値として使用されます

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

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
