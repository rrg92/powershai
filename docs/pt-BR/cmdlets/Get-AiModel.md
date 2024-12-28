---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModel

## SYNOPSIS <!--!= @#Synop !-->
Retorna as informacoes de um model específico do cache!

## DESCRIPTION <!--!= @#Desc !-->
Se o model existe em cache, usa os dados em cache!
Se não existe, tenta consultar, caso não tenha sido tentado ainda.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModel [[-ModelName] <Object>] [-MetaDataOnly] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ModelName
Nome do model

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

### -MetaDataOnly
Checa somente no provider!

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