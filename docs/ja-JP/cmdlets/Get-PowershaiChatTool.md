---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
現在のツール一覧を取得します。

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatTool [[-tool] <Object>] [-Enabled] [[-ChatId] <Object>] [-global] [-ForceCommand] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
名前で特定のツールを取得するか、オブジェクト自体を取得します。
.ps1 で終わる場合は、ForceCommand が使用されていない限り、スクリプトとして処理されます。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: *
Accept pipeline input: false
Accept wildcard characters: false
```

### -Enabled
有効なツールのみを一覧表示します。

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
ソースチャット

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -global
特定のツールを取得する場合、グローバルツールのリストで検索します。

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

### -ForceCommand
ツールをコマンドとして処理します。

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
