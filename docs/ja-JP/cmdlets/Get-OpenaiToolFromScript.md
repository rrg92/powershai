---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
OpenAI で期待されるスキーマ形式に .ps1 スクリプトを変換するためのヘルパー関数。
基本的に、この関数は .ps1 ファイル（または文字列）とそのヘルプドキュメントを読み取ります。  
その後、モデルが呼び出すことができるように、OpenAI によって指定された形式のオブジェクトを返します。

次のキーを含むハッシュテーブルを返します。
	functions - 関数のリストとそのコードはファイルから読み取られます。  
				モデルが呼び出すと、ここから直接実行できます。
				
	tools - OpenAI 呼び出しで送信されるツールのリスト。
	
PowerShell のコメントベースのヘルプに従って、関数とパラメーターを文書化できます。
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
