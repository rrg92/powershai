---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Remove chamadas de API da lista interna da sessão

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet ajuda a remover eventos gerados por Invoke-GradioSessionApi da lista interna de chamadas.
Normalmente, você deseja remover os eventos que já processou, passando o ID direto.
Mas, este cmdlet permite que você faça vários tipos de remoção, incluindo eventos não processados.
Use com cautela, pois, uma vez que um evento é removido da lista, os dados associados a ele também são removidos.
A menos que você tenha feito uma cópia do evento (ou dos dados resultantes) para outra variável, você não poderá mais recuperar essas informações.

A remoção de eventos também é útil para ajudar a liberar a memória consumida, que, dependendo da quantidade de eventos e dados, pode ser alta.

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
Especifica o evento, ou eventos, a serem removidos
O ID também pode ser um desses valores especiais:
	clean 	- Remove apenas as chamadas que já foram concluídas!
  all 	- Remove tudo, incluindo aqueles que não foram concluídos!

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
Use -Force para remover independentemente do status!

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
Não faz nenhuma remoção, mas retorna os candidatos!

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




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
