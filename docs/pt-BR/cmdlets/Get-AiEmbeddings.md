---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiEmbeddings

## SYNOPSIS <!--!= @#Synop !-->
Obtém embeddings de um ou mais inputs de texto!

## DESCRIPTION <!--!= @#Desc !-->
Este função obtém embeddings usando um modelo com suporte a embeddings!

## PARA PROVIDERS
	Providers que desejam export essa funcionalidade devem implementar a interface GetEmbeddings
	Resultado esperado:
		um array onde cada iem é um objeto contendo:
			- embeddings: o embedding gerado.
			- texto: o texto de origgem, se o parâmetro include text foi informado.
			
		deve ser gerado o embedding na mesma ordem do texto em que foi informado!

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiEmbeddings [[-text] <String[]>] [-IncludeText] [[-model] <Object>] [[-BatchSize] <Object>] [[-dimensions] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -text
Array de textos a serem gerados!

```yml
Parameter Set: (All)
Type: String[]
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -IncludeText
Incluir o texto na resposta!

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

### -model
model

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

### -BatchSize
Max embeddings para processar de uma só veZ!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -dimensions
Número de dimensoes 
Se null usará o default de cada provider!
Nem todo provider suporta definir. Se não suportado, um erro é disparado!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```