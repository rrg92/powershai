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
Esta función retorna el proveedor activo, que ha sido definido con el comando Set-AiProvider.

El objeto retornado es un hashtable que contiene todos los campos del proveedor.  
Este comando se utiliza comúnmente por los proveedores para obtener el nombre del proveedor activo.  

El parámetro -ContextProvider retorna el proveedor actual donde el script está corriendo.  
Si está corriendo en un script de un proveedor, devolverá ese proveedor, en lugar del proveedor definido con Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [[-CallStack] <Object>] [[-FilterContext] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
Si está habilitado, utiliza el proveedor de contexto, es decir, si el código se está ejecutando en un archivo en el directorio de un proveedor, asume este proveedor.  
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

### -CallStack
¡Stack alternativo a considerar! Véase más en Get-AiNearProvider

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -FilterContext
Permite elegir el proveedor con base en filtros

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
