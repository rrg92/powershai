---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Retourne la liste des paramètres disponibles dans un chat

## DESCRIPTION <!--!= @#Desc !-->
Cette commande renvoie un objet contenant la liste des propriétés.  
L'objet est en fait un tableau, où chaque élément représente une propriété.  

Ce tableau retourné a quelques modifications pour faciliter l'accès aux paramètres. 
Vous pouvez accéder aux paramètres en utilisant l'objet retourné directement, sans avoir besoin de filtrer sur la liste des paramètres.
Ceci est utile lorsque vous souhaitez accéder à un paramètre spécifique de la liste.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatParameter [[-ChatId] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
$MyParams = Get-PowershaiChatParameter
```


## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
