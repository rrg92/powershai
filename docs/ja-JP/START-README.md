![PowerShell ギャラリーバージョン](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell ギャラリーダウンロード](https://img.shields.io/powershellgallery/dt/powershai)
![X (旧Twitter)フォロー](https://img.shields.io/twitter/follow/iatalking)
![YouTube チャンネル登録者数](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)
![YouTube チャンネル視聴回数](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)


# PowershAI

* [英語](/docs/en-US/START-README.md)
* [フランス語](/docs/fr-FR/START-README.md)
* [日本語](/docs/ja-JP/START-README.md)
* [アラビア語](/docs/ar-SA/START-README.md)
* [ドイツ語](/docs/de-DE/START-README.md)
* [スペイン語](/docs/es-ES/START-README.md)
* [ヘブライ語](/docs/he-IL/START-README.md)
* [イタリア語](/docs/it-IT/START-README.md)

PowershAI (PowerShell + AI) は、PowerShell に直接 AI サービスを統合するモジュールです。  
コマンドは、スクリプトでもコマンドラインでも呼び出すことができます。  

LLM との会話、Hugging Face、Gradio などのスペースの呼び出しを可能にするさまざまなコマンドがあります。  
独自のトークンを使用して、GPT-4o-mini、gemini flash、llama 3.1 などのサービスと対話できます。  
つまり、PowershAI を使用する際に、これらのサービスを使用する際に発生する通常のコスト以外には、追加料金はかかりません。  

このモジュールは、お気に入りの LLM で PowerShell コマンドを統合し、呼び出し、POC などをテストするのに最適です。  
PowerShell に慣れているユーザーで、より簡単かつスムーズにスクリプトに AI を導入したいユーザーに最適です。

次の例は、一般的な状況で Powershai を使用する方法を示しています。

## Windows ログの分析 
```powershell 
import-module powershai 

Set-OpenaiToken # OpenAI のトークンを設定します (1 回のみ必要です)
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "重要なイベントはありますか？"
```

## サービスの説明 
```powershell 
import-module powershai 

Set-GoogleApiKey # Google Gemini のトークンを設定します (1 回のみ必要です)
Set-AiProvider google

Get-Service | ia "Windows にネイティブではないサービスで、リスクになる可能性のあるサービスを要約してください"
```

## Git コミットの説明 
```powershell 
import-module powershai 

Set-MaritalkToken # Maritaca.AI (ブラジルの LLM) のトークンを設定します
Set-AiProvider maritalk

git log --oneline | ia "これらのコミットの要約を作成してください"
```


上記の例は、Powershell で AI を使用し、ほぼすべてのコマンドと統合する方法の簡単なデモに過ぎません。
[完全なドキュメントでさらに詳しく](/docs/ja-JP)

## インストール

すべての機能は、PowerShell モジュールである `powershai` ディレクトリにあります。  
最も簡単なインストール方法は、`Install-Module` コマンドを使用することです。

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

インストールしたら、セッションにインポートするだけです。

```powershell
import-module powershai

# 使用可能なコマンドを表示します
Get-Command -mo powershai
```

このプロジェクトを直接クローンして、powershai ディレクトリをインポートすることもできます。

```powershell
cd CAMINHO

# クローン
git clone ...

# 特定のパスからインポートします！
Import-Module .\powershai
```

## 探索と貢献

PowershAI には、まだドキュメント化されていないものや進化の余地が多数あります。  
改善を行うにつれて、コードにコメントを追加して、私のやり方を学びたい人の助けになるようにしています。  
ご自由に探索し、改善の提案をご提供ください。

## その他の PowerShell プロジェクト

以下は、PowerShell と AI を統合した興味深いプロジェクトです。

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

探索、学習、そして貢献しましょう！




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳しました。_
<!--PowershaiAiDocBlockEnd-->
