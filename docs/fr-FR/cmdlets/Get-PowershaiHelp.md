---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
Utilise le fournisseur actuel pour obtenir de l'aide sur PowershAI !

## DESCRIPTION <!--!= @#Desc !-->
Cet applet de commande utilise les propres commandes de PowershAI pour aider l'utilisateur à obtenir de l'aide sur lui-même.  
Essentiellement, à partir de la question de l'utilisateur, il crée une invite avec quelques informations courantes et aides de base.  
Ensuite, cela est envoyé au LLM dans un chat.

En raison du volume important de données envoyées, il est recommandé d'utiliser cette commande uniquement avec des fournisseurs et des modèles qui acceptent plus de 128 k et qui sont peu coûteux.  
Pour le moment, cette commande est expérimentale et ne fonctionne qu'avec ces modèles :
	- Openai gpt-4*
	
En interne, il créera un Powershai Chat appelé "_pwshai_help", où il conservera tout l'historique !

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
Décrivez le texte de l'aide !

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

### -command
Si vous souhaitez obtenir de l'aide sur une commande spécifique, indiquez la commande ici.
Il ne s'agit pas nécessairement d'une commande PowershaiChat.

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

### -Recreate
Recrée le chat !

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
