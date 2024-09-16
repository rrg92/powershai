# Hugging Face プロバイダー

Hugging Face は世界最大の AI モデルリポジトリです！  
そこには、驚くほどの数のモデル、データセット、Gradio を使ったデモなどが用意されています！  

AI の GitHub とも言うべき場所です。商用でもオープンソースでも利用できます！

PowershAI の Hugging Face プロバイダーは、Powershell を驚くほど多くのサービスやモデルに接続します。  

## Gradio

Gradio は、AI モデルのデモを作成するためのフレームワークです。Python で少行のコードを書くだけで、テキスト、ファイルなど、さまざまな入力を受け付けるインターフェースを作成できます。  
さらに、キュー、アップロードなどの多くの問題を管理します。  そして、インターフェースに加えて、UI を介して公開されている機能をプログラミング言語からもアクセスできるように、API を提供することもできます。  
PowershAI はこの機能を活用し、Gradio の API をより簡単に利用できるようにしています。端末から機能を呼び出せば、ほぼ同じエクスペリエンスを実現できます！


## Hugging Face Hub  

Hugging Face Hub は、https://huggingface.co でアクセスできるプラットフォームです。  
このプラットフォームはモデルで構成されており、モデルとは、世界中の個人や企業が作成した AI モデルのソースコードのことです。  
また、"Spaces" もあり、ここでは Python (Gradio などを使用) または Docker を使用して作成したアプリケーションを公開するためのコードをアップロードできます。  

