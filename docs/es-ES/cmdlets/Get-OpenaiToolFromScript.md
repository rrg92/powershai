---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Función auxiliar para convertir un script .ps1, o scriptblock, en un formato de esquema esperado por OpenAI.
Básicamente, lo que esta función hace es ejecutar el script y obtener la ayuda de todos los comandos definidos.
Entonces, devuelve un objeto en el formato especificado por OpenAI para que el modelo pueda invocar!

Devuelve un hashtable que contiene las siguientes claves:
	functions - La lista de funciones, con su código leído del archivo.  
				Cuando el modelo invoque, puedes ejecutarlo directamente desde aquí.
				
	tools - Lista de herramientas, para ser enviadas en la llamada de OpenAI.
	
Puedes documentar tus funciones y parámetros siguiendo el Comment Based Help de PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-Script] <Object>] [[-Vars] <Object>] [[-JsonSchema] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Script
Archivo .ps1 o scriptblock!
El script se cargará en su propio ámbito (como si fuera un módulo).
Por lo tanto, es posible que no puedas acceder a ciertas variables dependiendo del ámbito.
¡Utiliza -Vars para especificar qué variables necesitas poner a disposición en el script!

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

### -Vars
¡Especifica variables y sus valores para que estén disponibles en el ámbito del script!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -JsonSchema
Especifica un esquema json personalizado para cada función retornada por el script.
Debes especificar una clave con el nombre de cada comando. El valor es otra hashtable donde cada clave es el nombre del parámetro y el valor es el esquema json de ese parámetro.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
