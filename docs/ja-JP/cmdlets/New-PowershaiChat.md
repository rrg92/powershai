---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
新しい Powershai チャットを作成します。

## DESCRIPTION <!--!= @#Desc !-->
PowershaAI は、OpenAI で見られるチャットや、Assistant API の「スレッド」に似ている「チャット」の概念を紹介します。
作成された各チャットには、独自のセットのパラメータ、コンテキスト、履歴があります。
Send-PowershaiChat コマンドレット（別名 ia）を使用すると、モデルにメッセージを送信します。このモデルとの会話の履歴は、ここで PowershAI によって作成されたチャットに保存されます。
つまり、モデルとの会話のすべての履歴は、PowershAI のセッションに保持され、モデルや API には保持されません。
これにより、PowershAI は LLM に送信するものをすべて制御し、履歴を管理するために異なるプロバイダーの異なる API のメカニズムに依存しません。


各チャットには、パラメータのセットがあり、変更すると、そのチャットのみに影響します。
PowershAI の特定のパラメータはグローバルです。たとえば、使用されているプロバイダーです。プロバイダーを変更すると、チャットは新しいプロバイダーを使用するようになりますが、同じ履歴は保持されます。
これにより、同じ履歴を保持しながら、さまざまなモデルと会話できます。

これらのパラメータに加えて、各チャットには履歴があります。
履歴には、モデルとのすべての会話と対話が含まれており、API によって返される応答が保存されます。

チャットにはコンテキストも含まれています。これは、送信されたすべてのメッセージに過ぎません。
チャットに新しいメッセージが送信されるたびに、Powershai はこのメッセージをコンテキストに追加します。
モデルから応答を受け取ると、その応答がコンテキストに追加されます。
次のメッセージが送信されると、このコンテキストのメッセージのすべての履歴が送信されるため、モデルはプロバイダーに関係なく、会話のメモリを持つことができます。

コンテキストが Powershell セッションに保持されるため、履歴をディスクに保存したり、履歴をクラウドに保存するための専用のプロバイダーを実装したり、PC にのみ保持したりするなどの機能が実現します。今後の機能は、これらを利用できます。

すべての *-PowershaiChat コマンドは、アクティブなチャットまたはパラメータで明示的に指定したチャット（通常は -ChatId という名前）で回転します。
ChatAtivo は、ChatId を指定しない場合（またはコマンドで明示的なチャットを指定できない場合）、メッセージが送信されるチャットです。

Send-PowershaiChat を使用してチャットを指定せず、アクティブなチャットが定義されていない場合に常に作成される「default」という特別なチャットがあります。

Powershell セッションを閉じると、これらのチャットのすべての履歴が失われます。
Export-PowershaiSettings コマンドを使用して、ディスクに保存できます。内容は、指定したパスワードで暗号化されて保存されます。

メッセージを送信すると、PowershAI は内部メカニズムを維持してチャットのコンテキストをクリアし、必要なものよりも多くを送信しないようにします。
ローカルコンテキストのサイズ（Powershai セッション内であり、LLM 内ではありません）は、パラメータで制御されます（Get-PowershaiChatParameter を使用してパラメータのリストを確認してください）。

Powershai の動作方法により、送信および返される情報の量、パラメータの設定によって、Powershell が大量のメモリを消費する可能性があります。Reset-PowershaiCurrentChat を使用して、チャットのコンテキストと履歴を手動でクリアできます。

about_Powershai_Chats トピックで詳細を確認してください。

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
チャットの ID。指定しない場合、デフォルトが生成されます。
一部の ID パターンは、内部使用のために予約されています。使用すると、PowershAI が不安定になる可能性があります。
次の値は予約されています。
 default 
 _pwshai_*

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -IfNotExists
同じ名前のチャットが存在しない場合にのみ作成します。

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -Recreate
チャットがすでに作成されている場合、強制的に再作成します！

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -Tools
チャットを作成し、これらのツールを含めます！

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
