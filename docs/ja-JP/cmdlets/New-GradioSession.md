---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
新しい Gradio セッションを作成します。

## DESCRIPTION <!--!= @#Desc !-->
セッションは、Gradio アプリへの接続を表します。  
セッションは、特定の Gradio アプリに接続されているブラウザのタブのようなものだと考えてください。  
送信されたファイル、実行された呼び出し、ログインなどは、すべてこのセッションに記録されます。

このコマンドレットは、"GradioSession" と呼ばれるオブジェクトを返します。  
このオブジェクトは、セッションに依存する他のコマンドレットで使用できます (すべてのコマンドレットでデフォルトで使用するアクティブなセッションを定義できます)。  

すべてのセッションには、それを一意に識別する名前があります。 ユーザーが指定しない場合は、アプリの URL に基づいて自動的に作成されます。  
同じ名前のセッションを 2 つ作成することはできません。

セッションを作成すると、このコマンドレットはセッションを内部セッションリポジトリに保存します。

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
アプリの URL

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

### -Name
このセッションを識別する一意の名前！

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

### -DownloadPath
ファイルをダウンロードするディレクトリ

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Force
強制的に再作成

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
