---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-PowershaiChatParameter

## SYNOPSIS
Retorna a lista de parâmetros disoponíveis em um chat

## SYNTAX

```
Get-PowershaiChatParameter [[-ChatId] <Object>]
```

## DESCRIPTION
Este comando retorna um objeto contendo a lista de propriedades.
 
O objeto é, na verdade, um array, onde cada elemento representa uma propriedade.
 

Esse array retornado possui algumas modificações para faciltiar o acesso aos parametros. 
Você pode acessar os parâmetros usando o objeto retornado diretamente, sem a necessidade de fitrar sobre a lista de parâmetros.
Isso é útil quando se desejar acessar um parâmetro específico da lista.

## EXAMPLES

### EXAMPLE 1
```
$MyParams = Get-PowershaiChatParameter
```

\> $MyParams.MaxTokens # Acessa o parâmetro max TOKENS
\> $MyParams | %{ write-host Parametro $_.name tem o valor $_.value } # itera sobre os parametros!

## PARAMETERS

### -ChatId
{{ Fill ChatId Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
