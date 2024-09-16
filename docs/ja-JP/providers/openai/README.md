# OpenAI プロバイダー  

# 概要 <!--! @#Short --> 

これは PowershAI の OpenAI プロバイダーの公式ドキュメントです。

# 詳細  <!--! @#Long --> 

OpenAI プロバイダーは、OpenAI サービスと通信するためのすべてのコマンドを提供します。  
このプロバイダーの cmdltet は、Verbo-OpenaiNomes の形式です。  
このプロバイダーは、https://platform.openai.com/docs/api-reference に記載されているとおり、HTTP 呼び出しを実装します。

**注**: API のすべての機能がまだ実装されているわけではありません。


## 初期設定 

OpenAI プロバイダーを使用するには、基本的にプロバイダーを有効にしてトークンを設定する必要があります。  
OpenAI の Web サイトで API トークンを生成する必要があります。つまり、アカウントを作成してクレジットを入力する必要があります。  
詳細については、https://platform.openai.com/api-keys を参照してください。

これらの情報が揃ったら、次のコードを実行してプロバイダーを有効にすることができます。

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

バックグラウンドで実行している場合（対話型ではない場合）、トークンは `OPENAI_API_KEY` 環境変数を用いて設定できます。  

トークンが設定されると、Powershai のチャットを使用して呼び出すことができます。

```
ia "こんにちは、Powershai からあなたと話しています"
```

そしてもちろん、コマンドを直接呼び出すことができます。

```
Get-OpenaiChat -prompt "s: あなたは PowerShell に関する質問に答えるボットです","現在の時刻を表示するにはどうすればよいですか?"
```




* Set-AiProvider openai を使用します（デフォルトです）。
オプションで、代替 URL を渡すことができます。

* Set-OpenaiToken を使用してトークンを設定します！


## 内部

OpenAI は、高度で堅牢な AI サービスを数多く提供するだけでなく、PowershAI の標準化ガイドとしても重要なプロバイダーです。  
PowershAI で定義されているほとんどの標準は OpenAI の仕様に従っており、これは最も広く使用されているプロバイダーであり、OpenAI を基準にするのが一般的です。  


そして、他のプロバイダーが OpenAI に従うことが多いことから、このプロバイダーはコードの再利用にも適しています。  
OpenAI と同じ仕様を使用する新しいプロバイダーを作成するのは非常に簡単で、設定変数をいくつか定義するだけです。






<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
