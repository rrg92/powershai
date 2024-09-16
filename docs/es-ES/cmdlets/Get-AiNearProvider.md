---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtiene el proveedor más reciente del script actual

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet es comúnmente usado por los proveedores de forma indirecta a través de Get-AiCurrentProvider.  
Mira en la callstack del powershell e identifica si el caller (la función que ejecutó) es parte de un script de un proveedor.  
Si lo es, retorna ese proveedor.

Si la llamada fue hecha en múltiples proveedores, el más reciente es retornado. Por ejemplo, imagina este escenario:

	Usuario -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
En este caso, nota que existen 2 calls de proveedores involucradas.  
En este caso, la función Get-AiNearProvider retornará el proveedor y, pues él es el más reciente de la call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
