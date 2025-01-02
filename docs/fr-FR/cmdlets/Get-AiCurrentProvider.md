---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtient le fournisseur actif

## DESCRIPTION <!--!= @#Desc !-->
Renvoie l'objet qui représente le fournisseur actif.  
Les fournisseurs sont implémentés sous forme d'objets et sont stockés en mémoire de session, dans une variable globale.  
Cette fonction renvoie le fournisseur actif, qui a été défini avec la commande Set-AiProvider.

L'objet retourné est une hashtable contenant tous les champs du fournisseur.  
Cette commande est couramment utilisée par les fournisseurs pour obtenir le nom du fournisseur actif.  

Le paramètre -ContextProvider renvoie le fournisseur actuel où le script s'exécute.  
S'il s'exécute dans un script d'un fournisseur, il renverra ce fournisseur, au lieu du fournisseur défini avec Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [[-CallStack] <Object>] [[-FilterContext] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
S'il est activé, utilise le fournisseur de contexte, c'est-à-dire, si le code s'exécute dans un fichier dans le répertoire d'un fournisseur, il assume ce fournisseur.
Sinon, obtient le fournisseur actuellement activé.

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

### -CallStack
Pile alternative à considérer ! Voir plus dans Get-AiNearProvider

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

### -FilterContext
Permet de choisir le fournisseur en fonction de filtres

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
