![PowerShell ギャラリー バージョン](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell ギャラリー ダウンロード](https://img.shields.io/powershellgallery/dt/powershai)
![X (旧 Twitter) フォロー](https://img.shields.io/twitter/follow/iatalking)
![YouTube チャンネル登録者数](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube チャンネル視聴回数](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [英語](docs/en-US/START-README.md)
* [フランス語](docs/fr-FR/START-README.md)
* [日本語](docs/ja-JP/START-README.md)
* [アラビア語](docs/ar-SA/START-README.md)
* [ドイツ語](docs/de-DE/START-README.md)
* [スペイン語](docs/es-ES/START-README.md)
* [ヘブライ語](docs/he-IL/START-README.md)
* [イタリア語](docs/it-IT/START-README.md)

PowershAI (PowerShell + AI) は、PowerShell に直接 AI サービスを統合するモジュールです。
スクリプトでもコマンドラインでもコマンドを呼び出すことができます。

LLM との会話、Hugging Face、Gradio などのスペースの呼び出しなど、さまざまなコマンドがあります。
GPT-4o-mini、gemini flash、llama 3.1 などと、これらのサービスの独自のトークンを使用して会話することができます。
つまり、PowershAI を使用するために追加料金はかかりません。これらのサービスの使用に通常かかる費用以外はかかりません。

このモジュールは、お気に入りの LLM と PowerShell コマンドを統合したり、呼び出し、POC などをテストしたりするのに最適です。
PowerShell に慣れているユーザーが、より簡単で簡単な方法でスクリプトに AI を導入したい場合に最適です。

次の例では、Powershai を一般的な状況でどのように使用できるかを示します。

## Windows ログの分析
```powershell
import-module powershai 

Set-OpenaiToken # OpenAI 用のトークンを設定します (1 回のみ必要です)
Set-AiProvider openai 

Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "重要なイベントはありますか？"
```

## サービスの説明
```powershell
import-module powershai 

Set-GoogleApiKey # Google Gemini 用のトークンを設定します (1 回のみ必要です)
Set-AiProvider google

Get-Service | ia "Windows 標準ではないサービスで、リスクとなる可能性のあるサービスをまとめます。"
```

## git コミットの説明
```powershell
import-module powershai 

Set-MaritalkToken # Maritaca.AI (ブラジルの LLM) のトークンを設定します
Set-AiProvider maritalk

git log --oneline | ia "これらのコミットをまとめます。"
```


上記の例は、Powershell で AI を使用し、ほぼすべてのコマンドを統合するのがいかに簡単かを示すほんの一例です。
[ドキュメントで詳しく調べてください](docs/pt-BR)

## インストール

すべての機能は `powershai` ディレクトリにあり、これは PowerShell モジュールです。
最も簡単なインストール方法は、`Install-Module` コマンドを使用することです。

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

インストール後、セッションにインポートするだけです。

```powershell
import-module powershai

# 使用可能なコマンドを表示します
Get-Command -mo powershai
```

このプロジェクトを直接クローンし、`powershai` ディレクトリをインポートすることもできます。

```powershell
cd PATH

# クローンします
git clone ...

# 特定のパスからインポートします！
Import-Module .\powershai
```

## 探索と貢献

PowershAI は、まだドキュメント化されていない部分が多く、進化を続けています。
改善する際に、コードにコメントを付けて、私のやり方を学びたい人の助けとなるようにしています。
お気軽に探索し、改善の提案をしてください。

## PowerShell を使用したその他のプロジェクト

以下は、PowerShell と AI を統合した興味深いその他のプロジェクトです。

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

探索、学習、貢献しましょう！



<!--PowershaiAiDocBlockStart-->
_PowershAI e IA を使用して自動翻訳しました。_
<!--PowershaiAiDocBlockEnd-->
