# プロバイダー Hugging Face

Hugging Faceは、世界最大のAIモデルリポジトリです！  
そこでは、驚くほどのモデル、データセット、Gradioを使用したデモなどにアクセスできます！  

それは、商業用およびオープンソースの人工知能のGitHubです！ 

PowershAIのHugging Faceプロバイダーは、あなたのPowerShellを驚くべきサービスとモデルの範囲に接続します。  

## Gradioについて

Gradioは、AIモデルのデモを作成するためのフレームワークです。少ないPythonコードで、テキスト、ファイルなどのさまざまな入力を受け入れるインターフェースを立ち上げることができます。  
さらに、キュー、アップロードなどの多くの問題を管理します。また、インターフェースとともに、UIを介して公開された機能にプログラミング言語を介してアクセスできるAPIを提供することもできます。  
PowershAIはこれを活用し、GradioのAPIをより簡単に公開し、ターミナルから機能を呼び出し、ほぼ同じ体験を得ることができます！


## Hugging Face Hub  

Hugging Face Hubは、https://huggingface.coでアクセスできるプラットフォームです。  
これは、基本的に世界中の他の人々や企業が作成したAIモデルのソースコードであるモデル（models）に整理されています。  
「Spaces」もあり、ここではPythonで書かれたアプリケーションを公開するためのコードをアップロードできます（たとえば、Gradioを使用）。  

