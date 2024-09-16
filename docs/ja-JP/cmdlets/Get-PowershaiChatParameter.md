---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
チャットで使用可能なパラメータのリストを返します

## DESCRIPTION <!--!= @#Desc !-->
このコマンドは、プロパティのリストを含むオブジェクトを返します。  
オブジェクトは実際には配列で、各要素がプロパティを表します。  

返されたこの配列には、パラメータへのアクセスを容易にするためのいくつかの変更が加えられています。 
パラメータのリストをフィルタリングする必要なく、返されたオブジェクトを使用して直接パラメータにアクセスできます。
これは、リストから特定のパラメータにアクセスする必要がある場合に役立ちます。

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatParameter [[-ChatId] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
$MyParams = Get-PowershaiChatParameter
```


## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
