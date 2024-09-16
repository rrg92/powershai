---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtient le fournisseur actif

## DESCRIPTION <!--!= @#Desc !-->
Retourne l'objet qui représente le fournisseur actif.  
Les fournisseurs sont implémentés en tant qu'objets et sont stockés dans la mémoire de la session, dans une variable globale.  
Cette fonction retourne le fournisseur actif, qui a été défini avec la commande Set-AiProvider.

L'objet retourné est une table de hachage contenant tous les champs du fournisseur.  
Cette commande est généralement utilisée par les fournisseurs pour obtenir le nom du fournisseur actif.  

Le paramètre -ContextProvider retourne le fournisseur actuel où le script est en cours d'exécution.  
S'il est en cours d'exécution dans un script d'un fournisseur, il retournera ce fournisseur, au lieu du fournisseur défini avec Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
Si activé, utilise le fournisseur de contexte, c'est-à-dire que si le code s'exécute dans un fichier du répertoire d'un fournisseur, il suppose ce fournisseur.
Sinon, il obtient le fournisseur actuellement activé.

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
