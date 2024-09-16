---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
lista os modelos disponíveis no provider atual

## DESCRIPTION <!--!= @#Desc !-->
Este comando lista todos os LLM que podem ser usados com o provider atual para uso no PowershaiChat.  
Esta função depende que o provider implemente a função GetModels.

O objeto retornado varia conforme o provider, mas, todo provider deve retorna um array de objetos, cada deve conter, pelo menos, a propridade id, que deve ser uma string usada para identificar o modelo em outros comandos que dependam de um modelo.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->