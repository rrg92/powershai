---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
セッションの内部リストから API 呼び出しを削除します

## DESCRIPTION <!--!= @#Desc !-->
この cmdlet は、Invoke-GradioSessionApi によって生成されたイベントを内部呼び出しリストから削除するのに役立ちます。
通常、処理済みのイベントを削除するには、直接 ID を渡します。
ただし、この cmdlet では、処理されていないイベントを含む、さまざまな種類の削除を実行できます。
注意して使用してください。イベントをリストから削除すると、関連付けられたデータも削除されます。
イベント（または結果として得られるデータ）を別の変数にコピーしていない限り、この情報は回復できなくなります。

イベントを削除すると、消費されるメモリを解放するのに役立ちます。イベントやデータの量によっては、消費されるメモリが大きくなる場合があります。

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
削除するイベントを指定します
ID は、次のいずれかの特殊な値にすることもできます。
	clean 	- 完了した呼び出しのみ削除します！
  all 	- 未完了のものを含めてすべて削除します！

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

### -Force
既定では、「completed」ステータスが渡されたイベントのみが削除されます！
-Force を使用して、ステータスに関係なく削除します！

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

### -Elegible
削除は行いませんが、候補を返します！

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

### -session
セッション ID

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

### -WhatIf

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: wi
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Confirm

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: cf
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
