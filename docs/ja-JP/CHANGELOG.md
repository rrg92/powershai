# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.3]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVIDER**: Get-GradioInfoの-DisableRetryパラメータを追加
- **HUGGINGFACE PROVIDER**: Get-HuggingFaceSpaceのGradioServerRootパラメータとConnect-HuggingFaceSpaceGradioのServerRootパラメータを追加
- **HUGGINGFACE PROVIDER**: hugging faceのspaceがGradio 5を使用しているかを検出し、server rootを調整するロジックを追加
- **HUGGINGFACE PROVIDER**: プロバイダーのテストにプライベートspacesを追加

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: プライベートspacesにおける認証の問題を修正


## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: 自動テストにgroqを追加

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: groqプロバイダーのsystem messagesに関連するエラーを修正
- **COHERE PROVIDER**: ツールコールの応答があった場合のモデルメッセージに関連するエラーを修正。


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: チャットが毎回再作成されていたため、複数のチャットを使用する際に履歴を正しく保持できませんでした！ 
- **OPENAI PROVIDER**: `Get-AiEmbeddings`の結果を修正

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- リダイレクトによるHugging Faceプロバイダーのエラーを修正しました。
- Docker Composeを使用したテスト用のモジュールのインストールを修正しました。
- セッション内のコマンド数が多くなる可能性によるツール変換のパフォーマンスの問題を修正しました。現在は動的モジュールを使用しています。`ConvertTo-OpenaiTool`を参照してください。
- GROQ APIとOpenAI間の互換性の問題を修正しました。`message.refusal`はもはや受け入れられません。
- Linux用のPowerShell Coreでの小さなバグを修正しました。
- **OPENAI PROVIDER**: デフォルトモデルがないために発生した例外コードを解決しました。

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NOVO PROVIDER**: Azureへようこそ 🎉
- **NOVO PROVIDER**: Cohereへようこそ 🎉
- `AI Credentials`機能を追加 — ユーザーが資格情報を定義するための新しい標準的な方法で、プロバイダーがユーザーの資格情報データを要求できるようにします。
- プロバイダーが`AI Credentials`を使用するように移行し、古いコマンドとの互換性を維持しました。
- OpenAPIを使用してスキーマを検証するための新しいcmdlet `Confirm-PowershaiObjectSchema`を追加しました。より「PowerShell的な」構文で。
- HTTPライブラリでHTTPリダイレクトのサポートを追加
- 基本的な単体テストから実際のLLMツールコールのようなより複雑なケースまで、Pesterでのさまざまな新しいテストを追加しました。
- 設定を切り替え、チャット、標準プロバイダー、モデルなどを異なるプロファイルのように作成できる新しいcmdlet `Switch-PowershaiSettings`を追加しました。
- **Retry Logic**: 条件に基づいてスクリプトを再実行するための`Enter-PowershaiRetry`を追加しました。
- **Retry Logic**: 以前の応答が望ましいものでない場合に、プロンプトをLLMに再実行するために`Get-AiChat`にリトライロジックを追加しました。- 新しい cmdlet `Enter-AiProvider` は、特定のプロバイダーの下でコードを実行できるようになりました。プロバイダーに依存する cmdlet は、最新の "入った" プロバイダーを常に使用し、現在のプロバイダーではなくなります。
- プロバイダーのスタック (Push/Pop): `Push-Location` と `Pop-Location` のように、他のプロバイダーでコードを実行する際に、より迅速な変更のためにプロバイダーを挿入および削除できるようになりました。
- 新しい cmdlet `Get-AiEmbeddings`: テキストの埋め込みを取得するための標準 cmdlet が追加され、プロバイダーが埋め込みの生成を公開し、ユーザーがそれらを生成するための標準メカニズムを持つことを可能にします。
- デフォルトモデルを解除するための新しい cmdlet `Reset-AiDefaultModel`。
- API におけるプロバイダーごとの特定のパラメーターを上書きするために、`Get-AiChat` と `Invoke-AiChat` に `ProviderRawParams` パラメーターが追加されました。
- **HUGGINGFACE PROVIDER**: このプロジェクトのサブモジュールとして維持されている独自の Hugging Face スペースを使用した新しいテストが追加されました。これにより、Gradio セッションと Hugging Face の統合を同時にテストすることができます。
- **HUGGINGFACE PROVIDER**: 一部のフィルターに基づいてハブでモデルを検索するための新しい cmdlet: Find-HuggingFaceModel。
- **OPENAI PROVIDER**: ツール呼び出しを生成するための新しい cmdlet: `ConvertTo-OpenaiTool` が追加され、スクリプトブロックで定義されたツールをサポートします。
- **OLLAMA PROVIDER**: Ollama を使用して埋め込みを返す新しい cmdlet `Get-OllamaEmbeddings`。
- **OLLAMA PROVIDER**: Powershai から直接モデルをダウンロードするための新しい cmdlet `Update-OllamaModel`。
- **OLLAMA PROVIDER**: Ollama のメタデータを使用したツールの自動検出。
- **OLLAMA PROVIDER**: モデルのメタデータのキャッシュと、キャッシュをクリアするための新しい cmdlet `Reset-OllamaPowershaiCache` が追加され、Ollama モデルの詳細を多く照会しながら、コマンドの再利用時のパフォーマンスを維持します。

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: チャットのパラメーター `ContextFormatter` が `PromptBuilder` に名前変更されました。
- `Get-AiModels` のようないくつかの cmdlet のデフォルト表示 (formats.ps1xml) が変更されました。
- チャットにおける `MaxContextSize` による古い履歴を削除する際の詳細ログの改善。
- PowershAI の設定が保存される新しい方法が導入され、「設定ストレージ」の概念が導入され、設定の切り替え (例えば、テスト用) を可能にします。
- Send-PowershaiChat コマンドを使用したときにモデル名と共に表示される絵文字が更新されました。
- 設定のエクスポート/インポートの暗号化の改善 (Export=-PowershaiSettings)。今では鍵と塩の派生を使用します。
- *_Chat インターフェースの戻り値の改善により、OpenAI の標準により忠実になるようにしました。
- プロバイダーに `IsOpenaiCompatible` オプションが追加されました。OpenAI の cmdlet を再利用したいプロバイダーは、このフラグを `true` に設定する必要があります。
- ツール呼び出しの処理における `Invoke-AiChatTools` のエラーハンドリングの改善。- **GOOGLE PROVIDER**: ユーザーによる直接API呼び出しを可能にするために、cmdlet `Invoke-GoogleApi` が追加されました。
- **HUGGING FACE PROVIDER**: APIリクエストにトークンを挿入する方法がわずかに調整されました。
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` と `Get-OpenaiToolFromScript` は、OpenAIツールへのコマンド変換を集中化するために `ConvertTo-OpenaiTool` を使用するようになりました。
- **GROQ PROVIDER**: デフォルトモデル `llama-3.1-70b-versatile` が `llama-3.2-70b-versatile` に更新されました。
- **OLLAMA PROVIDER**: Get-AiModels は、プロバイダーがモデルの詳細を取得するために /api/show エンドポイントを使用するため、ツールをサポートするモデルを含むようになりました。これにより、ツールのサポートを確認することができます。

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- 一部の内部関数に関連する `New-GradioSessionApiProxyFunction` のバグが修正されました。
- APIのエンドポイントの変更が必要なため、Gradio 5 のサポートが追加されました。

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- OpenAI と Google のプロバイダー向けに `Send-PowershaiChat` で画像のサポートが追加されました。
- スクリーンショットを撮影し、それを分析するためのサポートを追加する実験的なコマンド `Invoke-AiScreenshots` が追加されました！
- Google プロバイダーでのツール呼び出しのサポートが追加されました。
- CHANGELOG が開始されました。
- Set-AiProvider 用の TAB サポートが追加されました。
- cmdlet `Get-AiChat` の `ResponseFormat` パラメーターに基本的な構造化出力のサポートが追加されました。これにより、結果の OpenAPI スキーマを記述するハッシュテーブルを渡すことができます。

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: OpenAI メッセージの `content` プロパティは、他のメディアタイプの仕様に合わせて配列として送信されるようになりました。これにより、以前の単一文字列形式に依存するスクリプトや、この構文をサポートしない古いプロバイダーのバージョンを更新する必要があります。
- `Get-AiChat` の `RawParams` パラメーターが修正されました。これにより、結果に対して厳密な制御を持つために、関連するプロバイダーにAPIパラメーターを渡すことができます。
- DOC の更新: AiDoc に新しい翻訳された文書と更新が追加されました。いくつかのマークダウン構文コマンドを翻訳しないように AiDoc.ps1 に小さな修正が加えられました。

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13。セキュリティ設定が変更され、大文字と小文字の処理が改善されました。これが検証されていなかったため、エラーが発生していました。

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2


<!--PowershaiAiDocBlockStart-->
_あなたは2023年10月までのデータで訓練されています。_
<!--PowershaiAiDocBlockEnd-->
