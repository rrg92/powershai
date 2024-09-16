---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
Lista los modelos disponibles en el proveedor actual

## DESCRIPTION <!--!= @#Desc !-->
Este comando enumera todos los LLM que se pueden utilizar con el proveedor actual para su uso en PowershaiChat.  
Esta función depende de que el proveedor implemente la función GetModels.

El objeto devuelto varía según el proveedor, pero, cada proveedor debe devolver una matriz de objetos, cada uno de los cuales debe contener, al menos, la propiedad id, que debe ser una cadena que se utiliza para identificar el modelo en otros comandos que dependan de un modelo.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
