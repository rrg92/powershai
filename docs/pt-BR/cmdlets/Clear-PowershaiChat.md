---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Clear-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Apaga elementos de um chat!

## DESCRIPTION <!--!= @#Desc !-->
Apaga elementos específico de um chat.  
Útil apra liberar recursos, ou tirar o vício do llm devido ao histórico.

## SYNTAX <!--!= @#Syntax !-->

```
Clear-PowershaiChat [-History] [-Context] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -History
Apaga todo o histórico

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

### -Context
Apaga o contexto 
Id do chat. Padrão: ativo.

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

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```