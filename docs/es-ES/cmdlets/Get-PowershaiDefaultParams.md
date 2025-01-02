---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
Obtiene una referencia a la variable que define los parámetros predeterminados

## DESCRIPTION <!--!= @#Desc !-->
En Powershell, los módulos tienen su propio alcance de variables.  
Por lo tanto, al intentar definir esta variable fuera del alcance correcto, no afectará a los comandos de los módulos.  
Este comando permite que el usuario tenga acceso a la variable que controla el parámetro predeterminado de los comandos del módulo.  
En su mayor parte, esto se usará para depuración, pero, eventualmente, un usuario puede querer definir parámetros predeterminados.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiDefaultParams [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
El ejemplo a continuación muestra cómo definir la variable de depuración predeterminada del comando Invoke-Http.
```


## PARAMETERS <!--!= @#Params !-->


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
