---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
現在のプロバイダーのデフォルト LLM を設定します。

## DESCRIPTION <!--!= @#Desc !-->
ユーザーは、LLM が必要な場合に使用するデフォルトの LLM を設定できます。  
Send-PowershaAIChat や Get-AiChat などのコマンドはモデルを期待しており、指定されていない場合は、このコマンドで設定されたものが使用されます。

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
Get-AiModels で返されるモデルの ID
タブを使用してコマンドラインを補完できます。

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

### -Force
Get-AiModels で返されない場合でも、モデルを強制的に設定します。

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
