---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Retourne un ou plusieurs Chats créés avec New-PowershaAIChat

## DESCRIPTION <!--!= @#Desc !-->
Cette commande permet de retourner l'objet qui représente un Powershai Chat.  
Cet objet est l'objet référencé en interne par les commandes qui opèrent sur le Powershai Chat.  
Bien que vous puissiez modifier directement certains paramètres, il est déconseillé de le faire.  
Préférez toujours utiliser la sortie de cette commande comme entrée pour les autres commandes PowershaiChat.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id du chat
Noms spéciaux:
	. - Indique le chat lui-même
 	* - Indique tous les chats

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

### -SetActive
Définit le chat comme actif, lorsque l'id spécifié n'est pas un nom spécial.

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

### -NoError
Ignore les erreurs de validation

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
