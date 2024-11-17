![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/powershai)  
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/powershai)  
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/iatalking)  
![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCtNVhWslzx_yjbIX8JIYang)  
![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCtNVhWslzx_yjbIX8JIYang)  


# PowershAI

* [english](/docs/en-US/START-README.md)  
* [Français](/docs/fr-FR/START-README.md)  
* [日本語](/docs/ja-JP/START-README.md)  
* [العربية](/docs/ar-SA/START-README.md)  
* [Deutsch](/docs/de-DE/START-README.md)  
* [español](/docs/es-ES/START-README.md)  
* [עברית](/docs/he-IL/START-README.md)  
* [italiano](/docs/it-IT/START-README.md)  

PowershAI (PowerShell + AI) は、PowerShell に直接 AI サービスを統合するモジュールです。  
スクリプトやコマンドラインの両方でコマンドを呼び出すことができます。  

LLM と会話を行い、Hugging Face、Gradio などのスペースを呼び出すことができるコマンドがいくつかあります。  
独自のトークンを使用して、GPT-4o-mini、gemini flash、llama 3.1 などと会話できます。  
つまり、PowershAI を使用するために支払う必要があるのは、これらのサービスを通常使用する際に発生するコストのみです。  

このモジュールは、好きな LLM と PowerShell コマンドを統合し、呼び出しや POC をテストするのに最適です。  
PowerShell に慣れていて、より簡単で簡単な方法でスクリプトに AI を取り入れたい人に最適です！  

> [!IMPORTANT]  
> これは OpenAI、Google、Microsoft の公式モジュールではなく、ここにリストされている他のプロバイダーのものでもありません！  
> このプロジェクトは個人的なイニシアチブであり、オープンソースコミュニティによって維持されることを目的としています。  


以下の例は、一般的な状況で PowershAI を使用する方法を示しています。  

## Windows のログ分析  
```powershell  
import-module powershai  

Set-OpenaiToken # OpenAI のトークンを設定します (これを 1 回だけ行う必要があります)  
Set-AiProvider openai  

Get-WinEvent -LogName Application,System -MaxEvents 500 | ia "重要なイベントはありますか？"  
```  

## サービスの説明  
```powershell  
import-module powershai  

Set-GoogleApiKey # Google Gemini のトークンを設定します (これを 1 回だけ行う必要があります)  
Set-AiProvider google  

Get-Service | ia "Windows のネイティブではないサービスの要約を作成し、リスクを示してください"  
```  

## Git のコミットの説明  
```powershell  
import-module powershai  

Set-MaritalkToken # Maritaca.AI (ブラジルの LLM) のトークンを設定します  
Set-AiProvider maritalk  

git log --oneline | ia "これらのコミットの要約を作成してください"  
```  


上記の例は、Powershell で AI を使用し、ほぼすべてのコマンドと統合を開始するのがどれほど簡単かを示す小さなデモに過ぎません！  
[完全なドキュメントでさらに探索する](/docs/ja-JP)  

## インストール  

すべての機能は `powershai` ディレクトリにあり、これは PowerShell モジュールです。  
最も簡単なインストールオプションは、`Install-Module` コマンドを使用することです:  

```powershell  
Install-Module -Name powershai -Scope CurrentUser  
```  

インストール後、セッションにインポートするだけです:  

```powershell  
import-module powershai  

# 利用可能なコマンドを表示  
Get-Command -mo powershai  
```  

このプロジェクトを直接クローンし、powershai ディレクトリをインポートすることもできます:  

```powershell  
cd パス  

# クローンする  
git clone ...  

# 特定のパスからインポート!  
Import-Module .\powershai  
```  

## 探索と貢献  

PowershAI にはまだ文書化と進化が必要なことがたくさんあります！  
改善を行うたびに、私がどのように行ったかを学びたい人のためにコードにコメントを残します！  
探索し、改善の提案に貢献することを自由に行ってください。  

## PowerShell を使用した他のプロジェクト  

AI と PowerShell を統合する他の興味深いプロジェクトは次のとおりです:  

- [PSAI](https://github.com/dfinke/PSAI)  
- [PSOpenAI](https://github.com/mkht/PSOpenAI)  
- [dbatools.ai](https://github.com/potatoqualitee/dbatools.ai)  

探索し、学び、貢献してください！


<!--PowershaiAiDocBlockStart-->
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
