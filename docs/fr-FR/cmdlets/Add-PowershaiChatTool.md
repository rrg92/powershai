---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Ajoute des fonctions, des scripts, des exécutables en tant qu'outil invocable par le LLM dans le chat actuel (ou par défaut pour tous).

## DESCRIPTION <!--!= @#Desc !-->
Ajoute des fonctions dans la session actuelle à la liste des appels d'outils autorisés !
Lorsqu'une commande est ajoutée, elle est envoyée au modèle actuel comme une option pour l'appel d'outils.
L'aide disponible de la fonction sera utilisée pour la décrire, y compris les paramètres.
Ainsi, vous pouvez, en temps d'exécution, ajouter de nouvelles compétences à l'IA qui pourront être invoquées par le LLM et exécutées par PowershAI.

Lors de l'ajout de scripts, toutes les fonctions du script sont ajoutées d'un coup.

Pour plus d'informations sur les outils, consultez la rubrique about_Powershai_Chats

TRÈS IMPORTANT :
NE JAMAIS AJOUTER DE COMMANDES QUE VOUS NE CONNAISSEZ PAS OU QUI POURRAIENT METTRE VOTRE ORDINATEUR EN DANGER.
POWERSHELL L'EXÉCUTERA À LA DEMANDE DU LLM ET AVEC LES PARAMÈTRES QUE LE LLM INVOQUE, ET AVEC LES IDENTIFIANTS DE L'UTILISATEUR ACTUEL.
SI VOUS ÊTES CONNECTÉ AVEC UN COMPTE PRIVILÉGIÉ, COMME L'ADMINISTRATEUR, REMARQUEZ QUE VOUS POURREZ EXÉCUTER N'IMPORTE QUELLE ACTION À LA DEMANDE D'UN SERVEUR DISTANT (LE LLM).

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
Nom de la commande, chemin du script ou exécutable
Peut être un tableau de chaînes avec ces éléments mélangés.
Lorsqu'un nom se terminant par .ps1 est passé, il est traité comme un script (c'est-à-dire que les fonctions du script seront chargées)
Si vous souhaitez traiter avec une commande (exécuter le script), indiquez le paramètre -Command, pour forcer le traitement comme une commande !

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

### -description
Description de cet outil à passer au LLM.
La commande utilisera l'aide et enverra également le contenu décrit
Si ce paramètre est ajouté, il est envoyé avec l'aide.

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

### -ForceCommand
Force le traitement en tant que commande. Utile lorsque vous souhaitez qu'un script soit exécuté en tant que commande.
Utile uniquement lorsque vous transmettez un nom de fichier ambigu qui correspond au nom d'une commande !

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

### -ChatId
Chat dans lequel créer l'outil

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

### -Global
Crée l'outil globalement, c'est-à-dire qu'il sera disponible dans tous les chats

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
