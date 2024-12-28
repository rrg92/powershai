---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiError

## SYNOPSIS <!--!= @#Synop !-->
Cria um nova Exception cusotmizada para o PowershaAI

## DESCRIPTION <!--!= @#Desc !-->
FAciltia a criaÃ§Ã£o de exceptions customizadas!
Ã‰ usada internamente pelos providers para criar exceptions com propriedades e tipos que podem ser restados posteriormente.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiError [[-Name] <Object>] [[-Message] <Object>] [[-Props] <Object>] [[-Type] <Object>] [[-Parent] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Name
Unique erro identification

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

### -Message
A mensagem da exception!

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

### -Props
Propriedades personazalidas

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Type
Tipo adicional!

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

### -Parent
Exception pai!

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