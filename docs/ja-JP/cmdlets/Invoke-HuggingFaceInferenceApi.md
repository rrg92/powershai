---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-HuggingFaceInferenceApi

## SYNOPSIS <!--!= @#Synop !-->
Hugging Face推論APIを呼び出します
https://huggingface.co/docs/hub/en/api

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-HuggingFaceInferenceApi [[-model] <Object>] [[-params] <Object>] [-Public] [-OpenaiChatCompletion] [[-StreamCallback] <Object>] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model

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

### -params

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

### -Public

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

### -OpenaiChatCompletion
チャットコンプリーションエンドポイントを強制的に使用します
ParamsはOpenaiのAPIの同じparamsとして扱われる必要があります（cmdle Get-OpenaiChatを参照）。
詳細情報: https://huggingface.co/blog/tgi-messages-api
チャットテンプレートを持つモデルでのみ機能します！

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

### -StreamCallback
ストリームの場合に使用するストリームコールバックです！

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
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
