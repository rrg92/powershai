---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
現在のセッションの設定を、パスワードで暗号化されたファイルにエクスポートします

## DESCRIPTION <!--!= @#Desc !-->
このコマンドレットは、トークンなどの設定を安全に保存するのに役立ちます。  
パスワードを要求し、そのパスワードを使用してハッシュを作成し、セッション設定データを AES256 で暗号化します。  

エクスポートされた設定は、$POWERSHAI_SETTINGS 変数に定義されているすべての設定です。  
この変数は、プロバイダーによって構成されたすべてのデータを含むハッシュテーブルであり、トークンが含まれます。  

デフォルトでは、チャットはデータ量が多いためエクスポートされません。これにより、ファイルサイズが大きくなる可能性があります。

エクスポートされたファイルは、デフォルトではユーザーのホーム ($HOME) に自動的に作成されたディレクトリに保存されます。  
オブジェクトは、Export-CliXml で使用されるのと同じ方法であるシリアル化によってエクスポートされます。  

データは、Import-PowershaiSettings でのみインポートでき、同じパスワードを指定した場合にインポートできる独自の形式でエクスポートされます。  

PowershAI は自動エクスポートを実行しないため、新しいトークンの追加など、設定が変更されるたびにこのコマンドを呼び出すことをお勧めします。  

エクスポートディレクトリは、OneDrive、Dropbox など、クラウドドライブを含む有効なパスにすることができます。  

このコマンドは対話型として作成されました。つまり、ユーザーからのキーボード入力が必要です。

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### デフォルトの設定をエクスポートします！
```powershell
Export-PowershaiSettings
```

### チャットを含めてすべてをエクスポートします！
```powershell
Export-PowershaiSettings -Chat
```

### OneDrive にエクスポートします
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
エクスポートディレクトリ
デフォルトでは、ユーザーのプロファイルにある .powershai というディレクトリですが、環境変数 POWERSHAI_EXPORT_DIR を指定して変更できます。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -Chats
指定した場合、エクスポートにチャットを含めます
すべてのチャットがエクスポートされます

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
