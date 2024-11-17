---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
テキストの仮想フレームを作成し、そのフレームの境界内に文字を書き込みます。

## DESCRIPTION <!--!= @#Desc !-->
コンソールに描画フレームを作成し、特定の領域のみが更新されます！
複数行のテキストを送信でき、関数は描画を同じフレーム内に保持し、まるで特定の領域のみが更新されているかのような印象を与えます。
望ましい効果を得るために、この関数は他の書き込みなしで繰り返し呼び出す必要があります！

この関数は、インタラクティブなPowerShellモードで、コンソールウィンドウで実行される場合にのみ使用する必要があります。
文字列の結果の進行状況を同じエリアで正確に見る必要がある状況で役立ち、変動をよりよく比較できます。
これは補助関数にすぎません。

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
次の例では、2秒ごとに3つの文字列を書き込みます。
```


## PARAMETERS <!--!= @#Params !-->

### -Text
書き込むテキスト。配列にすることもできます。WおよびHの制限を超えると切り捨てられます。
スクリプトブロックの場合は、パイプラインオブジェクトを渡してコードを呼び出します！

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
オブジェクトを再渡します

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
