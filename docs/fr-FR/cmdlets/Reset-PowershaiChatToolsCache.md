---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
Efface le cache des outils d'IA.

## DESCRIPTION <!--!= @#Desc !-->
PowershAI maintient un cache avec les outils "compilées".
Lorsque PowershAI envoie la liste des outils au LLM, il doit également envoyer la description des outils, la liste des paramètres, la description, etc.  
La création de cette liste peut prendre un temps significatif car elle va parcourir la liste des outils, des fonctions et pour chacune, parcourir l'aide (et l'aide de chaque paramètre).

Lors de l'ajout d'un cmdlet comme Add-AiTool, il ne compile pas à ce moment-là.
Il laisse cela pour plus tard lorsqu'il doit appeler le LLM, dans la fonction Send-PowershaiChat.  
Si le cache n'existe pas, il est alors compilé à ce moment-là, ce qui peut faire que ce premier envoi au LLM prend quelques millisecondes ou secondes de plus que la normale.  

Cet impact est proportionnel au nombre de fonctions et de paramètres envoyés.  

Chaque fois que vous utilisez Add-AiTool ou Add-AiScriptTool, il invalide le cache, ce qui fait qu'à l'exécution suivante, il est généré.  
Cela vous permet d'ajouter de nombreuses fonctions en une seule fois, sans qu'elles soient compilées à chaque fois que vous en ajoutez une.

Cependant, si vous modifiez votre fonction, le cache n'est pas recalculé.  
Vous devez donc utiliser ce cmdlet pour que la prochaine exécution contienne les données mises à jour de vos outils après des modifications de code ou de script.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
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
