---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
New-PowershaAIChat で作成された 1 つ以上のチャットを返します

## DESCRIPTION <!--!= @#Desc !-->
このコマンドを使用すると、Powershai チャットを表すオブジェクトを返します。  
このオブジェクトは、Powershai チャットを操作するコマンドで内部的に参照されるオブジェクトです。  
特定のパラメーターを直接変更できますが、この操作はお勧めしません。  
常にこのコマンドの出力を、他の PowershaiChat コマンドの入力として使用するようにしてください。

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
チャット ID
特殊な名前:
	. - 自分のチャットを示します
 	* - すべてのチャットを示します

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

### -SetActive
指定された ID が特殊な名前でない場合、チャットをアクティブとして定義します。

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

### -NoError
検証エラーを無視します

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
