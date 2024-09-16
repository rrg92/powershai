---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Met à jour la valeur d'un paramètre du chat Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
Met à jour la valeur d'un paramètre d'un Powershai Chat.  
Si le paramètre n'existe pas, une erreur est retournée.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatParameter [[-parameter] <Object>] [[-value] <Object>] [[-ChatId] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -parameter
Nom du paramètre

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

### -value
Valeur du paramètre

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

### -ChatId
Chat à mettre à jour. Par défaut, met à jour le chat actif

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Force
Forcer la mise à jour, même si le paramètre n'existe pas dans la liste des paramètres

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
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
