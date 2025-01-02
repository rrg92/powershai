---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
Obtient une référence pour une variable qui définit les paramètres par défaut

## DESCRIPTION <!--!= @#Desc !-->
Dans Powershell, les modules ont leur propre portée de variables.  
Par conséquent, en essayant de définir cette variable en dehors de la portée correcte, cela n'affectera pas les commandes des modules.  
Cette commande permet à l'utilisateur d'accéder à une variable qui contrôle le paramètre par défaut des commandes du module.  
Dans la plupart des cas, cela sera utilisé pour le débogage, mais, éventuellement, un utilisateur peut vouloir définir des paramètres par défaut.

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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
