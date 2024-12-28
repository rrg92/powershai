---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromCommand

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Converte comandos do powershell para OpenaiTool.

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromCommand [[-functions] <Object>] [[-parameters] <Object>] [[-UserDescription] <Object>] [[-JsonSchema] <Hashtable[]>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -functions
Lista de comandos

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

### -parameters
Filtrar quais parametros serão adicionados

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: *
Accept pipeline input: false
Accept wildcard characters: false
```

### -UserDescription
Descricao customizada adicional

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

### -JsonSchema
Define uma esquema customizado. Especifique uma hashtable , onde cada key é o nome do parâmetro da funcao e o valor é o JSON schema. 
O Json schema definido irá ser mescaldo no esquema do parâmetro. As configurações definidas neste parâmetro tem prioridade
Voce pode especificar um json schema para cada funcao em -functions, bastando especificar um array com o mesmo tamanho. O schema no mesmo offset é usado.

```yml
Parameter Set: (All)
Type: Hashtable[]
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```