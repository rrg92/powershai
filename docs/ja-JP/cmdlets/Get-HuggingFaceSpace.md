---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
特定のスペースに関する情報を取得します！

## SYNTAX <!--!= @#Syntax !-->

### 複数
```
Get-HuggingFaceSpace [-author <Object>] [-My] [-NoGradioSession] [<CommonParameters>]
```

### 単一
```
Get-HuggingFaceSpace [[-Space] <Object>] [-NoGradioSession] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
特定のスペース（またはスペースの配列）でフィルターします。

```yml
Parameter Set: Single
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -author
すべてのスペースを作者別にフィルターします。

```yml
Parameter Set: Multiple
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -My
現在のユーザーのすべてのスペースをフィルターします！

```yml
Parameter Set: Multiple
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoGradioSession
自動的にグラディオセッションを作成しません。
デフォルトでは、グラディオスペースではグラディオセッションが作成されます！

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
