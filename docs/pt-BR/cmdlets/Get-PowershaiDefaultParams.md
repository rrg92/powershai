---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
Obtém uma referência para variável que define os default parameters

## DESCRIPTION <!--!= @#Desc !-->
No Powershell, módulos tem seu próprio escopo de variáveis.  
Portanto, ao tentar definir essa variável fora do escopo correto, não afetará os comandos dos módulos.  
Este comando permite que o usuário tenha acesso a variável que controla o default parameter dos comandos do módulo.  
Na maior parte, isso vai ser usado para debug, mas, eventualmente, um usuário pode querer definir parâmetros default.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiDefaultParams [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
O exemplo abaixo mostra como definir a variável de ebug default do comanod Invoke-Http.
```


## PARAMETERS <!--!= @#Params !-->