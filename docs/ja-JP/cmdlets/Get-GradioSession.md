---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
作成されたすべてのセッション、または特定の名前のセッションを取得します。

## SYNTAX <!--!= @#Syntax !-->

```
Get-GradioSession [[-Session] <Object>] [-Like] [-ById] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
セッションの名前を指定します。
* 全てを取得
. デフォルトを取得

```yml
Parameter Set: (All)
Type: Object
Aliases: Name
Accepted Values: 
Required: false
Position: 1
Default Value: *
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Like
-name が文字列の場合、- 演算子を使用して -like で検索します

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

### -ById
ID で取得 (セッションは ID である必要があります)

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
