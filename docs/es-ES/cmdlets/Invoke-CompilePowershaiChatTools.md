---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-CompilePowershaiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Convierte todas las tools añadidas en el formato esperado por la función Invoke-AiChatTools.

## DESCRIPTION <!--!= @#Desc !-->
Obtiene todas las tools registradas por el usuario con New-PowershaiChatTool y compila en un único objeto para ser enviado al LLM usando Invoke-AiChatTools.  
Este proceso puede ser bastante lento, dependiendo de la cantidad de tools añadidas.

El cmdlet va a recorrer todas las tools, obtener la ayuda de los comandos y de los parámetros, y convertir esto en un formato que pueda ser enviado en Invoke-AiChatTools.  
Como PowershAI define que el mecanismo de tools debe seguir el estándar de OpenAI, la función Get-OpenaiTool* del proveedor OpenAI es utilizada.  
Estas funciones contienen la lógica necesaria para generar el esquema de la tool calling siguiendo las especificaciones de OpenAI.  

Este comando itera en cada tool disponible para el chat actual y crea lo que es necesario para ser enviado con Invoke-AiChatTools.  
Invoke-AiChatTools contiene toda la lógica para manejar el envío, ejecución y respuesta del LLM.  

Básicamente, existen 2 tipos de tools que Powershai soporta: Script o Comando.  
Comando es cualquier código ejecutable por PowerShell: funciones, .exe, cmdlets nativos, etc.

Scripts son simples archivos .ps1 que definen las funciones que pueden ser usadas como tools.  
Es como si fuera un grupo de comandos.

Este comando invoca todo lo que es necesario para convertir estas tools en el formato estándar esperado por Invoke-AiChatTools.  
Invoke-AiChatTools no sabe nada sobre chats, tools globales. Es una función genérica que no depende del mecanismo de Chats creado por Powershai.  

Por eso, es necesario que esta función haga toda esta "traducción" de las facilidades del Powershai Chat para lo esperado por Invoke-AiChatTools.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-CompilePowershaiChatTools [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Chat del cual se obtendrán las tools  
Además del chat, las tools globales serán incluidas

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
