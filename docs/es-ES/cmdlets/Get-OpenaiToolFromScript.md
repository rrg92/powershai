---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Función auxiliar para convertir un script .ps1 en un formato de esquema esperado por OpenAI.
Básicamente, lo que hace esta función es leer un archivo .ps1 (o cadena) junto con su documentación de ayuda.  
Luego, devuelve un objeto en el formato especificado por OpenAI para que el modelo pueda invocarlo.

Devuelve una tabla hash que contiene las siguientes claves:
	functions - La lista de funciones, con su código leído del archivo.  
				Cuando el modelo invoque, puede ejecutar directamente desde aquí.
				
	tools - Lista de herramientas, para ser enviada en la llamada de OpenAI.
	
Puede documentar sus funciones y parámetros siguiendo la Ayuda basada en comentarios de PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

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
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
