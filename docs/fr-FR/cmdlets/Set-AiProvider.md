---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Modifie le fournisseur actuel

## DESCRIPTION <!--!= @#Desc !-->
Les fournisseurs sont des scripts qui implémentent l'accès à leurs API respectives.  
Chaque fournisseur a sa propre façon d'appeler les API, le format des données, le schéma de la réponse, etc.  

En changeant de fournisseur, vous affectez certains commandes qui fonctionnent sur le fournisseur actuel, comme `Get-AiChat`, `Get-AiModels`, ou les Chats, comme Send-PowershaAIChat.
Pour plus de détails sur les fournisseurs, consultez la rubrique about_Powershai_Providers

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
nom du fournisseur

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
