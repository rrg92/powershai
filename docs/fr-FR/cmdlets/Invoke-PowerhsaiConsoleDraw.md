---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Crée un cadre virtuel de texte et écrit des caractères à l'intérieur des limites de ce cadre

## DESCRIPTION <!--!= @#Desc !-->
Crée un cadre de dessin dans la console, qui est mis à jour dans une seule région spécifique !
Vous pouvez envoyer plusieurs lignes de texte et la fonction s'occupera de maintenir le dessin dans le même cadre, donnant l'impression que seule une région est mise à jour.
Pour l'effet désiré, cette fonction doit être invoquée de manière répétée, sans autres écritures entre les invocations !

Cette fonction ne doit être utilisée qu'en mode interactif de PowerShell, exécutée dans une fenêtre de console.
Elle est utile dans les situations où vous souhaitez voir le progrès d'un résultat sous forme de chaîne exactement dans la même zone, permettant de mieux comparer les variations.
C'est seulement une fonction auxiliaire.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
L'exemple suivant écrit 3 chaînes de texte toutes les 2 secondes.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Texte à écrire. Peut être un tableau. S'il dépasse les limites de W et H, il sera tronqué 
S'il s'agit d'un bloc de script, invoque le code en passant l'objet du pipeline !

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

### -w
Max de caractères par ligne

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
Max de lignes

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
Caractère utilisé comme espace vide

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PipeObj
Objet du pipeline

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
Repasse l'objet

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