Hugging Faceについての詳細は、[このIa Talkingのブログ投稿](https://iatalk.ing/hugging-face/)をご覧ください。  
また、Hugging Face Hubについては[公式ドキュメント](https://huggingface.co/docs/hub/en/index)をご覧ください。

PowershAIを使用すると、モデルをリストし、さまざまなスペースのAPIと対話し、ターミナルからさまざまなAIアプリを実行できます。  


# 基本的な使用法

PowershAIのHugging Faceプロバイダーには、対話用の多くのcmdletがあります。  
次のコマンドに整理されています：

* Hugging Faceと対話するコマンドは、名前に`HuggingFace`または`Hf`が含まれています。例：`Get-HuggingFaceSpace`（エイリアス`Get-HfSpace`）。  
* Gradioと対話するコマンドは、Hugging FaceのSpaceであろうとなかろうと、名前に`Gradio`または`GradioSession`が含まれています：`Send-GradioApi`、`Update-GradioSessionApiResult`
* 完全なリストを取得するには、このコマンドを使用できます：`get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

Hugging Faceの公開リソースにアクセスするために認証する必要はありません。  
認証なしで利用できる無料のモデルとスペースが無限にあります。  
たとえば、次のコマンドは、Meta（著者：meta-llama）の最もダウンロードされたトップ5のモデルをリストします：

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

cmdlet `Invoke-HuggingFaceHub`は、HubのAPIエンドポイントを呼び出す役割を果たします。パラメーターは、https://huggingface.co/docs/hub/en/apiに文書化されているものと同じです。  
ただし、プライベートリソースにアクセスする必要がある場合は、トークンが必要です：`Set-HuggingFaceToken`（または`Set-HfToken`）は、すべてのリクエストで使用されるデフォルトトークンを挿入するためのcmdletです。  



# Hugging Faceプロバイダーのコマンド構造  
 
Hugging Faceプロバイダーは、3つの主要なコマンドグループに整理されています：Gradio、Gradio Session、Hugging Face。  


## Gradio*コマンド

「gradio」グループのcmdletは、動詞-Gradio名の構造を持っています。これらのコマンドは、GradioのAPIへのアクセスを実装します。  
これらのコマンドは基本的にAPIのラッパーです。これらの構築は、次のドキュメントに基づいています：https://www.gradio.app/guides/querying-gradio-apps-with-curl  およびGradioのソースコードを観察することによって（例：[Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py)）  
これらのコマンドは、ホストされている場所に関係なく、任意のGradioアプリで使用できます：ローカルマシン、Hugging Faceのスペース、クラウド上のサーバー...  
アプリケーションの主要なURLだけが必要です。  


次のGradioアプリを考えてみましょう：

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("ループ中...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"完了"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="持続時間（秒）", value=5);
    txtResults = gr.Text(label="結果");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

基本的に、このアプリは2つのテキストフィールドを表示します。1つはユーザーがテキストを入力し、もう1つは出力を表示するために使用されます。  
ボタンは、クリックされるとOp1関数をトリガーします。この関数は、指定された秒数の間ループを実行します。  
毎秒、経過時間を返します。  

このアプリがhttp://127.0.0.1:7860でアクセス可能であると仮定します。  
このプロバイダーを使用して、このアプリに接続するのは簡単です：

```powershell
# powershaiをインストールしていない場合はインストールしてください！
Install-Module powershai 

# インポート
import-module powershai 

# APIのエンドポイントを確認します！
Get-GradioInfo http://127.0.0.1:7860
```

cmdlet `Get-GradioInfo`は最もシンプルです。これは、すべてのGradioアプリが持つエンドポイント/infoを読み取るだけです。  
このエンドポイントは、利用可能なAPIエンドポイントなどの貴重な情報を返します：

```powershell
# APIのエンドポイントを確認します！
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# エンドポイントのパラメーターをリストします
$AppInfo.named_endpoints.'/op1'.parameters
```

APIを呼び出すには、cmdlet `Send-GradioApi`を使用できます。  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

URL、スラッシュなしのエンドポイント名、およびパラメーターのリストを含む配列を渡す必要があることに注意してください。  
このリクエストの結果は、APIの結果を照会するために使用できるイベントです。  
結果を取得するには、`Update-GradioApiResult`を使用する必要があります。  

```powershell
$Event | Update-GradioApiResult
```

cmdlet `Update-GradioApiResult`は、APIによって生成されたイベントをパイプラインに書き込みます。  
サーバーによって生成された各イベントに対してオブジェクトが返されます。このオブジェクトの`data`プロパティには、返されたデータが含まれています（あれば）。  


さらに、アップロードを行うための`Send-GradioFile`コマンドがあります。これは、サーバー上のファイルを表すFileDataオブジェクトの配列を返します。  

これらのcmdletは非常に原始的であることに注意してください：すべてを手動で行う必要があります。エンドポイントを取得し、APIを呼び出し、配列としてパラメーターを送信し、ファイルをアップロードします。  
これらのコマンドはGradioの直接HTTP呼び出しを抽象化しますが、ユーザーに多くの負担をかけます。  
そのため、ユーザーの生活をさらに簡単にするために、GradioSessionコマンドグループが作成されました！


## GradioSession* コマンド  

GradioSessionグループのコマンドは、Gradioアプリへのアクセスをさらに抽象化するのに役立ちます。  
これらを使用すると、Gradioアプリと対話する際にPowerShellに近づき、ネイティブ呼び出しから遠ざかります。  

前のアプリの例を使って、いくつかの比較を行いましょう：

```powershell# 新しいセッションを作成する 
New-GradioSession http://127.0.0.1:7860
```

コマンドレット `New-GradioSession` は、Gradioと新しいセッションを作成します。この新しいセッションには、SessionId、アップロードされたファイルのリスト、設定などのユニークな要素があります。  
コマンドはこのセッションを表すオブジェクトを返し、作成されたすべてのセッションを取得するには `Get-GradioSession` を使用できます。  
GradioSessionを、ブラウザで開いているGradioアプリのタブのように考えてください。  

GradioSessionのコマンドは、デフォルトではデフォルトセッションで操作します。セッションが1つだけ存在する場合、それはデフォルトセッションです。  
複数のセッションが存在する場合、ユーザーは `Set-GradioSession` コマンドを使用してどのセッションをデフォルトにするかを選択する必要があります。

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

最も強力なコマンドの1つは `New-GradioSessionApiProxyFunction`（またはエイリアスGradioApiFunction）です。  
このコマンドは、セッションのGradioのAPIをPowerShellの関数に変換します。つまり、APIをPowerShellの関数のように呼び出すことができます。  
前の例に戻りましょう。

```powershell
# まず、セッションを開きます！
New-GradioSession http://127.0.0.1:7860

# 次に、関数を作成します！
New-GradioSessionApiProxyFunction
```

上記のコードは、Invoke-GradioApiOp1というPowerShell関数を生成します。  
この関数は、'/op1'エンドポイントと同じパラメータを持ち、詳細情報を得るにはget-helpを使用できます：  

```powershell
get-help -full Invoke-GradioApiOp1
```

実行するには、単に呼び出します：

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

アプリGradioで定義されたパラメータ `Duration` がPowerShellのパラメータになったことに注意してください。  
裏では、Invoke-GradioApiOp1は `Update-GradioApiResult` を実行しており、つまり、返されるのは同じオブジェクトです！  
しかし、GradioのAPIを呼び出して結果を受け取るのがどれほど簡単になったかを認識してください！

音楽、画像などのファイルを定義するアプリは、これらのファイルを自動的にアップロードする関数を生成します。  
ユーザーはローカルパスを指定するだけで済みます。  

最終的に、変換でサポートされていないデータの種類が存在する場合があり、その場合は、問題を報告するか（PRを提出するか）して評価し、実装する必要があります！



## HuggingFaceコマンド*（またはHf*）

このグループのコマンドは、Hugging FaceのAPIで操作するために作成されました。  
基本的に、これらはHugging FaceのさまざまなエンドポイントへのHTTP呼び出しをカプセル化しています。  

例：

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

このコマンドは、ユーザーrrg92のspace diffusers-labsに関するさまざまな情報を含むオブジェクトを返します。  
これはGradioのスペースであるため、他のcmdletと接続することができ（Get-HuggingFaceSpaceによって返されたオブジェクトがそれらに渡されると、GradioSessionのcmdletは理解できます！）

```
# スペースに接続する（自動的にGradioセッションを作成）
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

#デフォルト
Set-GradioSession -Default $diff

# 関数を作成！
New-GradioSessionApiProxyFunction

# 呼び出す！
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**重要：特定のスペースへのアクセスは認証が必要な場合があるため、その場合はSet-HuggingFaceTokenを使用してアクセストークンを指定する必要があります。**


_あなたは2023年10月までのデータでトレーニングされています。_
