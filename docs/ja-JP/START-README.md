![PowerShell ギャラリー バージョン](https://img.shields.io/powershellgallery/v/powershai)
![PowerShell ギャラリー ダウンロード](https://img.shields.io/powershellgallery/dt/powershai)
![X (旧Twitter) フォロー](https://img.shields.io/twitter/follow/iatalking)
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
コマンドは、スクリプト内でもコマンドラインでも呼び出すことができます。  

LLM との会話、Hugging Face や Gradio などのスペースの呼び出しなど、さまざまなコマンドがあります。  
GPT-4o-mini、gemini flash、llama 3.1 などの LLM と、これらのサービスの独自のトークンを使用して会話できます。  
つまり、PowershAI の使用には、これらのサービスを使用する際の通常の費用以外、追加費用はかかりません。  

このモジュールは、PowerShell コマンドをお気に入りの LLM に統合したり、呼び出し、POC、その他のテストを行うのに最適です。  
PowerShell に慣れている方にとって、スクリプトに AI をより簡単かつ簡単に組み込むのに最適です！

以下の例は、PowershAI を一般的な状況でどのように使用できるかを示しています。

## Windows ログの分析
```powershell 
import-module powershai 

Set-OpenaiToken # OpenAI のトークンを設定します（1 回のみ行う必要があります）
Set-AiProvider openai 

 Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "重要なイベントはありますか？"
```

## サービスの説明
```powershell 
import-module powershai 

Set-GoogleApiKey # Google Gemini のトークンを設定します（1 回のみ行う必要があります）
Set-AiProvider google

Get-Service | ia "Windows 固有ではないサービスで、リスクとなる可能性のあるサービスの概要を示してください"
```

## Git コミットの説明
```powershell 
import-module powershai 

Set-MaritalkToken # Maritaca.AI（ブラジルの LLM）のトークンを設定します
Set-AiProvider maritalk

git log --oneline | ia "これらのコミットの概要を示してください"
```


上記の例は、PowerShell で AI を使用し、ほぼすべてのコマンドと統合するのがいかに簡単かを示すほんの一例です。
[ドキュメントで詳しく調べる](docs/pt-BR)

## インストール

すべての機能は、PowerShell モジュールである `powershai` ディレクトリにあります。  
最も簡単なインストール方法は、`Install-Module` コマンドを使用することです。

```powershell
Install-Module -Name powershai -Scope CurrentUser
```

インストール後、セッションにインポートするだけです。

```powershell
import-module powershai

# 使用可能なコマンドを確認します
Get-Command -mo powershai
```

このプロジェクトを直接クローンして、`powershai` ディレクトリをインポートすることもできます。

```powershell
cd CAMINHO

# クローン
git clone ...

# 特定のパスからインポートします！
Import-Module .\powershai
```

## 探索と貢献

PowershAI には、まだドキュメント化されていない機能や進化の余地が数多くあります！  
改善を進めるにつれて、コードにコメントを残して、私と同じように学習したい人のために役立つ情報を提供しています！  
ご自由に探索して、改善のための提案を提供してください。

## PowerShell を使用したその他のプロジェクト

以下は、PowerShell を AI と統合した、興味深い他のプロジェクトです。

- [PSAI](https://github.com/dfinke/PSAI)
- [PSOpenAI](https://github.com/mkht/PSOpenAI)
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)

探索、学習、貢献しましょう！




<!--PowershaiAiDocBlockStart-->
_PowershAI と AI を使用して自動的に翻訳された。_
<!--PowershaiAiDocBlockEnd-->
