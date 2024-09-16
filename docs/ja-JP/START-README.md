![PowerShell ギャラリーバージョン](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell ギャラリーダウンロード](https://img.shields.io/powershellgallery/dt/powershai)
![X（旧Twitter）フォロー](https://img.shields.io/twitter/follow/iatalking)
![YouTube チャンネル登録者数](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube チャンネル視聴回数](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [英語](docs/en-US/START-README.md)
* [フランス語](docs/fr-FR/START-README.md)
* [日本語](docs/ja-JP/START-README.md)
* [アラビア語](docs/sa-SA/START-README.md)

PowershAI（PowerShell + AI）は、PowerShell に直接 AI サービスを統合するモジュールです。  
コマンドは、スクリプトとコマンドラインの両方で呼び出すことができます。  

LLM との対話、Hugging Face、Gradio などのスペースの呼び出しなど、さまざまなコマンドがあります。  
GPT-4o-mini、gemini flash、llama 3.1 などと、これらのサービスの独自のトークンを使用してチャットできます。  
つまり、PowershAI を使用する際に、これらのサービスを使用するために通常かかるコスト以外に、追加料金は発生しません。  

このモジュールは、PowerShell コマンドを好きな LLM と統合したり、呼び出し、POC などをテストしたりするのに最適です。  
PowerShell に慣れているユーザーが、AI を自分のスクリプトに簡単に統合したい場合に最適です！

次の例は、Powershai を一般的な状況でどのように使用できるかを示しています。

## Windows ログの分析 
```powershell 
import-module powershai 

Set-OpenaiToken # OpenAI のトークンを設定します（1 回のみ必要です）
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "重要なイベントはありますか？"
```

## サービスの説明 
```powershell 
import-module powershai 

Set-GoogleApiKey # Google Gemini のトークンを設定します（1 回のみ必要です）
Set-AiProvider google

Get-Service | ia "Windows 固有ではないサービスで、リスクとなる可能性のあるサービスの概要を作成してください"
```

## git コミットの説明 
```powershell 
import-module powershai 

Set-MaritalkToken # Maritaca.AI（ブラジルの LLM）のトークンを設定します
Set-AiProvider maritalk

git log --oneline | ia "これらのコミットの概要を作成してください"
```


上記の例は、PowerShell で AI を使用し、ほぼあらゆるコマンドと統合するのがいかに簡単かを示すほんの一例です。
[ドキュメントでさらに詳しく調べる](docs/pt-BR)

## インストール

すべての機能は `powershai` ディレクトリにあり、これは PowerShell モジュールです。  
最も簡単なインストール方法は、`Install-Module` コマンドを使用することです。

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

インストール後、セッションにインポートするだけです。

```powershell
import-module powershai

# 使用可能なコマンドを確認
Get-Command -mo powershai
```

このプロジェクトを直接クローンして、`powershai` ディレクトリをインポートすることもできます。

```powershell
cd CAMINHO

# クローン
git clone ...

# 特定のパスからインポート！
Import-Module .\powershai
```

## 探索と貢献

PowershAI はまだ多くのドキュメント化と進化が必要です！  
改善を加えるにつれて、コードにコメントを残し、私のやり方を学びたい方の助けになるようにします！  
ご自由に探索して、改善の提案を共有してください。

## その他の PowerShell プロジェクト

ここでは、AI と PowerShell を統合した興味深い他のプロジェクトをいくつか紹介します。

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

探索、学習、貢献しましょう！




<!--PowershaiAiDocBlockStart-->
_PowershAI および AI を使用して自動翻訳されました。_
<!--PowershaiAiDocBlockEnd-->
