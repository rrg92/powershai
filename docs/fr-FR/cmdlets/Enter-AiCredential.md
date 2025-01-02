---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-AiCredential

## SYNOPSIS <!--!= @#Synop !-->
Exécute un code et fournit toujours un credential spécifique

## DESCRIPTION <!--!= @#Desc !-->
Cette commande permet d'exécuter un code qui utilisera toujours un credential spécifique.
Chaque fois que la fonction Get-AiDefaultCredential est invoquée, le credential fourni sera toujours retourné.

## SYNTAX <!--!= @#Syntax !-->

```
Enter-AiCredential [[-credential] <Object>] [[-code] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -credential

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

### -code

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


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
