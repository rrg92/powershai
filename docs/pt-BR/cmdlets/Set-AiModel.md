---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiModel

## SYNOPSIS <!--!= @#Synop !-->
Altera opcoes de um model do provider atual

## DESCRIPTION <!--!= @#Desc !-->
Os models possuem configuracoes que podem ser modificadas e que alteram alguma feature ou característica.
Os parâmetros da função documentam as opcoes disponiveis e os efeitos.
Essa configuracoes fazem efeito somente na sesssão atual. Elas também são exportadas e importas quando se usa Export-PowershaiSettings (ou Import).
Estas opcoes definidas tem prioridade sobre as configuracoes default!

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiModel [[-ModelName] <Object>] [[-tools] <Object>] [[-embeddings] <Object>] [[-Unset] <String[]>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ModelName
Nome do modelo

```yml
Parameter Set: (All)
Type: Object
Aliases: model
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -tools
Habilita ou desabilita o suporte a tools

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

### -embeddings
Habilita ou desabilita o suporte a embeddings

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

### -Unset
Define opcoes que serão resetadas (tem prioridade sobre as demais opcoes).

```yml
Parameter Set: (All)
Type: String[]
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```