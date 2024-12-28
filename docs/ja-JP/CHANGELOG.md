# 変更ログ

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- リダイレクトによるHugging Faceプロバイダーのエラーを修正しました。
- Docker Composeを使用したテスト用モジュールのインストールを修正しました。
- セッション内のコマンド数が多くなる可能性があるため、ツールの変換におけるパフォーマンスの問題を修正しました。現在、動的モジュールを使用しています。`ConvertTo-OpenaiTool`を参照してください。
- GROQ APIとOpenAIの間の非互換性の問題を修正しました。`message.refusal`はもはや受け入れられません。
- PowerShell Core for Linuxの小さなバグを修正しました。
- **OPENAIプロバイダー**: 標準モデルがないことによって発生する例外コードを解決しました。

### Added <!--AiDoc:Translator:IgnoreLine-->
- **新しいプロバイダー**: Azureへようこそ🎉
- **新しいプロバイダー**: Cohereへようこそ🎉
- `AI Credentials`機能を追加しました。これは、ユーザーが資格情報を定義するための新しい標準的な方法であり、プロバイダーがユーザーから資格情報データの要求を可能にします。
- 以前のコマンドとの互換性を維持しながら、プロバイダーを`AI Credentials`を使用するように移行しました。
- OpenAPIを使用してスキーマを検証するための、よりPowerShellらしい構文を持つ新しいコマンドレット`Confirm-PowershaiObjectSchema`を追加しました。
- HTTP libでHTTPリダイレクトのサポートを追加しました。
- 基本的な単体テストから、実際のLLMツールの呼び出しなどのより複雑なケースまで、Pesterを使用したさまざまな新しいテストを追加しました。
- 新しいコマンドレット`Switch-PowershaiSettings`により、設定を切り替え、チャット、標準プロバイダー、モデルなどを異なるプロファイルのように作成できます。
- **再試行ロジック**: 条件に基づいてスクリプトを再実行するための`Enter-PowershaiRetry`を追加しました。
- **再試行ロジック**: 前回の応答が望ましいものでない場合に、LLMにプロンプトを簡単に再実行できるように、`Get-AiChat`に再試行ロジックを追加しました。
- 新しいコマンドレット`Enter-AiProvider`により、特定のプロバイダーの下でコードを実行できるようになりました。プロバイダーに依存するコマンドレットは、現在のプロバイダーではなく、最後に「エントリ」されたプロバイダーを常に使用します。
- プロバイダースタック（Push/Pop）：`Push-Location`と`Pop-Location`と同様に、他のプロバイダーでコードを実行するときの迅速な変更のために、プロバイダーを挿入および削除できるようになりました。
- 新しいコマンドレット`Get-AiEmbeddings`：テキストの埋め込みを取得するための標準コマンドレットを追加しました。これにより、プロバイダーは埋め込みの生成を公開し、ユーザーは埋め込みを生成するための標準メカニズムを持つことができます。
- 標準モデルの選択を解除するための新しいコマンドレット`Reset-AiDefaultModel`を追加しました。
- プロバイダーごとにAPI固有のパラメーターを上書きするために、`Get-AiChat`と`Invoke-AiChat`に`ProviderRawParams`パラメーターを追加しました。
- **HUGGINGFACEプロバイダー**: このプロジェクトのサブモジュールとして維持されている実際の独自のHugging Face spaceを使用した新しいテストを追加しました。これにより、GradioセッションとHugging Faceの統合など、複数の側面を同時にテストできます。
- **OPENAIプロバイダー**: スクリプトブロックで定義されたツールをサポートする、ツールの呼び出しを生成するための新しいコマンドレット`ConvertTo-OpenaiTool`を追加しました。
- **OLLAMAプロバイダー**: Ollamaを使用して埋め込みを返す新しいコマンドレット`Get-OllamaEmbeddings`を追加しました。

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **破壊的変更**: チャットの`ContextFormatter`パラメーターの名前を`PromptBuilder`に変更しました。
- `Get-AiModels`など、いくつかのコマンドレットの標準表示（formats.ps1xml）を変更しました。
- チャットの`MaxContextSize`による古い履歴の削除時の詳細ログを改善しました。
- PowershAIの設定の保存方法を変更し、「設定の保存」という概念を導入しました。これにより、設定の切り替え（たとえば、テスト用）が可能になります。
- `Send-PowershaiChat`コマンドを使用する場合の、モデル名と一緒に表示される絵文字を更新しました。
- 設定のエクスポート/インポート（Export=-PowershaiSettings）の暗号化を改善しました。現在、キーとソルトの導出を使用しています。
- OpenAIの標準により忠実になるように、*_Chatインターフェースの戻り値を改善しました。
- プロバイダーに`IsOpenaiCompatible`オプションを追加しました。OpenAIコマンドレットを再利用したいプロバイダーは、正しく機能させるためにこのフラグを`true`に設定する必要があります。
- ツールの呼び出しの処理における`Invoke-AiChatTools`のエラー処理を改善しました。
- **GOOGLEプロバイダー**: ユーザーによる直接的なAPI呼び出しを可能にするコマンドレット`Invoke-GoogleApi`を追加しました。
- **HUGGING FACEプロバイダー**: APIリクエストへのトークンの挿入方法をわずかに調整しました。
- **OPENAIプロバイダー**: `Get-OpenaiToolFromCommand`と`Get-OpenaiToolFromScript`は、OpenAIツールへのコマンドの変換を一元化するために、現在`ConvertTo-OpenaiTool`を使用しています。
- **GROQプロバイダー**: 標準モデルを`llama-3.1-70b-versatile`から`llama-3.2-70b-versatile`に更新しました。

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- 内部関数に関連する`New-GradioSessionApiProxyFunction`関数のバグを修正しました。
- APIエンドポイントの変更により必要となったGradio 5のサポートを追加しました。

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- OpenAIおよびGoogleプロバイダーの`Send-PowershaiChat`での画像サポート。
- スクリーンショットを撮影して分析するための実験的なコマンド`Invoke-AiScreenshots`を追加しました！
- Googleプロバイダーでのツールの呼び出しのサポート。
- CHANGELOGを開始しました。
- Set-AiProviderへのTABサポート。
- コマンドレット`Get-AiChat`の`ResponseFormat`パラメーターへの基本的な構造化出力のサポートを追加しました。これにより、結果のOpenAPIスキーマを記述するハッシュテーブルを渡すことができます。

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **破壊的変更**: 他のメディアタイプに対する仕様に合わせるため、OpenAIメッセージの`content`プロパティは配列として送信されるようになりました。これには、以前の単一文字列形式に依存するスクリプトと、この構文をサポートしていない古いバージョンのプロバイダーの更新が必要です。
- `Get-AiChat`の`RawParams`パラメーターを修正しました。これで、結果を厳密に制御するために、関連するプロバイダーにAPIパラメーターを渡すことができます。
- ドキュメントの更新：AiDocによる新しい翻訳済みのドキュメントと更新。AiDoc.ps1の小さな修正で、一部のmarkdown構文コマンドは翻訳されません。

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- #13を修正しました。セキュリティ設定が変更され、大文字と小文字の処理が改善されました。これは検証されていなかったため、エラーが発生していました。

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0


<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳しました
_
<!--PowershaiAiDocBlockEnd-->
