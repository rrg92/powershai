---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
Ottiene un riferimento alla variabile che definisce i parametri predefiniti

## DESCRIPTION <!--!= @#Desc !-->
In PowerShell, i moduli hanno il proprio ambito di variabili.  
Pertanto, se si tenta di definire questa variabile al di fuori dell'ambito corretto, non influenzerà i comandi dei moduli.  
Questo comando consente all'utente di accedere alla variabile che controlla il parametro predefinito dei comandi del modulo.  
Nella maggior parte dei casi, questo verrà utilizzato per il debug, ma, eventualmente, un utente potrebbe voler definire parametri predefiniti.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiDefaultParams [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
L'esempio seguente mostra come definire la variabile di debug predefinita del comando Invoke-Http.
```


## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
