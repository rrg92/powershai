---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Remove api cals da lista interna da sessão

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet auxilia na remoção de evenots gerados por Invoke-GradioSessionApi da lista internas de calls. 
Normalmente, você quer remover os eventos que já processou, passanso o id direto.  
Mas, este cmdlet permite fazer vários tipos de removação, incluindo eventos não procesando.  
Use com cautela, pois, uma vez que um vento é removido da lista, os dados associados com ele também são removidos.  
A menos que você tenha feito uma cópia do evento (ou dos dados resultantes) para uma outra variável, você não será mais capaz de recuperar estas informações.  

A removação de evenots também é útil para ajudar a liberar a memória consumida, que, dependendo da quantidade de eventos e dados, pode ser alta.

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
Especifica o evento, ou eventos, a serem removidos
Id também pode ser um desses valores especiais:
	clean 	- Remove somente as calls que já completaram!
  all 	- Remove tudo, inclunido os que não concluiram!

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
Por padrão, apenas os eventos passados com status "completed" são removidos!
Use -Force para remover inpdenente do status!

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
Nao faz nenhuma remocação, mas retorna os candidados!

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
Id da sessão

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