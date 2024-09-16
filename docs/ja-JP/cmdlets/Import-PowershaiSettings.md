---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Export-PowershaiSettings でエクスポートされた設定をインポートします

## DESCRIPTION <!--!= @#Desc !-->
このコマンドレットは Export-PowershaiSettings のペアであり、名前が示すように、エクスポートされたデータをインポートします。  
同じパスワードとファイルが渡されていることを確認する必要があります。  

重要：このコマンドはセッションで設定されたすべてのデータを上書きします。以前の設定されたデータが失われないことを確認している場合にのみ、このコマンドを実行してください。
たとえば、最近生成された API トークンなどです。

POWERSHAI_EXPORT_DIR 変数を使用して、標準以外のエクスポートパスを指定した場合、ここで同じパスを使用する必要があります。

インポートプロセスでは、一部のヘッダーが検証され、データが正しく復号化されていることを確認します。  
入力されたパスワードが間違っている場合、ハッシュが一致せず、パスワードが間違っているというエラーが発生します。

一方、ファイル形式が無効であるというエラーが表示された場合、インポートプロセス中に何らかの破損が発生したか、このコマンドのバグが原因です。  
この場合、github に問題を報告する issue を作成できます。

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### 標準インポート
```powershell
Import-PowershaiSettings
```

### OneDrive からのインポート
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Import-PowershaiSettings
```
代替ディレクトリ（OneDrive）にエクスポートされた設定をインポートします。

## PARAMETERS <!--!= @#Params !-->

### -ExportDir

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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
