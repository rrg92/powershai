---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Crea una nueva sesión Gradio.

## DESCRIPTION <!--!= @#Desc !-->
Una Sessions representa una conexión a una app Gradio.  
Imagina que una session sea como si fuera una pestaña del navegador abierta conectada a una determinada app gradio.  
Los archivos enviados, llamadas hechas, inicios de sesión, se guardan en esta sesión.

Este cmdlet devuelve un objeto que llamamos "GradioSesison".  
Este objeto puede usarse en otros commandlets que dependen de la sesión (y puede definirse una sesión activa, que todos los cmdlets usan de forma predeterminada si no se especifica).  

Toda sesión tiene un nombre que la identifica de forma única. Si no lo proporciona el usuario, se creará automáticamente en función de la URL de la app.  
No pueden existir dos sesiones con el mismo nombre.

Al crear una sesión, este cmdlet guarda esta sesión en un repositorio interno de sesiones.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
Url de la app

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

### -Name
Nombre único que identifica esta sesión!

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

### -DownloadPath
Directorio donde hacer la descarga de los archivos

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Force
Forzar recreación

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
