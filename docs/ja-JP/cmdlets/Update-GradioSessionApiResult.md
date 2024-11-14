---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
Invoke-GradioSessionApiによって生成されたコールの結果を更新します

## DESCRIPTION <!--!= @#Desc !-->
このコマンドレットは、Send-GradioApiおよびUpdate-GradioApiResultの同等の原則に従います。
ただし、特定のセッションで生成されたイベントにのみ機能します。
更新されたイベントに依存する他のコマンドレットで使用できるように、イベント自体を返します！

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
Invoke-GradioSessionApiによって返されたイベントのID、または返されたオブジェクト自体。

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -NoOutput
結果を出力に戻さない！

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

### -MaxHeartBeats
最大連続ハートビート。

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

### -session
セッションのID

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -History
指定された-IdのGradioApiEventオブジェクトのイベント履歴にイベントを追加します

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
