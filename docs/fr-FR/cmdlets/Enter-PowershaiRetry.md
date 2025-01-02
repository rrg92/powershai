---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-PowershaiRetry

## SYNOPSIS <!--!= @#Synop !-->
Gère l'exécution des commandes en fonction du résultat

## DESCRIPTION <!--!= @#Desc !-->
Ce cmdlet aide à exécuter des commandes tant qu'un certain résultat n'est pas atteint.
Avec cela, il est possible, par exemple, de demander à LLM de générer à nouveau un résultat si la réponse n'est pas celle demandée !

## SYNTAX <!--!= @#Syntax !-->

```
Enter-PowershaiRetry [[-Code] <Object>] [[-Expected] <Object>] [[-Retries] <Object>] [-ShowProgress] [-CheckErrors] [[-ModifyResult] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Code
Le scriptblock avec le code à exécuter

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

### -Expected
Résultat attendu 
Peut être une chaîne avec laquelle le résultat du code sera comparé.
Peut être un script block qui sera invoqué !
Doit retourner un booléen true pour être considéré comme valide !
$_ pointe vers le résultat actuel !

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

### -Retries
Maximum de tentatives

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 1
Accept pipeline input: false
Accept wildcard characters: false
```

### -ShowProgress
Affiche le progrès des tentatives

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

### -CheckErrors
Inclut des exceptions dans le contrôle !
Si non spécifié, si le code dans -Code résulte en erreur, l'erreur est renvoyée à l'appelant.
Lorsqu'il est spécifié, l'erreur est envoyée comme résultat pour que le code -Expected décide quoi faire !

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

### -ModifyResult
Permet de modifier la valeur à utiliser dans le contrôle. $_ pointera vers l'objet résultant de l'exécution !

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


<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
