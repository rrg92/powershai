---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiTool

## SYNOPSIS <!--!= @#Synop !-->
Converter um comando powershell (function, etc.) para OpenAI tool

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiTool [[-function] <Object>] [[-UserDescription] <Object>] [[-Parameters] <Object>] [[-Help] <Object>] [[-JsonSchema] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -function
Nome da funcao, ou objeto cmmand (resultado get Get-Command)

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

### -UserDescription
Descrição adicional

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

### -Parameters
filter specific parameters to add

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: *
Accept pipeline input: false
Accept wildcard characters: false
```

### -Help
Help do comando (resultado de get-help)
Você deve informar um help alternativo caso queria montar um help customizado ou manualmente queira obter o help devido aos casos de escopo.

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

### -JsonSchema
Especifique um esquema customizado para cada parâmetro de function 
ESte JSON schema será mescaldo no esquema gerado originalmente, tendo prioridade, por exemplo: se o custom tiver a key description, e no orignal, o do custom é usado.
A mescla é feita recursivamente, ou seja, propriedades que são objetos são mescaldas também.
Especifique uma key para cada parâmetro.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```