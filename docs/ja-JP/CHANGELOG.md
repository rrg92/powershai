# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: 自動テストに groq を追加しました

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: groq プロバイダーのシステムメッセージ関連のエラーを修正しました
- **COHERE PROVIDER**: ツール呼び出しの応答があった場合のモデルメッセージ関連のエラーを修正しました


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: 複数のチャットを使用する際に履歴が正しく保持されない、チャットが毎回再作成される問題を修正しました
- **OPENAI PROVIDER**: `Get-AiEmbeddings` の結果を修正しました

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- リダイレクトによる Hugging Face プロバイダーのエラーを修正しました。
- Docker Compose を使用したテスト用モジュールのインストールを修正しました。
- セッション内のコマンド数が多いために発生する可能性のある、ツール変換のパフォーマンスの問題を修正しました。現在は動的モジュールを使用しています。 `ConvertTo-OpenaiTool` を参照してください。
- GROQ API と OpenAI の間の非互換性の問題を修正しました。 `message.refusal` は受け入れられなくなりました。
- Linux 用 PowerShell Core の小さなバグを修正しました。
- **OPENAI PROVIDER**: デフォルトモデルがないことによる例外コードを解決しました。

### Added <!--AiDoc:Translator:IgnoreLine-->
- **新しいプロバイダー**: Azure へようこそ 🎉
- **新しいプロバイダー**: Cohere へようこそ 🎉
- `AI Credentials` 機能を追加しました。これは、ユーザーが資格情報を定義するための新しい標準的な方法であり、プロバイダーがユーザーに資格情報のデータの入力を要求できるようにします。
- プロバイダーを `AI Credentials` を使用するように移行しましたが、以前のコマンドとの互換性は維持されています。
- 新しいコマンドレット `Confirm-PowershaiObjectSchema` を追加しました。これにより、より「PowerShell 的な」構文を使用して OpenAPI でスキーマを検証できます。
- HTTP lib で HTTP リダイレクトのサポートを追加しました
- Pester を使用した新しいテストを多数追加しました。基本的な単体テストから、実際の LLM ツール呼び出しなどのより複雑なケースまで多岐にわたります。
- 新しいコマンドレット `Switch-PowershaiSettings` を使用すると、設定を切り替え、チャット、デフォルトプロバイダー、モデルなどを個別のプロファイルのように作成できます。
- **再試行ロジック**: 条件に基づいてスクリプトを再実行するための `Enter-PowershaiRetry` を追加しました。
- **再試行ロジック**: 前回の応答が望ましいものでない場合に LLM にプロンプトを簡単に再実行できるように、`Get-AiChat` に再試行ロジックを追加しました。
- 新しいコマンドレット `Enter-AiProvider` を使用すると、特定のプロバイダーでコードを実行できるようになりました。プロバイダーに依存するコマンドレットは、現在のプロバイダーではなく、「入力された」最新のプロバイダーを常に使用します。
- プロバイダーのスタック (プッシュ/ポップ): `Push-Location` や `Pop-Location` と同様に、別のプロバイダーでコードを実行する際に、より迅速に変更するためにプロバイダーを挿入および削除できるようになりました。
- 新しいコマンドレット `Get-AiEmbeddings`: テキストの埋め込みを取得するための標準コマンドレットを追加しました。これにより、プロバイダーは埋め込み生成を公開し、ユーザーは埋め込みを生成するための標準メカニズムを利用できます。
- デフォルトモデルの選択を解除するための新しいコマンドレット `Reset-AiDefaultModel`。
- `Get-AiChat` と `Invoke-AiChat` に `ProviderRawParams` パラメーターを追加しました。これにより、プロバイダーごとに API 特有のパラメーターを上書きできます。
- **HUGGINGFACE PROVIDER**: このプロジェクトのサブモジュールとして維持されている実際の専用の Hugging Face スペースを使用して、新しいテストを追加しました。これにより、Gradio セッションや Hugging Face 統合など、複数の側面を同時にテストできます。
- **HUGGINGFACE PROVIDER**: 新しいコマンドレット: Find-HuggingFaceModel。いくつかのフィルターに基づいてハブでモデルを検索できます。
- **OPENAI PROVIDER**: ツール呼び出しを生成するための新しいコマンドレット `ConvertTo-OpenaiTool` を追加しました。スクリプトブロックで定義されたツールをサポートしています。
- **OLLAMA PROVIDER**: Ollama を使用して埋め込みを返す新しいコマンドレット `Get-OllamaEmbeddings`。
- **OLLAMA PROVIDER**: powershai から直接 ollama モデルをダウンロード (プル) するための新しいコマンドレット `Update-OllamaModel`。
- **OLLAMA PROVIDER**: ollama のメタデータを使用したツールの自動検出
- **OLLAMA PROVIDER**: モデルメタデータのキャッシュと、キャッシュをクリアするための新しいコマンドレット `Reset-OllamaPowershaiCache`。これにより、ollama モデルの多くの詳細を照会しながら、コマンドの繰り返し使用に対するパフォーマンスを維持できます。

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **破壊的変更**: チャットの `ContextFormatter` パラメーターの名前が `PromptBuilder` に変更されました。
- `Get-AiModels` などの一部のコマンドレットのデフォルト表示 (formats.ps1xml) を変更しました。
- チャットの `MaxContextSize` による古い履歴の削除に関する詳細ログの改善。
- PowershAI 設定の新しい保存方法。「設定ストレージ」の概念を導入し、設定の切り替え (例: テスト用) を可能にしました。
- Send-PowershaiChat コマンドを使用した場合にモデル名とともに表示される絵文字を更新しました
- 設定のエクスポート/インポート (Export=-PowershaiSettings) の暗号化を改善しました。キーとソルトの派生として使用されるようになりました。
- *_Chat インターフェースの戻り値を改善し、OpenAI の標準により忠実になりました。
- プロバイダーに `IsOpenaiCompatible` オプションを追加しました。OpenAI コマンドレットを再利用するプロバイダーは、正しく機能するようにこのフラグを `true` に設定する必要があります。
- ツール呼び出しの処理における `Invoke-AiChatTools` のエラー処理を改善しました。
- **GOOGLE PROVIDER**: ユーザーが API を直接呼び出せるように `Invoke-GoogleApi` コマンドレットを追加しました。
- **HUGGING FACE PROVIDER**: API リクエストへのトークンの挿入方法を微調整しました。
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` と `Get-OpenaiToolFromScript` は、コマンドから OpenAI ツールへの変換を一元化するために `ConvertTo-OpenaiTool` を使用するようになりました。
- **GROQ PROVIDER**: デフォルトモデルを `llama-3.1-70b-versatile` から `llama-3.2-70b-versatile` に更新しました。
- **OLLAMA PROVIDER**: Get-AiModels にツールをサポートするモデルが含まれるようになりました。プロバイダーは /api/show エンドポイントを使用してモデルの詳細を取得するため、ツールサポートを確認できます。

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- `New-GradioSessionApiProxyFunction` 関数の、いくつかの内部関数に関連するバグを修正しました。
- API エンドポイントの変更により必要になった Gradio 5 のサポートを追加しました

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- OpenAI プロバイダーと Google プロバイダーの `Send-PowershaiChat` での画像のサポート。
- スクリーンショットを撮って分析するための実験的なコマンド `Invoke-AiScreenshots`。
- Google プロバイダーでのツール呼び出しのサポート。
- CHANGELOG を開始しました。
- Set-AiProvider での TAB サポート。
- `Get-AiChat` コマンドレットの `ResponseFormat` パラメーターに構造化出力の基本的なサポートを追加しました。これにより、結果の OpenAPI スキーマを記述するハッシュテーブルを渡すことができます。

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **破壊的変更**: OpenAI メッセージの `content` プロパティは、他のメディアタイプに合わせて配列として送信されるようになりました。以前の単一文字列形式と、この構文をサポートしていない古いバージョンのプロバイダーに依存するスクリプトを更新する必要があります。
- `Get-AiChat` の `RawParams` パラメーターを修正しました。結果を厳密に制御するために、API パラメーターを該当するプロバイダーに渡すことができるようになりました
- ドキュメントの更新: AiDoc で翻訳された新しいドキュメントと更新。AiDoc.ps1 の小さな修正。一部の markdown 構文コマンドを翻訳しないようにしました。


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- #13 を修正。セキュリティ設定が変更され、大文字と小文字の区別が改善されました。これは検証されていなかったため、エラーが発生していました。

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2



<!--PowershaiAiDocBlockStart-->
_PowerShellとAIを使用して自動翻訳されています。_
<!--PowershaiAiDocBlockEnd-->
