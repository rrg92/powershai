---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Exporta la configuración de la sesión actual a un archivo, encriptado con una contraseña

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet es útil para guardar la configuración, como los Tokens, de forma segura.  
Solicita una contraseña y la utiliza para crear un hash y encriptar los datos de configuración de la sesión en AES256.  

Las configuraciones exportadas son todas las definidas en la variable $POWERSHAI_SETTINGS.  
Esta variable es una hashtable que contiene todos los datos configurados por los proveedores, lo que incluye los tokens.  

Por defecto, los chats no se exportan debido a la cantidad de datos involucrados, lo que puede hacer que el archivo sea muy grande.

El archivo exportado se guarda en un directorio creado automáticamente, por defecto, en la home del usuario ($HOME).  
Los objetos se exportan mediante Serialization, que es el mismo método utilizado por Export-CliXml.  

Los datos se exportan en un formato propio que solo se puede importar con Import-PowershaiSettings e indicando la misma contraseña.  

Dado que PowershAI no realiza una exportación automática, se recomienda invocar este comando cada vez que haya un cambio de configuración, como la inclusión de nuevos tokens.  

El directorio de exportación puede ser cualquier ruta válida, incluidos unidades en la nube como OneDrive, Dropbox, etc.  

Este comando fue creado con la intención de ser interactivo, es decir, necesita la entrada del usuario desde el teclado.

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Exportando la configuración por defecto!
```powershell
Export-PowershaiSettings
```

### Exporta todo, incluyendo los chats!
```powershell
Export-PowershaiSettings -Chat
```

### Exportando a OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
Directorio de exportación 
Por defecto, es un directorio llamado .powershai en el perfil del usuario, pero puede especificar la variable de entorno POWERSHAI_EXPORT_DIR para cambiarlo.

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

### -Chats
Si se especifica, incluye los chats en la exportación 
Todos los chats se exportarán

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
