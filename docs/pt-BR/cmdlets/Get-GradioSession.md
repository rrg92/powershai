---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Obtem toda as sessions criadas, ou uma com um nome específico.

## SYNTAX <!--!= @#Syntax !-->

```
Get-GradioSession [[-Session] <Object>] [-Like] [-ById] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Especifique o nome da session.
* obtém todas 
. obtém a default

```yml
Parameter Set: (All)
Type: Object
Aliases: Name
Accepted Values: 
Required: false
Position: 1
Default Value: *
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Like
Se -name é uma string, faz uma busca usando - operador -like

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

### -ById
Get by id (Session must by a id)

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