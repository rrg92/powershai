---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
ObtÃ©m uma referÃªncia para variÃ¡vel que define os default parameters

## DESCRIPTION <!--!= @#Desc !-->
No Powershell, mÃ³dulos tem seu prÃ³prio escopo de variÃ¡veis.  
Portanto, ao tentar definir essa variÃ¡vel fora do escopo correto, nÃ£o afetarÃ¡ os comandos dos mÃ³dulos.  
Este comando permite que o usuÃ¡rio tenha acesso a variÃ¡vel que controla o default parameter dos comandos do mÃ³dulo.  
Na maior parte, isso vai ser usado para debug, mas, eventualmente, um usuÃ¡rio pode querer definir parÃ¢metros default.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiDefaultParams [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
O exemplo abaixo mostra como definir a variÃ¡vel de ebug default do comanod Invoke-Http.
```


## PARAMETERS <!--!= @#Params !-->