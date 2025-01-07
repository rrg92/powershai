---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-OllamaPowershaiCache

## SYNOPSIS <!--!= @#Synop !-->
Reseta o cache de modelos do ollama no powershai

## DESCRIPTION <!--!= @#Desc !-->
O ollama mantém um cache de modelos para evitar consultar informações detalhadas a todo momento.  
Este comando reseta esse cache. Ao obter as informações da próxima vez (usando Get-AiModels), o cache é populado novamente.

Este cache também é resetado automaticamente sempreque o powershai é importado novamente.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-OllamaPowershaiCache [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->