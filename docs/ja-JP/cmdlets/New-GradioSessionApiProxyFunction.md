---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Gradio のエンドポイント (またはすべてのエンドポイント) への呼び出しをカプセル化する関数を生成します。  
このコマンドレットは、Gradio の API エンドポイントをカプセル化する PowerShell 関数を生成する際に非常に便利です。API のパラメータは、関数のパラメータとして作成されます。  
これにより、PowerShell のネイティブな機能であるオートコンプリート、データ型、ドキュメントなどを利用することができ、セッションの任意のエンドポイントを簡単に呼び出すことができます。

このコマンドは、エンドポイントとパラメータのメタデータを取得し、グローバルスコープに PowerShell 関数を生成します。  
これにより、ユーザーは、これらの関数を通常の関数と同様に直接呼び出すことができます。  

たとえば、http://mydemo1.hf.space にある Gradio アプリケーションに、Stable Diffusion を使用して画像を生成する "/GenerateImage" というエンドポイントがあるとします。  
このアプリケーションは、Prompt (生成する画像の説明) と Steps (ステップの総数) の 2 つのパラメータを受け取るとします。

通常、Invoke-GradioSessionApi コマンドを以下のように使用します。

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

これにより、API が開始され、Update-GradioApiResult を使用して結果を取得できます。

$ApiEvent | Update-GradioApiResult

このコマンドレットを使用すると、これらの呼び出しをさらにカプセル化できます。

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

上記のコマンドは、Invoke-GradioApiGenerateimage という関数を生成します。
その後、この関数を以下のように簡単に使用して画像を生成できます。

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100 

デフォルトでは、このコマンドは実行され、結果のイベントを取得してパイプラインに出力するため、他のコマンドと統合できます。  
また、複数のスペースを簡単に接続することもできます。パイプラインの詳細については、以下をご覧ください。

命名規則

	生成される関数の名前は、`<Prefix><NomeOp>` の形式に従います。
		`<Prefix>` は、このコマンドレットの `-Prefix` パラメータの値です。
		`<NomeOp>` は、操作の名前であり、アルファベットと数字のみが含まれます。
		
		たとえば、操作が `/Op1` で、プレフィックスが `INvoke-GradioApi` の場合、次の関数が生成されます。Invoke-GradioApiOp1

	
パラメータ
	生成された関数は、渡されたパラメータを変換し、Invoke-GradioSessionApi コマンドレットを実行するために必要なロジックを含みます。  
	つまり、このコマンドレットを直接呼び出した場合と同じ戻り値が適用されます。(つまり、イベントが返され、現在のセッションのイベントリストに追加されます)。
	
	関数のパラメータは、API のエンドポイントによって異なる場合があります。各エンドポイントは、それぞれ異なるパラメータのセットとデータ型を持つためです。
	ファイル (またはファイルのリスト) を受け取るパラメータは、追加のアップロード手順があります。ファイルはローカルで参照でき、サーバーにアップロードされます。  
	URL または別のコマンドから受け取った FileData オブジェクトが指定された場合、追加のアップロードは行われず、送信のために対応する FileData オブジェクトが API に生成されます。

	エンドポイントのパラメータに加えて、常に生成される関数に追加される追加のパラメータのセットがあります。  
	それらは次のとおりです。
		- Manual  
		このパラメータが使用されている場合、このコマンドレットは Invoke-GradioSessionApi によって生成されたイベントを返します。  
		この場合、Update-GradioSessionApiResult を使用して手動で結果を取得する必要があります。
		
		- ApiResultMap 
		他のコマンドの結果をパラメータにマッピングします。PIPELINE のセクションで詳しく説明します。
		
		- DebugData
		開発者によるデバッグ用です。
		
アップロード 	
	ファイルを受け取るパラメータは、特別な方法で処理されます。  
	API を呼び出す前に、Send-GradioSessionFiles コマンドレットを使用して、これらのファイルを対応する Gradio アプリにアップロードします。  
	これは、このコマンドレットを使用するもう 1 つの大きな利点です。これは透過的であり、ユーザーはアップロードを処理する必要はありません。

