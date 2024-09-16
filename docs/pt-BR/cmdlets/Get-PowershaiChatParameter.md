---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Retorna a lista de parâmetros disoponíveis em um chat

## DESCRIPTION <!--!= @#Desc !-->
Este comando retorna um objeto contendo a lista de propriedades.  
O objeto é, na verdade, um array, onde cada elemento representa uma propriedade.  

Esse array retornado possui algumas modificações para faciltiar o acesso aos parametros. 
Você pode acessar os parâmetros usando o objeto retornado diretamente, sem a necessidade de fitrar sobre a lista de parâmetros.
Isso é útil quando se desejar acessar um parâmetro específico da lista.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatParameter [[-ChatId] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
$MyParams = Get-PowershaiChatParameter
```


## PARAMETERS <!--!= @#Params !-->

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