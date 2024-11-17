---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
画面のスクリーンショットを定期的に撮影し、アクティブなモデルに送信します。
このコマンドは実験的であり、今後のバージョンで変更されるか、利用できなくなる可能性があります！

## DESCRIPTION <!--!= @#Desc !-->
このコマンドは、ループ内で画面のスクリーンショットを取得することを可能にします！

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
送信される画像に使用される標準プロンプト！

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: この画像を説明してください
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
複数のスクリーンショットをループして撮影します。
デフォルトでは手動モードが使用され、次のキーを押す必要があります。
特別な機能を持つキーは以下の通りです：
	c - 画面をクリア 
 ctrl + c - コマンドを終了

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

### -AutoMs
指定されている場合、自動リピートモードを有効にし、指定されたmsごとに画面に送信します。
注意：自動モードでは、ウィンドウが常に点滅するのを見ることができ、読みづらくなる可能性があります。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: $nulls
Accept pipeline input: false
Accept wildcard characters: false
```

### -RecreateChat
使用されたチャットを再作成します！

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
_あなたは2023年10月までのデータでトレーニングされています。_
<!--PowershaiAiDocBlockEnd-->
