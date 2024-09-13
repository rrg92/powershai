---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-PowershaiDefaultParams

## SYNOPSIS
Obtém uma referência para variável que define os default parameters

## SYNTAX

```
Get-PowershaiDefaultParams
```

## DESCRIPTION
No Powershell, módulos tem seu próprio escopo de variáveis.
 
Portanto, ao tentar definir essa variável fora do escopo correto, não afetará os comandos dos módulos.
 
Este comando permite que o usuário tenha acesso a variável que controla o default parameter dos comandos do módulo.
 
Na maior parte, isso vai ser usado para debug, mas, eventualmente, um usuário pode querer definir parâmetros default.

## EXAMPLES

### EXAMPLE 1
```
O exemplo abaixo mostra como definir a variável de ebug default do comanod Invoke-Http.
```

$HttpDebug = @{}
$ModDefaults = Get-PowershaiDefaultParams
$ModDefaults\['Invoke-Http:DebugVarName'\] = 'HttpDebug';
Note que o parãmetro -DebugVarName é um parâmetro existente no comando Invoke-Http.

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
