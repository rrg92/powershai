---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Powershai Chat のチャット パラメーターの値を更新します。

## DESCRIPTION <!--!= @#Desc !-->
Powershai Chat のチャット パラメーターの値を更新します。  
パラメーターが存在しない場合、エラーが返されます。

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatParameter [[-parameter] <Object>] [[-value] <Object>] [[-ChatId] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -parameter
パラメーター名

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

### -value
パラメーターの値

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

### -ChatId
更新するチャット。デフォルトではアクティブなチャットを更新します

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

### -Force
パラメーターがパラメーター一覧に存在しなくても、強制的に更新します

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
