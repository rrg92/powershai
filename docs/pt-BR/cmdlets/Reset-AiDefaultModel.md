---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
Remove o modelo default do provider atual, que foi definido com Set-AiDefaultModel!

## DESCRIPTION <!--!= @#Desc !-->
Remove o modelo default definido com Set-AiDefaultModel. Note que ao fazer isso, o modelo default passa a ser o modelo definido pelo provider.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-AiDefaultModel [-Embeddings] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Embeddings

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