---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Atualiza o valor de um parâmetro do chat do Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
Atualiza o valor de um parâmetro de um Powershai Chat.  
Se o parâmetro não existe, um erro é retornado.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatParameter [[-parameter] <Object>] [[-value] <Object>] [[-ChatId] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -parameter
Nome do parâmetro

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
Valor do parâmetro

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
Chat que deseja atualizar. Por padrão atualiza o chat ativo

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
Forçar atualização, mesmo se o parâmetro não existe na lista de parâmetros

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
