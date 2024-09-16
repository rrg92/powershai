---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
現在のプロバイダーを変更します

## DESCRIPTION <!--!= @#Desc !-->
プロバイダーは、それぞれの API へのアクセスを実装するスクリプトです。  
各プロバイダーは、API の呼び出し方法、データの形式、応答のスキーマなどが異なります。  

プロバイダーを変更すると、`Get-AiChat`、`Get-AiModels`、またはチャット（例：Send-PowershaAIChat）など、現在のプロバイダーで動作する特定のコマンドに影響を与えます。
プロバイダーの詳細については、about_Powershai_Providers トピックを参照してください。

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
プロバイダー名

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
