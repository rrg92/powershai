---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiCommand

## SYNOPSIS <!--!= @#Synop !-->
ほとんどの関数を簡潔な方法で呼び出すことができます。

## DESCRIPTION <!--!= @#Desc !-->
これは、コマンドラインでさまざまな関数をより簡潔に呼び出すことができる、単純なユーティリティです。  
まだすべてのコマンドがサポートされているわけではないことに注意してください。

pshaiエイリアスで最もよく使用されます。

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiCommand [[-CommandName] <Object>] [[-RemArgs] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
pshai tools # ツールの一覧を表示
```


## PARAMETERS <!--!= @#Params !-->

### -CommandName
コマンド名

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

### -RemArgs

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




<!--PowershaiAiDocBlockStart-->
_PowershAIとAIを使用して自動翻訳された。_
<!--PowershaiAiDocBlockEnd-->
