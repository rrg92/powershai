---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiDefaultCredential

## SYNOPSIS <!--!= @#Synop !-->
Obtiene la credencial predeterminada del proveedor actual!

## DESCRIPTION <!--!= @#Desc !-->
Obtiene la credencial predeterminada. 
Este cmdlet debe ser utilizado primordialmente por los proveedores, cuando necesiten autenticarse. 
Sin embargo, se expone públicamente para permitir que el usuario pueda verificar las credenciales activas y hacer un mínimo de troubleshooting.

El cmdlet obtendrá la credencial predeterminada a partir de lo que ha sido definido por el usuario y también verificando algunas de las variables de entorno, si son soportadas por el proveedor.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiDefaultCredential [-IgnoreNotExists] [[-MigrateScript] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -IgnoreNotExists
Si no existe, ignora, en lugar de resultar en error!!

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

### -MigrateScript
Script para migrar credenciales existentes.
Usado exclusivamente por los proveedores. 
Cada proveedor puede especificar un script que debe retornar objetos AiCredential creados con NewAiCredential.

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