Hugging Face についてもっと知りたい方は、[Ia Talking のブログ記事](https://iatalk.ing/hugging-face/) をご覧ください。
また、Hugging Face Hub については、[公式ドキュメント](https://huggingface.co/docs/hub/en/index) をご覧ください。

PowershaAI を使用すると、モデルを一覧表示したり、さまざまな Spaces の API と対話したり、端末からさまざまな AI アプリケーションを実行したりできます。  


# 基本的な使い方

PowershAI の Hugging Face プロバイダーには、多くの cmdlet が用意されており、対話に利用できます。  
これらのコマンドは、以下のように分類されます。

* Hugging Face と対話するコマンドには、`HuggingFace` または `Hf` が名前に入ります。例: `Get-HuggingFaceSpace` (エイリアス `Get-HfSpace`)。  
* Gradio と対話するコマンドには、Hugging Face の Space であるかどうかにかかわらず、`Gradio` または `GradioSession` が名前に入ります: `Send-GradioApi`, `Update-GradioSessionApiResult`
* すべての cmdlets を取得するには、`get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*` コマンドを使用してください。

Hugging Face のパブリックリソースにアクセスするのに認証は必要ありません。  
認証なしで無料で利用できるモデルや Spaces が無数にあります。  
例えば、次のコマンドは、Meta (作者: meta-llama) からダウンロードされたトップ 5 のモデルを一覧表示します。

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

cmdlet `Invoke-HuggingFaceHub` は、Hub の API のエンドポイントを呼び出す役割を果たします。  パラメータは、https://huggingface.co/docs/hub/en/api に記載されているものと同じです。
ただし、プライベートリソースにアクセスする必要がある場合は、トークンが必要です。`Set-HuggingFaceToken` (または `Set-HfToken`) は、すべての要求で使用するデフォルトのトークンを設定するための cmdlet です。  



# Hugging Face プロバイダーのコマンド構造  
 
Hugging Face プロバイダーは、主に 3 つのグループのコマンドで構成されています。Gradio、Gradio Session、Hugging Face です。  


## Gradio*` コマンド

"gradio" グループの cmdlet は、Verbo-GradioName の構造になっています。  これらのコマンドは、Gradio の API へのアクセスを実装しています。  
これらのコマンドは、基本的に API のラッパーです。これらのコマンドの構築は、このドキュメント: https://www.gradio.app/guides/querying-gradio-apps-with-curl をベースにしており、Gradio のソースコード (例: [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) ) も参考にしています。
これらのコマンドは、ローカルマシン、Hugging Face の Space、クラウド上のサーバーなど、Gradio アプリケーションがどこでホストされているかに関係なく、どの Gradio アプリケーションでも使用できます。
アプリケーションのメイン URL が分かっていれば、使用できます。  


次の Gradio アプリケーションを考えてみましょう。

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="Duration, in, seconds", value=5);
    txtResults = gr.Text(label="Resultado");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

このアプリケーションは、基本的に 2 つのテキストフィールドを表示します。1 つはユーザーがテキストを入力するもので、もう 1 つは出力を表示するものです。  
ボタンをクリックすると、Op1 関数が実行されます。この関数は、パラメータで指定された秒数の間、ループ処理を行います。  
1 秒ごとに、経過時間を返します。  

アプリケーションを起動すると、http://127.0.0.1:7860 でアクセスできるようになっているとします。
このプロバイダーを使用すると、このアプリケーションに簡単に接続できます。

```powershell
# powershai をインストールします (まだインストールしていない場合)。
Install-Module powershai 

# インポート
import-module powershai 

# API のエンドポイントを確認します。
Get-GradioInfo http://127.0.0.1:7860
```

cmdlet `Get-GradioInfo` は最も単純なコマンドです。すべての Gradio アプリケーションが持つ /info エンドポイントを読み取ります。  
このエンドポイントからは、API で利用可能なエンドポイントなどの貴重な情報が返されます。

```powershell
# API のエンドポイントを確認します。
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# エンドポイントのパラメータを一覧表示します
$AppInfo.named_endpoints.'/op1'.parameters
```

API を呼び出すには、`Send-GradioApi` cmdlet を使用します。  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

URL、スラッシュを含まないエンドポイント名、パラメータの配列を指定する必要があることに注意してください。
この要求の結果はイベントであり、このイベントを使用して API の結果を確認できます。
結果を取得するには、`Update-GradioApiResult` を使用します。

```powershell
$Event | Update-GradioApiResult
```

cmdlet `Update-GradioApiResult` は、API から生成されたイベントをパイプラインに書き込みます。  
サーバーから生成されたイベントごとにオブジェクトが返されます。このオブジェクトの `data` プロパティには、返されたデータ (存在する場合) が含まれます。  


また、`Send-GradioFile` コマンドを使用すると、アップロードを実行できます。  このコマンドは、サーバー上のファイルを表現する `FileData` オブジェクトの配列を返します。  

これらの cmdlet は非常に基本的なものであることに注意してください。すべてを手動で行う必要があります。エンドポイントを取得し、API を呼び出し、パラメータを配列として送信し、ファイルをアップロードします。  
これらのコマンドは、Gradio の HTTP 呼び出しを抽象化していますが、ユーザーにはまだ多くの操作が必要です。  
そのため、GradioSession コマンドグループが作成されました。このグループのコマンドを使用すると、さらに抽象化され、ユーザーの負担が軽減されます。


## GradioSession*  コマンド

GradioSession グループのコマンドは、Gradio アプリケーションへのアクセスをさらに抽象化します。  
これらのコマンドを使用すると、Powershell から Gradio アプリケーションを操作するのがより簡単になります。  ネイティブな呼び出しから離れて操作できます。  

前のアプリケーションの例を使用して、いくつかの比較を行います。

```powershell
# 新しいセッションを作成します
New-GradioSession http://127.0.0.1:7860
```

cmdlet `New-GradioSession` は、Gradio との新しいセッションを作成します。  この新しいセッションには、SessionId、アップロードされたファイルのリスト、設定など、一意の要素が含まれています。  
このコマンドは、このセッションを表すオブジェクトを返します。作成されたセッションはすべて `Get-GradioSession` を使用して取得できます。  
GradioSession は、ブラウザで開いているタブにたとえられます。タブには Gradio アプリケーションが開かれています。  

GradioSession コマンドは、デフォルトでデフォルトセッションで動作します。セッションが 1 つしかない場合、そのセッションがデフォルトセッションになります。  
セッションが複数ある場合は、`Set-GradioSession` コマンドを使用して、どのセッションをデフォルトにするかを指定する必要があります。

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

最も強力なコマンドの 1 つが `New-GradioSessionApiProxyFunction` (またはエイリアスの GradioApiFunction) です。  
このコマンドは、セッションの Gradio の API を Powershell 関数に変換します。つまり、Gradio の API を Powershell 関数のように呼び出すことができます。  
前の例に戻ってみましょう。


```powershell
# まず、セッションを開きます。
New-GradioSession http://127.0.0.1:7860

# 次に、関数をいくつか作成します。
New-GradioSessionApiProxyFunction
```

上記のコードは、Invoke-GradioApiOp1 という Powershell 関数を生成します。  
この関数は、エンドポイント '/op1' と同じパラメータを持ちます。`get-help` を使用すると、詳細な情報が得られます。

```powershell
get-help -full Invoke-GradioApiOp1
```

実行するには、次のように呼び出します。

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Gradio アプリケーションで定義されている `Duration` パラメータが、Powershell パラメータになっていることに注意してください。  
実際には、Invoke-GradioApiOp1 は `Update-GradioApiResult` を実行しており、返されるオブジェクトは同じです。
しかし、Gradio の API を呼び出し、結果を受け取るのがいかに簡単になったかがお分かりいただけると思います。

音楽や画像などのファイルを定義するアプリケーションは、これらのファイルを自動的にアップロードする関数を生成します。  
ユーザーは、ローカルパスを指定するだけです。  

場合によっては、変換でサポートされていないデータ型が存在することがあります。そのようなデータ型が見つかった場合は、Issue を作成 (または PR を提出) して、評価と実装をお願いします。



## HuggingFace* (または Hf*) コマンド

このグループのコマンドは、Hugging Face の API を操作するために作成されました。  
基本的には、Hugging Face のさまざまなエンドポイントに対する HTTP 呼び出しをカプセル化しています。  

例:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

このコマンドは、ユーザー rrg92 の space diffusers-labs に関するさまざまな情報を含むオブジェクトを返します。  
これは Gradio space なので、他の cmdlet と接続できます (GradioSession cmdlet は、`Get-HuggingFaceSpace` から返されるオブジェクトが渡されると、それを認識します)。

```
# space に接続します (自動的に Gradio セッションが作成されます)。
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

# デフォルト
Set-GradioSession -Default $diff

# 関数をいくつか作成します。
New-GradioSessionApiProxyFunction

# 呼び出します。
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**重要: 特定の space にアクセスするには、認証が必要な場合があります。その場合は、`Set-HuggingFaceToken` を使用してアクセストークンを指定する必要があります。**




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
