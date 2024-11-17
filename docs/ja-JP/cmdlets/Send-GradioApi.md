---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Gradioにデータを送信し、イベントを表すオブジェクトを返します！  
このオブジェクトを他のcmdletに渡して結果を取得します。

グラディオAPIの動作

	基づいています: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	このcmdletの使い方を理解するためには、Gradio APIの動作を理解することが重要です。  
	APIのエンドポイントを呼び出すと、データはすぐには返されません。  
	これは、処理が長いためであり、その原因は（AIと機械学習）にあります。  
	
	したがって、結果を返す代わりに、Gradioは「Event Id」を返します。  
	このイベントを使用して、生成された結果を定期的に取得できます。  
	Gradioは生成されたデータを含むイベントメッセージを生成します。生成されたEventIdを渡して新しいデータを取得する必要があります。  
	これらのイベントはサーバーサイドイベント（SSE）を介して送信され、次のようなものがあります：
		- hearbeat 
		15秒ごとに、Gradioは接続を維持するためにこのイベントを送信します。  
		そのため、cmdlet Update-GradioApiResultを使用すると、返答が遅れることがあります。
		
		- complete 
		データが正常に生成されたときにGradioから送信される最後のメッセージです！
		
		- error 
		処理中にエラーが発生した場合に送信されます。  
		
		- generating
		APIにデータが既に利用可能ですが、まだ他のデータが来る可能性があるときに生成されます。
	
	PowershAIでは、これを3つの部分に分けています： 
		- このcmdlet（Send-GradioApi）は、Gradioに初期リクエストを行い、イベントを表すオブジェクト（これをGradioApiEventオブジェクトと呼びます）を返します。
		- この結果として得られるGradioApiEvent型のオブジェクトには、イベントを照会するために必要なすべての情報が含まれており、取得したデータとエラーも保持します。
		- 最後に、cmdlet Update-GradioApiResultがあり、生成されたイベントを渡す必要があります。これにより、Gradio APIを照会して新しいデータを取得します。  
			このcmdletのヘルプを確認して、データを取得するメカニズムを制御する方法についての詳細を確認してください。
			
	
	したがって、通常のフローでは、次のようにする必要があります： 
	
		#グラディオのエンドポイントを呼び出します！
		$MeuEvento = SEnd-GradioApi ... 
	
		# 結果が完了するまで取得します！
		# このcmdletのヘルプを確認して、詳細を学んでください！
		$MeuEvento | Update-GradioApiResult
		
GradioApiEventオブジェクト

	このcmdletから得られるGradioApiEventオブジェクトには、PowershAIがメカニズムを制御し、データを取得するために必要なすべての情報が含まれています。  
	APIによって生成されたデータを収集する方法を理解するために、その構造を知っておくことが重要です。
	プロパティ：
	
		- Status  
		イベントのステータスを示します。 
		このステータスが「complete」の場合、APIはすでに処理を完了し、すべての可能なデータが生成されたことを意味します。  
		それ以外の場合は、Update-GradioApiResultを呼び出してステータスを確認し、情報を更新する必要があります。 
		
		- QueryUrl  
		結果を照会するための正確なエンドポイントを含む内部値
		
		- data  
		生成されたすべての応答データを含む配列。Update-GradioApiResultを呼び出すたびに、データがあればこの配列に追加されます。  
		
		- events  
		サーバーによって生成されたイベントのリスト。 
		
		- error  
		応答にエラーがあった場合、このフィールドにはオブジェクト、文字列など、詳細を説明するものが含まれます。
		
		- LastQueryStatus  
		APIの最後の照会のステータスを示します。  
		「normal」の場合、APIが正常に照会され、最後まで正常に応答したことを示します。
		「HeartBeatExpired」の場合、ユーザーがcmdlet Update-GradioApiResultで設定したheartbeatのタイムアウトにより、照会が中断されたことを示します。
		
		- req 
		行ったリクエストのデータ！

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] 
[[-token] <Object>] [<CommonParameters>]
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
指定された場合、APIは呼び出されず、オブジェクトが作成され、この値が戻り値として使用されます。

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
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
