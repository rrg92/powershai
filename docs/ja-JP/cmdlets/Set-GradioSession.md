---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
セッションのオプションをいくつか定義します。

## SYNTAX <!--!= @#Syntax !-->

```
Set-GradioSession [[-Session] <Object>] [-Default] [[-MaxCalls] <Object>] [[-MaxCallsPolicy] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Gradio セッション

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Default
セッションをデフォルトとして定義します

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

### -MaxCalls
呼び出しの最大数を設定します。Invoke-GradioSessionApiで詳細を確認してください

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

### -MaxCallsPolicy
最大呼び出しのポリシーを設定します。Invoke-GradioSessionApiで詳細を確認してください

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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
