---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
現在のプロバイダーで使用可能なモデルを一覧表示します

## DESCRIPTION <!--!= @#Desc !-->
このコマンドは、PowershaiChat で使用するために、現在のプロバイダーで使用できるすべての LLM を一覧表示します。  
この関数は、プロバイダーが GetModels 関数を実装していることを前提としています。

返されるオブジェクトはプロバイダーによって異なりますが、すべてのプロバイダーはオブジェクトの配列を返す必要があります。各オブジェクトは、少なくとも id プロパティを含める必要があります。これは、モデルを識別するために使用する文字列であり、モデルに依存する他のコマンドで使用されます。

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
