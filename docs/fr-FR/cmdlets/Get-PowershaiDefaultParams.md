---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
Obtient une référence à la variable qui définit les paramètres par défaut

## DESCRIPTION <!--!= @#Desc !-->
Dans PowerShell, les modules ont leur propre portée de variable.  
Par conséquent, si vous essayez de définir cette variable en dehors de la portée correcte, elle n'affectera pas les commandes des modules.  
Cette commande permet à l'utilisateur d'accéder à la variable qui contrôle le paramètre par défaut des commandes du module.  
Dans la plupart des cas, cela sera utilisé pour le débogage, mais un utilisateur peut éventuellement vouloir définir des paramètres par défaut.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiDefaultParams [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
L'exemple ci-dessous montre comment définir la variable de débogage par défaut de la commande Invoke-Http.
```


## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Traduit automatiquement à l'aide de PowershAI et IA. 
_
<!--PowershaiAiDocBlockEnd-->
