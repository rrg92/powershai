---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
Prend des captures d'écran constantes et les envoie au modèle actif.
Cette commande est EXPÉRIMENTALE et peut changer ou ne pas être disponible dans les prochaines versions !

## DESCRIPTION <!--!= @#Desc !-->
Cette commande permet, dans une boucle, de prendre des captures d'écran !

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Invite par défaut à utiliser avec l'image envoyée !

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: Explique cette image
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
Reste en boucle à prendre plusieurs captures d'écran
Par défaut, le mode manuel est utilisé, où vous devez appuyer sur une touche pour continuer.
les touches suivantes ont des fonctions spéciales :
	c - efface l'écran 
 ctrl + c - termine la commande

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

### -AutoMs
Si spécifié, active le mode répétition automatique, où à chaque nombre de ms spécifié, il enverra à l'écran.
ATTENTION : En mode automatique, vous pourriez voir la fenêtre clignoter constamment, ce qui peut être mauvais pour la lecture.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: $nulls
Accept pipeline input: false
Accept wildcard characters: false
```

### -RecreateChat
Recrée le chat utilisé !

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


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et de l'IA._
<!--PowershaiAiDocBlockEnd-->
