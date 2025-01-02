---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiError

## SYNOPSIS <!--!= @#Synop !-->
Crée une nouvelle exception personnalisée pour le PowershaAI

## DESCRIPTION <!--!= @#Desc !-->
Facilite la création d'exceptions personnalisées !
Elle est utilisée en interne par les fournisseurs pour créer des exceptions avec des propriétés et des types qui peuvent être restitués ultérieurement.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiError [[-Name] <Object>] [[-Message] <Object>] [[-Props] <Object>] [[-Type] <Object>] [[-Parent] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Name
Identification unique de l'erreur

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
Le message de l'exception !

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
Propriétés personnalisées

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
Type supplémentaire !

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
Exception parente !

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


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
