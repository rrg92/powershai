---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Importa una configuración exportada con Export-PowershaiSettings

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet es el par de Export-PowershaiSettings, y como el nombre indica, importa los datos que han sido exportados.  
Debes asegurarte de que se pase la misma contraseña y el mismo archivo.  

IMPORTANTE: Este comando sobrescribirá todos los datos configurados en la sesión. Solo ejecútalo si estás absolutamente seguro de que no se pueden perder datos configurados previamente.  
Por ejemplo, algún nuevo API Token generado recientemente.

Si has especificado un camino de exportación diferente del predeterminado, usando la variable POWERSHAI_EXPORT_DIR, debes usarlo aquí también.

El proceso de importación valida algunos encabezados para garantizar que los datos se han descifrado correctamente.  
Si la contraseña proporcionada es incorrecta, los hashes no serán iguales y se disparará el error de contraseña incorrecta.

Si, por otro lado, se muestra un error de formato de archivo inválido, significa que hubo alguna corrupción en el proceso de importación o es un bug de este comando.  
En este caso, puedes abrir un issue en GitHub reportando el problema.

A partir de la versión 0.7.0, se generará un nuevo archivo, llamado exportsession-v2.xml.  
El archivo antiguo se mantendrá para que el usuario pueda recuperar eventuales credenciales, si es necesario.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [-v1] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Importación estándar
```powershell
Import-PowershaiSettings
```

### Importando desde OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Import-PowershaiSettings
```
Importa las configuraciones que fueron exportadas a un directorio alternativo (one drive).

## PARAMETERS <!--!= @#Params !-->

### -ExportDir

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -v1
Forza la importación de la versión 1

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
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
