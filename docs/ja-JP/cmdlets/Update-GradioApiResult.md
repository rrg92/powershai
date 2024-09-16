---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioApiResult

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Send-GradioApi によって返されるイベントを、サーバーからの新しい結果で更新し、デフォルトではパイプラインにイベントを返します。

Gradio API の結果は、ほとんどの HTTP REST サービスのように、すぐに生成されるわけではありません。  
Send-GradioApi コマンドのヘルプは、このプロセスがどのように機能するかを詳しく説明しています。  

このコマンドは、Send-GradioApi によって返される GradioApiEvent オブジェクトを更新するために使用されます。
このオブジェクトは、API に対する各呼び出しの応答を表し、データと履歴を含む、結果を照会するために必要なものがすべて含まれています。

基本的に、この cmdlet は、API 呼び出しのステータス照会エンドポイントを呼び出すことで動作します。
照会に必要なパラメータは、-ApiEvent パラメータで渡されるオブジェクト自体に含まれています（これは Send-GradioApi cmdlet によって作成され、返されます）。

この cmdlet が実行されるたびに、HTTP 接続を介してサーバーに永続的に接続し、イベントを待機します。  
サーバーがデータを送信すると、-ApiEvent パラメータで渡されたオブジェクトを更新し、デフォルトではパイプラインに返されるイベントを書き込みます。

返されるイベントは、GradioApiEventResult 型のオブジェクトであり、API 実行の応答によって生成されたイベントを表します。  

-History パラメータを指定すると、生成されたすべてのイベントが、-ApiEvent で指定されたオブジェクトの events プロパティに格納され、返されたデータも格納されます。

基本的に、生成されたイベントは、ハートビートまたはデータを送信できます。

GRADIOAPIEventResult オブジェクト
	num 	= イベントのシーケンス番号。1 から始まります。
	ts 		= イベントが作成された日時（サーバーではなく、ローカル日時）。
	event 	= イベントの名前
	data 	= このイベントで返されるデータ

データ（DATA）

	Gradio からデータを取得するには、基本的にこの cmdlet によって返されるイベントを読み取り、GradioApiEventResult の data プロパティを確認します。
	通常、Gradio のインターフェースは、受信した最新のイベントでこのフィールドを上書きします。  
	
	-History を使用すると、パイプラインへの書き込みに加えて、cmdlet は data フィールドにデータを保存するため、サーバーによって生成された完全な履歴にアクセスできます。  
	大量のデータが返される場合、これによりメモリ消費量が増える可能性があることに注意してください。
	
	よく知られている「問題のある」ケースが 1 つあります。場合によっては、Gradio は同じデータで最新の 2 つのイベントを出力することがあります（1 つのイベントは「generating」という名前になり、もう 1 つは complete になります）。  
	これを安全に区別するための解決策はまだ見つかっていないため、ユーザーはこれを処理する最良の方法を決定する必要があります。  
	常に受信した最新のイベントを使用する場合は、これは問題になりません。
	生成されたイベントをすべて使用する場合、これらのケースを処理する必要があります。
	簡単な例としては、コンテンツが同じ場合、繰り返さないようにします。ただし、同じコンテンツを含む 2 つのイベントが、論理的に異なるイベントである場合もあります。
	
	

ハートビート 

	Gradio API によって生成されるイベントの 1 つは、ハートビートです。  
	Gradio は 15 秒ごとに「HeartBeat」というタイプのイベントを送信して、接続をアクティブに保ちます。  
	これにより、cmdlet が「ハング」します。HTTP 接続がアクティブになっているため、cmdlet は応答（データ、エラー、またはハートビート）を待ち続けます。
	
	これを制御するメカニズムがない場合、cmdlet は CTRL + C でもキャンセルできないため、無限に実行されます。
	これを解決するために、この cmdlet は MaxHeartBeats パラメータを提供しています。  
	このパラメータは、cmdlet が API の照会を停止するまでに許可される連続するハートビート イベントの数を示します。  
	
	たとえば、サーバーによって送信されたイベントの次の 2 つのシナリオを考えてみます。
	
		シナリオ 1:
			generating 
			heartbeat 
			generating 
			heartbeat 
			generating 
			complete
			
		シナリオ 2:
			generating 
			generating
			heartbeat 
			heartbeat
			heartbeat 
			complete

	デフォルト値（2）の場合、シナリオ 1 では、cmdlet は complete になるまで決して終了しません。これは、連続する 2 つのハートビートがなかったためです。
	
	シナリオ 2 では、2 つのデータイベント（generating）を受信した後、4 番目のイベント（hearbeat）で、連続する 2 つのハートビートが送信されたため、cmdlet は終了します。  
	この場合、ハートビートが期限切れになったと言います。
	この場合、残りの部分を取得するために、Update-GradioApiResult を再び呼び出す必要があります。
	
	コマンドがハートビートの期限切れによって終了するたびに、LastQueryStatus プロパティの値が HeartBeatExpired に更新されます。  
	これにより、いつ再び呼び出す必要があるかを適切に確認して処理できます。
	
	
ストリーム  
	
	Gradio API がすでに SSE（Server Side Events）を使用して応答しているため、多くの API の「ストリーム」と同様の効果を使用できます。  
	この cmdlet Update-GradioApiResult は、すでに SSE を使用してサーバーのイベントを処理しています。  
	さらに、イベントが利用可能になったときに処理を行う場合、-Script パラメータを使用して、イベントを受信したときに呼び出されるスクリプトブロック、関数などを指定できます。  
	
	-MaxHeartBeats パラメータと組み合わせることで、リアルタイムで何かを更新する呼び出しを作成できます。 
	たとえば、チャットボットからの応答の場合、すぐに画面に書き込むことができます。
	
	このパラメータは、チェックを行うコード（つまり、同じスレッド）で連続して呼び出されることに注意してください。  
	そのため、長時間かかるスクリプトは、新しいイベントの検出を妨げ、結果としてデータの配信を妨げる可能性があります。
	
.

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioApiResult [[-ApiEvent] <Object>] [-Script <Object>] [-MaxHeartBeats <Object>] [-NoOutput] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiEvent
Send-GradioApi の結果

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Script
生成された各イベントで呼び出されるスクリプト！
次のキーを含むハッシュテーブルを受け取ります。
 	event - 生成されたイベントが含まれます。event.event はイベントの名前です。event.data は返されるデータです。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -MaxHeartBeats
停止するまでの連続する最大ハートビート数！
これにより、コマンドは、サーバーからのこの数の連続するハートビートのみを待機します。
サーバーがこの数を送信すると、cmdlet は終了し、イベントの LastQueryStatus を HeartBeatExpired に設定します。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoOutput
結果を cmdlet の出力に書き込みません

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

### -History
イベントとデータの履歴を ApiEvent オブジェクトに保存します
これにより、PowerShell のメモリ消費量が増加することに注意してください。

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
