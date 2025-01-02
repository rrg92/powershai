---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiProviderInterface

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Invoque les implémentations des interfaces d'un fournisseur provider!
Le PowershAI s'attend à ce que certaines fonctions soient mises en œuvre par les fournisseurs.

Par exemple, la fonction Chat est utilisée lorsque nous invoquons le Get-AiChat.
Ces fonctions doivent être mises en œuvre pour fournir la fonctionnalité de manière standard.
Ces fonctions sont mises en œuvre en utilisant le nom du fournisseur, par exemple : openai_Chat.

Le Powershai utilise cette fonction pour invoquer les fonctions mises en œuvre par le powershai. Elle agit comme un wrapper et facilite et traite les scénarios communs à toutes ces invocations.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiProviderInterface [[-FuncName] <Object>] [[-FuncParams] <Object>] [-Ignore] [-CheckExists] [[-ProviderName] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -FuncName

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

### -FuncParams

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

### -Ignore

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

### -CheckExists

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

### -ProviderName

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


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
