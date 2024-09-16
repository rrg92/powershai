---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
Convertit un tableau de chaînes et d'objets en un format de message OpenAI standard !

## DESCRIPTION <!--!= @#Desc !-->
Vous pouvez passer un tableau mixte où chaque élément peut être une chaîne ou un objet.
S'il s'agit d'une chaîne, elle peut commencer par le préfixe s, u ou a, ce qui signifie respectivement système, utilisateur ou assistant.
S'il s'agit d'un objet, il est ajouté directement au tableau résultant.

Voir : https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "C'est un texte",@{role:"assistant";content="Réponse de l'assistant"}, "s:Msg système"
```


## PARAMETERS <!--!= @#Params !-->

### -prompt

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



<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
