---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtiene el proveedor activo

## DESCRIPTION <!--!= @#Desc !-->
Devuelve el objeto que representa el proveedor activo.  
Los proveedores se implementan como objetos y se almacenan en la memoria de la sesión, en una variable global.  
Esta función devuelve el proveedor activo, que se ha definido con el comando Set-AiProvider.

El objeto que devuelve es una hashtable que contiene todos los campos del proveedor.  
Este comando se usa comúnmente para que los proveedores obtengan el nombre del proveedor activo.  

El parámetro -ContextProvider devuelve el proveedor actual donde se está ejecutando el script.  
Si se está ejecutando en un script de un proveedor, devolverá ese proveedor, en lugar del proveedor definido con Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
Si está habilitado, usa el proveedor de contexto, es decir, si el código se está ejecutando en un archivo en el directorio de un proveedor, asume este proveedor.
De lo contrario, obtiene el proveedor habilitado actualmente.

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```



<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
