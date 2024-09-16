---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtient le fournisseur le plus récent du script actuel

## DESCRIPTION <!--!= @#Desc !-->
Cette cmdlet est couramment utilisée par les fournisseurs de manière indirecte via Get-AiCurrentProvider.  
Elle examine la pile d'appels de Powershell et identifie si l'appelant (la fonction qui a été exécutée) fait partie d'un script d'un fournisseur.  
Si c'est le cas, elle renvoie ce fournisseur.

Si l'appel a été effectué dans plusieurs fournisseurs, le plus récent est renvoyé. Par exemple, imaginez ce scénario :

	Utilisateur -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
Dans ce cas, remarquez qu'il y a 2 appels de fournisseurs impliqués.  
Dans ce cas, la fonction Get-AiNearProvider retournera le fournisseur y, car il est le plus récent de la pile d'appels.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
