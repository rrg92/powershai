---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
現在のチャット（またはデフォルトですべてのチャット）で、関数、スクリプト、実行可能ファイルを LLM から呼び出せるツールとして追加します。

## DESCRIPTION <!--!= @#Desc !-->
現在のセッションに、ツール呼び出しが許可されているツールの一覧に含まれる関数を追加します。
コマンドを追加すると、現在のモデルにツール呼び出しのオプションとして送信されます。
関数の使用可能なヘルプは、パラメーターを含めて説明するために使用されます。
これにより、実行時に、LLM によって呼び出され、PowershAI によって実行できる、新しい AI スキルを追加できます。

スクリプトを追加すると、スクリプト内のすべての関数が一度に追加されます。

ツールの詳細については、「about_Powershai_Chats」トピックを参照してください。

**非常に重要：**
**知らないコマンドや、コンピュータのセキュリティを損なう可能性のあるコマンドは** **決して追加しないでください。**
**Powershell は、LLM の要求に応じて、LLM によって呼び出されるパラメーターと、現在のユーザーの資格情報を使用して、コマンドを実行します。**
**管理者などの特権アカウントでログインしている場合は、リモートサーバー（LLM）の要求で、あらゆる操作を実行できることに注意してください。**

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
コマンド名、スクリプトのパス、または実行可能ファイル
これらを混在させた文字列の配列にすることができます。
.ps1 で終わる名前が渡された場合、スクリプトとして扱われます（つまり、スクリプトの関数が読み込まれます）
コマンドとして処理したい場合は（スクリプトを実行）、-Command パラメーターを指定して、コマンドとして処理されるように強制します。

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

### -description
LLM に渡されるこのツールの説明。
コマンドはヘルプを使用し、記述された内容も送信します。
このパラメーターを追加すると、ヘルプとともに送信されます。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ForceCommand
コマンドとして処理することを強制します。スクリプトをコマンドとして実行する場合に役立ちます。
コマンドの名前と一致する、あいまいなファイル名を指定した場合にのみ役立ちます。

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

### -ChatId
ツールを作成するチャット

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
グローバルにツールを作成します。つまり、すべてのチャットで使用できるようになります。

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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