パイプライン 
	
	PowerShell の最も強力な機能の 1 つに、パイプラインがあります。これは、`|` を使用して複数のコマンドを接続できる機能です。
	このコマンドレットは、この機能を最大限に活用しようとしています。  
	
	生成されたすべての関数を `|` で接続できます。
	これを行うと、前のコマンドレットによって生成された各イベントが次のコマンドレットに渡されます。  
	
	App1 と App2 という 2 つの Gradio アプリがあるとします。
	App1 は、`Img` というエンドポイントを持ち、`Text` というパラメータを受け取ります。このエンドポイントでは、Diffusers を使用して画像を生成し、生成される画像のパーツを順番に表示します。
	App2 は、`Ascii` というエンドポイントを持ち、`Image` というパラメータを受け取ります。このエンドポイントでは、画像をテキスト形式の ASCII バージョンに変換します。
	
	これらの 2 つのコマンドをパイプラインで非常に簡単に接続できます。  
	最初に、セッションを生成します。

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator
		
	関数を生成します。
		$App1 | New-GradioSessionApiProxy -Prefix App # これにより、AppImg 関数が生成されます。
		$App2 | New-GradioSessionApiProxy -Prefix App # これにより、AppAscii 関数が生成されます。
		
	画像を生成し、ASCII ジェネレーターに接続します。
	
	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data[0]; write-host $_.pipeline[0].data[0].url } 
	
	次に、上記の手順を分解します。
	
	最初のパイプの前には、画像を生成するコマンドがあります。`AppImg -Text "A car"` です。
	この関数は、App1 の `/Img` エンドポイントを呼び出しています。このエンドポイントでは、Hugging Face の Diffusers ライブラリを使用して、画像生成のプロセスの各ステップを出力します。  
	この場合、各出力はぼやけた画像であり、最後の出力は完成した画像です。  
	この結果は、パイプラインオブジェクトの `data` プロパティにあります。これは、結果を含む配列です。
	
	その後のパイプには、`AppAscii -Map ImageInput=0` というコマンドがあります。
	このコマンドは、AppImg コマンドによって生成された各オブジェクトを受け取ります。この場合、Diffusers プロセスの各ステップの画像です。  
	
	コマンドは複数の出力を生成できるため、どの結果をどのパラメータに関連付けるかを正確にマッピングする必要があります。  
	そのため、`-Map` パラメータ (実際の名前は `ApiResultMap` です) を使用します。
	構文は簡単です。`NomeParam=DataIndex,NomeParam=DataIndex` です。
	上記のコマンドでは、`AppAscii` に対して、`data` プロパティの最初の値を `ImageInput` パラメータに使用するように指示しています。  
	たとえば、AppImg が 4 つの値を返し、画像が最後の位置にある場合、`ImageInput=3` (0 は最初) を使用します。
	
	
	最後に、最後のパイプは、AppAscii の結果のみを出力します。この結果は、パイプラインオブジェクト (つまり `$_`) の `data` プロパティにあります (AppImg の結果と同じです)。  
	また、パイプラインオブジェクトには `pipeline` という特別なプロパティがあります。これにより、生成されたすべてのコマンドの結果にアクセスできます。  
	たとえば、`$_.pipeline[0]` には、最初のコマンド (AppImg) の結果が含まれています。
	
	このメカニズムにより、複数の Gradio アプリを 1 つのパイプラインに非常に簡単に接続できます。
	この手順は、New-GradioSessionApiProxy によって生成されたコマンド間でのみ機能します。他のコマンドをパイプラインで接続しても、同じ効果は得られません (ForEachObject などを使用し、パラメータを直接関連付ける必要があります)。


セッション 
	関数が生成されると、元のセッションは関数と共に格納されます。  
	セッションが削除された場合、このコマンドレットはエラーを生成します。この場合、このコマンドレットをもう一度呼び出して関数を生成する必要があります。  


次の図は、関係する依存関係をまとめたものです。

	New-GradioSessionApiProxyFunction(Prefix)
		---> function <Prefix><OpName>
			---> Send-GradioSessionFiles (ファイルがある場合)
			---> Invoke-GradioSessionApi | Update-GradioSessionApiResult

Invoke-GradioSessionApi は最終的に実行されるため、そのすべてのルールが適用されます。
Get-GradioSessionApiProxyFunction を使用して、生成された関数のリストを取得し、Remove-GradioSessionApiProxyFunction を使用して、生成された 1 つ以上の関数を削除できます。  
関数は、動的なモジュールを使用して生成されます。

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
特定のエンドポイントに対してのみ生成されます。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -Prefix
生成される関数のプレフィックス

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Invoke-GradioApi
Accept pipeline input: false
Accept wildcard characters: false
```

### -Session
セッション

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
同じ名前の関数がすでに存在していても、関数の生成を強制します。

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
