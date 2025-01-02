---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtient le provider le plus récent du script actuel

## DESCRIPTION <!--!= @#Desc !-->
Ce cmdlet est couramment utilisé par les providers de manière indirecte via Get-AiCurrentProvider.  
Il examine la pile d'appels de PowerShell et identifie si l'appelant (la fonction qui a été exécutée) fait partie d'un script d'un provider.  
Si c'est le cas, il retourne ce provider.

Si l'appel a été effectué dans plusieurs providers, le plus récent est retourné. Par exemple, imaginez ce scénario :

	Utilisateur -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
Dans ce cas, notez qu'il y a 2 appels de providers impliqués.  
Dans ce cas, la fonction Get-AiNearProvider retournera le provider y, car il est le plus récent de la pile d'appels.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [[-callstack] <Object>] [[-filter] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -callstack
Utiliser une pile d'appels spécifique.  
Ce paramètre est utile lorsqu'une fonction qui a invoqué souhaite qu'on considère à partir d'un point spécifique !

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

### -filter
ScriptBlock avec le filtre. $_ pointe vers le provider trouvé !

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
