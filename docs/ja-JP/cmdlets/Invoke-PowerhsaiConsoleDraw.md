---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
仮想テキストフレームを作成し、そのフレームの境界内に文字を書きます

## DESCRIPTION <!--!= @#Desc !-->
コンソールに描画フレームを作成し、特定の領域のみが更新されます！
複数行のテキストを送信でき、関数は描画を同じフレームに保持し、特定の領域のみが更新されているように見えます。
必要な効果を得るには、この関数は他の書き込みを伴わずに繰り返し呼び出す必要があります！

この関数は、powershellの対話モードでのみ、コンソールウィンドウで実行している場合にのみ使用してください。
これは、文字列の結果の進捗状況を正確に同じ領域に表示する場合に便利です。
これは補助関数に過ぎません。

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
次の例は、3秒ごとに3つのテキスト文字列を書き込みます。
```


## PARAMETERS <!--!= @#Params !-->

### -Text
書き込むテキスト。配列にすることもできます。WとHの制限を超えると、切り捨てられます
スクリプトブロックの場合、パイプラインオブジェクトを渡してコードを呼び出します！

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

### -w
各行の最大文字数

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
最大行数

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
空白として使用される文字

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PipeObj
パイプラインオブジェクト

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
オブジェクトを渡す

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
