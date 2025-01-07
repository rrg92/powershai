---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Find-HuggingFaceModel

## SYNOPSIS <!--!= @#Synop !-->
Procurar por um modelo específico no hub!

## DESCRIPTION <!--!= @#Desc !-->
Basedo em https://huggingface.co/docs/hub/en/api#get-apimodels

## SYNTAX <!--!= @#Syntax !-->

```
Find-HuggingFaceModel [[-search] <Object>] [[-filter] <Object>] [[-author] <Object>] [[-RawParams] <Object>] [[-limit] <Object>] [[-sort] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -search
pesquisa no nome do model

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

### -filter
filtro em tags

```yml
Parameter Set: (All)
Type: Object
Aliases: tags
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -author
filtra autores especificos

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
sobrescreve parâmetros direto na api do hub!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -limit
limit a busca

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 100
Accept pipeline input: false
Accept wildcard characters: false
```

### -sort
ordena por uma propriedade especifica

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: downloads
Accept pipeline input: false
Accept wildcard characters: false
```